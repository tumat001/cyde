extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "21":
		return _get_instructions_for_0_1()
	elif uuid == "22":
		return _get_instructions_for_0_2()
	elif uuid == "23":
		return _get_instructions_for_0_3()
	elif uuid == "24":
		return _get_instructions_for_0_4()
	elif uuid == "25":
		return _get_instructions_for_0_5()
	elif uuid == "26":
		return _get_instructions_for_0_6()
	elif uuid == "27":
		return _get_instructions_for_0_7()
	elif uuid == "28":
		return _get_instructions_for_0_8()
	elif uuid == "29":
		return _get_instructions_for_0_9()
	elif uuid == "210":
		return _get_instructions_for_0_10()
	elif uuid == "211":
		return _get_instructions_for_0_11()
	elif uuid == "212":
		return _get_instructions_for_0_12()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41"
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.TROJAN__SMS),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.TROJAN__SMS),
		
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(5.5, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(7.5, EnemyConstants.Enemies.TROJAN__SMS),
		
		
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(15.5, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.TROJAN__SMS),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		
		MultipleEnemySpawnInstruction.new(5, 6, 0.2, EnemyConstants.Enemies.TROJAN__DDOS),
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__SMS),
		
		MultipleEnemySpawnInstruction.new(8, 5, 0.1, EnemyConstants.Enemies.TROJAN__DDOS),
		MultipleEnemySpawnInstruction.new(9, 5, 0.1, EnemyConstants.Enemies.TROJAN__DDOS),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 8, 0.15, EnemyConstants.Enemies.TROJAN__DDOS),
		
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(9, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.TROJAN__SMS),
		
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__SMS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(11.5, EnemyConstants.Enemies.TROJAN__BANKING),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__SMS),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.TROJAN__DDOS),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.TROJAN__BANKING),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__SMS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__SMS),
		
		LinearEnemySpawnInstruction.new(10, 15, 0.5, 0.060, EnemyConstants.Enemies.TROJAN__DDOS, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.TROJAN__BANKING),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.TROJAN__DDOS),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.TROJAN__SMS),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.TROJAN__SMS),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.TROJAN__SMS),
		
		
	]


# BOSS
func _get_instructions_for_0_12():
	return [
		MultipleEnemySpawnInstruction.new(0, 10, 0.15, EnemyConstants.Enemies.TROJAN__DDOS),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.TROJAN_BOSS),
		
	]
