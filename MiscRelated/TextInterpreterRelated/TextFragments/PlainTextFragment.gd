extends "res://MiscRelated/TextInterpreterRelated/TextFragments/AbstractTextFragment.gd"



enum OrderedListType {
	NUMBERED = 0,
	LOWER_CASE_LATIN_LETTER = 1,
	UPPER_CASE_LATIN_LETTER = 2,
	LOWER_CASE_ROMAN_NUMERAL = 3,
	UPPER_CASE_ROMAN_NUMERAL = 4,
}

const ordered_list_type_to_string_identifier_map : Dictionary = {
	OrderedListType.NUMBERED : "1",
	OrderedListType.LOWER_CASE_LATIN_LETTER : "a",
	OrderedListType.UPPER_CASE_LATIN_LETTER : "A",
	OrderedListType.LOWER_CASE_ROMAN_NUMERAL : "i",
	OrderedListType.UPPER_CASE_ROMAN_NUMERAL : "I",
	
}


enum AlignmentType {
	LEFT = 0,
	CENTER = 1,
	RIGHT = 2,
}

var alignment_type : int = AlignmentType.LEFT


var _text_desc : String
var _has_space_between_num_and_text : bool
var _is_percent : bool

var _stat_type : int

func _init(
		arg_stat_type : int,
		arg_text_desc : String = "",
		arg_has_spacing : bool = false).(true):
	
	_text_desc = arg_text_desc
	_has_space_between_num_and_text = arg_has_spacing
	_stat_type = arg_stat_type
	
	has_numerical_value = false

#

func _get_as_text() -> String:
	if alignment_type == AlignmentType.CENTER:
		return get_text__with_center_BBCode(_get_as_text_with_no_alignment_types())
	elif alignment_type == AlignmentType.RIGHT:
		return "[right]%s[/right]" % _get_as_text_with_no_alignment_types()
	else:
		return _get_as_text_with_no_alignment_types()


func _get_as_text_with_no_alignment_types() -> String:
	var base_string = ""
	
	if _has_space_between_num_and_text:
		base_string += " " + _text_desc
	else:
		base_string += _text_desc
	
	if type_to_img_map.has(_stat_type):
		base_string += " [img=<%s>]%s[/img]" % [width_img_val_placeholder, type_to_img_map[_stat_type]]
	
	
	return "[color=%s]%s[/color]" % [_get_type_color_map_to_use(_stat_type, -1), base_string]



#

func get_as_text_for_tooltip() -> String:
	return _get_as_text()

#

func get_deep_copy():
	var copy = get_script().new(_text_desc, _stat_type, _has_space_between_num_and_text)
	
	._configure_copy_to_match_self(copy)
	
	return copy


##################

static func get_text__with_center_BBCode(arg_text):
	return "[center]%s[/center]" % arg_text

static func get_text__as_unordered_list(arg_texts : Array, arg_double_new_line : bool = false):
	var new_line = "\n"
	if arg_double_new_line:
		new_line += "\n"
	
	
	var final_text = ""
	for i in arg_texts.size():
		final_text += "%s"
		if i != arg_texts.size():
			final_text += new_line
	
	return "[ul]%s[/ul]" % (final_text % arg_texts)
	

static func get_text__indented(arg_text):
	return "[indent]%s[/indent]" % arg_text

#static func get_text__as_ordered_list(arg_texts : Array, arg_order_type : int = OrderedListType.NUMBERED):
#	var string_identifier = ordered_list_type_to_string_identifier_map[arg_order_type]
#
#	var final_text = ""
#	for i in arg_texts.size():
#		final_text += "%s"
#		if i != arg_texts.size():
#			final_text += "\n"
#
#	return "[ol type=%s]%s[/ol]" % [string_identifier, final_text % arg_texts]
#


