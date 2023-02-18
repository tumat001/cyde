extends MarginContainer

const TooltipPlainTextDescription = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipPlainTextDescription.gd")
const TooltipPlainTextDescriptionScene = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipPlainTextDescription.tscn")
const TooltipWithTextIndicatorDescription = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipWithTextIndicatorDescription.gd")
const TooltipWithTextIndicatorDescriptionScene = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipWithTextIndicatorDescription.tscn")
const TooltipWithImageIndicatorDescription = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipWithImageIndicatorDescription.gd")
const TooltipWithImageIndicatorDescriptionScene = preload("res://GameHUDRelated/Tooltips/TooltipBodyConstructors/TooltipWithImageIndicatorDescription.tscn")

var descriptions : Array = []

var specific_font_colors : Array = []
export(Color) var default_font_color : Color
export(bool)var override_color_of_descs : bool = true

export(int) var default_font_size : int = 10
export(bool) var uses_bbcode : bool = true

var use_custom_size_flags_for_descs : bool = false
var custom_horizontal_size_flags_for_descs : int = SIZE_FILL

#

onready var row_container = $RowContainer

var tower_for_text_fragment_interpreter
var tower_info_for_text_fragment_interpreter

var use_color_for_dark_background : bool = true

#

func _ready():
	update_display()

func update_display():
	rect_min_size.y = 0
	rect_size.y = 0
	
	_kill_all_desc()
	var index = 0
	
	for desc in descriptions:
		var desc_instance
		
		if desc is String:
			desc_instance = TooltipPlainTextDescriptionScene.instance()
			desc_instance.description = desc
#		elif desc is TooltipPlainTextDescription:
#			desc_instance = TooltipPlainTextDescriptionScene.instance()
#		elif desc is TooltipWithTextIndicatorDescription:
#			desc_instance = TooltipWithTextIndicatorDescriptionScene.instance()
#		elif desc is TooltipWithImageIndicatorDescription:
#			desc_instance = TooltipWithImageIndicatorDescriptionScene.instance()
#	
#		if !(desc is String):
#			desc_instance.get_info_from_self_class(desc)
#		
		elif desc is Array: # Arr with [<string>, [TextFragmentInterpreters]]
			desc_instance = TooltipPlainTextDescriptionScene.instance()
			desc_instance.description = desc[0]
			desc_instance._text_fragment_interpreters = desc[1]
			desc_instance._use_color_for_dark_background = use_color_for_dark_background
			
		else:
			desc_instance = desc
		
		
		if override_color_of_descs:
			if specific_font_colors.size() > index:
				if specific_font_colors[index] != null:
					desc_instance.color = specific_font_colors[index]
				else:
					desc_instance.color = default_font_color
			else:
				desc_instance.color = default_font_color
		
		if desc_instance.get("font_size"):
			desc_instance.font_size = default_font_size
		
		if use_custom_size_flags_for_descs:
			desc_instance.size_flags_horizontal = custom_horizontal_size_flags_for_descs
			
		
		desc_instance.uses_bbcode = uses_bbcode
		
		if !is_instance_valid(desc_instance._tower):
			desc_instance._tower = tower_for_text_fragment_interpreter
		
		if desc_instance._tower_info == null:
			desc_instance._tower_info = tower_info_for_text_fragment_interpreter
		
		desc_instance.mouse_filter = MOUSE_FILTER_IGNORE
		
		row_container.add_child(desc_instance)
		index += 1
	

func _kill_all_desc():
	for ch in row_container.get_children():
		ch.queue_free()




func _queue_free():
	clear_descriptions_in_array()
	
	.queue_free()

func clear_descriptions_in_array():
	for desc in descriptions:
		if !desc is String:
			desc.queue_free()

#

func set_spacing_per_string_line(arg_val):
	row_container.add_constant_override("separation", arg_val)

#

func get_visible_character_count():
	var count = 0
	for ch in row_container.get_children():
		count += ch.get_visible_character_count()
	
	return count

func set_visible_character_count(arg_count):
	var curr_arg_count = arg_count
	
	for ch in row_container.get_children():
		ch.set_visible_character_count(curr_arg_count)
		
		var ch_count : int = ch.get_visible_character_count()
		
		curr_arg_count -= ch_count
		if curr_arg_count < 0:
			curr_arg_count = -1
	
	

func get_percent_visible_character_count():
	var percent_total : float = 0
	
	for ch in row_container.get_children():
		percent_total += ch.get_percent_visible_character_count()
	
	return percent_total /  row_container.get_child_count()

func get_total_character_count():
	var count : int = 0
	
	for ch in row_container.get_children():
		count += ch.get_total_char_count()
	
	return count
