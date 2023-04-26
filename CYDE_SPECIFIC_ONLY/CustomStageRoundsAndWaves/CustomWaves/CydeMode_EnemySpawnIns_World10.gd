extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"

# TODO, change enemy spawn styles.
# THIS is same as in stage 04


# CHANGE INTO: Boss style waves

func get_instructions_for_stageround(uuid : String):
	if uuid == "101":
		return _get_instructions_for_0_1()
	elif uuid == "102":
		return _get_instructions_for_0_2()
	elif uuid == "103":
		return _get_instructions_for_0_3()
	elif uuid == "104":
		return _get_instructions_for_0_4()
	elif uuid == "105":
		return _get_instructions_for_0_5()
	elif uuid == "106":
		return _get_instructions_for_0_6()
	elif uuid == "107":
		return _get_instructions_for_0_7()
	elif uuid == "108":
		return _get_instructions_for_0_8()
	elif uuid == "109":
		return _get_instructions_for_0_9()
	elif uuid == "1010":
		return _get_instructions_for_0_10()
	elif uuid == "1011":
		return _get_instructions_for_0_11()
	elif uuid == "1012":
		return _get_instructions_for_0_12()
#	elif uuid == "1013":
#		return _get_instructions_for_0_13()
#	elif uuid == "1014":
#		return _get_instructions_for_0_14()
#	elif uuid == "1015":
#		return _get_instructions_for_0_15()
#	elif uuid == "1016":
#		return _get_instructions_for_0_16()
#	elif uuid == "1017":
#		return _get_instructions_for_0_17()
#	elif uuid == "1018":
#		return _get_instructions_for_0_18()
#	elif uuid == "1019":
#		return _get_instructions_for_0_19()
#	elif uuid == "1020":
#		return _get_instructions_for_0_20()
#
	
	return null



func is_transition_time_in_stageround(uuid : String) -> bool:
	return uuid == "41" #anything but starting with 10
	
	#return uuid == "01"  # to transfer to other factions



func _get_instructions_for_0_1():
	return [
		#SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.AMALGAMATION_ADWORM),
		
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.VIRUS__DIRECT_ACTION),
		SingleEnemySpawnInstruction.new(4, EnemyConstants.Enemies.VIRUS__DIRECT_ACTION),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.VIRUS__DIRECT_ACTION),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.TROJAN__DDOS),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.TROJAN__DDOS),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.VIRUS__DIRECT_ACTION),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.VIRUS__BOOT_SECTOR),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.VIRUS__BOOT_SECTOR),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.TROJAN__BANKING),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.TROJAN__DDOS),
		SingleEnemySpawnInstruction.new(9, EnemyConstants.Enemies.TROJAN__DDOS),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.TROJAN__DDOS),
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.AMALGAMATION_VIRJAN),
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__DESK_AD),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(11.5, EnemyConstants.Enemies.WORM__I_LOVE_U),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.WORM__I_LOVE_U),
		
		SingleEnemySpawnInstruction.new(18, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(19, EnemyConstants.Enemies.WORM__NETWORK),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ADWARE__DOLLAR_REVENUE),
		
		MultipleEnemySpawnInstruction.new(6, 10, 0.5, EnemyConstants.Enemies.WORM__NETWORK),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.ADWARE__APPEARCH),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ADWARE__APPEARCH),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.AMALGAMATION_ADWORM),
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 7, 0.70, EnemyConstants.Enemies.RANSOMWARE__LOCKERSWARE),
		
		MultipleEnemySpawnInstruction.new(0.35, 7, 0.70, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(2.5, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.RANSOMWARE__AS_A_SERVICE),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7.25, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7.5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.AMALGAMATION_RANSKIT),
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.MOBILE_MALWARE__SAMSAM),
		
		LinearEnemySpawnInstruction.new(5, 15, 0.5, 0.060, EnemyConstants.Enemies.MALWARE_BOT__CHATTER_BOT, 0.1),
		
		SingleEnemySpawnInstruction.new(9, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(10.5, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(10.75, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		SingleEnemySpawnInstruction.new(10.825, EnemyConstants.Enemies.FILELESS__SCAMBOTS),
		
		
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.MOBILE_MALWARE__WINDOWS_REGISTRY),
		
		MultipleEnemySpawnInstruction.new(0, 15, 1, EnemyConstants.Enemies.FILELESS__PHISHING),
		
		
		MultipleEnemySpawnInstruction.new(8, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		MultipleEnemySpawnInstruction.new(9, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		MultipleEnemySpawnInstruction.new(10, 2, 0.1, EnemyConstants.Enemies.MALWARE_BOT__DOS),
		
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.AMALGAMATION_MALFILEBOT),
		
	]
#
#func _get_instructions_for_0_13():
#	return [
#		MultipleEnemySpawnInstruction.new(0, 6, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
#
#		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.FILELESS_BOSS),
#
#		MultipleEnemySpawnInstruction.new(16, 6, 0.15, EnemyConstants.Enemies.FILELESS__PHISHING),
#
#	]
#
#
#func _get_instructions_for_0_14():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_15():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_16():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_17():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_18():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_19():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
#func _get_instructions_for_0_20():
#	return [
#		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.FILELESS__KEYLOG),
#	]
#
