extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"

######### WORLD 01, WHERE IT ALL STARTS ############

const CydeMode_StageRounds_World01 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomStageRounds/CydeMode_StageRounds_World01.gd")
const CydeMode_EnemySpawnIns_World01 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomWaves/CydeMode_EnemySpawnIns_World01.gd")


const Comics_BlackScreen = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_BlackScreen.png")

const Comics_01_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P01_aa.png")
const Comics_01_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P01_ab.png")
const Comics_01_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P01_ac.png")
const Comics_02_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P02_aa.png")
const Comics_02_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P02_ab.png")
const Comics_02_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P02_ac.png")

const Comics_03 = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P03.jpg")

const Comics_04_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P04_aa.png")
const Comics_04_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P04_ab.png")
const Comics_04_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P04_ac.png")
const Comics_04_ad = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P04_ad.png")

const Comics_05 = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P05.jpg")

const Comics_06_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P06_aa.png")
const Comics_06_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P06_ab.png")
const Comics_06_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P06_ac.png")

const Comics_07_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P07_ab.png")  # intentional
const Comics_07_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P07_aa.png")  # intentional
const Comics_07_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P07_ac.png")

const Comics_08_aa = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P08_aa.png")
const Comics_08_ab = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P08_ab.png")
const Comics_08_ac = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/Comics/Comics_P08_ac.png")


#const tower_buff_desc_on_correct_ice_breaker = "If you got it correct, all towers become stronger for 1 minute."
#const enemy_buff_desc_on_incorrect_ice_breaker = "Otherwise, if you got it wrong, all enemies become stronger for 1 minute."

#

var stage_rounds_to_use

#

enum World01_States {
	
	NONE = 1 << 0
	
	SHOWN_COMIC_SEQUENCE = 1 << 1,
	ENTERED_PLAYER_NAME = 1 << 2,
	INTRO_01_COMPLETED = 1 << 3,
	INTRO_02_COMPLETED = 1 << 4,
	
}


#

var dia_seg__comic_sequence_001 : DialogSegment
var dia_seg__comic_sequence_004 : DialogSegment
var dia_seg__comic_sequence_007 : DialogSegment
var dia_seg__comic_sequence_008 : DialogSegment #04
var dia_seg__comic_sequence_012 : DialogSegment #05
var dia_seg__comic_sequence_013 : DialogSegment #06
var dia_seg__comic_sequence_016 : DialogSegment #07
var dia_seg__comic_sequence_019 : DialogSegment #08

#var dia_seg__comic_sequence_last : DialogSegment

#

var dia_seg__entered_player_name_001 : DialogSegment

#

var dia_seg__intro_01_sequence_001 : DialogSegment


# AFTER buying tower
var dia_seg__intro_02_sequence_005 : DialogSegment
var dia_seg__intro_02_sequence_008 : DialogSegment 


## FORMERLY Ice breaker quiz portion
# Start round portion (USED TO BE Ice breaker quiz portion)
var dia_seg__intro_03_sequence_001 : DialogSegment


# Reinforce buying tower phase
var dia_seg__intro_04_sequence_001 : DialogSegment
var dia_seg__intro_04_sequence_002 : DialogSegment  # after buying tower
var dia_seg__intro_04_sequence_002a : DialogSegment
var dia_seg__intro_04_sequence_003 : DialogSegment
var dia_seg__intro_04_sequence_004 : DialogSegment

# Other mechanics (player health/shield) portion

# Level Up & reinforcement

var dia_seg__intro_05_sequence_001 : DialogSegment
var dia_seg__intro_05_sequence_006 : DialogSegment
var dia_seg__intro_05_sequence_008 : DialogSegment
var dia_seg__intro_05_sequence_009 : DialogSegment

#

var dia_seg__intro_06_sequence_001 : DialogSegment
var dia_seg__intro_06_sequence_006 : DialogSegment

#

var dia_seg__intro_07_sequence_001 : DialogSegment
var dia_seg__intro_07_sequence_003 : DialogSegment
var dia_seg__intro_07_sequence_005 : DialogSegment
var dia_seg__intro_07_sequence_007 : DialogSegment

#

var dia_seg__intro_08_sequence_001 : DialogSegment
var dia_seg__intro_08_sequence_002 : DialogSegment

#

var dia_seg__intro_09_sequence_001 : DialogSegment

# 2nd Question (about Behavior)
var dia_seg__intro_10_sequence_001 : DialogSegment
var dia_seg__intro_10_sequence_003 : DialogSegment


# 3rd info
var dia_seg__intro_11_sequence_001 : DialogSegment

# 3rd Question (about Prac)
var dia_seg__intro_12_sequence_001 : DialogSegment
var dia_seg__intro_12_sequence_003 : DialogSegment

# Boss time
var dia_seg__intro_13_sequence_001 : DialogSegment

# POST-Boss time
var dia_seg__intro_14_sequence_001 : DialogSegment


# on lose
var dia_seg__on_lose_01_sequence_001 : DialogSegment

#

#TODO once the offical towers are added, change this
var tower_id_to_buy_at_intro_tutorial = Towers.SPRINKLER
var tower_name_to_buy_at_intro_tutorial = "Sprinkler"
var tower_instance_bought_at_intro_tutorial

#TODO once the offical towers are added, change this
var tower_id_to_buy_at_intro_tutorial__002 = Towers.STRIKER
var tower_name_to_buy_at_intro_tutorial__002 = "Striker"
var tower_instance_bought_at_intro_tutorial__002

#TODO once the offical towers are added, change this
var tower_id_to_buy_at_intro_tutorial__003 = Towers.MINI_TESLA
var tower_name_to_buy_at_intro_tutorial__003 = "Mini Tesla"
var tower_instance_bought_at_intro_tutorial__003

var tower_ids_to_buy_at_intro_tutorial__004 = [Towers.SPRINKLER, Towers.STRIKER, Towers.SPRINKLER, Towers.MINI_TESLA, Towers.MINI_TESLA]

# QUESTIONS RELATED -- SPECIFIC FOR THIS

var all_possible_ques_and_ans__for_virus_01
var all_possible_ques_and_ans__for_virus_02
var all_possible_ques_and_ans__for_virus_03

# QUESTIONS RELATED -- CAN BE COPY PASTED TO OTHERS

var current_possible_ques_and_ans

var show_change_question_use_left : int = 1
var remove_false_answer_use_left : int = 1

var remove_choice_count : int = 1

# STATES

var prevent_other_dia_segs_from_playing__from_loss : bool = false

#

var persistence_id_for_portrait__cyde : int = 1

var persistence_id_for_comics__black_background : int = 10

var persistence_id_for_comics__01_aa : int = 11
var persistence_id_for_comics__01_ab : int = 12
var persistence_id_for_comics__01_ac : int = 13

var persistence_id_for_comics__02_aa : int = 14
var persistence_id_for_comics__02_ab : int = 15
var persistence_id_for_comics__02_ac : int = 16

var persistence_id_for_comics__03 : int = 17

var persistence_id_for_comics__04_aa : int = 20
var persistence_id_for_comics__04_ab : int = 21
var persistence_id_for_comics__04_ac : int = 22
var persistence_id_for_comics__04_ad : int = 23

var persistence_id_for_comics__05 : int = 24

var persistence_id_for_comics__06_aa : int = 25
var persistence_id_for_comics__06_ab : int = 26
var persistence_id_for_comics__06_ac : int = 27

var persistence_id_for_comics__07_aa : int = 28
var persistence_id_for_comics__07_ab : int = 29
var persistence_id_for_comics__07_ac : int = 30

var persistence_id_for_comics__08_aa : int = 31
var persistence_id_for_comics__08_ab : int = 32
var persistence_id_for_comics__08_ac : int = 33

#

var _temp_active_comic_background_dia_eles : Array = []
var _comic_black_background_dia_ele

#

func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_01,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World01_Modi"):
	
	pass

func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	towers_offered_on_shop_refresh.append([tower_id_to_buy_at_intro_tutorial])
	towers_offered_on_shop_refresh.append([tower_id_to_buy_at_intro_tutorial__002])
	towers_offered_on_shop_refresh.append([tower_id_to_buy_at_intro_tutorial__003])
	towers_offered_on_shop_refresh.append(tower_ids_to_buy_at_intro_tutorial__004)
	
	#
	
	stage_rounds_to_use = CydeMode_StageRounds_World01.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World01.new())
	
	#
	
	game_elements.synergy_manager.allow_synergies_clauses.attempt_insert_clause(game_elements.synergy_manager.AllowSynergiesClauseIds.CYDE__STAGE_01_CLAUSE)
	
	#
	
	call_deferred("_deferred_applied")
	
	
	# OLD
#	if !flag_is_enabled(world_completion_num_state, World01_States.SHOWN_COMIC_SEQUENCE):
#		# TODO - SHOW COMIC SEQUENCE STYLE SEQUENCE
#
#		_construct_and_play__comic_sequence_dialogs()
#
#
#	elif !flag_is_enabled(world_completion_num_state, World01_States.ENTERED_PLAYER_NAME):
#
#		_construct_and_play__enter_player_name_dialogs()
#
#	elif !flag_is_enabled(world_completion_num_state, World01_States.INTRO_01_COMPLETED):
#
#		_construct_and_play__intro_01_sequence_001()
#
#	else:
#
#		_construct_and_play__intro_02_sequence_001()

func _deferred_applied():
	_construct_and_play__comic_sequence_dialogs()
	
	#_construct_dia_seg__intro_07_sequence_001()
	#_play_dia_seg__intro_07_sequence_001()


