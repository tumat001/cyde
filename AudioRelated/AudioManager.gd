extends Node


const AudioStreamPlayerComponentPool = preload("res://MiscRelated/PoolRelated/Implementations/AudioStreamPlayerComponentPool.gd")
const ValTransition = preload("res://MiscRelated/ValTransitionRelated/ValTransition.gd")


# save related

var data_name__background_music_volume_name : String = "backgroundmusic_volume"
var data_name__background_music_is_mute_name : String = "backgroundmusic_ismute"

var data_name__sound_fx_volume_name : String = "soundfx_volume"
var data_name__sound_fx_is_mute_name : String = "soundfx_ismute"


#

const DECIBEL_VAL__INAUDIABLE : float = -30.0   # true zero/silence cannot be met, but this should be good enough
const DECIBEL_VAL__STANDARD : float = 0.0  

#

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
var player_sound_type_to_stream_players_map : Dictionary
var stream_player_to_adv_params_map : Dictionary

#var audio_stream_player_component_pool : AudioStreamPlayerComponentPool

var _center_of_screen : Vector2


enum PlayerConstructionType {
	PLAIN = 0
	TWO_D = 1
}

enum PlayerSoundType {
	SOUND_FX = 0,
	BACKGROUND_MUSIC = 1,
	
	
	DEFAULT = 0,
}

const bus__sound_fx_name : String = "SoundFX"
const bus__background_name : String = "Background"

const player_sound_type_to_bus_name_map : Dictionary = {
	PlayerSoundType.SOUND_FX : bus__sound_fx_name,
	PlayerSoundType.BACKGROUND_MUSIC : bus__background_name,
}


var _next_available_id : int = 0

#

var _last_calc_has_linear_set_params : bool

#

var bus__sound_fx_volume : float setget set_bus__sound_fx_volume
signal bus__sound_fx_volume_changed(arg_val)
var bus__sound_fx_bus_mute : bool setget set_bus__sound_fx_bus_mute
signal bus__sound_fx_mute_changed(arg_val)

var bus__background_music_volume : float setget set_bus__background_music_volume
signal bus__background_music_volume_changed(arg_val)
var bus__background_music_bus_mute : bool setget set_bus__background_music_bus_mute
signal bus__background_music_mute_changed(arg_val)


#

var game_elements

#####


# DONT Instantiate. Use methods
class PlayAdvParams:
	
	signal node_source_tree_exiting(id_source)
	
	func _init(arg_id):
		id_source = arg_id
	
	var node_source setget set_node_source
	var id_source
	
	var play_sound_type : int
	
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
	
	#######
	

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
		
		if play_adv_params != null:
			arg_stream_player.bus = player_sound_type_to_bus_name_map[play_adv_params.play_sound_type]
		else:
			arg_stream_player.bus = player_sound_type_to_bus_name_map[PlayerSoundType.DEFAULT]
		arg_stream_player.play()
		
		#
		
		var sound_type = PlayerSoundType.DEFAULT
		if play_adv_params != null:
			sound_type = play_adv_params.play_sound_type
		
		if !player_sound_type_to_stream_players_map.has(sound_type):
			player_sound_type_to_stream_players_map[sound_type] = []
		if !player_sound_type_to_stream_players_map[sound_type].has(arg_stream_player):
			player_sound_type_to_stream_players_map[sound_type].append(arg_stream_player)
		
		stream_player_to_adv_params_map[arg_stream_player] = play_adv_params
		
		
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
	
	
	var adv_param : PlayAdvParams = stream_player_to_adv_params_map[arg_stream_player]
	if adv_param != null:
		var sound_type = adv_param.play_sound_type
		if player_sound_type_to_stream_players_map[sound_type].has(arg_stream_player):
			player_sound_type_to_stream_players_map[sound_type].erase(arg_stream_player)
	
	stream_player_to_adv_params_map.erase(arg_stream_player)


#######

class LinearSetAudioParams:
	const ValTransition = preload("res://MiscRelated/ValTransitionRelated/ValTransition.gd")
	
	
	var pause_at_target_db : bool
	var stop_at_target_db : bool
	
	var target_db : float
	
	var time_to_reach_target_db : float = ValTransition.VALUE_UNSET
	var db_mag_inc_or_dec_per_sec : float = ValTransition.VALUE_UNSET
	
	# set by AudioManager
	var _db_val_transition : ValTransition



func linear_set_audio_player_volume_using_params(arg_player, arg_linear_set_params : LinearSetAudioParams):
	arg_linear_set_params._db_val_transition = ValTransition.new()
	arg_linear_set_params._db_val_transition.connect("target_val_reached", self, "_on_audio_volume_target_val_reached", [arg_player, arg_linear_set_params])
	
	var final_val_inc_to_use = arg_linear_set_params.db_mag_inc_or_dec_per_sec
	if arg_player.volume_db > arg_linear_set_params.target_db:
		final_val_inc_to_use *= -1
	
	var reached_target_db = arg_linear_set_params._db_val_transition.configure_self(arg_player.volume_db, arg_player.volume_db, arg_linear_set_params.target_db, arg_linear_set_params.time_to_reach_target_db, final_val_inc_to_use, ValTransition.ValueIncrementMode.LINEAR)
	
	
	if !reached_target_db:
		stream_player_to_linear_audio_set_param_map[arg_player] = arg_linear_set_params
		
		_last_calc_has_linear_set_params = true
		_update_can_do_process()
	else:
		_on_audio_volume_target_val_reached(arg_player, arg_linear_set_params)
		if stream_player_to_linear_audio_set_param_map.has(arg_player):
			stream_player_to_linear_audio_set_param_map.erase(arg_player)
		
		_last_calc_has_linear_set_params = stream_player_to_linear_audio_set_param_map.size() != 0
		_update_can_do_process()

