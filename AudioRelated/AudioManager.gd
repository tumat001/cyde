extends Node


const AudioStreamPlayerComponentPool = preload("res://MiscRelated/PoolRelated/Implementations/AudioStreamPlayerComponentPool.gd")

const ValTransition = preload("res://MiscRelated/ValTransitionRelated/ValTransition.gd")


#const DECIBEL_LEVEL__STANDARD : float = -30.0   #todo tentative

enum MaskLevel {
	
	MASK_02 = 2
	MASK_01 = 1
	
}

var total_active_stream_player_count_per_mask_level : int = 80

var sound_path_name_to__stream_player_node_to_is_active_map : Dictionary
var stream_player_node_to_mask_level_map : Dictionary
var mask_level_to_active_count_map : Dictionary
var source_id_to_stream_players_arr_map : Dictionary
#var _current_total_active_stream_player_count : int

var stream_player_to_linear_audio_set_param_map : Dictionary

#var audio_stream_player_component_pool : AudioStreamPlayerComponentPool

var _center_of_screen : Vector2


enum PlayerConstructionType {
	PLAIN = 0
	TWO_D = 1
	
}



var _next_available_id : int = 0

#

var _last_calc_has_linear_set_params : bool

#

# DONT Instantiate. Use methods
class PlayAdvParams:
	
	signal node_source_tree_exiting(id_source)
	
	func _init(arg_id):
		id_source = arg_id
	
	var node_source setget set_node_source
	var id_source
	
	#
	
	func set_node_source(arg_node):
		if is_instance_valid(node_source):
			node_source.disconnect("tree_exiting", self, "_on_node_source_tree_exiting")
		
		node_source = arg_node
		
		if is_instance_valid(node_source):
			node_source.connect("tree_exiting", self, "_on_node_source_tree_exiting")
	
	func _on_node_source_tree_exiting():
		emit_signal("node_source_tree_exiting", id_source)
		

#

func _ready():
	for mask_level in MaskLevel.values():
		mask_level_to_active_count_map[mask_level] = 0
	
	
	#audio_stream_player_component_pool = AudioStreamPlayerComponentPool.new()
	#audio_stream_player_component_pool.node_to_parent = self
	#audio_stream_player_component_pool.source_of_create_resource = self
	
	_center_of_screen = get_viewport().size / 2
	
	_update_can_do_process()

####

func construct_play_adv_params() -> PlayAdvParams:
	var id = _next_available_id
	_next_available_id += 1 
	return PlayAdvParams.new(id)


#############


func play_sound(arg_audio_path_name : String, 
		arg_mask_level : int, arg_construction_type : int = PlayerConstructionType.PLAIN,
		play_adv_params : PlayAdvParams = null):
	
	var stream_player = get_available_or_construct_new_audio_stream_player(arg_audio_path_name, arg_construction_type)
	
	return play_sound__with_provided_stream_player(arg_audio_path_name, stream_player, arg_mask_level)


# returns bool, whether the sound is played or not based on sound count limit
func play_sound__with_provided_stream_player(arg_audio_path_name : String, arg_stream_player, 
		arg_mask_level : int, play_adv_params : PlayAdvParams = null):
	
	if mask_level_to_active_count_map[arg_mask_level] <= total_active_stream_player_count_per_mask_level:
		if !sound_path_name_to__stream_player_node_to_is_active_map.has(arg_audio_path_name):
			sound_path_name_to__stream_player_node_to_is_active_map[arg_audio_path_name] = {}
		sound_path_name_to__stream_player_node_to_is_active_map[arg_audio_path_name][arg_stream_player] = true
		
		stream_player_node_to_mask_level_map[arg_stream_player] = arg_mask_level
		
		mask_level_to_active_count_map[arg_mask_level] += 1
		
		if play_adv_params != null:
			if !source_id_to_stream_players_arr_map.has(play_adv_params.id_source):
				source_id_to_stream_players_arr_map[play_adv_params.id_source] = []
			source_id_to_stream_players_arr_map[play_adv_params.id_source].append(arg_stream_player)
			
			if !play_adv_params.is_connected("node_source_tree_exiting", self, "_on_play_adv_param_node_source_tree_exiting"):
				play_adv_params.connect("node_source_tree_exiting", self, "_on_play_adv_param_node_source_tree_exiting")
		
		arg_stream_player.play()
		
		return true
	else:
		return false


# to be used by outside sources, and the node be fed to "play_sound__using_path_name"
func get_available_or_construct_new_audio_stream_player(arg_path_name : String, player_construction_type : int):
	var player
	
	if sound_path_name_to__stream_player_node_to_is_active_map.has(arg_path_name):
		var stream_player_node_to_is_active_map = sound_path_name_to__stream_player_node_to_is_active_map[arg_path_name]
		for player_node in stream_player_node_to_is_active_map:
			if !stream_player_node_to_is_active_map[player_node]:
				player = player_node
				break
		
		if player == null:
			player = _construct_new_audio_stream_player__based_on_cons_type(player_construction_type)
		
	else:
		player = _construct_new_audio_stream_player__based_on_cons_type(player_construction_type)
	
	
	player.stream = load(arg_path_name)
	
	_connect_signals_of_stream_player(player, arg_path_name)
	
	return player


