extends "res://CYDE_SPECIFIC_ONLY/MapRelated/BaseCydeMap.gd"




onready var boss_enemy_path = $EnemyPaths/BossEnemyPath


#####

func _init():
	pass
	

#####

func _apply_map_specific_changes_to_game_elements(arg_game_elements):
	._apply_map_specific_changes_to_game_elements(arg_game_elements)
	
	var modis = [
		StoreOfGameModifiers.GameModiIds__CYDE_Common_Modifiers,
		StoreOfGameModifiers.GameModiIds__CYDE_World_10,
	]
	arg_game_elements.game_modifiers_manager.add_game_modi_ids(modis)
	
	
	####
	
	boss_enemy_path.is_used_for_natural_spawning = false
	
	if !arg_game_elements.enemy_manager.is_connected("before_enemy_is_added_to_path", self, "_before_enemy_is_added_to_path"):
		arg_game_elements.enemy_manager.connect("before_enemy_is_added_to_path", self, "_before_enemy_is_added_to_path", [], CONNECT_PERSIST)
	
	

#####

func _before_enemy_is_added_to_path(enemy, path):
	if enemy.enemy_spawn_metadata_from_ins != null and enemy.enemy_spawn_metadata_from_ins.has(StoreOfEnemyMetadataIdsFromIns.STAGE_10_BOSS_PATH):
		boss_enemy_path.add_child(enemy)
		

