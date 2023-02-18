extends MarginContainer

const TowerBuyCard = preload("res://GameHUDRelated/BuySellPanel/TowerBuyCard.gd")
const GoldManager = preload("res://GameElementsRelated/GoldManager.gd")
const RelicManager = preload("res://GameElementsRelated/RelicManager.gd")
const TowerTypeInformation = preload("res://GameInfoRelated/TowerTypeInformation.gd")
const CombinationManager = preload("res://GameElementsRelated/CombinationManager.gd")
const ConditionalClauses = preload("res://MiscRelated/ClauseRelated/ConditionalClauses.gd")

const LevelUpIcon_Green_Pic = preload("res://GameHUDRelated/BuySellPanel/AdditionalIcons/LevelUpIcon_Green_20x20.png")
const LevelUpIcon_Orange_Pic = preload("res://GameHUDRelated/BuySellPanel/AdditionalIcons/LevelUpIcon_Orange_20x20.png")


const Towers = preload("res://GameInfoRelated/Towers.gd")

signal level_up
signal level_down
signal reroll
signal tower_bought(tower_id)
signal viewing_tower_description_tooltip(tower_id, arg_buy_slot)
signal can_refresh_shop_changed(arg_val)

const gold_cost_color : Color = Color(253.0/255.0, 192.0/255.0, 8.0/255.0, 1)
const relic_cost_color : Color = Color(30.0/255.0, 217.0/255.0, 2.0/255.0, 1)

const cannot_press_button_color : Color = Color(0.5, 0.5, 0.5, 1)
const can_press_button_color : Color = Color(1, 1, 1, 1)

var all_buy_slots : Array
onready var buy_slot_container = $HBoxContainer/BuySlotContainer
onready var buy_slot_01 = $HBoxContainer/BuySlotContainer/BuySlot01
onready var buy_slot_02 = $HBoxContainer/BuySlotContainer/BuySlot02
onready var buy_slot_03 = $HBoxContainer/BuySlotContainer/BuySlot03
onready var buy_slot_04 = $HBoxContainer/BuySlotContainer/BuySlot04
onready var buy_slot_05 = $HBoxContainer/BuySlotContainer/BuySlot05
onready var buy_slot_06 = $HBoxContainer/BuySlotContainer/BuySlot06

onready var level_up_cost_label = $HBoxContainer/LevelRerollContainer/HBoxContainer/LevelUpPanel/HBoxContainer/HBoxContainer/MarginContainer2/LevelUpCostLabel
onready var reroll_cost_label = $HBoxContainer/LevelRerollContainer/RerollPanel/HBoxContainer2/HBoxContainer/MarginContainer2/RerollCostLabel

onready var level_up_cost_currency_icon = $HBoxContainer/LevelRerollContainer/HBoxContainer/LevelUpPanel/HBoxContainer/HBoxContainer/MarginContainer3/LevelUpCurrencyIcon
onready var level_up_texture_icon = $HBoxContainer/LevelRerollContainer/HBoxContainer/LevelUpPanel/HBoxContainer/MarginContainer2/LevelUpTexture

onready var level_up_button = $HBoxContainer/LevelRerollContainer/HBoxContainer/LevelUpPanel/LevelUpButton
onready var reroll_button = $HBoxContainer/LevelRerollContainer/RerollPanel/RerollButton
onready var level_up_panel = $HBoxContainer/LevelRerollContainer/HBoxContainer/LevelUpPanel
onready var reroll_panel = $HBoxContainer/LevelRerollContainer/RerollPanel
#onready var relic_buy_etc_panel = $RelicBuyEtcPanel
onready var relic_general_store_show_button = $RelicGeneralStoreShowButton

var gold_manager : GoldManager
var relic_manager : RelicManager setget set_relic_manager
var level_manager setget set_level_manager
var shop_manager setget set_shop_manager
var tower_manager setget set_tower_manager
var combination_manager : CombinationManager setget set_combination_manager
var game_settings_manager setget set_game_settings_manager

var tower_inventory_bench setget set_tower_inventory_bench

# top left pos is global_position
var bot_right_pos : Vector2

var _can_level_up : bool

#

enum BuySlotDisabledClauses {
	END_OF_GAME = 100,
	
