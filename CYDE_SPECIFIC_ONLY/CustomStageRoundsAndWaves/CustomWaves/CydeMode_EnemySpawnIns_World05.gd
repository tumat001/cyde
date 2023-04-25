extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "51":
		return _get_instructions_for_0_1()
	elif uuid == "52":
		return _get_instructions_for_0_2()
	elif uuid == "53":
		return _get_instructions_for_0_3()
	elif uuid == "54":
		return _get_instructions_for_0_4()
	elif uuid == "55":
		return _get_instructions_for_0_5()
	elif uuid == "56":
		return _get_instructions_for_0_6()
	elif uuid == "57":
		return _get_instructions_for_0_7()
	elif uuid == "58":
		return _get_instructions_for_0_8()
	elif uuid == "59":
		return _get_instructions_for_0_9()
	elif uuid == "510":
		return _get_instructions_for_0_10()
	elif uuid == "511":
		return _get_instructions_for_0_11()
	elif uuid == "512":
		return _get_instructions_for_0_12()
	elif uuid == "513":
		return _get_instructions_for_0_13()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41" #anything but starting with 5
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(12.25, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 5, 0.15, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
		MultipleEnemySpawnInstruction.new(8, 5, 0.15, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(8.5, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(8.75, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		
		LinearEnemySpawnInstruction.new(6, 15, 0.5, 0.060, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS, 0.1),
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		MultipleEnemySpawnInstruction.new(7, 5, 0.15, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.RANSOMWARE__ENCRYPTORS),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 2, 1, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.RANSOMWARE_BOSS),
		
		MultipleEnemySpawnInstruction.new(16, 6, 0.15, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
	]
