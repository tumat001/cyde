extends "res://CYDE_SPECIFIC_ONLY/MapRelated/BaseCydeMap.gd"


func _init():
	pass
	#_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World02)
	



func _apply_map_specific_changes_to_game_elements(arg_game_elements):
	._apply_map_specific_changes_to_game_elements(arg_game_elements)
	
	var modis = [
		StoreOfGameModifiers.GameModiIds__CYDE_Common_Modifiers,
		StoreOfGameModifiers.GameModiIds__CYDE_World_03,
	]
	arg_game_elements.game_modifiers_manager.add_game_modi_ids(modis)
	
