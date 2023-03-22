extends Control

const DialogSegment = preload("res://MiscRelated/DialogRelated/DataClasses/DialogSegment.gd")
const BaseDialogElementControl = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/BaseDialogElementControl.gd")
const BaseDialogBackgroundElementControl = preload("res://MiscRelated/DialogRelated/Controls/DialogBackgroundElementsControls/BaseDialogBackgroundElement.gd")
const ValTransition = preload("res://MiscRelated/ValTransitionRelated/ValTransition.gd")
const ConditionalClauses = preload("res://MiscRelated/ClauseRelated/ConditionalClauses.gd")


signal resolve_block_advanced_requested_status(arg_status)
signal dialog_element_control_constructed(arg_element, arg_ins, arg_id)

signal shown_all_DBE_and_finished_display(arg_dia_seg)

#

var current_dialog_segment : DialogSegment setget set_dialog_segment
var _latest_base_dialog_ele_control : BaseDialogElementControl 
var _latest_BDE_dialog_ele_cons_inses : Array
var _latest_BDE_index : int = 0
var last_calculated_not_all_BDEs_are_shown : bool

var absolute_block_timer : Timer
const absolute_block_duration : float = 0.40
var _is_absolute_block_active : bool


var game_elements


#

enum TransitioningClauseIds {
	POS_X = 0,
	POS_Y = 1,
}

var val_transition__center_container__top_left_pos__x : ValTransition
var val_transition__center_container__top_left_pos__y : ValTransition

var is_transitioning_clauses : ConditionalClauses
var last_calculated_is_transitioning : bool

var transitioning_id_to_val_trans_map : Dictionary
var transitioning_id_to_is_active_map : Dictionary

const time_taken_for_pos_change_transition : float = 0.3

#

#var last_calculated_dialog_main_panel__block_advance

#

onready var dialog_main_panel = $CenterContainer/DialogMainPanel
onready var dialog_background_ele_container = $DialogBackgrounElementsContainer
onready var center_container = $CenterContainer

#

func _init():
	val_transition__center_container__top_left_pos__x = ValTransition.new()
	val_transition__center_container__top_left_pos__x.connect("target_val_reached", self, "_on_target_val_reached", [val_transition__center_container__top_left_pos__x, TransitioningClauseIds.POS_X], CONNECT_PERSIST)
	val_transition__center_container__top_left_pos__y = ValTransition.new()
	val_transition__center_container__top_left_pos__y.connect("target_val_reached", self, "_on_target_val_reached", [val_transition__center_container__top_left_pos__y, TransitioningClauseIds.POS_Y], CONNECT_PERSIST)
	
	is_transitioning_clauses = ConditionalClauses.new()
	is_transitioning_clauses.connect("clause_inserted", self, "_on_is_transitioning_clauses_inserted", [], CONNECT_PERSIST)
	is_transitioning_clauses.connect("clause_removed", self, "_on_is_transitioning_clauses_removed", [], CONNECT_PERSIST)
	_update_last_calculated_is_transitioning()
	
	transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_X] = val_transition__center_container__top_left_pos__x
	transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_Y] = val_transition__center_container__top_left_pos__y
	

func _on_is_transitioning_clauses_inserted(arg_clause_id):
	transitioning_id_to_is_active_map[arg_clause_id] = true
	_update_last_calculated_is_transitioning()

func _on_is_transitioning_clauses_removed(arg_clause_id):
	transitioning_id_to_is_active_map[arg_clause_id] = false
	_update_last_calculated_is_transitioning()

func _update_last_calculated_is_transitioning():
	last_calculated_is_transitioning = !is_transitioning_clauses.is_passed
	


func _on_target_val_reached(arg_val_transition, arg_transition_id):
	is_transitioning_clauses.remove_clause(arg_transition_id)


#

func _ready():
	dialog_main_panel.visible = false
	
	absolute_block_timer = Timer.new()
	absolute_block_timer.one_shot = true
	absolute_block_timer.connect("timeout", self, "_on_absolute_block_timer_timeout", [], CONNECT_PERSIST)
	add_child(absolute_block_timer)

func _on_absolute_block_timer_timeout():
	_is_absolute_block_active = false

#

