extends MarginContainer

const Almanac_BrownBackground_ForDescriptions_3x3_Pic = preload("res://GeneralGUIRelated/AlmanacGUI/Assets/Shared/Almanac_BrownBackground_ForDescriptions_3x3.png")
const Almanac_LightBrownBackground_ForDescriptions_3x3_Pic = preload("res://GeneralGUIRelated/AlmanacGUI/Assets/Shared/Almanac_LightBrownBackground_ForDescriptions_3x3.png")


const default_font_color__for_dark_mode := Color("#dddddd")
const default_font_color__for_light_mode := Color("#000000")

onready var desc_panel = $MarginContainer/ScrollContainer/Descs
onready var background = $Background


var descriptions : Array
var is_dark_mode : bool = true setget set_is_dark_mode


func update_display():
	desc_panel.descriptions = descriptions
	
	desc_panel.use_color_for_dark_background = is_dark_mode
	
	if is_dark_mode:
		desc_panel.default_font_color = default_font_color__for_dark_mode
		background.texture = Almanac_BrownBackground_ForDescriptions_3x3_Pic
	else:
		desc_panel.default_font_color = default_font_color__for_light_mode
		background.texture = Almanac_LightBrownBackground_ForDescriptions_3x3_Pic
	
	
	desc_panel.update_display()


func set_is_dark_mode(arg_val):
	is_dark_mode = arg_val
	
	if is_inside_tree():
		update_display()
