
signal clause_inserted(clause)
signal clause_removed(clause)


var _clauses : Array = []
var blacklisted_clauses : Array = []
var _composite_clauses : Array = []

var is_passed : bool

func _init():
	is_passed = true


func is_passed_clauses() -> bool:
	var no_normal_clause : bool = _clauses.size() == 0
	var compo_clauses_passed : bool = true
	for clause in _composite_clauses:
		if !clause.is_passed_clauses():
			compo_clauses_passed = false
			break
	
	return no_normal_clause and compo_clauses_passed


func attempt_insert_clause(clause, clause_emit_signal : bool = true) -> bool:
	if !blacklisted_clauses.has(clause):
		if clause is Object and clause.get_script() == get_script():
			if !_composite_clauses.has(clause):
				_composite_clauses.append(clause)
				_update_is_passed()
				
				if !clause.is_connected("clause_inserted", self, "_compo_clause_clause_inserted"):
					clause.connect("clause_inserted", self, "_compo_clause_clause_inserted", [], CONNECT_PERSIST)
					clause.connect("clause_removed", self, "_compo_clause_clause_removed", [], CONNECT_PERSIST)
				
				if clause_emit_signal:
					emit_signal("clause_inserted", clause)
			
		else: 
			if !_clauses.has(clause):
				_clauses.append(clause)
				_update_is_passed()
				
				if clause_emit_signal:
					emit_signal("clause_inserted", clause)
		
		return true
	else:
		return false


func remove_clause(clause, clause_emit_signal : bool = true):
	
	if clause is Object and clause.get_script() == get_script():
		_composite_clauses.erase(clause)
		if clause.is_connected("clause_inserted", self, "_compo_clause_clause_inserted"):
			clause.disconnect("clause_inserted", self, "_compo_clause_clause_inserted")
			clause.disconnect("clause_removed", self, "_compo_clause_clause_removed")
		
		
	else:
		_clauses.erase(clause)
	
	_update_is_passed()
	
	if clause_emit_signal:
		emit_signal("clause_removed", clause)


func has_clause(clause):
	return _clauses.has(clause) or _composite_clauses.has(clause)

func has_only_clause_or_no_clause(clause):
	return (_clauses.has(clause) and _clauses.size() == 1) or is_passed_clauses()


func _update_is_passed():
	is_passed = is_passed_clauses()


func get_all_clause_ids__of_non_composite__non_copy():
	return _clauses

#

func _compo_clause_clause_inserted(val_inserted):
	_update_is_passed()
	emit_signal("clause_inserted", val_inserted)
	

func _compo_clause_clause_removed(val_removed):
	_update_is_passed()
	emit_signal("clause_removed", val_removed)


#

func duplicate():
	var copy = get_script().new()
	
	copy._clauses = _clauses.duplicate(true)
	copy.blacklisted_clauses = blacklisted_clauses.duplicate(true)
	copy._composite_clauses = _composite_clauses.duplicate(true)
	
	copy._update_is_passed()
	
	return copy


func copy_clauses_of_condtional_clause(other_conditional_clause):
	_clauses = other_conditional_clause._clauses.duplicate(true)
	blacklisted_clauses = other_conditional_clause.blacklisted_clauses.duplicate(true)
	_composite_clauses = other_conditional_clause._composite_clauses.duplicate(true)
	
	_update_is_passed()