	TUTORIAL_DISABLE = 1000
}
var buy_slot_01_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_01_disabled : bool

var buy_slot_02_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_02_disabled : bool

var buy_slot_03_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_03_disabled : bool

var buy_slot_04_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_04_disabled : bool

var buy_slot_05_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_05_disabled : bool

var buy_slot_06_disabled_clauses : ConditionalClauses
var last_calculated_buy_slot_06_disabled : bool

var buy_slot_to_last_calc_property_name_map : Dictionary
var buy_slot_to_disabled_clauses : Dictionary


enum CanRefreshShopClauses {
	PLAYER_LEVEL_01 = 1
	
	END_OF_GAME = 10
	
	TUTORIAL_DISABLE = 1000
}
var can_refresh_shop_clauses : ConditionalClauses
var last_calculated_can_refresh_shop : bool

#

func set_level_manager(arg_manager):
	level_manager = arg_manager
	
	level_manager.connect("on_current_level_up_cost_amount_changed", self, "_level_cost_currency_changed", [], CONNECT_PERSIST)
	level_manager.connect("on_current_level_up_cost_currency_changed", self, "_level_cost_currency_changed", [], CONNECT_PERSIST)
	level_manager.connect("on_can_level_up_changed", self, "_can_level_up_changed", [], CONNECT_PERSIST)
	level_manager.connect("on_current_level_changed", self, "_on_current_level_changed", [], CONNECT_PERSIST)
	
	_level_cost_currency_changed(level_manager.current_level_up_cost)
	_can_level_up_changed(level_manager.can_level_up())
	_on_current_level_changed(level_manager.current_level)


func set_shop_manager(arg_manager):
	shop_manager = arg_manager
	
	shop_manager.connect("on_cost_per_roll_changed", self, "update_reroll_gold_cost", [], CONNECT_PERSIST)
	shop_manager.connect("can_roll_changed", self, "_can_roll_changed", [], CONNECT_PERSIST)
	update_reroll_gold_cost(shop_manager.current_cost_per_roll)
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func set_tower_manager(arg_manager):
	tower_manager = arg_manager
	
	#relic_buy_etc_panel.tower_manager = arg_manager

func set_relic_manager(arg_manager):
	relic_manager = arg_manager
	
	relic_general_store_show_button.set_relic_manager(relic_manager)
	#relic_buy_etc_panel.relic_manager = arg_manager

func set_tower_inventory_bench(arg_bench):
	tower_inventory_bench = arg_bench
	
	for slot in all_buy_slots:
		slot.tower_inventory_bench = tower_inventory_bench

func set_combination_manager(arg_manager):
	combination_manager = arg_manager
	
	combination_manager.connect("updated_applicable_combinations_on_towers", self, "_on_updated_applicable_combinations_on_towers__from_combi_manager", [], CONNECT_PERSIST)

func set_game_settings_manager(arg_manager):
	game_settings_manager = arg_manager
	
	for slot in all_buy_slots:
		slot.game_settings_manager = game_settings_manager



