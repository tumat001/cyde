extends MarginContainer

signal option_view_battlefield_selected()  # the end (when finished)
signal option_main_menu_selected()

#########

const vid_path_for__defeat = ""
const vid_path_for__win = ""

#

var show_main_menu_button : bool = true setget set_show_main_menu_button

var is_ending : bool = false

var tweener_for_start : SceneTreeTween

#

onready var vic_left_border_panel = $HBoxContainer/MarginContainer/LeftBorder/VicLeftBorder
onready var vic_right_border_panel = $HBoxContainer/MarginContainer2/RightBorder/VicRightBorder
onready var def_left_border_panel = $HBoxContainer/MarginContainer/LeftBorder/DefLeftBorder
onready var def_right_border_panel = $HBoxContainer/MarginContainer2/RightBorder/DefRightBorder

onready var game_result_label = $HBoxContainer/MiddleContainer/ContentContainer/VBoxContainer/GameResultLabel

onready var view_battlefield_button = $HBoxContainer/MiddleContainer/ContentContainer/VBoxContainer/ButtonsContainer/ViewButton
onready var main_menu_button = $HBoxContainer/MiddleContainer/ContentContainer/VBoxContainer/ButtonsContainer/MainMenuButton

#

onready var video_player = $VideoPlayer

onready var skip_button = $SkipButton

##

func display_as_victory():
#	game_result_label.text = "Victory"
#	vic_left_border_panel.visible = true
#	vic_right_border_panel.visible = true
#	def_left_border_panel.visible = false
#	def_right_border_panel.visible = false
	
	start_show_display(true)

func display_as_defeat():
#	game_result_label.text = "Defeat"
#	vic_left_border_panel.visible = false
#	vic_right_border_panel.visible = false
#	def_left_border_panel.visible = true
#	def_right_border_panel.visible = true
	
	start_show_display(false)

###

func _ready():
	view_battlefield_button.connect("on_button_released_with_button_left", self, "_on_view_battlefield_selected")
	main_menu_button.connect("on_button_released_with_button_left", self, "_on_main_menu_selected")
	
	set_show_main_menu_button(show_main_menu_button)
	
	####
	
	video_player.connect("finished", self, "_on_video_player_finished", [], CONNECT_PERSIST)

func _on_view_battlefield_selected():
	emit_signal("option_view_battlefield_selected")

func _on_main_menu_selected():
	emit_signal("option_main_menu_selected")

####

func set_show_main_menu_button(arg_val):
	show_main_menu_button = arg_val
	
	if is_inside_tree():
		main_menu_button.visible = arg_val


########


func start_show_display(arg_as_victory : bool):
	modulate.a = 0.0
	tweener_for_start = create_tween()
	tweener_for_start.connect("finished", self, "_on_start_display_finished")
	tweener_for_start.tween_property(self, "modulate:a", 1.0, 0.25)
	
	if arg_as_victory:
		video_player.stream = load(vid_path_for__win)
	else:
		video_player.stream = load(vid_path_for__defeat)
	
	video_player.play()

func _on_start_display_finished():
	tweener_for_start = null



func _on_video_player_finished():
	#emit_signal("option_view_battlefield_selected")
	start_end_display()


func start_end_display():
	if !is_ending:
		is_ending = true
		
		if tweener_for_start != null:
			tweener_for_start.custom_step(99999)
		
		modulate.a = 1.0
		var tweener = create_tween()
		tweener.connect("finished", self, "_on_end_display_finished")
		tweener.tween_property(self, "modulate:a", 0.0, 0.25)


func _on_end_display_finished():
	is_ending = false
	
	emit_signal("option_view_battlefield_selected")


##

func _on_SkipButton_pressed():
	start_end_display()
	