func _on_game_elements_before_game_start__base_class():
	._on_game_elements_before_game_start__base_class()
	
	clear_all_tower_cards_from_shop()
	set_round_is_startable(false)
	set_can_level_up(false)
	set_can_refresh_shop__panel_based(false)
	set_can_refresh_shop_at_round_end_clauses(false)
	set_enabled_buy_slots([1])
	
	set_can_sell_towers(false)
	set_can_toggle_to_ingredient_mode(false)
	set_can_towers_swap_positions_to_another_tower(false)
	add_shop_per_refresh_modifier(-5)
	add_gold_amount(20)
	
	set_visiblity_of_all_placables(false)
	#set_visiblity_of_placable(get_map_area_placable_with_name("InMapAreaPlacable02"), true)
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World02)
	game_elements.game_result_manager.show_main_menu_button = false
	
	listen_for_game_result_window_close(self, "_on_game_result_window_closed__on_win", "_on_game_result_window_closed__on_lose")
	game_elements.game_result_manager.connect("game_result_decided", self, "_on_game_result_decided", [], CONNECT_ONESHOT)
	
	set_can_do_combination(false)


func _on_game_result_window_closed__on_win():
	_construct_dia_seg__intro_14_sequence_001()
	_play_dia_seg__intro_14_sequence_001()
	

func _on_game_result_window_closed__on_lose():
	
	_construct_dia_seg__on_lose_01_sequence_001()
	_play_dia_seg__on_lose_01_sequence_001()
	

func _on_game_result_decided():
	var res = game_elements.game_result_manager.game_result
	if res == game_elements.game_result_manager.GameResult.DEFEAT:
		prevent_other_dia_segs_from_playing__from_loss = true


#


func _construct_and_play__comic_sequence_dialogs():
	var show_skip = flag_is_enabled(CydeSingleton.get_world_completion_state_num_to_world_id(StoreOfGameModifiers.GameModiIds__CYDE_World_01), World01_States.SHOWN_COMIC_SEQUENCE)
	
	var skip_adv_params__bot_right = SkipAdvParams.new()
	skip_adv_params__bot_right.skip_button_rect_pos__for_non_main_dialog_panel = Vector2(960, 540)
	skip_adv_params__bot_right.skip_button_rect_pos_origin = DialogSegment.RectPosOrigin.BOT_RIGHT
	skip_adv_params__bot_right.is_skip_button_in_main_dialog_panel = false
	
	
	var comic_style_descs_adv_param = DescriptionsAdvParams.new()
	comic_style_descs_adv_param.default_text_color = Color("#151515")
	comic_style_descs_adv_param.use_dark_mode_text = false
	comic_style_descs_adv_param.background_texture_of_segment = DialogSegment.Background_Pic_White
	
	######
	
	dia_seg__comic_sequence_001 = DialogSegment.new()
	
	var dia_seg__comic_sequence_001__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_001, dia_seg__comic_sequence_001__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_001_pos := Vector2(200, 0)
	var seg_comic_sequence_001_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_001, seg_comic_sequence_001_pos, seg_comic_sequence_001_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_001)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_001, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	var adv_params_for_black_background := BackgroundElementAdvParams.new()
	adv_params_for_black_background.starting_initial_mod_a = 1
	adv_params_for_black_background.starting_target_mod_a = 1
	adv_params_for_black_background.ending_initial_mod_a = 1
	adv_params_for_black_background.ending_target_mod_a = 0
	adv_params_for_black_background.func_name_to_call_on_element_constructed = "_add_comic_black_background_ele"
	adv_params_for_black_background.wait_for_all_background_elements_to_fade_out = false
	
	adv_params_for_black_background.fade_out_on_next_dia_seg = false
	#adv_params_for_black_background.ignored_for_wait_for_all_background_elements_to_fade_out = true
	
	var custom_pos_0_0 = Vector2(0, 0)
	# black background
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_001, Comics_BlackScreen, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__black_background, adv_params_for_black_background)
	
	
	var adv_params__1_to_1__1_to_0 := BackgroundElementAdvParams.new()
	adv_params__1_to_1__1_to_0.starting_initial_mod_a = 1
	adv_params__1_to_1__1_to_0.starting_target_mod_a = 1
	adv_params__1_to_1__1_to_0.ending_initial_mod_a = 1
	adv_params__1_to_1__1_to_0.ending_target_mod_a = 0
	adv_params__1_to_1__1_to_0.func_name_to_call_on_element_constructed = "_add_constructed_background_ele_to_arr"
	adv_params__1_to_1__1_to_0.wait_for_all_background_elements_to_fade_out = false
	
	adv_params__1_to_1__1_to_0.fade_out_on_next_dia_seg = false
	
	# actual comic
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_001, Comics_01_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__01_aa, adv_params__1_to_1__1_to_0)
	
	
	
	#####
	
	var dia_seg__comic_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_001, dia_seg__comic_sequence_002)
	
	
	var dia_seg__comic_sequence_002__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_002, dia_seg__comic_sequence_002__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_002_pos := Vector2(-200, -100)
	var seg_comic_sequence_002_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_002, seg_comic_sequence_002_pos, seg_comic_sequence_002_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_002)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_002, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	var adv_params__0_to_1__1_to_0 := BackgroundElementAdvParams.new()
	adv_params__0_to_1__1_to_0.starting_initial_mod_a = 0
	adv_params__0_to_1__1_to_0.starting_target_mod_a = 1
	adv_params__0_to_1__1_to_0.ending_initial_mod_a = 1
	adv_params__0_to_1__1_to_0.ending_target_mod_a = 0
	adv_params__0_to_1__1_to_0.func_name_to_call_on_element_constructed = "_add_constructed_background_ele_to_arr"
	adv_params__0_to_1__1_to_0.wait_for_all_background_elements_to_fade_out = false
	
	adv_params__0_to_1__1_to_0.fade_out_on_next_dia_seg = false
	
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_002, Comics_01_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__01_ab, adv_params__0_to_1__1_to_0)
	
	
	#####
	
	var dia_seg__comic_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_002, dia_seg__comic_sequence_003)
	
	
	var dia_seg__comic_sequence_003__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_003, dia_seg__comic_sequence_003__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_003_pos := Vector2(-200, 150)
	var seg_comic_sequence_003_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_003, seg_comic_sequence_003_pos, seg_comic_sequence_003_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_003)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_003, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_003, Comics_01_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__01_ac, adv_params__0_to_1__1_to_0)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_003, self, "_on_comic_P01_part_ended", null)
	
	#####
	
	# PART 02
	dia_seg__comic_sequence_004 = DialogSegment.new()
	
	
	adv_params__0_to_1__1_to_0.wait_for_all_background_elements_to_fade_out = true
	
	
	var dia_seg__comic_sequence_004__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_004, dia_seg__comic_sequence_004__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_004_pos := Vector2(-300, 150)
	var seg_comic_sequence_004_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_004, seg_comic_sequence_004_pos, seg_comic_sequence_004_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_004)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_004, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_004, Comics_02_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__02_aa, adv_params__0_to_1__1_to_0)
	
	
	#######
	var dia_seg__comic_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_004, dia_seg__comic_sequence_005)
	
	
	adv_params__0_to_1__1_to_0.wait_for_all_background_elements_to_fade_out = false
	
	
	var dia_seg__comic_sequence_005__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_005, dia_seg__comic_sequence_005__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_005_pos := Vector2(300, 150)
	var seg_comic_sequence_005_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_005, seg_comic_sequence_005_pos, seg_comic_sequence_005_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_005)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_005, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_005, Comics_02_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__02_ab, adv_params__0_to_1__1_to_0)
	
	
	#######
	var dia_seg__comic_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_005, dia_seg__comic_sequence_006)
	
	
	var dia_seg__comic_sequence_006__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_006, dia_seg__comic_sequence_006__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_006_pos := Vector2(0, 0)
	var seg_comic_sequence_006_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_006, seg_comic_sequence_006_pos, seg_comic_sequence_006_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_006)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_006, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_006, Comics_02_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__02_ac, adv_params__0_to_1__1_to_0)
	
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_006, self, "_on_comic_P02_part_ended", null)
	
	#######
	
	dia_seg__comic_sequence_007 = DialogSegment.new()
	
	
	var dia_seg__comic_sequence_007__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_007, dia_seg__comic_sequence_007__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_007_pos := Vector2(0, 200)
	var seg_comic_sequence_007_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_007, seg_comic_sequence_007_pos, seg_comic_sequence_007_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_007)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_007, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_007, Comics_03, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__03, adv_params__0_to_1__1_to_0)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_007, self, "_on_comic_P03_part_ended", null)
	
	#####
	
	dia_seg__comic_sequence_008 = DialogSegment.new()
	
	
	var dia_seg__comic_sequence_008__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_008, dia_seg__comic_sequence_008__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_008_pos := Vector2(-180, -120)
	var seg_comic_sequence_008_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_008, seg_comic_sequence_008_pos, seg_comic_sequence_008_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_008)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_008, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_008, Comics_04_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__04_aa, adv_params__0_to_1__1_to_0)
	
	
	#######
	
	var dia_seg__comic_sequence_009 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_008, dia_seg__comic_sequence_009)
	
	var dia_seg__comic_sequence_009__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_009, dia_seg__comic_sequence_009__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_009_pos := Vector2(180, -120)
	var seg_comic_sequence_009_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_009, seg_comic_sequence_009_pos, seg_comic_sequence_009_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_009)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_009, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_009, Comics_04_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__04_ab, adv_params__0_to_1__1_to_0)
	
	
	########
	
	var dia_seg__comic_sequence_010 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_009, dia_seg__comic_sequence_010)
	
	var dia_seg__comic_sequence_010__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_010, dia_seg__comic_sequence_010__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_010_pos := Vector2(-150, 150)
	var seg_comic_sequence_010_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_010, seg_comic_sequence_010_pos, seg_comic_sequence_010_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_010)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_010, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_010, Comics_04_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__04_ac, adv_params__0_to_1__1_to_0)
	
	
	########
	
	var dia_seg__comic_sequence_011 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_010, dia_seg__comic_sequence_011)
	
