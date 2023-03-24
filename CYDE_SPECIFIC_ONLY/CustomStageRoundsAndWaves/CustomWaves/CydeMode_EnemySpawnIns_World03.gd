extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "31":
		return _get_instructions_for_0_1()
	elif uuid == "32":
		return _get_instructions_for_0_2()
	elif uuid == "33":
		return _get_instructions_for_0_3()
	elif uuid == "34":
		return _get_instructions_for_0_4()
	elif uuid == "35":
		return _get_instructions_for_0_5()
	elif uuid == "36":
		return _get_instructions_for_0_6()
	elif uuid == "37":
		return _get_instructions_for_0_7()
	elif uuid == "38":
		return _get_instructions_for_0_8()
	elif uuid == "39":
		return _get_instructions_for_0_9()
	elif uuid == "310":
		return _get_instructions_for_0_10()
	elif uuid == "311":
		return _get_instructions_for_0_11()
	elif uuid == "312":
		return _get_instructions_for_0_12()
	elif uuid == "313":
		return _get_instructions_for_0_13()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41"
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.WORM__EMAIL),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(9.5, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.WORM__EMAIL),
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.WORM__EMAIL),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(5.5, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(7.5, EnemyConstants.Enemies.WORM__EMAIL),
		
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		
		MultipleEnemySpawnInstruction.new(5, 6, 0.2, EnemyConstants.Enemies.WORM__NETWORK),
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.WORM__EMAIL),
		
		MultipleEnemySpawnInstruction.new(8, 5, 0.1, EnemyConstants.Enemies.WORM__NETWORK),
		MultipleEnemySpawnInstruction.new(9, 5, 0.1, EnemyConstants.Enemies.WORM__NETWORK),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 16, 0.15, EnemyConstants.Enemies.WORM__NETWORK),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.WORM__EMAIL),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.WORM__NETWORK),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__EMAIL),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.WORM__EMAIL),
		
		LinearEnemySpawnInstruction.new(10, 15, 0.5, 0.060, EnemyConstants.Enemies.WORM__NETWORK, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.WORM__NETWORK),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.WORM__EMAIL),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.WORM__EMAIL),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.WORM__EMAIL),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(13.5, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(13.75, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 10, 0.15, EnemyConstants.Enemies.WORM__NETWORK),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.WORM_BOSS),
		
	]
