extends MarginContainer

const Almanac_ItemListPage_Data = preload("res://GeneralGUIRelated/AlmanacGUI/DataClasses/Almanac_ItemListPage_Data.gd")
const Almanac_Category_Data = preload("res://GeneralGUIRelated/AlmanacGUI/DataClasses/Almanac_Category_Data.gd")

const Almanac_ItemListEntry_Button = preload("res://GeneralGUIRelated/AlmanacGUI/Subs/ItemListEntryButton/Almanac_ItemListEntry_Button.gd")
const Almanac_ItemListEntry_Button_Scene = preload("res://GeneralGUIRelated/AlmanacGUI/Subs/ItemListEntryButton/Almanac_ItemListEntry_Button.tscn")

#

var _all_buttons_in_container = []
#var _all_visible_buttons_in_container = []

var _category_data : Almanac_Category_Data
var _almanac_item_list_entries : Array

#

onready var header_label = $MarginContainer/VBoxContainer/MarginContainer/HeaderLabel
onready var header_desc = $MarginContainer/VBoxContainer/MarginContainer2/HeaderDesc
onready var button_container = $MarginContainer/VBoxContainer/ButtonMarginer/ButtonContainer

onready var left_border = $LeftBorder
onready var right_border = $RightBorder
onready var top_border = $TopBorder
onready var bottom_border = $BottomBorder

onready var vbox_container = $MarginContainer/VBoxContainer

var _all_borders : Array = []
var _all_misc_controls_in_category : Array = []

#

func _ready():
	_all_borders.append(left_border)
	_all_borders.append(right_border)
	_all_borders.append(top_border)
	_all_borders.append(bottom_border)
	
	_all_misc_controls_in_category.append(header_label)
	_all_misc_controls_in_category.append(header_desc)

#

func set_category_data__and_item_list_entries(arg_category_data : Almanac_Category_Data,
		arg_almanac_item_list_entries_data : Array):
	
	_category_data = arg_category_data
	_almanac_item_list_entries = arg_almanac_item_list_entries_data
	
	_set_properties_based_on_category()
	_set_properties_based_on_almanac_item_list_entries()

func _set_properties_based_on_category():
	if _category_data != null:
		header_label.text = _category_data.cat_text
		header_desc.descriptions = _category_data.cat_description
	else:
		header_label.text = ""
		header_desc.descriptions = []
	
	#
	
	if header_label.text.length() != 0:
		header_label.visible = true
	else:
		header_label.visible = false
	
	if header_desc.descriptions.size() != 0:
		header_desc.visible = true
	else:
		header_desc.visible = false
	
	
	var at_least_one_visible : bool = false
	for control in _all_misc_controls_in_category:
		if control.visible:
			at_least_one_visible = true
			break
	if at_least_one_visible:
		vbox_container.add_constant_override("separation", 4)
	else:
		vbox_container.add_constant_override("separation", 0)
	
	#
	
	header_desc.update_display()
	
	for border in _all_borders:
		border.texture = _category_data.border_texture
		border.modulate = _category_data.border_modulate

func _set_properties_based_on_almanac_item_list_entries():
	#_all_visible_buttons_in_container.clear()
	
	var count = _almanac_item_list_entries.size()
	if _all_buttons_in_container.size() > count:
		count = _all_buttons_in_container.size()
	
	var button_count = _all_buttons_in_container.size()
	var item_list_count = _almanac_item_list_entries.size()
	
	#var highest_x_size : float
	#var highest_y_size : float
	
	for i in count:
		var button : Almanac_ItemListEntry_Button
		
		if button_count > i:
			button = _all_buttons_in_container[i]
			if item_list_count <= i:
				button.visible = false
			else:
				button.visible = true
				#_all_visible_buttons_in_container.append(button)
			
		elif item_list_count > i:
			button = _construct_almanac_item_list_entry_button()
			_all_buttons_in_container.append(button)
			#_all_visible_buttons_in_container.append(button)
		
		if item_list_count > i:
			button.almanac_item_list_entry_data = _almanac_item_list_entries[i]
		
		
		#var button_size = button.rect_size
		#if button_size.x > highest_x_size:
		#	highest_x_size = button_size.x
		#if button_size.y > highest_y_size:
		#	highest_y_size = button_size.y
	
	#var highest_size = Vector2(highest_x_size, highest_y_size)
	#for button in _all_buttons_in_container:
	#	button.rect_min_size = highest_size
	
	call_deferred("_set_deferred_button_sizes__step_01")

func _set_deferred_button_sizes__step_01():
	call_deferred("_set_deferred_button_sizes")

func _set_deferred_button_sizes():
	var highest_x_size : float
	var highest_y_size : float
	
	for button in _all_buttons_in_container:
		if button.visible:
			var button_size = button.rect_size
			if button_size.x > highest_x_size:
				highest_x_size = button_size.x
			if button_size.y > highest_y_size:
				highest_y_size = button_size.y
	
	var highest_size = Vector2(highest_x_size, highest_y_size)
	for button in _all_buttons_in_container:
		button.rect_min_size = highest_size
		button.rect_size = highest_size


func _construct_almanac_item_list_entry_button():
	var button = Almanac_ItemListEntry_Button_Scene.instance()
	button_container.add_child(button)
	
	return button

