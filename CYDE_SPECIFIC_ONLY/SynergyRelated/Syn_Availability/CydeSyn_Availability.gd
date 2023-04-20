extends "res://GameInfoRelated/ColorSynergyRelated/AbstractGameElementsModifyingSynergyEffect.gd"

#

#const tier_1_gold_amount : int = 5
#const tier_2_gold_amount : int = 2

#var gold_manager
#var gold_income_per_round : int


const tier_1_tower_count : int = 2
const tier_2_tower_count : int = 1

var tower_count_per_round : int

#

var availa_tier_tower_map : Dictionary = {
	1 : [],
	2 : [],
	3 : [],
	4 : [],
	5 : [],
	6 : []
}
var _tier_tower_map_initialized : bool = false

#

var game_elements : GameElements
var curr_tier : int

func _apply_syn_to_game_elements(arg_game_elements : GameElements, tier : int):
	if game_elements == null:
		game_elements = arg_game_elements
		#gold_manager = game_elements.gold_manager
	
	curr_tier = tier
	
	#if !game_elements.stage_round_manager.is_connected("round_ended", self, "_give_gold_income"):
	#	game_elements.stage_round_manager.connect("round_ended", self, "_give_gold_income")
	
	if !game_elements.stage_round_manager.is_connected("round_ended", self, "_summon_towers"):
		game_elements.stage_round_manager.connect("round_ended", self, "_summon_towers")
	
	
	if curr_tier == 1:
		#gold_income_per_round == tier_1_gold_amount
		tower_count_per_round = tier_1_tower_count
		
	elif curr_tier == 2:
		#gold_income_per_round == tier_2_gold_amount
		tower_count_per_round = tier_2_tower_count
	
	
	if !_tier_tower_map_initialized:
		_tier_tower_map_initialized = true
		_initialize_tier_tower_map()
	
	._apply_syn_to_game_elements(arg_game_elements, tier)

func _initialize_tier_tower_map():
	for tower_id in Towers.tower_color_to_tower_id_map[TowerColors.AVAILABILITY]:
		if game_elements.shop_manager.is_tower_id_valid_for_adding_to_inventory(tower_id):
			availa_tier_tower_map[Towers.TowerTiersMap[tower_id]].append(tower_id)
	
	#todo
	print(availa_tier_tower_map)

###

func _remove_syn_from_game_elements(game_elements : GameElements, tier : int):
	curr_tier = 0
	
	if game_elements.stage_round_manager.is_connected("round_ended", self, "_give_gold_income"):
		game_elements.stage_round_manager.disconnect("round_ended", self, "_give_gold_income")
	
	if game_elements.stage_round_manager.is_connected("round_ended", self, "_summon_towers"):
		game_elements.stage_round_manager.disconnect("round_ended", self, "_summon_towers")
	
	
	#gold_income_per_round = 0
	tower_count_per_round = 0
	
	._remove_syn_from_game_elements(game_elements, tier)

#

#func _give_gold_income(current_stageround):
#	gold_manager.increase_gold_by(gold_income_per_round, gold_manager.IncreaseGoldSource.TOWER_GOLD_INCOME)

func _summon_towers(arg_stageround):
	for i in tower_count_per_round:
		var tower_id_to_summon = game_elements.shop_manager.generate_tower_id_to_be_rolled_from_level_of_roll(game_elements.level_manager.current_level, availa_tier_tower_map)
		
		var tower = game_elements.tower_inventory_bench.insert_tower_from_last(tower_id_to_summon)
		if !game_elements.tower_manager.is_first_time_tower_tier_acquired_status(tower.tower_type_info.tower_tier):
			game_elements.tower_manager._add_to_tier_aesth_queue__and_attempt_start_display(tower.tower_type_info.tower_tier, tower.global_position, true)
		