func set_dialog_segment(arg_segment : DialogSegment):
	current_dialog_segment = arg_segment
	
	dialog_main_panel.dia_seg_of_whole_screen_panel_changed()
	
	##
	##
	
	if arg_segment != null:
		arg_segment.emit_setted_into_whole_screen_panel()
		
		#
		
		var final_time_taken_for_pos_change_transition = time_taken_for_pos_change_transition
		
		if !visible or modulate.a == 0:
			final_time_taken_for_pos_change_transition = 0
			
		if final_time_taken_for_pos_change_transition != 0:
			var reached_x = val_transition__center_container__top_left_pos__x.configure_self(center_container.rect_position.x, center_container.rect_position.x, arg_segment.final_dialog_top_left_pos.x, final_time_taken_for_pos_change_transition, ValTransition.VALUE_UNSET, arg_segment.final_dialog_top_left_pos_val_trans_mode)
			var reached_y = val_transition__center_container__top_left_pos__y.configure_self(center_container.rect_position.y, center_container.rect_position.y, arg_segment.final_dialog_top_left_pos.y, final_time_taken_for_pos_change_transition, ValTransition.VALUE_UNSET, arg_segment.final_dialog_top_left_pos_val_trans_mode)
			
			if !reached_x:
				is_transitioning_clauses.attempt_insert_clause(TransitioningClauseIds.POS_X)
			if !reached_y:
				is_transitioning_clauses.attempt_insert_clause(TransitioningClauseIds.POS_Y)
			
		else:
			center_container.rect_position = arg_segment.final_dialog_top_left_pos
		
		
		#
		
		visible = true
		
		dialog_main_panel.dialog_segment = arg_segment
		
		_latest_BDE_index = 0
		_latest_BDE_dialog_ele_cons_inses = current_dialog_segment.get_all_dialog_element_construction_inses()
		dialog_main_panel.flush_dialog_elements_in_content_panel()
		_start_show_dia_main_panel_element_using_construction_ins__and_increment_index(_latest_BDE_dialog_ele_cons_inses[_latest_BDE_index])
		
		_is_absolute_block_active = true
		absolute_block_timer.start(absolute_block_duration)
		
		#########
		
		_configure_and_build_background_elements(arg_segment)
		
		if arg_segment.disable_almanac_button:
			game_elements.almanac_button.is_disabled_conditional_clauses.attempt_insert_clause(arg_segment.disable_almanac_button_clause_id)
		else:
			game_elements.almanac_button.is_disabled_conditional_clauses.remove_all_clauses()
		
	else:
		dialog_main_panel.visible = false
		visible = false
		game_elements.almanac_button.is_disabled_conditional_clauses.remove_all_clauses()
	
	

func _start_show_dia_main_panel_element_using_construction_ins__and_increment_index(cons_ins : DialogSegment.DialogElementsConstructionIns):
	_latest_base_dialog_ele_control = cons_ins.build_element()
	dialog_main_panel.add_dialog_element_to_content_panel(_latest_base_dialog_ele_control)
	dialog_main_panel._latest_base_dialog_ele_control = _latest_base_dialog_ele_control
	
	emit_signal("dialog_element_control_constructed", _latest_base_dialog_ele_control, cons_ins, cons_ins.element_id)
	
	
	_latest_base_dialog_ele_control.set_mod_a_to_zero()
	
	#_latest_base_dialog_ele_control.connect("mod_a_increase_to_target__finished", self, "_on_mod_a_increase_to_target__of_latest_DEC_finished", [], CONNECT_ONESHOT | CONNECT_DEFERRED)
	_latest_base_dialog_ele_control.connect("is_fully_finished", self, "_on_latest_diag_ele_is_fully_finished", [], CONNECT_ONESHOT | CONNECT_DEFERRED)
	if !current_dialog_segment.temp_var__already_traversed:
		_latest_base_dialog_ele_control.start_mod_a_increase()
		_latest_base_dialog_ele_control._start_display()
		_latest_BDE_index += 1
	else:
		_latest_base_dialog_ele_control.set_mod_a_to_one__using_val_transition()
		_latest_base_dialog_ele_control._force_finish_display()
		_latest_BDE_index += 1
	
	if current_dialog_segment.is_construction_inses_sizes_above_index(_latest_BDE_index):
		last_calculated_not_all_BDEs_are_shown = true
		
	else:
		last_calculated_not_all_BDEs_are_shown = false
		current_dialog_segment.emit_fully_displayed_signal()
		emit_signal("shown_all_DBE_and_finished_display", current_dialog_segment)