# Called when the node enters the scene tree for the first time.
func _ready():
	buy_slot_01_disabled_clauses = ConditionalClauses.new()
	buy_slot_01_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_01_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_01_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_01_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	buy_slot_02_disabled_clauses = ConditionalClauses.new()
	buy_slot_02_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_02_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_02_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_02_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	buy_slot_03_disabled_clauses = ConditionalClauses.new()
	buy_slot_03_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_03_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_03_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_03_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	buy_slot_04_disabled_clauses = ConditionalClauses.new()
	buy_slot_04_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_04_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_04_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_04_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	buy_slot_05_disabled_clauses = ConditionalClauses.new()
	buy_slot_05_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_05_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_05_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_05_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	buy_slot_06_disabled_clauses = ConditionalClauses.new()
	buy_slot_06_disabled_clauses.connect("clause_inserted", self, "_on_buy_slot_06_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	buy_slot_06_disabled_clauses.connect("clause_removed", self, "_on_buy_slot_06_disabled_clauses_ins_or_rem", [], CONNECT_PERSIST)
	
	can_refresh_shop_clauses = ConditionalClauses.new()
	can_refresh_shop_clauses.connect("clause_inserted", self, "_on_can_refresh_shop_clauses_inserted_or_removed", [], CONNECT_PERSIST)
	can_refresh_shop_clauses.connect("clause_removed", self, "_on_can_refresh_shop_clauses_inserted_or_removed", [], CONNECT_PERSIST)
	
	
	#
	all_buy_slots.append(buy_slot_01)
	all_buy_slots.append(buy_slot_02)
	all_buy_slots.append(buy_slot_03)
	all_buy_slots.append(buy_slot_04)
	all_buy_slots.append(buy_slot_05)
	all_buy_slots.append(buy_slot_06)
	
	#
	
	buy_slot_to_disabled_clauses[buy_slot_01] = buy_slot_01_disabled_clauses
	buy_slot_to_disabled_clauses[buy_slot_02] = buy_slot_02_disabled_clauses
	buy_slot_to_disabled_clauses[buy_slot_03] = buy_slot_03_disabled_clauses
	buy_slot_to_disabled_clauses[buy_slot_04] = buy_slot_04_disabled_clauses
	buy_slot_to_disabled_clauses[buy_slot_05] = buy_slot_05_disabled_clauses
	buy_slot_to_disabled_clauses[buy_slot_06] = buy_slot_06_disabled_clauses
	
	buy_slot_to_last_calc_property_name_map[buy_slot_01] = "last_calculated_buy_slot_01_disabled"
	buy_slot_to_last_calc_property_name_map[buy_slot_02] = "last_calculated_buy_slot_02_disabled"
	buy_slot_to_last_calc_property_name_map[buy_slot_03] = "last_calculated_buy_slot_03_disabled"
	buy_slot_to_last_calc_property_name_map[buy_slot_04] = "last_calculated_buy_slot_04_disabled"
	buy_slot_to_last_calc_property_name_map[buy_slot_05] = "last_calculated_buy_slot_05_disabled"
	buy_slot_to_last_calc_property_name_map[buy_slot_06] = "last_calculated_buy_slot_06_disabled"
	
	for slot in all_buy_slots:
		slot.tower_inventory_bench = tower_inventory_bench
		slot.game_settings_manager = game_settings_manager
		slot.buy_sell_level_roll_panel = self
		
		slot.connect("card_pressed_down", self, "_on_buy_slot__card_pressed_down", [slot], CONNECT_PERSIST)
		#slot.connect("card_released_up_and_not_queue_freed", self, "_on_buy_slot__card_released_up_and_not_queue_freed", [slot], CONNECT_PERSIST)
	
	_update_last_calculated_can_refresh_shop()
	
	call_deferred("_deferred_ready")

func _deferred_ready():
	bot_right_pos = rect_global_position + rect_size


func _on_RerollButton_pressed():
	if last_calculated_can_refresh_shop:
		emit_signal("reroll")


# Assuming that the array received is 5 in length
func update_new_rolled_towers(tower_ids_to_roll_to : Array):
	for i in all_buy_slots.size():
		if tower_ids_to_roll_to.size() > i:
			all_buy_slots[i].roll_buy_card_to_tower_id(tower_ids_to_roll_to[i])
			all_buy_slots[i].visible = true
		else:
			all_buy_slots[i].roll_buy_card_to_tower_id(Towers.NONE)
			all_buy_slots[i].visible = false
	
	
	_update_cards_based_on_combination_metadata(tower_ids_to_roll_to)
	
#	for tower_id in tower_card_combination_metadata.keys():
#		var metadata = tower_card_combination_metadata[tower_id]
#		if (metadata == CombinationManager.TowerBuyCardMetadata.IMMEDIATELY_COMBINABLE):
#
#			var tower_card = all_buy_slots[buy_slot_pos].current_child
#			if tower_card != null:
#				tower_card.call_deferred("play_shine_sparkle_on_card")
#
#		buy_slot_pos += 1
	
	last_calculated_buy_slot_01_disabled = buy_slot_01_disabled_clauses.is_passed
	last_calculated_buy_slot_02_disabled = buy_slot_02_disabled_clauses.is_passed
	last_calculated_buy_slot_03_disabled = buy_slot_03_disabled_clauses.is_passed
	last_calculated_buy_slot_04_disabled = buy_slot_04_disabled_clauses.is_passed
	last_calculated_buy_slot_05_disabled = buy_slot_05_disabled_clauses.is_passed
	last_calculated_buy_slot_06_disabled = buy_slot_06_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)


