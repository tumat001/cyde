extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 09 #####


func _init():
	stage_rounds = [
		_get_stageround_9_1(),
		_get_stageround_9_2(),
		_get_stageround_9_3(),
		_get_stageround_9_4(), 
		
		_get_stageround_9_5(), #info
		_get_stageround_9_6(), #question
		
		_get_stageround_9_7(), 
		
		_get_stageround_9_8(), #info
		_get_stageround_9_9(), #question
		
		_get_stageround_9_10(), 
		
		_get_stageround_9_11(), #info
		_get_stageround_9_12(), #question
		
		_get_stageround_9_13(),
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_9_1():
	var stageround = StageRound.new(9, 1)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_9_2():
	var stageround = StageRound.new(9, 2)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.5
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_9_3():
	var stageround = StageRound.new(9, 3)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_9_4():
	var stageround = StageRound.new(9, 4)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	
	return stageround

func _get_stageround_9_5():
	var stageround = StageRound.new(9, 5)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_9_6():
	var stageround = StageRound.new(9, 6)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_9_7():
	var stageround = StageRound.new(9, 7)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_9_8():
	var stageround = StageRound.new(9, 8)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_9_9():
	var stageround = StageRound.new(9, 9)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_9_10():
	var stageround = StageRound.new(9, 10)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_9_11():
	var stageround = StageRound.new(9, 11)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_9_12():
	var stageround = StageRound.new(9, 12)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_9_13():
	var stageround = StageRound.new(9, 13)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


#
