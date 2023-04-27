extends "res://GameplayRelated/EnemiesInRounds/BaseMode_EnemySpawnIns.gd"


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
	return uuid == "41" #anything but starting with 6
	
	#return uuid == "01"  # to transfer to other factions


func _get_instructions_for_0_1():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
	]

func _get_instructions_for_0_2():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
	]

func _get_instructions_for_0_3():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
	]

func _get_instructions_for_0_4():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(9, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
	]

func _get_instructions_for_0_5():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(4, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(11, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		
	]

func _get_instructions_for_0_6():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(1.5, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(5.25, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(5.5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(8.25, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(8.5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		
	]

func _get_instructions_for_0_7():
	return [
		MultipleEnemySpawnInstruction.new(0, 6, 0.15, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		MultipleEnemySpawnInstruction.new(6, 8, 0.15, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		MultipleEnemySpawnInstruction.new(11, 10, 0.15, EnemyConstants.Enemies.ROOTKIT_MEMORY),
	]

func _get_instructions_for_0_8():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		
		
	]

func _get_instructions_for_0_9():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		MultipleEnemySpawnInstruction.new(5, 4, 0.5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		SingleEnemySpawnInstruction.new(10, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		
	]

func _get_instructions_for_0_10():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		MultipleEnemySpawnInstruction.new(7, 4, 0.5, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
	]


func _get_instructions_for_0_11():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(1, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(2, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		SingleEnemySpawnInstruction.new(3, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
		MultipleEnemySpawnInstruction.new(6, 20, 0.4, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
	]

func _get_instructions_for_0_12():
	return [
		SingleEnemySpawnInstruction.new(0, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		
		SingleEnemySpawnInstruction.new(5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(6, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(6.5, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(6.75, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7.0, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7.125, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		SingleEnemySpawnInstruction.new(7.25, EnemyConstants.Enemies.ROOTKIT_MEMORY),
		
		SingleEnemySpawnInstruction.new(12, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(14, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(15, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		SingleEnemySpawnInstruction.new(16, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		
	]

# BOSS
func _get_instructions_for_0_13():
	return [
		MultipleEnemySpawnInstruction.new(0, 2, 0.75, EnemyConstants.Enemies.ROOTKIT_VIRTUAL),
		
		SingleEnemySpawnInstruction.new(8, EnemyConstants.Enemies.ROOTKIT_BOSS),
		
		MultipleEnemySpawnInstruction.new(10, 10, 0.5, EnemyConstants.Enemies.ROOTKIT_KERNEL_MODE),
		
	]



