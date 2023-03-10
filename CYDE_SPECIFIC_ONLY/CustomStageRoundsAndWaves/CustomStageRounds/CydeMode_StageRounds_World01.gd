extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"



func _init():
	stage_rounds = [
		_get_stageround_1_1(),
		_get_stageround_1_2(),
		_get_stageround_1_3(),
		_get_stageround_1_4(),
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_1_1():
	var stageround = StageRound.new(1, 1)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	
	return stageround

func _get_stageround_1_2():
	var stageround = StageRound.new(1, 2)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	
	return stageround

func _get_stageround_1_3():
	var stageround = StageRound.new(1, 3)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	
	return stageround

func _get_stageround_1_4():
	var stageround = StageRound.new(1, 4)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	
	return stageround

#