#	var dia_seg__comic_sequence_011__descs = [
#		"Lorem Ipsum Yada Yada"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_010, dia_seg__comic_sequence_010__descs, comic_style_descs_adv_param)
#
#	var seg_comic_sequence_010_pos := Vector2(150, 150)
#	var seg_comic_sequence_010_size := Vector2(250, 100)
#	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_010, seg_comic_sequence_010_pos, seg_comic_sequence_010_size)
#	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_010)
#
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_011, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_011, Comics_04_ad, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__04_ad, adv_params__0_to_1__1_to_0)
	
	# clear for next
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_011, self, "_on_comic_P04_part_ended", null)
	
	
	############
	
	dia_seg__comic_sequence_012 = DialogSegment.new()
	
#	var dia_seg__comic_sequence_011__descs = [
#		"Lorem Ipsum Yada Yada"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_010, dia_seg__comic_sequence_010__descs, comic_style_descs_adv_param)
#
#	var seg_comic_sequence_010_pos := Vector2(150, 150)
#	var seg_comic_sequence_010_size := Vector2(250, 100)
#	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_010, seg_comic_sequence_010_pos, seg_comic_sequence_010_size)
#	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_010)
#
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_012, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_012, Comics_05, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__05, adv_params__0_to_1__1_to_0)
	
	# clear for next
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_012, self, "_on_comic_P05_part_ended", null)
	
	####
	
	dia_seg__comic_sequence_013 = DialogSegment.new()
	
	var dia_seg__comic_sequence_013__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_013, dia_seg__comic_sequence_013__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_013_pos := Vector2(-180, -120)
	var seg_comic_sequence_013_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_013, seg_comic_sequence_013_pos, seg_comic_sequence_013_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_013)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_013, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_013, Comics_06_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__06_aa, adv_params__0_to_1__1_to_0)
	
	
	####
	
	var dia_seg__comic_sequence_014 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_013, dia_seg__comic_sequence_014)
	
	var dia_seg__comic_sequence_014__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_014, dia_seg__comic_sequence_014__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_014_pos := Vector2(180, -120)
	var seg_comic_sequence_014_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_014, seg_comic_sequence_014_pos, seg_comic_sequence_014_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_014)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_014, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_014, Comics_06_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__06_ab, adv_params__0_to_1__1_to_0)
	
	
	####
	
	var dia_seg__comic_sequence_015 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_014, dia_seg__comic_sequence_015)
	
	var dia_seg__comic_sequence_015__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_015, dia_seg__comic_sequence_015__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_015_pos := Vector2(0, -20)
	var seg_comic_sequence_015_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_015, seg_comic_sequence_015_pos, seg_comic_sequence_015_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_015)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_015, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_015, Comics_06_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__06_ac, adv_params__0_to_1__1_to_0)
	
	# clear for next
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_015, self, "_on_comic_P06_part_ended", null)
	
	
	##### COMIC 07
	
	dia_seg__comic_sequence_016 = DialogSegment.new()
	
	var dia_seg__comic_sequence_016__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_016, dia_seg__comic_sequence_016__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_016_pos := Vector2(-180, -120)
	var seg_comic_sequence_016_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_016, seg_comic_sequence_016_pos, seg_comic_sequence_016_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_016)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_016, Comics_07_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__07_aa, adv_params__0_to_1__1_to_0)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_016, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	#####
	
	var dia_seg__comic_sequence_017 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_016, dia_seg__comic_sequence_017)
	
	var dia_seg__comic_sequence_017__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_017, dia_seg__comic_sequence_017__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_017_pos := Vector2(180, -120)
	var seg_comic_sequence_017_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_017, seg_comic_sequence_017_pos, seg_comic_sequence_017_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_017)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_017, Comics_07_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__07_ab, adv_params__0_to_1__1_to_0)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_017, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	#####
	
	var dia_seg__comic_sequence_018 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_017, dia_seg__comic_sequence_018)
	
	var dia_seg__comic_sequence_018__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_018, dia_seg__comic_sequence_018__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_018_pos := Vector2(0, -20)
	var seg_comic_sequence_018_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_018, seg_comic_sequence_018_pos, seg_comic_sequence_018_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_018)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_018, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_018, Comics_07_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__07_ac, adv_params__0_to_1__1_to_0)
	
	
	# clear for next
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_018, self, "_on_comic_P07_part_ended", null)
	
	
	###### COMICS 08
	
	dia_seg__comic_sequence_019 = DialogSegment.new()
	
	var dia_seg__comic_sequence_019__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_019, dia_seg__comic_sequence_019__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_019_pos := Vector2(-180, -120)
	var seg_comic_sequence_019_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_019, seg_comic_sequence_019_pos, seg_comic_sequence_019_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_019)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_019, Comics_08_aa, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__08_aa, adv_params__0_to_1__1_to_0)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_019, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	#####
	
	
	var dia_seg__comic_sequence_020 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_019, dia_seg__comic_sequence_020)
	
	
	var dia_seg__comic_sequence_020__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_020, dia_seg__comic_sequence_020__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_020_pos := Vector2(180, -120)
	var seg_comic_sequence_020_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_020, seg_comic_sequence_020_pos, seg_comic_sequence_020_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_020)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_020, Comics_08_ab, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__08_ab, adv_params__0_to_1__1_to_0)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_020, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	#####
	
	var dia_seg__comic_sequence_021 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_020, dia_seg__comic_sequence_021)
	
	
	var dia_seg__comic_sequence_021__descs = [
		"Lorem Ipsum Yada Yada"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__comic_sequence_021, dia_seg__comic_sequence_021__descs, comic_style_descs_adv_param)
	
	var seg_comic_sequence_021_pos := Vector2(0, -20)
	var seg_comic_sequence_021_size := Vector2(250, 100)
	_configure_dia_set_to_pos_and_size(dia_seg__comic_sequence_021, seg_comic_sequence_021_pos, seg_comic_sequence_021_size)
	_configure_dia_set_to_pos_and_size__to_instant_transition_times(dia_seg__comic_sequence_021)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__comic_sequence_021, Comics_08_ac, custom_pos_0_0, custom_pos_0_0, persistence_id_for_comics__08_ac, adv_params__0_to_1__1_to_0)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__comic_sequence_021, self, "_set_up_actions__to_construct_and_play__enter_name_or_intro_01", SKIP_BUTTON__SKIP_DIALOG_TEXT, skip_adv_params__bot_right)
	
	
	
	##############
	
	#TODO do this on appropriate sequence
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__comic_sequence_021, self, "_on_comic_last_sequence_ended", null)
	
	# play
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_001)
	
	


func _add_comic_black_background_ele(arg_ele):
	_comic_black_background_dia_ele = arg_ele

func _add_constructed_background_ele_to_arr(arg_ele):
	_temp_active_comic_background_dia_eles.append(arg_ele)

func _set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true():
	for ele in _temp_active_comic_background_dia_eles:
		ele.fade_out_on_next_dia_seg = true
	

##

func _on_comic_P01_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_004)

func _on_comic_P02_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_007)

func _on_comic_P03_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_008)

func _on_comic_P04_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_012)

func _on_comic_P05_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_013)

func _on_comic_P06_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_016)

func _on_comic_P07_part_ended(arg_seg, arg_params):
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__comic_sequence_019)



#todo put this in appropriate place
func _on_comic_last_sequence_ended(arg_seg, arg_params):
	_set_up_actions__to_construct_and_play__enter_name_or_intro_01()
	

func _set_up_actions__to_construct_and_play__enter_name_or_intro_01():
	_set_all__temp_active_comic_background_dia_eles_fade_out_at_next_dia_seg__to_true()
	_temp_active_comic_background_dia_eles.clear()
	
	_comic_black_background_dia_ele.ignored_for_wait_for_all_background_elements_to_fade_out = false
	_comic_black_background_dia_ele.fade_out_on_next_dia_seg = true
	
	##
	
	world_completion_num_state = set_flag(world_completion_num_state, World01_States.SHOWN_COMIC_SEQUENCE)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	if !flag_is_enabled(world_completion_num_state, World01_States.ENTERED_PLAYER_NAME):
		_construct_and_play__enter_player_name_dialogs()
		
	else:
		_construct_and_play__intro_01_sequence_001()
	


#

func _construct_and_play__enter_player_name_dialogs():
	dia_seg__entered_player_name_001 = DialogSegment.new()
	
	#if dia_seg__comic_sequence_last != null:
	#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_last, dia_seg__entered_player_name_001)
	
	var dia_seg__entered_player_name_001__descs = [
		"Before the game starts, please enter your name."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__entered_player_name_001, dia_seg__entered_player_name_001__descs)
	_configure_dia_seg_to_default_templated_dialog_text_input(dia_seg__entered_player_name_001, "", self, "_on_input_entered__on_dia_seg__entered_player_name_001")
	_configure_dia_set_to_standard_pos_and_size(dia_seg__entered_player_name_001)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__entered_player_name_001)

