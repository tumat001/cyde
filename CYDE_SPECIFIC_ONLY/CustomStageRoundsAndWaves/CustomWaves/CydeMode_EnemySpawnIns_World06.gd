extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"

# TODO, change enemy spawn styles.
# THIS is same as in stage 04

# TODO MUST BE ROOKIT instead of Fileless

func get_instructions_for_stageround(uuid : String):
	if uuid == "61":
		return _get_instructions_for_0_1()
	elif uuid == "62":
		return _get_instructions_for_0_2()
	elif uuid == "63":
		return _get_instructions_for_0_3()
	elif uuid == "64":
		return _get_instructions_for_0_4()
	elif uuid == "65":
		return _get_instructions_for_0_5()
	elif uuid == "66":
		return _get_instructions_for_0_6()
	elif uuid == "67":
		return _get_instructions_for_0_7()
	elif uuid == "68":
		return _get_instructions_for_0_8()
	elif uuid == "69":
		return _get_instructions_for_0_9()
	elif uuid == "610":
		return _get_instructions_for_0_10()
	elif uuid == "611":
		return _get_instructions_for_0_11()
	elif uuid == "612":
		return _get_instructions_for_0_12()
	elif uuid == "613":
		return _get_instructions_for_0_13()
	
	
	return null


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41" #anything but starting with 5
	
	#return uuid == "01"  # to transfer to other factions


#todo
#func _get_instructions_for_instant_win():
#	return [
#		#SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(8.25, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(8.5, EnemyConstants.Enemies.FILELESS__PHISHING),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 10, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(13, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		MultipleEnemySpawnInstruction.new(5, 4, 0.5, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		LinearEnemySpawnInstruction.new(6, 15, 0.5, 0.060, EnemyConstants.Enemies.FILELESS__KEYLOG, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.FILELESS__KEYLOG),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.FILELESS__PHISHING),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.FILELESS__PHISHING),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 6, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.FILELESS_BOSS),
		
		MultipleEnemySpawnInstruction.new(16, 6, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
		
	]
