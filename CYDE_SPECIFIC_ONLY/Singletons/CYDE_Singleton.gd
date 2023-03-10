extends Node

# CONSTANTS

const cyde_robot__name := "Cyde"
const dr_kevin_murphy__full_name = "Dr. Kevin Murphy"
const dr_kevin_murphy__last_name = "Dr. Murphy"
const dr_asi_mitnick__full_name = "Dr. Asi Mitnik"
const dr_asi_mitnick__last_name = "Dr. Mitnik"

const cyberland__name := "Cyberland"


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
	
	_fill_in_missing_world_id_to_world_completion_num_state(arg_save_dict[data_name__world_id_to_world_completion_num_state_map], 0)

func _fill_in_missing_world_id_to_world_completion_num_state(arg_specific_save_dict : Dictionary, arg_default_val):
	for modi_name in StoreOfGameModifiers.all_cyde_world_modi_names:
		if !arg_specific_save_dict.has(modi_name):
			arg_specific_save_dict[modi_name] = arg_default_val


func set_world_completion_state_num_to_world_id(arg_state, arg_id):
	world_id_to_world_completion_num_state_dict[arg_id] = arg_state

func get_world_completion_state_num_to_world_id(arg_id):
	return world_id_to_world_completion_num_state_dict[arg_id]