func _construct_new_audio_stream_player__based_on_cons_type(arg_cons_type : int):
	if arg_cons_type == PlayerConstructionType.PLAIN:
		return _construct_new_audio_stream_player()
	elif arg_cons_type == PlayerConstructionType.TWO_D:
		return _construct_new_audio_stream_player_2D()

func _construct_new_audio_stream_player():
	var player = AudioStreamPlayer.new()
	
	player.connect("tree_exiting", self, "_on_stream_player_queue_free", [player])
	
	add_child(player)
	
	return player

func _construct_new_audio_stream_player_2D():
	var player = AudioStreamPlayer2D.new()
	
	player.connect("tree_exiting", self, "_on_stream_player_queue_free", [player])
	
	add_child(player)
	
	return player

#

func _connect_signals_of_stream_player(arg_stream_player, arg_path_name):
	if !arg_stream_player.is_connected("finished", self, "_on_stream_player_finished"):
		arg_stream_player.connect("finished", self, "_on_stream_player_finished", [arg_stream_player, arg_path_name])
	


func _on_play_adv_param_node_source_tree_exiting(arg_id):
	stop_stream_players_with_source_ids(arg_id)
	


#

func stop_stream_players_with_source_ids(arg_id):
	var remove_bucket = []
	var stream_players = source_id_to_stream_players_arr_map[arg_id]
	for player in stream_players:
		if is_instance_valid(player):
			stop_stream_player_and_mark_as_inactive(player)
		else:
			remove_bucket.append(player)
	
	for player in remove_bucket:
		source_id_to_stream_players_arr_map[arg_id].erase(player)


func _on_stream_player_finished(arg_stream_player, arg_path_name):
	stop_stream_player_and_mark_as_inactive(arg_stream_player)
	

func stop_stream_player_and_mark_as_inactive(arg_stream_player):
	if arg_stream_player.is_connected("finished", self, "_on_stream_player_finished"):
		arg_stream_player.disconnect("finished", self, "_on_stream_player_finished")
	
	var arg_path_name = arg_stream_player.stream.resource_path
	
	arg_stream_player.stop()
	
	sound_path_name_to__stream_player_node_to_is_active_map[arg_path_name][arg_stream_player] = false
	var mask_level = stream_player_node_to_mask_level_map[arg_stream_player]
	mask_level_to_active_count_map[mask_level] -= 1



func _on_stream_player_queue_free(arg_stream_player):
	remove_stream_player(arg_stream_player)

func remove_stream_player(arg_stream_player):
	var arg_path_name = arg_stream_player.stream.resource_name
	
	var mask_level = stream_player_node_to_mask_level_map[arg_stream_player]
	
	var node_to_is_active_map
	if sound_path_name_to__stream_player_node_to_is_active_map.has(arg_path_name):
		node_to_is_active_map = sound_path_name_to__stream_player_node_to_is_active_map[arg_path_name]
		
		sound_path_name_to__stream_player_node_to_is_active_map[arg_path_name].clear()
	
	var is_active = false
	if node_to_is_active_map != null:
		is_active = node_to_is_active_map[arg_stream_player]
	
	stream_player_node_to_mask_level_map.erase(arg_stream_player)
	
	if stream_player_to_linear_audio_set_param_map.has(arg_stream_player):
		stream_player_to_linear_audio_set_param_map.erase(arg_stream_player)
	
	if is_active:
		mask_level_to_active_count_map[mask_level] -= 1


#######

class LinearSetAudioParams:
	var pause_at_target_volume : bool
	var stop_at_target_volume : bool
	
	var target_volume : float
	
	# set by AudioManager
	var _val_transition

func linear_set_audio_player_volume_to(arg_player, arg_linear_set_params : LinearSetAudioParams):
	stream_player_to_linear_audio_set_param_map[arg_player] = arg_linear_set_params
	arg_linear_set_params._val_transition = ValTransition.new()
	arg_linear_set_params._val_transition.connect("target_val_reached", self, "_on_target_val_reached", [arg_player, arg_linear_set_params])
	
	_last_calc_has_linear_set_params = true
	_update_can_do_process()


func _update_can_do_process():
	var can_do_process = _last_calc_has_linear_set_params
	
	set_process(can_do_process)


func _process(delta):
	for player in stream_player_to_linear_audio_set_param_map:
		var param : LinearSetAudioParams = stream_player_to_linear_audio_set_param_map[player]
		
		
	