func _update_can_do_process():
	var can_do_process = _last_calc_has_linear_set_params
	
	set_process(can_do_process)


func _process(delta):
	var audio_players_to_remove : Array
	
	for player in stream_player_to_linear_audio_set_param_map:
		var param : LinearSetAudioParams = stream_player_to_linear_audio_set_param_map[player]
		
		var reached_target = param._db_val_transition.delta_pass(delta)
		if !reached_target:
			player.volume_db = param._db_val_transition.get_current_val()
			
		else:
			# NOTE: no need to do anything on the player as this is handled via signals
			audio_players_to_remove.append(player)
	
	for player in audio_players_to_remove:
		if stream_player_to_linear_audio_set_param_map.has(player):
			stream_player_to_linear_audio_set_param_map.erase(player)
	
	if audio_players_to_remove.size() != 0:
		_last_calc_has_linear_set_params = stream_player_to_linear_audio_set_param_map.size() != 0
		_update_can_do_process()
	


func _on_audio_volume_target_val_reached(arg_player, arg_linear_set_params : LinearSetAudioParams):
	arg_player.volume_db = arg_linear_set_params.target_db
	
	if arg_linear_set_params.pause_at_target_db:
		arg_player.stream_paused = true
	
	if arg_linear_set_params.stop_at_target_db:
		stop_stream_player_and_mark_as_inactive(arg_player)
	
	
	#_last_calc_has_linear_set_params = stream_player_to_linear_audio_set_param_map.size() != 0
	#_update_can_do_process()


#############################

func set_bus__sound_fx_volume(arg_val):
	bus__sound_fx_volume = arg_val
	
	var idx = AudioServer.get_bus_index(bus__sound_fx_name)
	AudioServer.set_bus_volume_db(idx, arg_val)
	
	emit_signal("bus__sound_fx_volume_changed", arg_val)

func set_bus__background_music_volume(arg_val):
	bus__background_music_volume = arg_val
	
	var idx = AudioServer.get_bus_index(bus__background_name)
	AudioServer.set_bus_volume_db(idx, arg_val)
	
	emit_signal("bus__background_music_volume_changed", arg_val)


func set_bus__sound_fx_bus_mute(arg_val):
	bus__sound_fx_bus_mute = arg_val
	
	var idx = AudioServer.get_bus_index(bus__sound_fx_name)
	AudioServer.set_bus_mute(idx, bus__sound_fx_bus_mute)
	
	emit_signal("bus__sound_fx_mute_changed", arg_val)

func set_bus__background_music_bus_mute(arg_val):
	bus__background_music_bus_mute = arg_val
	
	var idx = AudioServer.get_bus_index(bus__background_name)
	AudioServer.set_bus_mute(idx, bus__background_music_bus_mute)
	
	emit_signal("bus__background_music_mute_changed", arg_val)


####################

func _get_save_dict_for_data():
	var save_dict = {
		data_name__background_music_volume_name : bus__background_music_volume,
		data_name__background_music_is_mute_name : bus__background_music_bus_mute,
		
		data_name__sound_fx_volume_name : bus__sound_fx_volume,
		data_name__sound_fx_is_mute_name : bus__sound_fx_bus_mute,
		
	}
	
	return save_dict



func _load_save_data(arg_file : File):
	var save_dict = parse_json(arg_file.get_line())
	
	if !save_dict is Dictionary:
		save_dict = {}
	
	_initialize_stats_with_save_dict(save_dict)

func _initialize_save_data_from_scratch():
	_initialize_stats_with_save_dict({})


func _initialize_stats_with_save_dict(arg_save_dict : Dictionary):
	_initialize_background_music_relateds(arg_save_dict)
	_initialize_sound_fx_relateds(arg_save_dict)
	


func _initialize_background_music_relateds(arg_save_dict : Dictionary):
	if arg_save_dict.has(data_name__background_music_volume_name):
		set_bus__background_music_volume(int(arg_save_dict[data_name__background_music_volume_name]))
		
	else:
		#player_name = ""
		pass
	
	if arg_save_dict.has(data_name__background_music_is_mute_name):
		set_bus__background_music_bus_mute(arg_save_dict[data_name__background_music_is_mute_name])
		
	else:
		#player_name = ""
		pass


func _initialize_sound_fx_relateds(arg_save_dict : Dictionary):
	if arg_save_dict.has(data_name__sound_fx_volume_name):
		set_bus__sound_fx_volume(int(arg_save_dict[data_name__sound_fx_volume_name]))
		
	else:
		#player_name = ""
		pass
	
	if arg_save_dict.has(data_name__sound_fx_is_mute_name):
		set_bus__sound_fx_bus_mute(arg_save_dict[data_name__sound_fx_is_mute_name])
		
	else:
		#player_name = ""
		pass


func _on_singleton_initialize():
	GameSaveManager.load_stats__of_audio_manager()


#func _init():
#	CommsForBetweenScenes.connect("game_elements_created", self, "connect_signals_with_game_elements")
#
#
#func connect_signals_with_game_elements(arg_game_elements):
#	game_elements = arg_game_elements
#
#	game_elements.connect("before_game_quit", self, "_on_before_game_quit", [], CONNECT_PERSIST)
#
#func disconnect_signals_with_game_elements():
#	game_elements.disconnect("before_game_quit", self, "_on_before_game_quit")
#
#	game_elements = null
#
#func _on_before_game_quit():
#	disconnect_signals_with_game_elements()
#
#	GameSaveManager.save_settings__of_audio_manager()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		GameSaveManager.save_settings__of_audio_manager()
		
		#get_tree().quit() # default behavior


