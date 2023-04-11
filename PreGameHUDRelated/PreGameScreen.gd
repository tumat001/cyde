extends Control

const StartingScreen = preload("res://PreGameHUDRelated/StartingScreen/StartingScreen.gd")
const StartingScreen_Scene = preload("res://PreGameHUDRelated/StartingScreen/StartingScreen.tscn")
const AudioSettingsPanel_Scene = preload("res://AudioRelated/GUIRelated/AudioSettingsPanel/AudioSettingsPanel.tscn")
const AudioSettingsPanel = preload("res://AudioRelated/GUIRelated/AudioSettingsPanel/AudioSettingsPanel.gd")

#

const background_video_paths : Array = [
	#"res://CYDE_SPECIFIC_ONLY/PreGameLobbyRelated/VidBackgrounds/PreGameLobby_BG_01.ogv",
	"res://CYDE_SPECIFIC_ONLY/PreGameLobbyRelated/VidBackgrounds/PreGameLobby_BG_03.ogv",
	"res://CYDE_SPECIFIC_ONLY/PreGameLobbyRelated/VidBackgrounds/PreGameLobby_BG_05.ogv",
	
]

#

var node_tree_of_screen : Array = []
var starting_screen : StartingScreen
var current_visible_control : Control

#

var audio_adv_param

#

var audio_settings_panel : AudioSettingsPanel

#

onready var back_button = $TopRightPanel/HBoxContainer/BackButton
onready var content_panel = $ContentPanel

onready var top_right_panel = $TopRightPanel

onready var video_player = $BackgroundPanel/VideoPlayer

#

func _ready():
	starting_screen = StartingScreen_Scene.instance()
	show_control(starting_screen)
	
	visible = true
	starting_screen.pre_game_screen = self
	
	##
	
	CommsForBetweenScenes.connect("before_goto_scene", self , "_on_before_comms_goto_scene")
	
	audio_adv_param = AudioManager.construct_play_adv_params()
	audio_adv_param.node_source = self
	audio_adv_param.play_sound_type = AudioManager.PlayerSoundType.BACKGROUND_MUSIC
	
	var path_name = StoreOfAudio.get_audio_path_of_id(StoreOfAudio.AudioIds.HOMEPAGE_LOBBY_THEME_01)
	var player = AudioManager.get_available_or_construct_new_audio_stream_player(path_name, AudioManager.PlayerConstructionType.PLAIN)
	player.autoplay = true
	AudioManager.play_sound__with_provided_stream_player(path_name, player, AudioManager.MaskLevel.MASK_02, audio_adv_param)
	
	##
	
	var non_essential_rng = StoreOfRNG.get_rng(StoreOfRNG.RNGSource.NON_ESSENTIAL)
	var rand_vid_path = StoreOfRNG.randomly_select_one_element(background_video_paths, non_essential_rng)
	var vid = load(rand_vid_path)
	video_player.stream = vid
	video_player.connect("finished", self, "_on_video_player_finished")
	
	call_deferred("_deferred_ready")

func _deferred_ready():
	video_player.play()
	

func _on_video_player_finished():
	video_player.play()


func _on_before_comms_goto_scene(arg_scene_to_remove, arg_new_scene_path):
	AudioManager.stop_stream_players_with_source_ids(audio_adv_param.id_source)
	



#

func show_control(control : Control):
	if !node_tree_of_screen.has(control):
		node_tree_of_screen.append(control)
	
	if !has_control(control):
		content_panel.add_child(control)
	
	if is_instance_valid(current_visible_control):
		current_visible_control.visible = false
	
	current_visible_control = control
	control.visible = true
	
	visible = true


func hide_control(control : Control):
	control.visible = false
	
	if node_tree_of_screen.has(control):
		node_tree_of_screen.erase(control)
	
	if node_tree_of_screen.size() > 0:
		var node = node_tree_of_screen[node_tree_of_screen.size() - 1]
		if is_instance_valid(node):
			node.visible = true
			current_visible_control = node


func has_any_visible_control() -> bool:
	for child in content_panel.get_children():
		if child.visible:
			return true
	
	return false

func has_control(control : Control) -> bool:
	return content_panel.get_children().has(control)

func has_control_with_script(script : Reference) -> bool:
	for child in content_panel.get_children():
		if child.get_script() == script:
			return true
	
	return false

func get_control_with_script(script : Reference) -> Control:
	for child in content_panel.get_children():
		if child.get_script() == script:
			return child
	
	return null


#


func remove_control(arg_control : Control):
	if !arg_control.is_queued_for_deletion():
		arg_control.queue_free()
	
	hide_control(arg_control)


#

func hide_or_remove_latest_from_node_tree__except_for_starting_screen():
	if is_instance_valid(audio_settings_panel) and audio_settings_panel.visible:
		audio_settings_panel.visible = false
		return
	
	if node_tree_of_screen.size() > 0:
		var node = node_tree_of_screen[node_tree_of_screen.size() - 1]
		
		if node != starting_screen:
			# remove control if this var/property is not defined or set to false
			if !node.get("REMOVE_WHEN_ESCAPED_BY_PRE_GAME_SCREEN"):
				hide_control(node)
			else:
				remove_control(node)


#

func _unhandled_key_input(event : InputEventKey):
	if !event.echo and event.pressed:
		if event.is_action_pressed("ui_cancel"):
			hide_or_remove_latest_from_node_tree__except_for_starting_screen()
	
	accept_event()

#

func set_should_show_top_right_panel(arg_val): #set_should_show_back_button(arg_val):
	#back_button.visible = arg_val
	
	top_right_panel.visible = arg_val

func set_should_show_back_button(arg_val):
	back_button.visible = arg_val
	

func _on_BackButton_on_button_released_with_button_left():
	if is_instance_valid(audio_settings_panel) and audio_settings_panel.visible:
		audio_settings_panel.visible = false
		return
	
	if is_instance_valid(current_visible_control):
		if current_visible_control.has_method("_exit_to_previous"):
			current_visible_control._exit_to_previous()

####

func get_control_child_adding_node():
	return content_panel


####

func _on_ToAudioSettingsButton_pressed():
	if !if_audio_panel_exists_and_is_visible():
		_show_audio_panel__and_create_if_not_yet()
	elif audio_settings_panel.visible:
		audio_settings_panel.visible = false

func _show_audio_panel__and_create_if_not_yet():
	if !is_instance_valid(audio_settings_panel):
		audio_settings_panel = AudioSettingsPanel_Scene.instance()
		content_panel.add_child(audio_settings_panel)
	
	content_panel.move_child(audio_settings_panel, content_panel.get_child_count() - 1)
	audio_settings_panel.visible = true


func if_audio_panel_exists_and_is_visible():
	return is_instance_valid(audio_settings_panel) and audio_settings_panel.visible

func set_audio_panel_to_invis():
	audio_settings_panel.visible = false
