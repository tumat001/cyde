extends "res://GameInfoRelated/ColorSynergyRelated/AbstractGameElementsModifyingSynergyEffect.gd"

#

const tier_1_gold_amount : int = 5
const tier_2_gold_amount : int = 2

#

var gold_manager
var gold_income_per_round : int


var game_elements : GameElements
var curr_tier : int

func _apply_syn_to_game_elements(arg_game_elements : GameElements, tier : int):
	if game_elements == null:
		game_elements = arg_game_elements
		gold_manager = game_elements.gold_manager
	curr_tier = tier
	
	if !game_elements.stage_round_manager.is_connected("round_ended", self, "_give_gold_income"):
		game_elements.stage_round_manager.connect("round_ended", self, "_give_gold_income")
	
	
	if curr_tier == 1:
		gold_income_per_round == tier_1_gold_amount
	elif curr_tier == 2:
		gold_income_per_round == tier_2_gold_amount
	
	._apply_syn_to_game_elements(arg_game_elements, tier)


func _remove_syn_from_game_elements(game_elements : GameElements, tier : int):
	curr_tier = 0
	
	if game_elements.stage_round_manager.is_connected("round_ended", self, "_give_gold_income"):
		game_elements.stage_round_manager.disconnect("round_ended", self, "_give_gold_income")
	
	gold_income_per_round = 0
	
	._remove_syn_from_game_elements(game_elements, tier)

#

func _give_gold_income(current_stageround):
	gold_manager.increase_gold_by(gold_income_per_round, gold_manager.IncreaseGoldSource.TOWER_GOLD_INCOME)