func _on_input_entered__on_dia_seg__entered_player_name_001(arg_text : String, arg_dia_seg):
	if arg_text.length() <= 1:
		# REPEAT INPUTS
		var dia_seg__entered_player_name_001_AA = DialogSegment.new()
		
		var dia_seg__entered_player_name_001_AA__descs = [
			"I'm pretty sure that that possibly can't be a name. Please enter your name."
		]
		_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__entered_player_name_001_AA, dia_seg__entered_player_name_001_AA__descs)
		_configure_dia_seg_to_default_templated_dialog_text_input(dia_seg__entered_player_name_001_AA, "", self, "_on_input_entered__on_dia_seg__entered_player_name_001")
		_configure_dia_set_to_standard_pos_and_size(dia_seg__entered_player_name_001_AA)
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg__entered_player_name_001_AA)
		
	else:
		CydeSingleton.player_name = arg_text
		
		world_completion_num_state = set_flag(world_completion_num_state, World01_States.ENTERED_PLAYER_NAME)
		set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
		
		_construct_and_play__intro_01_sequence_001()
		


func _construct_and_play__intro_01_sequence_001():
	var show_skip = flag_is_enabled(CydeSingleton.get_world_completion_state_num_to_world_id(StoreOfGameModifiers.GameModiIds__CYDE_World_01), World01_States.INTRO_01_COMPLETED)
	
	
	###
	
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Hello [i]%s[/i], I am %s. I was created by the late %s to protect the city of %s from any data threats." % [CydeSingleton.player_name, CydeSingleton.cyde_robot__name, CydeSingleton.dr_kevin_murphy__full_name, CydeSingleton.cyberland__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_001, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		generate_colored_text__player_name__as_line(),
		"Hi %s, nice to meet you." % [CydeSingleton.cyde_robot__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_002, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I am glad to meet you too. After %s's death, the laboratory was taken over by %s, who changed its name to the wicked laboratory and its vision." % [CydeSingleton.dr_kevin_murphy__last_name, CydeSingleton.dr_asi_mitnick__full_name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_003, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		generate_colored_text__player_name__as_line(),
		"What happened then?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_004, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	###
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		"%s created a malicious software called Malware that was specifically designed to gain unauthorised access to %s's database and use it to gain control of the entire city." % [CydeSingleton.dr_asi_mitnick__last_name, CydeSingleton.cyberland__name],
		"But before %s died, he programmed me to awaken and protect the city from these threats. And that's why I am here now, to find worthy heroes like you to assist me in saving the city from destruction." % [CydeSingleton.dr_kevin_murphy__last_name],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_005, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_002], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	###
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		generate_colored_text__player_name__as_line(),
		"I’m sorry to hear that. How can I help you?",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_006)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_006, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	###
	
	var dia_seg__intro_01_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_007)
	
	var dia_seg__intro_01_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can help by playing this game with me. In each round, you will learn about different types of malware and how to prevent them. You will also have to defend your data from these malwares. Are you ready to be a hero?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_007)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_007, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	###
	
	var dia_seg__intro_01_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_008)
	
	var dia_seg__intro_01_sequence_008__descs = [
		generate_colored_text__player_name__as_line(),
		"Yes, I am ready!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_008)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_008, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	###
	
	var dia_seg__intro_01_sequence_009 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_009)
	
	var dia_seg__intro_01_sequence_009__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Great! Let's start our journey to save %s." % [CydeSingleton.cyberland__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_009, dia_seg__intro_01_sequence_009__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_009)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_009, self, "_on_end_of_dia_seg__intro_01_sequence_009", null)
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_009, self, "_set_up_actions__to_construct_and_play__intro_02_sequence_001", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_009, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	##### very last for this func
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)
	


func _on_end_of_dia_seg__intro_01_sequence_009(arg_dia_seg, arg_params):
	_set_up_actions__to_construct_and_play__intro_02_sequence_001()

func _set_up_actions__to_construct_and_play__intro_02_sequence_001():
	world_completion_num_state = set_flag(world_completion_num_state, World01_States.INTRO_01_COMPLETED)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	_construct_and_play__intro_02_sequence_001()


func _construct_and_play__intro_02_sequence_001():
	var dia_seg__intro_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Now that you know the story, let's proceed to the next phase of the game. You will encounter different types of malware in your journey.",
		#"As we progress, I will be providing you with information about the malware you'll face in the stage."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_001)
	
	###
	
#	var dia_seg__intro_02_sequence_002 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_002)
#
#	var dia_seg__intro_02_sequence_002__descs = [
#		"It's important to know about the malware you'll face in each stage to be able to defeat it effectively. Make sure to read the information carefully and remember it. The information will also appear in the icebreaker quiz, so be prepared."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_002)
#
	###
	
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	var dia_seg__intro_02_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_003)
	
	var dia_seg__intro_02_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["In this game, you have access to a shop where you can buy |0|. There are many different types of |0| available in the game, each with its unique abilities and strengths.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_003)
	
	###
	
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	
	var dia_seg__intro_02_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_004)
	
	var dia_seg__intro_02_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Now let's talk about buying and placing towers.",
		["To buy a |0|, simply click on this card.", [plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_004, dia_seg__intro_02_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_004)
	dia_seg__intro_02_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_02_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["After buying |0|, they appear on the bench. You can think of the bench as a storage space, or inventory of towers.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_005)
	
	
	
	var dia_seg__intro_02_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_006)
	
	var dia_seg__intro_02_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["But |0| placed on the bench do not attack, or do anything! After all, it is in the inventory.", [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_006)
	
	###
	
	var dia_seg__intro_02_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_007)
	
	var dia_seg__intro_02_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's place this |0| in the map by dragging it to this placable or slot.", [plain_fragment__tower]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_007, dia_seg__intro_02_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_007)
	dia_seg__intro_02_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var plain_fragment__x_name_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "%s" % tower_name_to_buy_at_intro_tutorial)
	
	
	dia_seg__intro_02_sequence_008 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Good job! |0| will now defend your data against the enemies!", [plain_fragment__x_name_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_008, dia_seg__intro_02_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_008)
	
	###
	
	
	
	##### very last for this func
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_001)
	

############################
############################

func _on_dia_seg__intro_02_sequence_004__fully_displayed():
	set_next_shop_towers_and_increment_counter()
	set_enabled_buy_slots([1])
	
	var tower_buy_card = get_tower_buy_card_at_buy_slot_index(0)
	if is_instance_valid(tower_buy_card):
		display_white_arrows_pointed_at_node(tower_buy_card)
	
	listen_for_tower_with_id__bought__then_call_func(tower_id_to_buy_at_intro_tutorial, "_on_tower_bought__on_dia_seg__intro_02_sequence_004", self)

func _on_tower_bought__on_dia_seg__intro_02_sequence_004(arg_tower_instance):
	tower_instance_bought_at_intro_tutorial = arg_tower_instance
	set_tower_is_draggable(arg_tower_instance, false)
	set_tower_is_sellable(arg_tower_instance, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_005)


func _on_dia_seg__intro_02_sequence_007__fully_displayed():
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial, true)
	
	display_white_circle_at_node(tower_instance_bought_at_intro_tutorial)
	
	var placable = get_map_area_placable_with_name("InMapAreaPlacable03")
	set_visiblity_of_placable(placable, true)
	display_white_circle_at_node(placable)
	
	_construct_dia_seg__intro_03_sequence_001()
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_id_to_buy_at_intro_tutorial], "_on_tower_placed_in_map__on_dia_seg__intro_02_sequence_007", self)

func _on_tower_placed_in_map__on_dia_seg__intro_02_sequence_007(arg_towers : Array):
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_008)

func _construct_dia_seg__intro_03_sequence_001():
#	dia_seg__intro_03_sequence_001 = DialogSegment.new()
#
#	var dia_seg__intro_03_sequence_001__descs = [
#		"Alright, now let's talk about the Icebreaker Quiz. This is an important part of the game and will test your knowledge on the malware that you're fighting against."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_001)
#
#	###
#
#	var dia_seg__intro_03_sequence_002 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_002)
#
#	var dia_seg__intro_03_sequence_002__descs = [
#		"When you're in the middle of a round, the game will pause and an Icebreaker question will appear for a few seconds.",
#		"But don't worry. You have two single-use support features in your disposal.",
#		"First, you can [i]Reduce[/i] the amount of incorrect choices. This will allow you to clear up uncertainties.",
#		"Second, you can [i]Change[/i] the question. This is provided in case you really cannot answer the problem."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_002)
#
#	###
#
#	var dia_seg__intro_03_sequence_003 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_003)
#
#	var dia_seg__intro_03_sequence_003__descs = [
#		"Effects occur whether you get the answer correct or not.",
#		tower_buff_desc_on_correct_ice_breaker,
#		enemy_buff_desc_on_incorrect_ice_breaker,
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_003)
#
#	###
#
#	var dia_seg__intro_03_sequence_004 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_004)
#
#	var dia_seg__intro_03_sequence_004__descs = [
#		"So make sure to pay attention to the information about the malware, and answer the questions carefully. Good luck!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_004__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_004)
#
#	###
#
#	var dia_seg__intro_03_sequence_005 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_005)
#
#	var dia_seg__intro_03_sequence_005__descs = [
#		"....."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_005__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_005)
#
#	###
#
	#var dia_seg__intro_03_sequence_006 = DialogSegment.new()
	dia_seg__intro_03_sequence_001 = DialogSegment.new()
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_006)
	
	var dia_seg__intro_03_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		"When starting the round, enemies and malwares will spawn in the entrance(s), indicated by the flags.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_001)
	dia_seg__intro_03_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_03_sequence_007 = DialogSegment.new()
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_006, dia_seg__intro_03_sequence_007)
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_007)
	
	var dia_seg__intro_03_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Please click the Ready button, or press %s, to start the round." % InputMap.get_action_list("game_round_toggle")[0].as_text()
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_007, dia_seg__intro_03_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_007)
	dia_seg__intro_03_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	#########################
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_008, dia_seg__intro_03_sequence_001)