#func _on_mod_a_increase_to_target__of_latest_DEC_finished():
#	if !_latest_base_dialog_ele_control._block_next_element_show():
#		if last_calculated_not_all_BDEs_are_shown:
#			print("showing more dia elements")
#			_start_show_dia_main_panel_element_using_construction_ins__and_increment_index(_latest_BDE_dialog_ele_cons_inses[_latest_BDE_index])
#
#
#		else:
#			last_calculated_not_all_BDEs_are_shown = false
#			print("all bdes exhausted")
#
#	print("----------")

func _on_latest_diag_ele_is_fully_finished():
	if !_latest_base_dialog_ele_control._block_next_element_show():
		if last_calculated_not_all_BDEs_are_shown:
			_start_show_dia_main_panel_element_using_construction_ins__and_increment_index(_latest_BDE_dialog_ele_cons_inses[_latest_BDE_index])
			
		else:
			last_calculated_not_all_BDEs_are_shown = false
			dialog_main_panel.all_BDE_of_whole_screen_panel_diplay_finished()

#

func is_block_advance():
	return _is_absolute_block_active or dialog_main_panel.is_block_advance() or last_calculated_not_all_BDEs_are_shown or current_dialog_segment.is_block_advance() or dialog_background_ele_container.is_block_advance() or last_calculated_is_transitioning

func resolve_block_advance():
	if !_is_absolute_block_active:
		if dialog_main_panel.is_block_advance():
			dialog_main_panel.resolve_block_advance()
		
		if last_calculated_not_all_BDEs_are_shown:
			_latest_base_dialog_ele_control.set_mod_a_to_one__using_val_transition()
		
		if current_dialog_segment.is_block_advance():
			current_dialog_segment.immediately_resolve_block_advance()
		
		if dialog_background_ele_container.is_block_advance():
			dialog_background_ele_container.resolve_block_advance()
	
	resolve_block_advance__val_transitions()
	
	call_deferred("_emit_resolve_block_advanced_requested_status")


func _emit_resolve_block_advanced_requested_status():
	var is_not_block_advance = !is_block_advance()
	emit_signal("resolve_block_advanced_requested_status", is_not_block_advance)
	
	if is_not_block_advance:
		current_dialog_segment.emit_fully_displayed_signal()
		emit_signal("shown_all_DBE_and_finished_display", current_dialog_segment)


###############

func _configure_and_build_background_elements(arg_segment : DialogSegment):
	var construction_inses = arg_segment.get_all_background_elements_construction_inses()
	var existing_persistence_id_to_ele_map : Dictionary = _get_existing_background_elements_persistence_id_to_ele_map()
	
	for construction_ins in construction_inses:
		if construction_ins.has_persistence_id() and existing_persistence_id_to_ele_map.has(construction_ins.persistence_id):
			var existing_ele = existing_persistence_id_to_ele_map[construction_ins.persistence_id]
			construction_ins.build_element(existing_ele)
			
			#
			existing_persistence_id_to_ele_map.erase(construction_ins.persistence_id)
			
			existing_ele._start_display()
			
		else:
			var new_ele = construction_ins.build_element(null)
			dialog_background_ele_container.add_dialog_element_to_container(new_ele)
			
			new_ele._start_display()
	
	# background eles not found in construction ins will be removed
	for background_ele in existing_persistence_id_to_ele_map.values():
		dialog_background_ele_container.remove_dialog_element_to_container(background_ele)
		background_ele.visible = false
		background_ele.queue_free()
	
	


func _get_existing_background_elements_persistence_id_to_ele_map():
	var bucket = {}
	
	for child in dialog_background_ele_container.get_children():
		bucket[child.persistence_id] = child
	
	return bucket


##########

func _process(delta):
	if last_calculated_is_transitioning:
		if transitioning_id_to_is_active_map[TransitioningClauseIds.POS_X]:
			var val_transition = transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_X]
			val_transition.delta_pass(delta)
			
			center_container.rect_position.x = val_transition.get_current_val()
		
		if transitioning_id_to_is_active_map[TransitioningClauseIds.POS_Y]:
			var val_transition = transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_Y]
			val_transition.delta_pass(delta)
			
			center_container.rect_position.y = val_transition.get_current_val()
		


func resolve_block_advance__val_transitions():
	if last_calculated_is_transitioning:
		for val_transition in transitioning_id_to_val_trans_map.values():
			val_transition.instantly_finish_transition()
			
			if val_transition == transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_X]:
				center_container.rect_position.x = val_transition.get_current_val()
				
			elif val_transition == transitioning_id_to_val_trans_map[TransitioningClauseIds.POS_Y]:
				center_container.rect_position.y = val_transition.get_current_val()
				



