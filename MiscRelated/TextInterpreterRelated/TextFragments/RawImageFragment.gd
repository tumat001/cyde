extends "res://MiscRelated/TextInterpreterRelated/TextFragments/AbstractTextFragment.gd"


enum AlignmentType {
	LEFT = 0,
	CENTER = 1,
	RIGHT = 2,
}

var image_path : String
var alignment_type : int

func _init(arg_img_path : String, arg_alignment_type : int).(false):
	image_path = arg_img_path
	alignment_type = arg_alignment_type
	


func _get_as_text() -> String:
	if alignment_type == AlignmentType.CENTER:
		return "[center]%s[/center]" % _get_as_text_with_no_alignment_types()
	elif alignment_type == AlignmentType.RIGHT:
		return "[right]%s[/right]" % _get_as_text_with_no_alignment_types()
	else:
		return _get_as_text_with_no_alignment_types()


func _get_as_text_with_no_alignment_types():
	return "[img]%s[/img]" % [image_path]

func get_as_text_for_tooltip() -> String:
	return _get_as_text()

##


func get_deep_copy():
	var copy = get_script().new(image_path)
	
	._configure_copy_to_match_self(copy)
	
	return copy
	