func _play_dia_seg__intro_03_sequence_001():
	if !prevent_other_dia_segs_from_playing__from_loss:
		play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_001)



func _on_dia_seg__intro_03_sequence_006__fully_displayed():
	for flag in game_elements.map_manager.base_map.flag_to_path_map.keys():
		display_white_circle_at_node(flag)
	

func _on_dia_seg__intro_03_sequence_007__fully_displayed():
	set_round_is_startable(true)
	
	var arrows = display_white_arrows_pointed_at_node(get_round_status_button(), 9)
	arrows[1].y_offset = -20
	
	_construct_dia_seg__intro_04_sequence_001()
	#listen_for_round_end_into_stage_round_id_and_call_func("02", self, "_on_round_ended__into_stage_02")
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_stage_02", "_on_round_ended__into_stage_02")

func _on_round_started__into_stage_02():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_stage_02():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_04_sequence_001()

####

#func _on_round_ended__into_stage_02(arg_stageround_id):
#	set_round_is_startable(false)
#
#	_play_dia_seg__intro_04_sequence_001()
#

func _construct_dia_seg__intro_04_sequence_001():
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	var plain_fragment__round_ends = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "round ends")
	var plain_fragment__enemy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemy")
	
	dia_seg__intro_04_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["That was easy! Only one |0| showed up. But soon even more will.", [plain_fragment__enemy]],
		["Because of that, we need more |0|.", [plain_fragment__towers]],
		["Click this button or press %s to |0| for us to access more |1|." % [InputMap.get_action_list("game_shop_refresh")[0].as_text()], [plain_fragment__refresh_the_shop, plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_001, dia_seg__intro_04_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_001)
	dia_seg__intro_04_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_04_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Nice. Now the |0| is refreshed with new |1|.", [plain_fragment__shop, plain_fragment__towers]],
		["Every time a |0|, the shop is refreshed for free! So you have time to spare, you can just wait for a free refresh.", [plain_fragment__round_ends]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_002)
	
	###
	
	dia_seg__intro_04_sequence_002a = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_002a)
	
	var dia_seg__intro_04_sequence_002a__descs = [
		generate_colored_text__cyde_name__as_line(),
		["First, let's buy that |0|.", [plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_002a, dia_seg__intro_04_sequence_002a__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_002a)
	dia_seg__intro_04_sequence_002a.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_002a__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	
	dia_seg__intro_04_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now let's place that |0| in the map, so that it can defend against the malware!", [plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	dia_seg__intro_04_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_04_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Great! Let's begin the next round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_004)
	dia_seg__intro_04_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###

func _play_dia_seg__intro_04_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_001)
	

func _on_dia_seg__intro_04_sequence_001__fully_displayed():
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_04__sequence_001")
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	set_player_level(2)
	
	set_can_refresh_shop__panel_based(true)

func _on_shop_refreshed__intro_04__sequence_001(arg_tower_ids):
	#listen_for_tower_with_id__bought__then_call_func(tower_id_to_buy_at_intro_tutorial__002, "_on_tower_bought__on_dia_seg__intro_04_sequence_001", self)
	set_next_shop_towers_and_increment_counter()
	
	set_enabled_buy_slots([])
	set_can_refresh_shop__panel_based(false)
	
	#var tower_buy_card = get_tower_buy_card_at_buy_slot_index(0)
	#if is_instance_valid(tower_buy_card):
	#	display_white_arrows_pointed_at_node(tower_buy_card)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_002)

#func _on_tower_bought__on_dia_seg__intro_04_sequence_001(arg_tower_instance):
#	tower_instance_bought_at_intro_tutorial__002 = arg_tower_instance
#	set_tower_is_draggable(arg_tower_instance, false)
#	set_tower_is_sellable(arg_tower_instance, false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_003)
#


func _on_dia_seg__intro_04_sequence_002a__fully_displayed():
	listen_for_tower_with_id__bought__then_call_func(tower_id_to_buy_at_intro_tutorial__002, "_on_tower_bought__on_dia_seg__intro_04_sequence_002a", self)
	
	var tower_buy_card = get_tower_buy_card_at_buy_slot_index(0)
	if is_instance_valid(tower_buy_card):
		display_white_arrows_pointed_at_node(tower_buy_card)
	
	set_enabled_buy_slots([1])

func _on_tower_bought__on_dia_seg__intro_04_sequence_002a(arg_tower_instance):
	tower_instance_bought_at_intro_tutorial__002 = arg_tower_instance
	set_tower_is_draggable(arg_tower_instance, false)
	set_tower_is_sellable(arg_tower_instance, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_003)




func _on_dia_seg__intro_04_sequence_003__fully_displayed():
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__002, true)
	
	display_white_circle_at_node(tower_instance_bought_at_intro_tutorial__002)
	
	var placable = get_map_area_placable_with_name("InMapAreaPlacable04")
	set_visiblity_of_placable(placable, true)
	display_white_circle_at_node(placable)
	
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_id_to_buy_at_intro_tutorial__002], "_on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003", self)

func _on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003(arg_tower_ids):
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__002, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_004)


func _on_dia_seg__intro_04_sequence_004__fully_displayed():
	set_round_is_startable(true)
	_construct_dia_seg__intro_05_sequence_001()
	
	var arrows = display_white_arrows_pointed_at_node(get_round_status_button(), 9)
	arrows[1].y_offset = -20
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_stage_03", "_on_round_ended__into_stage_03")

func _on_round_started__into_stage_03():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_stage_03():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_05_sequence_001()


#####
# After many enemies have shown and reduced the player's shields, introduce the concept of shield

func _construct_dia_seg__intro_05_sequence_001():
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	var plain_fragment__shield = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHIELD, "shield")
	var plain_fragment__shields = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHIELD, "shields")
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	
	
	dia_seg__intro_05_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["That was a lot of |0|!", [plain_fragment__enemies]],
		["Whenever |0| escape, they deal damage to your |1|. You lose the game when you run out of |2|!", [plain_fragment__enemies, plain_fragment__shield, plain_fragment__shields]],
		["Your |0| is indicated here.", [plain_fragment__shield]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_001)
	dia_seg__intro_05_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_05_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_002)
	
	var dia_seg__intro_05_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Indicated here is the upcoming rounds and the previous rounds, as icons."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_002)
	dia_seg__intro_05_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_05_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_003)
	
	var dia_seg__intro_05_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Indicated here is the number of rounds in this stage, which is %s." % stage_rounds_to_use.stage_rounds.size(),
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_003, dia_seg__intro_05_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_003)
	dia_seg__intro_05_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_05_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_003, dia_seg__intro_05_sequence_004)
	
	var dia_seg__intro_05_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"From what we saw, there are still a lot of rounds to come. We need to get stronger by placing even more towers!",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_004)
	#dia_seg__intro_05_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	var dia_seg__intro_05_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_005)
	
	var dia_seg__intro_05_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Please |0|, and buy the offered |1|, to prepare against even more enemies.", [plain_fragment__refresh_the_shop, plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_005, dia_seg__intro_05_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_005)
	dia_seg__intro_05_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var plain_fragment__tower_inst_name_03 = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "%s" % tower_name_to_buy_at_intro_tutorial__003)
	var plain_fragment__leveling_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "leveling up")
	var plain_fragment__level = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level")
	var plain_fragment__level_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level up")
	
	dia_seg__intro_05_sequence_006 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["You may notice that you cannot place |0| in the map. This is because you can only place a certain limit of towers.", [plain_fragment__tower_inst_name_03]],
		["This limit is determined by your |0|, indicated here. This limit and can be increased by |1|.", [plain_fragment__level, plain_fragment__leveling_up]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_006, dia_seg__intro_05_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_006)
	dia_seg__intro_05_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	var dia_seg__intro_05_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_006, dia_seg__intro_05_sequence_007)
	
	var dia_seg__intro_05_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's press this button to |0|!", [plain_fragment__level_up]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_007, dia_seg__intro_05_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_007)
	dia_seg__intro_05_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var plain_fragment__level_3 = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level 3")
	var plain_fragment__3_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "3 towers")
	
	dia_seg__intro_05_sequence_008 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now that we are |0|, we can now place |1|.", [plain_fragment__level_3, plain_fragment__3_towers]],
		["Place |0| in the map.", [plain_fragment__tower_inst_name_03]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_008, dia_seg__intro_05_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_008)
	dia_seg__intro_05_sequence_008.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_008__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	
	dia_seg__intro_05_sequence_009 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_009__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Well done! Let's start the round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_009, dia_seg__intro_05_sequence_009__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_009)
	dia_seg__intro_05_sequence_009.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_009__fully_displayed", [], CONNECT_ONESHOT)
	
	
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_009, null)
	

func _play_dia_seg__intro_05_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_001)
	

func _on_dia_seg__intro_05_sequence_001__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_player_health_bar_panel(), true, true)
	arrows[0].x_offset = 10
	arrows[1].y_offset = 80
	arrows[1].flip_h = true
	

func _on_dia_seg__intro_05_sequence_002__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_round_indicator_panel())
	arrows[0].x_offset = 10
	arrows[0].y_offset = -10
	arrows[1].y_offset = 100
	arrows[1].flip_h = true
	
	

func _on_dia_seg__intro_05_sequence_003__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_rounds_count_panel())
	arrows[0].x_offset = -20
	arrows[1].y_offset = 80
	arrows[1].flip_h = true

func _on_dia_seg__intro_05_sequence_005__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	set_player_level(2)
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_05__sequence_005")

