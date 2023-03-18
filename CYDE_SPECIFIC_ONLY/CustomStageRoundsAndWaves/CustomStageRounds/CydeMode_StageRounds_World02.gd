extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"



func _init():
	stage_rounds = [
		_get_stageround_1_1(),
		_get_stageround_1_2(),
		_get_stageround_1_3(),
		
		_get_stageround_1_4(), #info
		_get_stageround_1_5(), #question
		
		_get_stageround_1_6(),
		
		_get_stageround_1_7(), #info
		_get_stageround_1_8(), #question
		
		_get_stageround_1_9(), #info
		_get_stageround_1_10(), #question
		
		_get_stageround_1_11(), #final boss stage 01
		
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
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_1_5():
	var stageround = StageRound.new(1, 5)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_1_6():
	var stageround = StageRound.new(1, 6)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround

func _get_stageround_1_7():
	var stageround = StageRound.new(1, 7)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround

func _get_stageround_1_8():
	var stageround = StageRound.new(1, 8)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround

func _get_stageround_1_9():
	var stageround = StageRound.new(1, 9)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround

func _get_stageround_1_10():
	var stageround = StageRound.new(1, 10)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround

func _get_stageround_1_11():
	var stageround = StageRound.new(1, 11)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	stageround.can_gain_streak = false
	return stageround


#