func _update_cards_based_on_combination_metadata(tower_ids_to_roll_to = get_tower_ids_in_current_buy_cards()):
	var tower_card_combination_metadata : Dictionary = combination_manager.get_tower_buy_cards_metadata(tower_ids_to_roll_to) 
	
	for buy_card in all_buy_slots:
		var tower_card = buy_card.current_child
		if is_instance_valid(tower_card):
			var tower_id = tower_card.tower_information.tower_type_id
			
			if tower_card_combination_metadata.has(tower_id):
				var metadata = tower_card_combination_metadata[tower_id]
				
				if (metadata == CombinationManager.TowerBuyCardMetadata.IMMEDIATELY_COMBINABLE):
					tower_card.call_deferred("play_shine_sparkle_on_card")
					
				
				tower_card.shiny_border_texture_rect.visible = (metadata == CombinationManager.TowerBuyCardMetadata.IMMEDIATELY_COMBINABLE or metadata == CombinationManager.TowerBuyCardMetadata.PROGRESS_TOWARDS_COMBINABLE)
				#tower_card.set_show_border_shine(metadata == CombinationManager.TowerBuyCardMetadata.IMMEDIATELY_COMBINABLE)

func get_tower_ids_in_current_buy_cards():
	var bucket = []
	for buy_card in all_buy_slots:
		var tower_card = buy_card.current_child
		if is_instance_valid(tower_card):
			bucket.append(tower_card.tower_information.tower_type_id)
	
	return bucket

func _on_updated_applicable_combinations_on_towers__from_combi_manager():
	_update_cards_based_on_combination_metadata()


#


func get_all_unbought_tower_ids() -> Array:
	var ids : Array = []
	
	for slot in all_buy_slots:
		if is_instance_valid(slot.current_child):
			ids.append(slot.current_child.tower_information.tower_type_id)
	
	return ids


#

func _level_cost_currency_changed(_val):
	if level_manager.current_level_up_currency == level_manager.Currency.GOLD:
		update_level_up_gold_cost(level_manager.current_level_up_cost)
	elif level_manager.current_level_up_currency == level_manager.Currency.RELIC:
		update_level_up_relic_cost(level_manager.current_level_up_cost)



func update_level_up_gold_cost(new_cost : int):
	level_up_cost_label.text = str(new_cost)
	level_up_cost_label.add_color_override("font_color", gold_cost_color)
	level_up_cost_currency_icon.texture = level_manager.get_currency_icon(level_manager.Currency.GOLD)

func update_level_up_relic_cost(new_cost : int):
	level_up_cost_label.text = str(new_cost)
	level_up_cost_label.add_color_override("font_color", relic_cost_color)
	level_up_cost_currency_icon.texture = level_manager.get_currency_icon(level_manager.Currency.RELIC)



func update_reroll_gold_cost(new_cost : int):
	reroll_cost_label.text = str(new_cost)
	reroll_cost_label.add_color_override("font_color", gold_cost_color)

func update_reroll_relic_cost(new_cost : int):
	reroll_cost_label.text = str(new_cost)
	reroll_cost_label.add_color_override("font_color", relic_cost_color)

#

func _on_LevelDownButton_pressed():
	emit_signal("level_down")


func _on_LevelUpButton_pressed():
	emit_signal("level_up")


# connected via inspector node
func _on_tower_bought(tower_type_info : TowerTypeInformation):
	gold_manager.decrease_gold_by(tower_type_info.tower_cost, GoldManager.DecreaseGoldSource.TOWER_BUY)
	emit_signal("tower_bought", tower_type_info.tower_type_id)

func _on_viewing_tower_description_tooltip(tower_type_info : TowerTypeInformation, arg_buy_slot):
	emit_signal("viewing_tower_description_tooltip", tower_type_info.tower_type_id, arg_buy_slot)


# Gold updating related

func _update_tower_cards_buyability_based_on_gold_and_clauses(current_gold : int):
	for buy_slot in all_buy_slots:
		var tower_card = buy_slot.current_child
		var clause_prop_name = buy_slot_to_last_calc_property_name_map[buy_slot]
		
		if is_instance_valid(tower_card) and tower_card is TowerBuyCard:
			tower_card.current_gold = current_gold
			tower_card.can_buy__set_from_clauses = get(clause_prop_name)
			tower_card._update_can_buy_card()