func _on_shop_refreshed__intro_05__sequence_005(arg_tower_ids):
	set_next_shop_towers_and_increment_counter()
	set_can_refresh_shop__panel_based(false)
	
	listen_for_tower_with_id__bought__then_call_func(tower_id_to_buy_at_intro_tutorial__003, "_on_tower_bought__on_dia_seg__intro_05_sequence_005", self)

func _on_tower_bought__on_dia_seg__intro_05_sequence_005(arg_tower):
	tower_instance_bought_at_intro_tutorial__003 = arg_tower
	
	#set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__003, false)
	set_tower_is_sellable(tower_instance_bought_at_intro_tutorial__003, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_006)

func _on_dia_seg__intro_05_sequence_006__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_player_level_panel())
	arrows[0].x_offset = -85
	arrows[1].y_offset = -30
	

func _on_dia_seg__intro_05_sequence_007__fully_displayed():
	display_white_arrows_pointed_at_node(get_level_up_button_from_shop_panel())
	set_can_level_up(true)
	
	listen_for_player_level_up(3, self, "_on_dia_seg__intro_05_sequence_007__level_up")

func _on_dia_seg__intro_05_sequence_007__level_up(arg_level):
	set_can_level_up(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_008)

func _on_dia_seg__intro_05_sequence_008__fully_displayed():
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__003, true)
	set_visiblity_of_all_placables(true)
	
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_id_to_buy_at_intro_tutorial__003], "_on_tower_placed_in_map__on_dia_seg__intro_05_sequence_008", self)

func _on_tower_placed_in_map__on_dia_seg__intro_05_sequence_008(arg_tower_ids):
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__003, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_009)


func _on_dia_seg__intro_05_sequence_009__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_04", "_on_round_ended__into_round_04")

func _on_round_started__into_round_04():
	_construct_dia_seg__intro_06_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_04():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_06_sequence_001()



##########


func _construct_dia_seg__intro_06_sequence_001():
	
	dia_seg__intro_06_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"In this world, knowledge is power. Having and knowing information about these malwares will greatly help us in our path to victory."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_001)
	#dia_seg__intro_06_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	######
	
	var dia_seg__intro_06_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_002)
	
	var dia_seg__intro_06_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Every stage, I will give you information about the current malware we are dealing with. Make sure to remember this, as your knowledge will be tested.",
		"Speaking of information, I will provide you with one."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#####
	
	var dia_seg__intro_06_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_003)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__VIRUS_BACKGROUND_01
	var x_type_item_entry_data__virus_background_01 = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_06_sequence_003, x_type_item_entry_data__virus_background_01, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_06_sequence_003)
	dia_seg__intro_06_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_003__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	
	#####
	
	
	var dia_seg__intro_06_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_003, dia_seg__intro_06_sequence_004)
	
	var dia_seg__intro_06_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can view the informations about the malware by clicking here.",
		"You can also view informations about the towers and enemies here.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_004, dia_seg__intro_06_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_004)
	dia_seg__intro_06_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#####
	
	
	var dia_seg__intro_06_sequence_004_a = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_004, dia_seg__intro_06_sequence_004_a)
	
	var dia_seg__intro_06_sequence_004_a__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Rounds where I give you information are indicated by the \"info\" symbol.",
		"Rounds where your knowledge is tested are indicated by the \"question mark\" symbol.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_004_a, dia_seg__intro_06_sequence_004_a__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_004_a)
	dia_seg__intro_06_sequence_004_a.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_004_a__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_004_a, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	####
	
	var dia_seg__intro_06_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_004_a, dia_seg__intro_06_sequence_005)
	
	var dia_seg__intro_06_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_005, dia_seg__intro_06_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_005)
	dia_seg__intro_06_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#####
	
	dia_seg__intro_06_sequence_006 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can adjust the game's speed by pressing the speed buttons here."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_006, dia_seg__intro_06_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_006)
	dia_seg__intro_06_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	
	
	

func _play_dia_seg__intro_06_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_001)
	

func _on_dia_seg__intro_06_sequence_003__fully_displayed(arg_tidbit_to_view_and_enable):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_to_view_and_enable)


func _on_dia_seg__intro_06_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_almanac_button_bot_right())
	
	arrows[1].x_offset = -15
	arrows[1].y_offset = 40

func _on_dia_seg__intro_06_sequence_004_a__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_round_indicator_panel())
	arrows[0].x_offset = 10
	arrows[0].y_offset = -10
	arrows[1].y_offset = 100
	arrows[1].flip_h = true
	



func _on_dia_seg__intro_06_sequence_005__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_07_sequence_001()
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_05", "_on_round_ended__into_round_05")


func _on_round_started__into_round_05():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_006)
	
	

func _on_round_ended__into_round_05():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_07_sequence_001()


func _on_dia_seg__intro_06_sequence_006__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_round_speed_button_01(), true, false)
	arrows[0].x_offset = -35

########


func _construct_dia_seg__intro_07_sequence_001():
	_construct_questions_and_choices_for__virus_Q01()
	
	
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	var plain_fragment__Refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "Refresh the shop")
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	var plain_fragment__shop_refresh = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop refresh")
	var plain_fragment__shop_refreshes = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop refreshes")
	var plain_fragment__end_of_round = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "end of each round")
	var plain_fragment__level_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level up")
	var plain_fragment__Leveling_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "Leveling up")
	
	var plain_fragment__x_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "5 towers")
	var plain_fragment__x_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "2 gold")
	
	
	#
	
	dia_seg__intro_07_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Alright. The Icebreaker quiz is about to start after proceeding from this point. You will be asked a question, and you are given multiple choices.",
		["Selecting the right choice gives your |0| a power up for %s seconds. However, choosing wrong will give |1| a power up for %s seconds." % [POWER_UP__DEFAULT_DURATION, POWER_UP__DEFAULT_DURATION], [plain_fragment__towers, plain_fragment__enemies]],
		"You can do a last minute review if you wish by accessing the almanac here."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_001, dia_seg__intro_07_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_001)
	dia_seg__intro_07_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#######
	
	var dia_seg__intro_07_sequence_002 = _construct_and_configure_choices_for_intro_07_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_001, dia_seg__intro_07_sequence_002)
	dia_seg__intro_07_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_07_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_07_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	#######
	
	
	dia_seg__intro_07_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_003, dia_seg__intro_07_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#######
	
	
	var dia_seg__intro_07_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_003, dia_seg__intro_07_sequence_004)
	
	var dia_seg__intro_07_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's practice the basics one last time.",
		["|0| to gain access to more |1|.", [plain_fragment__Refresh_the_shop, plain_fragment__towers]],
	]
	
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_004, dia_seg__intro_07_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_004)
	dia_seg__intro_07_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	
	###
	
	dia_seg__intro_07_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["You may notice that there are |0| now. This is the standard amount of |1| you get per |2|.", [plain_fragment__x_towers, plain_fragment__towers, plain_fragment__shop_refresh]],
		["Also, the |0| every |1|.", [plain_fragment__shop_refreshes, plain_fragment__end_of_round]],
		["You can |0| any time you want, but it does cost |1|, so refresh wisely.", [plain_fragment__refresh_the_shop, plain_fragment__x_gold]]
	]
	
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_005, dia_seg__intro_07_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	####
	
	var dia_seg__intro_07_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_005, dia_seg__intro_07_sequence_006)
	
	var dia_seg__intro_07_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's |0| to place more |1|.", [plain_fragment__level_up, plain_fragment__towers]],
	]
	
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_006, dia_seg__intro_07_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_006)
	dia_seg__intro_07_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	dia_seg__intro_07_sequence_007 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["|0| is rather cheap at the start, but gets expensive very quickly.", [plain_fragment__Leveling_up]]
	]
	
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_007, dia_seg__intro_07_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_007)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_07_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_007, dia_seg__intro_07_sequence_008)
	
	var dia_seg__intro_07_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round."
	]
	
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_008, dia_seg__intro_07_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_008)
	dia_seg__intro_07_sequence_008.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_008__fully_displayed", [], CONNECT_ONESHOT)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	

func _play_dia_seg__intro_07_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_001)

func _on_dia_seg__intro_07_sequence_001__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_almanac_button_bot_right())
	
	arrows[1].x_offset = -15
	arrows[1].y_offset = 40



func _on_dia_seg__intro_07_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__intro_07_sequence_002__fully_displayed():
	play_quiz_time_music()


func _on_dia_seg__intro_07_sequence_004__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	set_player_level(3)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_07__sequence_004")

func _on_shop_refreshed__intro_07__sequence_004(arg_tower_ids):
	set_enabled_buy_slots([1, 2, 3, 4, 5])
	set_next_shop_towers_and_increment_counter()
	
	add_shop_per_refresh_modifier(0)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_005)

func _on_dia_seg__intro_07_sequence_006__fully_displayed():
	display_white_arrows_pointed_at_node(get_level_up_button_from_shop_panel())
	set_can_level_up(true)
	
	listen_for_player_level_up(4, self, "_on_dia_seg__intro_07_sequence_006__level_up")

func _on_dia_seg__intro_07_sequence_006__level_up(arg_player_level):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_007)
	

func _on_dia_seg__intro_07_sequence_008__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_08_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_06", "_on_round_ended__into_round_06")
	

func _on_round_started__into_round_06():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_06():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_08_sequence_001()

#

func _on_virus_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_07_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()


func _on_virus_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_07_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()

func _on_virus_Q01_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_07_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_07_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_002, dia_seg__intro_07_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()

########

