extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "41":
		return _get_instructions_for_0_1()
	elif uuid == "42":
		return _get_instructions_for_0_2()
	elif uuid == "43":
		return _get_instructions_for_0_3()
	elif uuid == "44":
		return _get_instructions_for_0_4()
	elif uuid == "45":
		return _get_instructions_for_0_5()
	elif uuid == "46":
		return _get_instructions_for_0_6()
	elif uuid == "47":
		return _get_instructions_for_0_7()
	elif uuid == "48":
		return _get_instructions_for_0_8()
	elif uuid == "49":
		return _get_instructions_for_0_9()
	elif uuid == "410":
		return _get_instructions_for_0_10()
	elif uuid == "411":
		return _get_instructions_for_0_11()
	elif uuid == "412":
		return _get_instructions_for_0_12()
	elif uuid == "413":
		return _get_instructions_for_0_13()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "51" #anything but starting with 4
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(8.25, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(8.5, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 10, 0.15, EnemyConstants.Enemies.ADWARE__DESK_AD),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		MultipleEnemySpawnInstruction.new(5, 4, 0.5, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		LinearEnemySpawnInstruction.new(6, 15, 0.5, 0.060, EnemyConstants.Enemies.ADWARE__APPEARCH, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 6, 0.15, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ADWARE_BOSS),
		
		MultipleEnemySpawnInstruction.new(16, 6, 0.15, EnemyConstants.Enemies.ADWARE__DESK_AD),
		
	]
