extends Node


###########################
# RESOURCES
##########################

# CONSTANTS

const cyde_robot__name := "Cyde"
const dr_kevin_murphy__full_name = "Dr. Kevin Murphy"
const dr_kevin_murphy__last_name = "Dr. Murphy"
const dr_asi_mitnick__full_name = "Dr. Asi Mitnick"
const dr_asi_mitnick__last_name = "Dr. Mitnick"

const cyberland__name := "Cyberland"


# IMAGES RELATED

enum CYDE_STATE {
	
	STANDARD_001 = 0
	STANDARD_002 = 1,
	STANDARD_003 = 2,
	
	SAD_001 = 10,
	SAD_002 = 11,
	
	ANGRY_001 = 20,
	ANGRY_002 = 21,
	
	HAPPY_001 = 30,
	
	WOW_001 = 40,
	
	LAUGH_001 = 50,
	
	DRAINED_001 = 60,
	DRAINED_002 = 61,
	
	
}
const cyde_state_to_image_map : Dictionary = {
	CYDE_STATE.STANDARD_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/NormalCyde.png"),
	CYDE_STATE.STANDARD_002 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/NormalCyde.png"),   #todo
	CYDE_STATE.STANDARD_003 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/NormalCyde.png"),   #todo
	
	CYDE_STATE.SAD_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/sad.png"),
	CYDE_STATE.SAD_002 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/sad.png"), #todo
	
	CYDE_STATE.ANGRY_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/angry.png"),
	CYDE_STATE.ANGRY_002 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/angry.png"), #todo
	
	CYDE_STATE.HAPPY_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/happy.png"),
	
	CYDE_STATE.WOW_001 : null, #preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/wow.png"),
	
	CYDE_STATE.LAUGH_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/laugh.png"),
	
	CYDE_STATE.DRAINED_001 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/drain.png"),
	CYDE_STATE.DRAINED_002 : preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/CYDE_Portraits/drain.png"), #todo
	
}




###########################
# SAVES AND STATES
##########################

# SAVE RELATED

const data_name__player_name := "data_name__player_name"
const data_name__world_id_to_world_completion_num_state_map = "data_name__world_id_to_world_completion_num_state_map"


var player_name : String
var world_id_to_world_completion_num_state_dict : Dictionary  # world dialog sm modi id -> int


#

var game_elements

#

func _on_singleton_initialize():
	GameSaveManager.load_stats__of_cyde_singleton()
	#call_deferred("_deferred_on_singleton_initialize")

#func _deferred_on_singleton_initialize():
#	GameSaveManager.load_stats__of_cyde_singleton()



func _init():
	CommsForBetweenScenes.connect("game_elements_created", self, "connect_signals_with_game_elements")


func connect_signals_with_game_elements(arg_game_elements):
	game_elements = arg_game_elements
	
	game_elements.connect("before_game_quit", self, "_on_before_game_quit", [], CONNECT_PERSIST)

func disconnect_signals_with_game_elements():
	game_elements.disconnect("before_game_quit", self, "_on_before_game_quit")
	
	game_elements = null

func _on_before_game_quit():
	disconnect_signals_with_game_elements()
	
	GameSaveManager.save_cyde_related_data__of_cyde_singleton()

#

func _get_save_dict_for_data():
	var save_dict = {
		data_name__player_name : player_name,
		data_name__world_id_to_world_completion_num_state_map : world_id_to_world_completion_num_state_dict,
		
	}
	
	return save_dict


func _load_save_data(arg_file : File):
	var save_dict = parse_json(arg_file.get_line())
	
	if !save_dict is Dictionary:
		save_dict = {}
	
	_initialize_stats_with_save_dict(save_dict)

func _initialize_stats_with_save_dict(arg_save_dict : Dictionary):
	_initialize_player_name(arg_save_dict)
	_initialize_world_id_to_world_completion_num_state_dict(arg_save_dict)
	

func _initialize_save_data_from_scratch():
	_initialize_stats_with_save_dict({})


### PLAYER NAME RELATED

func _initialize_player_name(arg_save_dict : Dictionary):
	if arg_save_dict.has(data_name__player_name):
		player_name = arg_save_dict[data_name__player_name]
		
	else:
		player_name = ""

func _initialize_world_id_to_world_completion_num_state_dict(arg_save_dict : Dictionary):
	if arg_save_dict.has(data_name__world_id_to_world_completion_num_state_map):
		world_id_to_world_completion_num_state_dict = arg_save_dict[data_name__world_id_to_world_completion_num_state_map]
		
	else:
		world_id_to_world_completion_num_state_dict = {}
	
	_fill_in_missing_world_id_to_world_completion_num_state(world_id_to_world_completion_num_state_dict, 0)

func _fill_in_missing_world_id_to_world_completion_num_state(arg_specific_save_dict : Dictionary, arg_default_val):
	for modi_name in StoreOfGameModifiers.all_cyde_world_modi_names:
		if !arg_specific_save_dict.has(modi_name):
			arg_specific_save_dict[modi_name] = arg_default_val


func set_world_completion_state_num_to_world_id(arg_state, arg_id):
	world_id_to_world_completion_num_state_dict[arg_id] = arg_state

func get_world_completion_state_num_to_world_id(arg_id) -> int:
	return world_id_to_world_completion_num_state_dict[arg_id]


#############################



