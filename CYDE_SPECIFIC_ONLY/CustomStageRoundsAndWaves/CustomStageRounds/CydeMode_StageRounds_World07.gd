extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 07 #####


func _init():
	stage_rounds = [
		_get_stageround_7_1(),
		_get_stageround_7_2(),
		_get_stageround_7_3(),
		_get_stageround_7_4(), 
		
		_get_stageround_7_5(), #info
		_get_stageround_7_6(), #question
		
		_get_stageround_7_7(), 
		
		_get_stageround_7_8(), #info
		_get_stageround_7_9(), #question
		
		_get_stageround_7_10(), 
		
		_get_stageround_7_11(), #info
		_get_stageround_7_12(), #question
		
		_get_stageround_7_13(),
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_7_1():
	var stageround = StageRound.new(7, 1)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_7_2():
	var stageround = StageRound.new(7, 2)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.5
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_7_3():
	var stageround = StageRound.new(7, 3)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_7_4():
	var stageround = StageRound.new(7, 4)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	
	return stageround

func _get_stageround_7_5():
	var stageround = StageRound.new(7, 5)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_7_6():
	var stageround = StageRound.new(7, 6)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_7_7():
	var stageround = StageRound.new(7, 7)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_7_8():
	var stageround = StageRound.new(7, 8)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_7_9():
	var stageround = StageRound.new(7, 9)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_7_10():
	var stageround = StageRound.new(7, 10)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_7_11():
	var stageround = StageRound.new(7, 11)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_7_12():
	var stageround = StageRound.new(7, 12)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_7_13():
	var stageround = StageRound.new(7, 13)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


#
