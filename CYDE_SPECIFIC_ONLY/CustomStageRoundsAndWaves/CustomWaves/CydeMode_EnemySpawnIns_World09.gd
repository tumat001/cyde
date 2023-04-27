extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"

func get_instructions_for_stageround(uuid : String):
	if uuid == "91":
		return _get_instructions_for_0_1()
	elif uuid == "92":
		return _get_instructions_for_0_2()
	elif uuid == "93":
		return _get_instructions_for_0_3()
	elif uuid == "94":
		return _get_instructions_for_0_4()
	elif uuid == "95":
		return _get_instructions_for_0_5()
	elif uuid == "96":
		return _get_instructions_for_0_6()
	elif uuid == "97":
		return _get_instructions_for_0_7()
	elif uuid == "98":
		return _get_instructions_for_0_8()
	elif uuid == "99":
		return _get_instructions_for_0_9()
	elif uuid == "910":
		return _get_instructions_for_0_10()
	elif uuid == "911":
		return _get_instructions_for_0_11()
	elif uuid == "912":
		return _get_instructions_for_0_12()
	elif uuid == "913":
		return _get_instructions_for_0_13()
	
	
	return null


###

func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41" #anything but starting with 9
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(4, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		SingleEnemySpawnInstruction.new(9, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		SingleEnemySpawnInstruction.new(2.5, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		SingleEnemySpawnInstruction.new(4, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 3, 0.3, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		MultipleEnemySpawnInstruction.new(12, 3, 0.3, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		MultipleEnemySpawnInstruction.new(8, 3, 0.5, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		LinearEnemySpawnInstruction.new(6, 3, 0.5, 0.060, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.MOBILE_MALWARE__MEMORY_RESIDENT),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 3, 0.15, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MOBILE_MALWARE_BOSS),
		
		MultipleEnemySpawnInstruction.new(16, 3, 0.15, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
	]
