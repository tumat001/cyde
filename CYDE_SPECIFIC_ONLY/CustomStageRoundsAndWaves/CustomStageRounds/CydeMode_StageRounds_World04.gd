extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 04 #####


func _init():
	stage_rounds = [
		_get_stageround_4_1(),
		_get_stageround_4_2(),
		_get_stageround_4_3(),
		_get_stageround_4_4(), 
		
		_get_stageround_4_5(), #info
		_get_stageround_4_6(), #question
		
		_get_stageround_4_7(), 
		
		_get_stageround_4_8(), #info
		_get_stageround_4_9(), #question
		
		_get_stageround_4_10(), 
		
		_get_stageround_4_11(), #info
		_get_stageround_4_12(), #question
		
		_get_stageround_4_13(),
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_4_1():
	var stageround = StageRound.new(4, 1)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_4_2():
	var stageround = StageRound.new(4, 2)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.5
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_4_3():
	var stageround = StageRound.new(4, 3)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_4_4():
	var stageround = StageRound.new(4, 4)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	
	return stageround

func _get_stageround_4_5():
	var stageround = StageRound.new(4, 5)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_4_6():
	var stageround = StageRound.new(4, 6)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_4_7():
	var stageround = StageRound.new(4, 7)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_4_8():
	var stageround = StageRound.new(4, 8)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_4_9():
	var stageround = StageRound.new(4, 9)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_4_10():
	var stageround = StageRound.new(4, 10)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_4_11():
	var stageround = StageRound.new(4, 11)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	
	stageround.is_info_round = true
	
	return stageround

func _get_stageround_4_12():
	var stageround = StageRound.new(4, 12)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_4_13():
	var stageround = StageRound.new(4, 13)
	stageround.end_of_round_gold = 2
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


#
