extends "res://GameplayRelated/StagesAndRoundsRelated/BaseMode_StageRounds.gd"

#### WORLD 10 #####


func _init():
	stage_rounds = [
		_get_stageround_10_1(),
		
		_get_stageround_10_2(), # normal
		_get_stageround_10_3(), # virus boss + question
		
		_get_stageround_10_4(), # trojan
		_get_stageround_10_5(), 
		
		_get_stageround_10_6(), # worms
		_get_stageround_10_7(), 
		
		_get_stageround_10_8(), # adware
		_get_stageround_10_9(), 
		
		_get_stageround_10_10(), # ransom
		_get_stageround_10_11(), 
		
		_get_stageround_10_12(), # rootkits
		_get_stageround_10_13(),
		
		_get_stageround_10_14(), # fileless
		_get_stageround_10_15(),
		
		_get_stageround_10_16(), # malware bots
		_get_stageround_10_17(),
		
		_get_stageround_10_18(), # mobile mal
		_get_stageround_10_19(),
		
		
		_get_stageround_10_20(),  # asi boss
		
	]
	

func get_first_half_faction() -> int:
	return EnemyConstants.EnemyFactions.BASIC



# stagerounds

func _get_stageround_10_1():
	var stageround = StageRound.new(10, 1)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.15
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_10_2():
	var stageround = StageRound.new(10, 2)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 0.5
	stageround.enemy_first_damage = 0
	
	
	return stageround

func _get_stageround_10_3():
	var stageround = StageRound.new(10, 3)
	stageround.end_of_round_gold = 3
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_4():
	var stageround = StageRound.new(10, 4)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_5():
	var stageround = StageRound.new(10, 5)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_6():
	var stageround = StageRound.new(10, 6)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_7():
	var stageround = StageRound.new(10, 7)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_8():
	var stageround = StageRound.new(10, 8)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_9():
	var stageround = StageRound.new(10, 9)
	stageround.end_of_round_gold = 4
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_10():
	var stageround = StageRound.new(10, 10)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_11():
	var stageround = StageRound.new(10, 11)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_12():
	var stageround = StageRound.new(10, 12)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_13():
	var stageround = StageRound.new(10, 13)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround


func _get_stageround_10_14():
	var stageround = StageRound.new(10, 14)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


func _get_stageround_10_15():
	var stageround = StageRound.new(10, 15)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround

func _get_stageround_10_16():
	var stageround = StageRound.new(10, 16)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

func _get_stageround_10_17():
	var stageround = StageRound.new(10, 17)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround


func _get_stageround_10_18():
	var stageround = StageRound.new(10, 18)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround


func _get_stageround_10_19():
	var stageround = StageRound.new(10, 19)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	stageround.is_question_round = true
	
	return stageround


func _get_stageround_10_20():
	var stageround = StageRound.new(10, 20)
	stageround.end_of_round_gold = 5
	stageround.enemy_damage_multiplier = 1
	stageround.enemy_health_multiplier = 1
	stageround.enemy_first_damage = 0
	
	return stageround

#
