extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


func get_instructions_for_stageround(uuid : String):
	if uuid == "81":
		return _get_instructions_for_0_1()
	elif uuid == "82":
		return _get_instructions_for_0_2()
	elif uuid == "83":
		return _get_instructions_for_0_3()
	elif uuid == "84":
		return _get_instructions_for_0_4()
	elif uuid == "85":
		return _get_instructions_for_0_5()
	elif uuid == "86":
		return _get_instructions_for_0_6()
	elif uuid == "87":
		return _get_instructions_for_0_7()
	elif uuid == "88":
		return _get_instructions_for_0_8()
	elif uuid == "89":
		return _get_instructions_for_0_9()
	elif uuid == "810":
		return _get_instructions_for_0_10()
	elif uuid == "811":
		return _get_instructions_for_0_11()
	elif uuid == "812":
		return _get_instructions_for_0_12()
	elif uuid == "813":
		return _get_instructions_for_0_13()
	
	
	return null

#####


func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41" #anything but starting with 8
	
	#return uuid == "01"  # to transfer to other factions


#todo
#func _get_instructions_for_instant_win():
#	return [
#		#SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]



func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		MultipleEnemySpawnInstruction.new(4, 10, 0.2, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		SingleEnemySpawnInstruction.new(8.25, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		SingleEnemySpawnInstruction.new(8.5, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 12, 0.3, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MALWARE_BOT__DOS),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		MultipleEnemySpawnInstruction.new(0, 5, 0.8, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		MultipleEnemySpawnInstruction.new(10, 5, 0.3, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		MultipleEnemySpawnInstruction.new(5, 4, 0.5, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		LinearEnemySpawnInstruction.new(7, 10, 0.5, 0.060, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT, 0.1),
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
		MultipleEnemySpawnInstruction.new(5, 8, 0.15, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		
		MultipleEnemySpawnInstruction.new(12, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		MultipleEnemySpawnInstruction.new(14, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		MultipleEnemySpawnInstruction.new(16, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		MultipleEnemySpawnInstruction.new(10, 2, 1, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		MultipleEnemySpawnInstruction.new(10.5, 2, 1, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 6, 0.15, EnemyConstants.Enemies.MALWARE_BOT__SPAM_BOT),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.MALWARE_BOT_BOSS),
		
		MultipleEnemySpawnInstruction.new(16, 6, 0.15, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT),
		
	]
