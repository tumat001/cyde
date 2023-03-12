extends MarginContainer


const BaseTowerSpecificTooltip = preload("res://MiscRelated/GUI_Category_Related/BaseTowerSpecificTooltip/BaseTowerSpecificTooltip.gd")
const BaseTowerSpecificTooltip_Scene = preload("res://MiscRelated/GUI_Category_Related/BaseTowerSpecificTooltip/BaseTowerSpecificTooltip.tscn")

const Almanac_Page = preload("res://GeneralGUIRelated/AlmanacGUI/Subs/Almanac_Page/Almanac_Page.gd")
const Almanac_Page_Scene = preload("res://GeneralGUIRelated/AlmanacGUI/Subs/Almanac_Page/Almanac_Page.tscn")

const AdvancedQueue = preload("res://MiscRelated/QueueRelated/AdvancedQueue.gd")

const ConditionalClauses = preload("res://MiscRelated/ClauseRelated/ConditionalClauses.gd")



#

var game_elements

#

var almanac_page
var reservation_for_whole_screen_gui

#

#var _is_disabled : bool
#var _is_disabled_reason : Array

enum IsDisabledClauseId {
	QUESTION_IN_PROGRESS = 0
	
}
var is_disabled_clause_id_to_reason_descs_map : Dictionary

var is_disabled_conditional_clauses : ConditionalClauses
var last_calculated_is_disabled : bool


onready var button = $Button

####

func _init():
	reservation_for_whole_screen_gui = AdvancedQueue.Reservation.new(self)
	reservation_for_whole_screen_gui.on_entertained_method = "_on_queue_reservation_entertained"
	
	is_disabled_conditional_clauses = ConditionalClauses.new()
	#is_disabled_conditional_clauses.connect("clause_inserted", self, "_on_is_disabled_clause_added_or_removed", [], CONNECT_PERSIST)
	#is_disabled_conditional_clauses.connect("clause_removed", self, "_on_is_disabled_clause_added_or_removed", [], CONNECT_PERSIST)
	is_disabled_conditional_clauses.connect("all_clause_changed", self, "_on_is_disabled_clause_added_or_removed", [], CONNECT_PERSIST)
	_on_is_disabled_clause_added_or_removed()
	
	######## Construction of reasons
	
	is_disabled_clause_id_to_reason_descs_map[IsDisabledClauseId.QUESTION_IN_PROGRESS] = [
		"You cannot browse the almanac while answering a question."
	]
	

func _on_queue_reservation_entertained():
	pass
	


#

func _on_is_disabled_clause_added_or_removed():
	last_calculated_is_disabled = !is_disabled_conditional_clauses.is_passed
	
	_update_disp_based_on_is_disabled()


#func set_is_disabled(arg_is_disabled, arg_is_disabled_reason : Array):
#	_is_disabled = arg_is_disabled
#	_is_disabled_reason = arg_is_disabled_reason
#
#	_update_disp_based_on_is_disabled()




func _update_disp_based_on_is_disabled():
	if last_calculated_is_disabled:
		modulate = Color(0.3, 0.3, 0.3, 0.8)
	else:
		modulate = Color(1, 1, 1, 1)
	


#

func _ready():
	_update_disp_based_on_is_disabled()
	_update_display_based_on_stats_manager_almanac_stats()
	
	_connect_to_stats_manager_almanac_status()

#

func _update_display_based_on_stats_manager_almanac_stats():
	var has_at_least_one_entry_in_tidbits = StatsManager.if_tidbit_map_has_at_least_one_tidbit_with_non_zero_val()
	visible = has_at_least_one_entry_in_tidbits

func _connect_to_stats_manager_almanac_status():
	StatsManager.connect("tidbit_id_val_changed", self, "_on_tidbit_id_val_changed", [], CONNECT_PERSIST)

func _on_tidbit_id_val_changed(arg_id, arg_val):
	_update_display_based_on_stats_manager_almanac_stats()


#

func _on_Button_about_tooltip_construction_requested():
	if last_calculated_is_disabled:
		var a_tooltip = BaseTowerSpecificTooltip_Scene.instance()
		a_tooltip.descriptions = _get_is_disabled_reason_for_tooltip() #_is_disabled_reason
		#a_tooltip.header_left_text = "Partner Configuration"
		
		button.display_requested_about_tooltip(a_tooltip)

func _get_is_disabled_reason_for_tooltip():
	var first_clause_in_list = is_disabled_conditional_clauses._clauses[0]
	return is_disabled_clause_id_to_reason_descs_map[first_clause_in_list]



func _on_Button_pressed_mouse_event(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if !last_calculated_is_disabled:
			_construct_and_configure_and_show_almanac_gui_for_game_elements()
			


func _construct_and_configure_and_show_almanac_gui_for_game_elements():
	if !is_instance_valid(almanac_page):
		if !is_instance_valid(AlmanacManager.almanac_page_gui):
			almanac_page = Almanac_Page_Scene.instance()
		else:
			almanac_page = AlmanacManager.almanac_page_gui
	
	if is_instance_valid(almanac_page.get_parent()) and almanac_page.get_parent() != game_elements.whole_screen_gui:
		almanac_page.get_parent().remove_child(almanac_page)
	
	if !AlmanacManager.is_connected("requested_exit_almanac", self, "_on_requested_exit_almanac"):
		AlmanacManager.connect("requested_exit_almanac", self, "_on_requested_exit_almanac", [], CONNECT_PERSIST)
	
	#
	
	game_elements.whole_screen_gui.add_control_but_dont_show(almanac_page)
	game_elements.whole_screen_gui.queue_control(almanac_page, reservation_for_whole_screen_gui)
	
	#
	AlmanacManager.set_almanac_page_gui(almanac_page)
	almanac_page.set_almanac_item_list_page_data(AlmanacManager.tidbit_page)


func _on_requested_exit_almanac():
	game_elements.whole_screen_gui.hide_control(almanac_page)





