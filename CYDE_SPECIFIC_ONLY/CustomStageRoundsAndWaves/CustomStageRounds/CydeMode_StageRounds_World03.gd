extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 03 #####


func _init():
	stage_rounds = [
		_get_stageround_3_1(),
		_get_stageround_3_2(),
		_get_stageround_3_3(),
		
		_get_stageround_3_4(), #info
		_get_stageround_3_5(), #question
		
		_get_stageround_3_6(),
		
		_get_stageround_3_7(), #info
		_get_stageround_3_8(), #question
		
		_get_stageround_3_9(),
		
		_get_stageround_3_10(), #info
		_get_stageround_3_11(), #question
		
		_get_stageround_3_12(),
		
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_3_1():
	var stageround = StageRound.new(3, 1)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_3_2():
	var stageround = StageRound.new(3, 2)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.3
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_3_3():
	var stageround = StageRound.new(3, 3)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.3
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_3_4():
	var stageround = StageRound.new(3, 4)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_3_5():
	var stageround = StageRound.new(3, 5)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_3_6():
	var stageround = StageRound.new(3, 6)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_3_7():
	var stageround = StageRound.new(3, 7)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_3_8():
	var stageround = StageRound.new(3, 8)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_3_9():
	var stageround = StageRound.new(3, 9)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_3_10():
	var stageround = StageRound.new(3, 10)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_3_11():
	var stageround = StageRound.new(3, 11)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_3_12():
	var stageround = StageRound.new(3, 12)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.65
	stageround.enemy_first_damage = 0
	
	return stageround

#
