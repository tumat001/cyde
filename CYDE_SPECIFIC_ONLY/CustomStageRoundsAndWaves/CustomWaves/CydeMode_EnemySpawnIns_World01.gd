extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "11":
		return _get_instructions_for_0_1()
	elif uuid == "12":
		return _get_instructions_for_0_2()
	elif uuid == "13":
		return _get_instructions_for_0_3()
	elif uuid == "14":
		return _get_instructions_for_0_4()
	elif uuid == "15":
		return _get_instructions_for_0_5()
	elif uuid == "16":
		return _get_instructions_for_0_6()
	elif uuid == "17":
		return _get_instructions_for_0_7()
	elif uuid == "18":
		return _get_instructions_for_0_8()
	elif uuid == "19":
		return _get_instructions_for_0_9()
	elif uuid == "110":
		return _get_instructions_for_0_10()
	elif uuid == "111":
		return _get_instructions_for_0_11()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41"
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(3.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(5.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(10.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(18, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(3.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(5.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(10.5, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(18, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_7():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.BASIC),
	]


# BOSS
func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.VIRUS_BOSS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.BASIC),
	]