#

func kill_all_tooltips_of_buycards():
	for buy_slot in all_buy_slots:
		buy_slot.kill_tooltip_of_tower_card()
	

# button state related

func _can_level_up_changed(can_level_up):
	_can_level_up = can_level_up
	
	if can_level_up:
		level_up_button.disabled = false
		#level_up_panel.modulate = can_press_button_color
	else:
		level_up_button.disabled = true
		#level_up_panel.modulate = cannot_press_button_color
	
	_update_level_up_panel_modulate()

func _can_roll_changed(can_roll):
	if can_roll:
		reroll_button.disabled = false
		reroll_panel.modulate = can_press_button_color
	else:
		reroll_button.disabled = true
		reroll_panel.modulate = cannot_press_button_color


func _on_current_level_changed(curr_level : int):
	if curr_level == level_manager.LEVEL_1:
		#reroll_panel.visible = false
		can_refresh_shop_clauses.attempt_insert_clause(CanRefreshShopClauses.PLAYER_LEVEL_01)
		level_up_panel.visible = false
	else:
		#reroll_panel.visible = true
		can_refresh_shop_clauses.remove_clause(CanRefreshShopClauses.PLAYER_LEVEL_01)
		level_up_panel.visible = true
	
	if curr_level == level_manager.LEVEL_9:
		level_up_texture_icon.texture = LevelUpIcon_Green_Pic
	else:
		level_up_texture_icon.texture = LevelUpIcon_Orange_Pic
	
	_update_level_up_panel_modulate()

##

func _update_level_up_panel_modulate():
	if level_manager.current_level == level_manager.LEVEL_10:
		level_up_panel.modulate.a = 0
	else:
		if _can_level_up:
			level_up_panel.modulate = can_press_button_color
		else:
			level_up_panel.modulate = cannot_press_button_color

####

func _on_buy_slot_01_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_01_disabled = buy_slot_01_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func _on_buy_slot_02_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_02_disabled = buy_slot_02_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func _on_buy_slot_03_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_03_disabled = buy_slot_03_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func _on_buy_slot_04_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_04_disabled = buy_slot_04_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func _on_buy_slot_05_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_05_disabled = buy_slot_05_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

func _on_buy_slot_06_disabled_clauses_ins_or_rem(arg_clause):
	last_calculated_buy_slot_06_disabled = buy_slot_06_disabled_clauses.is_passed
	
	_update_tower_cards_buyability_based_on_gold_and_clauses(gold_manager.current_gold)

#

func remove_tower_card_from_all_buy_slots():
	for buy_slot in all_buy_slots:
		buy_slot.kill_current_tower_buy_card()

func remove_tower_card_from_buy_slot(arg_buy_slot_index : int):
	var buy_slot = all_buy_slots[arg_buy_slot_index]
	buy_slot.kill_current_tower_buy_card()

#

func _on_can_refresh_shop_clauses_inserted_or_removed(arg_clause):
	_update_last_calculated_can_refresh_shop()

func _update_last_calculated_can_refresh_shop():
	last_calculated_can_refresh_shop = can_refresh_shop_clauses.is_passed
	reroll_panel.visible = last_calculated_can_refresh_shop
	
	emit_signal("can_refresh_shop_changed", last_calculated_can_refresh_shop)


#

func is_mouse_pos_within_panel_bounds():
	var mouse_pos = get_viewport().get_mouse_position()
	
	return (mouse_pos.x >= rect_global_position.x and mouse_pos.x <= bot_right_pos.x) and (mouse_pos.y >= rect_global_position.y and mouse_pos.y <= bot_right_pos.y)


func _on_buy_slot__card_pressed_down(arg_card, arg_buy_slot):
	buy_slot_container.move_child(arg_buy_slot, buy_slot_container.get_child_count() - 1)

#func _on_buy_slot__card_released_up_and_not_queue_freed(arg_card, arg_buy_slot):
#	pass



func _on_RelicGeneralStoreShowButton_released_mouse_event(event):
	relic_manager.show_whole_screen_relic_general_store_panel()
	