func _construct_dia_seg__intro_08_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	var plain_fragment__Towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Towers")
	
	#
	
	dia_seg__intro_08_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_08_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Finally, let's practice selling |0|.", [plain_fragment__towers]],
		["Please sell any |0| by pressing %s while hovering it, or by dragging it to the bottom panel." % [InputMap.get_action_list("game_tower_sell")[0].as_text()], [plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_001, dia_seg__intro_08_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_001)
	#dia_seg__intro_08_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_08_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_08_sequence_001.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_08_sequence_01__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_08_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_08_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Nice job. You usually sell |0| if you want to replace them with a different one.", [plain_fragment__towers]],
		#"Towers in this game can be relocated during the planning phase, or not when the round is ongoing."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_002, dia_seg__intro_08_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_002)
	
	
	###
	
	var dia_seg__intro_08_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_002, dia_seg__intro_08_sequence_003)
	
	var dia_seg__intro_08_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["|0| in this game can be dragged and dropped during the planning phase, or not when the round is ongoing.", [plain_fragment__Towers]],
		["You can drop a |0| to another |0| to swap their places.", [plain_fragment__tower]],
		"You can try that right now if you want to."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_003, dia_seg__intro_08_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_003)
	
	
	###
	
	var dia_seg__intro_08_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_003, dia_seg__intro_08_sequence_004)
	
	var dia_seg__intro_08_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round, whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_004, dia_seg__intro_08_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_004)
	dia_seg__intro_08_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_08_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	
	
	

func _play_dia_seg__intro_08_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_08_sequence_001)
	

func _on_dia_seg__intro_08_sequence_01__setted_into_whole_screen_panel():
	set_can_sell_towers(true)
	listen_for_any_tower_sold(self, "_on_dia_seg__intro_08_sequence_01__sold_any_tower")
	
	set_tower_is_sellable(tower_instance_bought_at_intro_tutorial, true)
	set_tower_is_sellable(tower_instance_bought_at_intro_tutorial__002, true)
	set_tower_is_sellable(tower_instance_bought_at_intro_tutorial__003, true)
	
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial, true)
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__002, true)
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__003, true)
	
	

func _on_dia_seg__intro_08_sequence_01__sold_any_tower(arg_sellback_gold, arg_tower_id):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_08_sequence_002)
	

func _on_dia_seg__intro_08_sequence_004__fully_displayed():
	set_round_is_startable(true)
	_construct_dia_seg__intro_09_sequence_001()
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_07", "_on_round_ended__into_round_07")

func _on_round_started__into_round_07():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_07():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_09_sequence_001()


#########


func _construct_dia_seg__intro_09_sequence_001():
	#var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	#var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	#var plain_fragment__Towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Towers")
	
	#
	
	dia_seg__intro_09_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"New information regarding our enemies, the Viruses, has been researched. This time, it is about their behavior on devices.",
		"I'll put it on display for you to review."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_001)
	
	#
	
	var dia_seg__intro_09_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__VIRUS_BEHAVIOR_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_09_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_09_sequence_002)
	dia_seg__intro_09_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_09_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	
	
	#
	
	var dia_seg__intro_09_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_003)
	
	var dia_seg__intro_09_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can always choose to review all informations I give you by clicking the almanac button here.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_003, dia_seg__intro_09_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_003)
	dia_seg__intro_09_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_09_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	
	var dia_seg__intro_09_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_003, dia_seg__intro_09_sequence_004)
	
	var dia_seg__intro_09_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_004, dia_seg__intro_09_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_004)
	dia_seg__intro_09_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_09_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	

func _play_dia_seg__intro_09_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_001)
	


func _on_dia_seg__intro_09_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)
	

func _on_dia_seg__intro_09_sequence_003__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_almanac_button_bot_right())
	
	arrows[1].x_offset = -15
	arrows[1].y_offset = 40

func _on_dia_seg__intro_09_sequence_004__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_08", "_on_round_ended__into_round_08")

func _on_round_started__into_round_08():
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_10_sequence_001()

func _on_round_ended__into_round_08():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_10_sequence_001()

#####


func _construct_dia_seg__intro_10_sequence_001():
	#var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	#var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	#var plain_fragment__Towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Towers")
	#
	_construct_questions_and_choices_for__virus_Q02()
	
	
	dia_seg__intro_10_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_001)
	
	#
	
	var dia_seg__intro_10_sequence_002 = _construct_and_configure_choices_for_intro_10_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_002)
	dia_seg__intro_10_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_10_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_10_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_10_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	#
	
	dia_seg__intro_10_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is one last question in this stage. Maintain your readiness."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_003, dia_seg__intro_10_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_003)
	
	#
	
	
	var dia_seg__intro_10_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_003, dia_seg__intro_10_sequence_004)
	
	var dia_seg__intro_10_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Start the round whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_004, dia_seg__intro_10_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_004)
	dia_seg__intro_10_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_10_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	

func _play_dia_seg__intro_10_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_001)
	

func _on_dia_seg__intro_10_sequence_002__fully_displayed():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
	

func _on_dia_seg__intro_10_sequence_02__setted_into_whole_screen_panel():
	play_quiz_time_music()
	



func _on_virus_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_10_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_10_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	

func _on_virus_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_10_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_10_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_virus_Q02_timeout(arg_params):
	
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_10_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_10_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_002, dia_seg__intro_10_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	



func _on_dia_seg__intro_10_sequence_004__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_11_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_09", "_on_round_ended__into_round_09")

func _on_round_started__into_round_09():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_09():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_11_sequence_001()




func _construct_dia_seg__intro_11_sequence_001():
	
	dia_seg__intro_11_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"One last information regarding our enemies, the Viruses, has been researched. This time, it is about how to avoid them, in general.",
		"I'll put it on display for you to review."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_001)
	
	#
	
	var dia_seg__intro_11_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__VIRUS_PRACTICES_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_11_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_11_sequence_002)
	dia_seg__intro_11_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_11_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	
	#
	
	var dia_seg__intro_11_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_003)
	
	var dia_seg__intro_11_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_003, dia_seg__intro_11_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_003)
	dia_seg__intro_11_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_11_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	

func _play_dia_seg__intro_11_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_001)
	


func _on_dia_seg__intro_11_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)
	

func _on_dia_seg__intro_11_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_12_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_10", "_on_round_ended__into_round_10")

func _on_round_started__into_round_10():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_10():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_12_sequence_001()

#######


func _construct_dia_seg__intro_12_sequence_001():
	_construct_questions_and_choices_for__virus_Q03()
	
	
	dia_seg__intro_12_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_001, dia_seg__intro_12_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_001)
	
	###
	
	var dia_seg__intro_12_sequence_002 = _construct_and_configure_choices_for_intro_12_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_12_sequence_001, dia_seg__intro_12_sequence_002)
	dia_seg__intro_12_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_12_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_12_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_12_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_12_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Start the round whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_003, dia_seg__intro_12_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_003)
	dia_seg__intro_12_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_12_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	

func _play_dia_seg__intro_12_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_12_sequence_001)
	


func _on_dia_seg__intro_12_sequence_002__fully_displayed():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
	

func _on_dia_seg__intro_12_sequence_02__setted_into_whole_screen_panel():
	play_quiz_time_music()
	

func _on_dia_seg__intro_12_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_13_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_11", "_on_round_ended__into_round_11")

func _on_round_started__into_round_11():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_11():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_13_sequence_001()


func _on_virus_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_12_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_12_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_12_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	
	

func _on_virus_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_12_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_12_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_12_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_virus_Q03_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_12_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_12_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_12_sequence_002, dia_seg__intro_12_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_12_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	
	

#########

func _construct_dia_seg__intro_13_sequence_001():
	var plain_fragment__Virus_Boss = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "Virus Boss")
	
	
	dia_seg__intro_13_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_13_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"At the very last round of each stage, a very tough malware will try to destroy us!",
		["In this case, a |0| will attempt to defeat us.", [plain_fragment__Virus_Boss]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_13_sequence_001, dia_seg__intro_13_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_13_sequence_001)
	
	###
	var plain_fragment__Level_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "Level up")
	
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_13_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_13_sequence_001, dia_seg__intro_13_sequence_002)
	
	var dia_seg__intro_13_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["|0| and place as many |1| as you can in order to defeat the Virus Boss!", [plain_fragment__Level_up, plain_fragment__towers]],
		"When you're ready, you can start the round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_13_sequence_002, dia_seg__intro_13_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_13_sequence_002)
	dia_seg__intro_13_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_13_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_13_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_13_sequence_001)
	


func _on_dia_seg__intro_13_sequence_002__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_12", "_on_round_ended__into_round_12")


func _on_round_started__into_round_12():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_12():
	pass

##########

