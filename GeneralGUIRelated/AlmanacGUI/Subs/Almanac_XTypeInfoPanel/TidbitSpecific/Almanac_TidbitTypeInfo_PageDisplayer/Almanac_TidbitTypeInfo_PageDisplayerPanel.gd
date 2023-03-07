extends MarginContainer

const TextTidbitTypeInfo = preload("res://GeneralInfoRelated/TextTidbitRelated/TextTidbitTypeInfo.gd")

#

const page_label_string_format = "Page: %s/%s"


var tidbit_type_info : TextTidbitTypeInfo setget set_tidbit_type_info
var descs_panel setget set_descs_panel

onready var page_label = $HBoxContainer/ContentPanel/MarginContainer/PageLabel
onready var prev_page_button = $HBoxContainer/PrevPageButton
onready var next_page_button = $HBoxContainer/NextPageButton


func set_tidbit_type_info(arg_info):
	if tidbit_type_info != null:
		tidbit_type_info.disconnect("current_page_number__for_almanac_use_changed", self, "_on_current_page_number__for_almanac_use_changed")
	
	tidbit_type_info = arg_info
	
	if tidbit_type_info != null:
		tidbit_type_info.connect("current_page_number__for_almanac_use_changed", self, "_on_current_page_number__for_almanac_use_changed", [], CONNECT_PERSIST)
		_on_current_page_number__for_almanac_use_changed(null)

func set_descs_panel(arg_panel):
	descs_panel = arg_panel


#

func _on_current_page_number__for_almanac_use_changed(_arg_val):
	if tidbit_type_info != null:
		if descs_panel != null:
			descs_panel.descriptions = GameSettingsManager.get_descriptions_to_use_based_on_x_type_info(tidbit_type_info, GameSettingsManager)
			descs_panel.update_display()
		
		#
		var page_num = tidbit_type_info.current_page_number__for_almanac_use
		var max_page_num = tidbit_type_info.get_total_page_count()
		page_label.text = page_label_string_format % [page_num, max_page_num]
		
		if page_num == 1 and max_page_num != 1:
			next_page_button.disabled = false
		else:
			next_page_button.disabled = true
		
		if page_num != 1:
			prev_page_button.disabled = false
		else:
			prev_page_button.disabled = true
		
		





func _on_PrevPageButton_pressed():
	if tidbit_type_info != null:
		tidbit_type_info.current_page_number__for_almanac_use -= 1


func _on_NextPageButton_pressed():
	if tidbit_type_info != null:
		tidbit_type_info.current_page_number__for_almanac_use += 1




