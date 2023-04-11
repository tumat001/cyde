extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 08 #####


func _init():
	stage_rounds = [
		_get_stageround_8_1(),
		_get_stageround_8_2(),
		_get_stageround_8_3(),
		_get_stageround_8_4(), 
		
		_get_stageround_8_5(), #info
		_get_stageround_8_6(), #question
		
		_get_stageround_8_7(), 
		
		_get_stageround_8_8(), #info
		_get_stageround_8_9(), #question
		
		_get_stageround_8_10(), 
		
		_get_stageround_8_11(), #info
		_get_stageround_8_12(), #question
		
		_get_stageround_8_13(),
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_8_1():
	var stageround = StageRound.new(8, 1)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_8_2():
	var stageround = StageRound.new(8, 2)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.5
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_8_3():
	var stageround = StageRound.new(8, 3)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_8_4():
	var stageround = StageRound.new(8, 4)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	
	return stageround

func _get_stageround_8_5():
	var stageround = StageRound.new(8, 5)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_8_6():
	var stageround = StageRound.new(8, 6)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_8_7():
	var stageround = StageRound.new(8, 7)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_8_8():
	var stageround = StageRound.new(8, 8)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_8_9():
	var stageround = StageRound.new(8, 9)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_8_10():
	var stageround = StageRound.new(8, 10)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_8_11():
	var stageround = StageRound.new(8, 11)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_8_12():
	var stageround = StageRound.new(8, 12)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_8_13():
	var stageround = StageRound.new(8, 13)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


#
