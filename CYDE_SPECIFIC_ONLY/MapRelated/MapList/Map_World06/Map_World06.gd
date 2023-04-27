extends "res://CYDE_SPECIFIC_ONLY/MapRelated/BaseCydeMap.gd"



var game_elements


onready var base_enemy_path = $EnemyPaths/EnemyPath
onready var mirrored_enemy_path = $EnemyPaths/EnemyPath02

#

func _init():
	pass
	#_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World02)
	



func _apply_map_specific_changes_to_game_elements(arg_game_elements):
	._apply_map_specific_changes_to_game_elements(arg_game_elements)
	
	game_elements = arg_game_elements
	
	var modis = [
		StoreOfGameModifiers.GameModiIds__CYDE_Common_Modifiers,
		StoreOfGameModifiers.GameModiIds__CYDE_World_06,
	]
	arg_game_elements.game_modifiers_manager.add_game_modi_ids(modis)
	
	_configure_mirror_path_curve()
	
	game_elements.enemy_manager.current_path_to_spawn_pattern = arg_game_elements.enemy_manager.PathToSpawnPattern.SWITCH_PER_SPAWN


func _configure_mirror_path_curve():
	var reversed_curve : Curve2D = Curve2D.new()
	for point in base_enemy_path.curve.get_baked_points():
		var new_point := Vector2(point.x, game_elements.get_bot_right_coordinates_of_playable_map().y - point.y + game_elements.get_top_left_coordinates_of_playable_map().y) #
		reversed_curve.add_point(new_point)
	
	var curve_id = 2 #could be any
	mirrored_enemy_path.set_curve_and_id(reversed_curve, curve_id)

######

