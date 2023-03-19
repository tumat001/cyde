extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 02 #####


func _init():
	stage_rounds = [
		_get_stageround_2_1(),
		_get_stageround_2_2(),
		_get_stageround_2_3(),
		
		_get_stageround_2_4(), #info
		_get_stageround_2_5(), #question
		
		_get_stageround_2_6(),
		
		_get_stageround_2_7(), #info
		_get_stageround_2_8(), #question
		
		_get_stageround_2_9(),
		
		_get_stageround_2_10(), #info
		_get_stageround_2_11(), #question
		
		_get_stageround_2_12(),
		
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_2_1():
	var stageround = StageRound.new(2, 1)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.3
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_2_2():
	var stageround = StageRound.new(2, 2)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.3
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_2_3():
	var stageround = StageRound.new(2, 3)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.3
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_2_4():
	var stageround = StageRound.new(2, 4)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_2_5():
	var stageround = StageRound.new(2, 5)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_2_6():
	var stageround = StageRound.new(2, 6)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_2_7():
	var stageround = StageRound.new(2, 7)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_2_8():
	var stageround = StageRound.new(2, 8)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_2_9():
	var stageround = StageRound.new(2, 9)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_2_10():
	var stageround = StageRound.new(2, 10)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_2_11():
	var stageround = StageRound.new(2, 11)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_2_12():
	var stageround = StageRound.new(2, 12)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

#