func _construct_dia_seg__intro_14_sequence_001():
	dia_seg__intro_14_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_14_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Congratulations for beating your first challenge! However, this is just the first out of the thousand steps.",
		"In related news, I have some exciting news for you! I have a new map for you to explore."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_001, dia_seg__intro_14_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_14_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_001, dia_seg__intro_14_sequence_002)
	
	var dia_seg__intro_14_sequence_002__descs = [
		generate_colored_text__player_name__as_line(),
		"A new map? That sounds exciting. Tell me more.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_002, dia_seg__intro_14_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_14_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_002, dia_seg__intro_14_sequence_003)
	
	var dia_seg__intro_14_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"With each new stage, a new map will be unlocked for you to explore. There are typically twelve (12) rounds in each stage, but some stages may have more or fewer rounds. Each stage has its own unique map, so be prepared to face new challenges and adjust your strategy accordingly."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_003, dia_seg__intro_14_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
#	var dia_seg__intro_14_sequence_004 = DialogSegment.new()
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_003, dia_seg__intro_14_sequence_004)
#
#	var dia_seg__intro_14_sequence_004__descs = [
#		"With each new stage, a new map will be unlocked for you to explore. There are typically nine (9) rounds in each stage, but some stages may have more or fewer rounds. Each stage has its own unique map, so be prepared to face new challenges and adjust your strategy accordingly."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_004, dia_seg__intro_14_sequence_004__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_004)
#
	###
	
	var dia_seg__intro_14_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_003, dia_seg__intro_14_sequence_005)
	
	var dia_seg__intro_14_sequence_005__descs = [
		generate_colored_text__player_name__as_line(),
		"I'm ready for the challenge. How do I access the next map?"
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_005, dia_seg__intro_14_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_14_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_005, dia_seg__intro_14_sequence_006)
	
	var dia_seg__intro_14_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Once you complete the current stage, the next map will be unlocked automatically. Simply follow the designated path to the new map, and you will be transported there.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_006, dia_seg__intro_14_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_14_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_006, dia_seg__intro_14_sequence_007)
	
	var dia_seg__intro_14_sequence_007__descs = [
		generate_colored_text__player_name__as_line(),
		"Got it. Thanks for the information."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_007, dia_seg__intro_14_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_007)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_14_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_14_sequence_007, dia_seg__intro_14_sequence_008)
	
	var dia_seg__intro_14_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You're welcome. Good luck on your journey, player, and may you uncover all of the secrets that lie ahead."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_14_sequence_008, dia_seg__intro_14_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_14_sequence_008)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_14_sequence_008, self, "_on_end_of_dia_seg__intro_14_sequence_008", null)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_14_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	

func _play_dia_seg__intro_14_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_14_sequence_001)
	

func _on_end_of_dia_seg__intro_14_sequence_008(arg_seg, arg_params):
	_record_map_ids_to_be_available_in_map_selection_panel()
	CommsForBetweenScenes.goto_starting_screen(game_elements)
	




#####################


func _construct_dia_seg__on_lose_01_sequence_001():
	dia_seg__on_lose_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_lose_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, your data has been breached..."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_001, dia_seg__on_lose_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_001)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_lose_01_sequence_001, self, "_on_end_of_dia_seg__on_lose_x_segment__end", null)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#########
	
	
	

func _play_dia_seg__on_lose_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_lose_01_sequence_001)
	


func _on_end_of_dia_seg__on_lose_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)
	




#########################################
################ QUESTIONS ##############


func _construct_questions_and_choices_for__virus_Q01():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Particular kind of software that, when run,\ncopies itself by altering other programs\n and incorporating its own code into those programs."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_virus_Q01_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Malware that disguises itself as legitimate code or software."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "A type of malware whose primary function\n is to self-replicate and infect other computers\n while remaining active on infected systems."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Type of malware that provides the creator (usually an attacker, but not always)\n with a backdoor into systems."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__01.add_choice(choice_01__ques_01)
#	choices_for_question_info__01.add_choice(choice_02__ques_01)
#	choices_for_question_info__01.add_choice(choice_03_ques_01)
#	choices_for_question_info__01.add_choice(choice_04_ques_01)
#
#
#	var question_01_desc = [
#		"What is a computer virus?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_virus_Q01_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "1971"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_virus_Q01_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "1940"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "1982"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "1986"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_virus_Q01_choice_wrong_clicked"
#	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__02.add_choice(choice_01__ques_02)
#	choices_for_question_info__02.add_choice(choice_02__ques_02)
#	choices_for_question_info__02.add_choice(choice_03_ques_02)
#	choices_for_question_info__02.add_choice(choice_04_ques_02)
#
#
#	var question_02_desc = [
#		"In what year Bob Thomas developed the Creeper program, which is frequently referred to as the first virus?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_virus_Q01_timeout"
#
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__virus_Q01(self, "_on_virus_Q01_choice_right_clicked", "_on_virus_Q01_choice_wrong_clicked", "_on_virus_Q01_timeout")
	
	all_possible_ques_and_ans__for_virus_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_virus_01.add_question_info_for_choices_panel(question)
	#all_possible_ques_and_ans__for_virus_01.add_question_info_for_choices_panel(question_info__01)
	#all_possible_ques_and_ans__for_virus_01.add_question_info_for_choices_panel(question_info__02)



func _construct_questions_and_choices_for__virus_Q02():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Propagation"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_virus_Q02_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Dormant"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Triggering"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Execution"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__01.add_choice(choice_01__ques_01)
#	choices_for_question_info__01.add_choice(choice_02__ques_01)
#	choices_for_question_info__01.add_choice(choice_03_ques_01)
#	choices_for_question_info__01.add_choice(choice_04_ques_01)
#
#
#	var question_01_desc = [
#		"What phase is the virus where they self-replicate, stashing copies of itself in files, programs, or other parts of your disk?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_virus_Q02_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Triggering"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_virus_Q02_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Dormant"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Propagation"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Execution"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_virus_Q02_choice_wrong_clicked"
#	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__02.add_choice(choice_01__ques_02)
#	choices_for_question_info__02.add_choice(choice_02__ques_02)
#	choices_for_question_info__02.add_choice(choice_03_ques_02)
#	choices_for_question_info__02.add_choice(choice_04_ques_02)
#
#
#	var question_02_desc = [
#		"What phase is the virus where this could be a user action, like clicking an icon or opening an app"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_virus_Q02_timeout"
#
	
	
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__virus_Q02(self, "_on_virus_Q02_choice_right_clicked", "_on_virus_Q02_choice_wrong_clicked", "_on_virus_Q02_timeout")
	
	all_possible_ques_and_ans__for_virus_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_virus_02.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_virus_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_virus_02.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_virus_02.add_question_info_for_choices_panel(question_info__02)


###########

func _construct_questions_and_choices_for__virus_Q03():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Use your spam blocking or filtering tools\nto block unsolicited emails, instant messages and pop-ups"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_virus_Q03_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Don’t open email attachments\nor click on hyperlinks from unknown senders."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Use passwords that are hard to guess and change them regularly.\nDo not store user names and passwords on websites."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Exercise caution when downloading files from the Internet.\nOnly download from trusted sources."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__01.add_choice(choice_01__ques_01)
#	choices_for_question_info__01.add_choice(choice_02__ques_01)
#	choices_for_question_info__01.add_choice(choice_03_ques_01)
#	choices_for_question_info__01.add_choice(choice_04_ques_01)
#
#
#	var question_01_desc = [
#		"What are the basic rules that prevent you from accidentally clicking a malicious email that contains a virus?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_virus_Q03_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Prepare back-up files"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_virus_Q03_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Don't open malicious email"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Always scan viruses on your device every week"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Install anti-virus"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_virus_Q03_choice_wrong_clicked"
#	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
#
#
#	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
#	choices_for_question_info__02.add_choice(choice_01__ques_02)
#	choices_for_question_info__02.add_choice(choice_02__ques_02)
#	choices_for_question_info__02.add_choice(choice_03_ques_02)
#	choices_for_question_info__02.add_choice(choice_04_ques_02)
#
#
#	var question_02_desc = [
#		"What do you need to do to make sure you will not lose your important files?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_virus_Q03_timeout"
#
#
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__virus_Q03(self, "_on_virus_Q03_choice_right_clicked", "_on_virus_Q03_choice_wrong_clicked", "_on_virus_Q03_timeout")
	
	all_possible_ques_and_ans__for_virus_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_virus_03.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_virus_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_virus_03.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_virus_03.add_question_info_for_choices_panel(question_info__02)
	



############ QUESTIONS STATE ############


func _show_dialog_choices_modi_panel():
	return false

func _build_dialog_choices_modi_panel_config():
	var config = DialogChoicesModiPanel.ModiPanelConfig.new()
	
	config.show_change_question_use_left = show_change_question_use_left
	config.remove_false_answer_use_left = remove_false_answer_use_left
	
	config.remove_false_answer_count = remove_choice_count
	
	config.func_source_for_actions = self
	config.func_name_for__change_question = "_on_dialog_choices_modi_panel__change_question"
	config.func_name_for__remove_false_answer = "_on_dialog_choices_modi_panel__removed_choices"
	
	return config


func _on_dialog_choices_modi_panel__removed_choices(arg_param):
	#remove_choice_count -= 1
	
	remove_false_answer_use_left -= 1

func _on_dialog_choices_modi_panel__change_question(arg_param):
	show_change_question_use_left -= 1
	
	if current_possible_ques_and_ans == all_possible_ques_and_ans__for_virus_01:
		var dia_seg = _construct_and_configure_choices_for_intro_07_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_virus_02:
		var dia_seg = _construct_and_configure_choices_for_intro_10_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_virus_03:
		var dia_seg = _construct_and_configure_choices_for_intro_12_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)



#

func _construct_and_configure_choices_for_intro_07_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_virus_01
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_07", all_possible_ques_and_ans__for_virus_01, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__intro_07(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_07 = DialogSegment.new()
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg_intro_01, dia_seg_intro_02)
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_07, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_07)
	
	return dia_seg_question__for_intro_07

###

func _construct_and_configure_choices_for_intro_10_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_virus_02
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_10", all_possible_ques_and_ans__for_virus_02, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__intro_10(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_07 = DialogSegment.new()
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg_intro_01, dia_seg_intro_02)
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_07, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_07)
	
	return dia_seg_question__for_intro_07

###

func _construct_and_configure_choices_for_intro_12_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_virus_03
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_12", all_possible_ques_and_ans__for_virus_03, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")

func _construct_dia_seg_for_questions__intro_12(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_12 = DialogSegment.new()
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg_intro_01, dia_seg_intro_02)
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_12, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_12)
	
	return dia_seg_question__for_intro_12
	
	

##########################################

