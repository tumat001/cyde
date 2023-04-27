extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"


const CydeMode_StageRounds_World10 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomStageRounds/CydeMode_StageRounds_World10.gd")
const CydeMode_EnemySpawnIns_World10 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomWaves/CydeMode_EnemySpawnIns_World10.gd")


enum World10_States {
	
	NONE = 1 << 0
	
	SHOWN_CYDE_CONVO_01 = 1 << 1,
	SHOWN_ASI_CONVO_01 = 1 << 2,
	
}

var stage_rounds_to_use



var dia_seg__intro_01_sequence_001 : DialogSegment


# Question 01
var dia_seg__question_01_sequence_001 : DialogSegment
var dia_seg__question_01_sequence_003 : DialogSegment

# Question 02
var dia_seg__question_02_sequence_001 : DialogSegment
var dia_seg__question_02_sequence_003 : DialogSegment

# Question 03
var dia_seg__question_03_sequence_001 : DialogSegment
var dia_seg__question_03_sequence_003 : DialogSegment

# Question 04
var dia_seg__question_04_sequence_001 : DialogSegment
var dia_seg__question_04_sequence_003 : DialogSegment

# Question 05
var dia_seg__question_05_sequence_001 : DialogSegment
var dia_seg__question_05_sequence_003 : DialogSegment

# Question 06
var dia_seg__question_06_sequence_001 : DialogSegment
var dia_seg__question_06_sequence_003 : DialogSegment

# Question 07
var dia_seg__question_07_sequence_001 : DialogSegment
var dia_seg__question_07_sequence_003 : DialogSegment

# Question 08
var dia_seg__question_08_sequence_001 : DialogSegment
var dia_seg__question_08_sequence_003 : DialogSegment

# Question 09
var dia_seg__question_09_sequence_001 : DialogSegment
var dia_seg__question_09_sequence_003 : DialogSegment




# asi convo

var dia_seg__asi_convo_01_sequence_001 : DialogSegment

## on lose
var dia_seg__on_lose_01_sequence_001 : DialogSegment

## on win
var dia_seg__on_win_01_sequence_001 : DialogSegment


#######

var all_possible_ques_and_ans__01
var all_possible_ques_and_ans__02
var all_possible_ques_and_ans__03
var all_possible_ques_and_ans__04
var all_possible_ques_and_ans__05
var all_possible_ques_and_ans__06
var all_possible_ques_and_ans__07
var all_possible_ques_and_ans__08
var all_possible_ques_and_ans__09


#####################
# QUESTIONS RELATED -- CAN BE COPY PASTED TO OTHERS
var current_possible_ques_and_ans

var show_change_question_use_left : int = 1
var remove_false_answer_use_left : int = 1

var remove_choice_count : int = 1

# STATES

var prevent_other_dia_segs_from_playing__from_loss : bool

#

var persistence_id_for_portrait__cyde : int = 1
var persistence_id_for_portrait__asi : int = 2

#

var expert_based_fac_passive

#######


func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_10,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World10_Modi"):
	
	pass


func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	stage_rounds_to_use = CydeMode_StageRounds_World10.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World10.new())
	
	#
	
	call_deferred("_deferred_applied")
	
	#todo if there is beyond 10, then change this
	#_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World10)
	
	game_elements.game_result_manager.show_main_menu_button = false
	
	listen_for_game_result_window_close(self, "_on_game_result_window_closed__on_win", "_on_game_result_window_closed__on_lose")
	game_elements.game_result_manager.connect("game_result_decided", self, "_on_game_result_decided", [], CONNECT_ONESHOT)
	
	


func _on_game_result_window_closed__on_win():
	_construct_dia_seg__on_win_01_sequence_001()
	_play_dia_seg__on_win_01_sequence_001()
	

func _on_game_result_window_closed__on_lose():
	_construct_dia_seg__on_lose_01_sequence_001()
	_play_dia_seg__on_lose_01_sequence_001()


func _on_game_result_decided():
	var res = game_elements.game_result_manager.game_result
	if res == game_elements.game_result_manager.GameResult.DEFEAT:
		prevent_other_dia_segs_from_playing__from_loss = true
	elif res == game_elements.game_result_manager.GameResult.VICTORY:
		_record_map_ids_to_be_available_in_map_selection_panel()


func _deferred_applied():
	_construct_dia_seg__intro_01_sequence_001()
	_play_dia_seg__intro_01_sequence_001()
	


func _on_game_elements_before_game_start__base_class():
	._on_game_elements_before_game_start__base_class()
	
	#clear_all_tower_cards_from_shop()
	set_round_is_startable(false)
	#set_can_level_up(true)
	#set_can_refresh_shop__panel_based(true)
	#set_can_refresh_shop_at_round_end_clauses(true)
	#set_enabled_buy_slots([1, 2, 3, 4, 5])
	
	set_can_sell_towers(true)
	set_can_toggle_to_ingredient_mode(false)
	#set_can_towers_swap_positions_to_another_tower(false)
	#add_shop_per_refresh_modifier(-5)
	add_gold_amount(30)
	
	set_player_level(4)
	
	game_elements.game_result_manager.show_main_menu_button = false
	
	_initialize_blocker_ability()
	
	######
	
	expert_based_fac_passive = preload("res://CYDE_SPECIFIC_ONLY/EnemyFactionPassiveRelated/CydeFactionPassive_ExpertBased.gd").new()
	add_cyde_faction_passive(expert_based_fac_passive)
	

#######


func _construct_dia_seg__intro_01_sequence_001():
	var show_skip = flag_is_enabled(CydeSingleton.get_world_completion_state_num_to_world_id(StoreOfGameModifiers.GameModiIds__CYDE_World_10), World10_States.SHOWN_CYDE_CONVO_01)
	
	
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		generate_colored_text__player_name__as_line(),
		"We've come a long way. We defeated a large number of malwares, and who knows what we'll face in this final stage."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_001, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	#####
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		generate_colored_text__asi_name__as_line(),
		"Well, well, well. So the little pawns made it this far? I am kinda impressed Hahaha.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_002, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_002, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	####
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"We’ve come to put an end to your nefarious plans, Dr. Mitnick. Your reign of wickedness stops now!",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_003, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_003, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	####
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		generate_colored_text__asi_name__as_line(),
		"Ha! You're nothing but a nuisance, an insignificant obstacle in my grand scheme. Do you really think you stand a chance against my intellect and mastery of science?"
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_004, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.ANGRY_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	####
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		generate_colored_text__player_name__as_line(),
		"We may not have your scientific knowledge, but we have something you lack: heart and determination! We fight for what's right!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_005, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.ANGRY_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		generate_colored_text__asi_name__as_line(),
		"Feelings and emotions are nothing but weaknesses. I've transcended such trivialities. Prepare to be crushed!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_006, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__intro_01_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_007)
	
	var dia_seg__intro_01_sequence_007__descs = [
		generate_colored_text__player_name__as_line(),
		"We won't be intimidated by your empty words. We’ve faced tougher foes than you and come out victorious!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_007)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_007, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__intro_01_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_008)
	
	var dia_seg__intro_01_sequence_008__descs = [
		generate_colored_text__asi_name__as_line(),
		"You underestimate my power! Witness the true might of my creations!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_008)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_008, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__intro_01_sequence_009 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_009)
	
	var dia_seg__intro_01_sequence_009__descs = [
		generate_colored_text__cyde_name__as_line(),
		"This is it. The final showdown.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_009, dia_seg__intro_01_sequence_009__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_009)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_009, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_009, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	
	##### ON LAST SEG
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_009, self, "_on_dia_seg__intro_01__ended", null)
	
	



func _play_dia_seg__intro_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)


func _on_dia_seg__intro_01__ended(arg_seg, arg_params):
	_on_intro_01_completed()
	

func _on_intro_01_completed():
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	set_round_is_startable(true)
	
	#_construct_dia_seg__intro_02_sequence_001()
	#listen_for_round_end_into_stage_round_id_and_call_func("42", self, "_on_round_started__into_round_02")
	
	# flag setting
	world_completion_num_state = set_flag(world_completion_num_state, World10_States.SHOWN_CYDE_CONVO_01)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	####
	
	listen_for_round_end_into_stage_round_id_and_call_func("103", self, "_on_round_started__into_round_03")

func _on_round_started__into_round_03(arg_stageround_id):
	if !prevent_other_dia_segs_from_playing__from_loss:
		_construct_dia_seg__question_01_sequence_001()
		_play_dia_seg__question_01_sequence_001()
		


########### QUESTION 01 - VIRUS + TROJAN

func _construct_dia_seg__question_01_sequence_001():
	_construct_questions_and_choices_for__Q01()
	
	
	dia_seg__question_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"%s has recreated the bosses of each type of malware, but this time, they are combined! We need to use information and knowledge to our advantage!" % [CydeSingleton.dr_asi_mitnick__last_name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_01_sequence_001, dia_seg__question_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_01_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__question_01_sequence_001_ab = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_01_sequence_001, dia_seg__question_01_sequence_001_ab)
	
	var dia_seg__question_01_sequence_001_ab__descs = [
		generate_colored_text__asi_name__as_line(),
		"Behold my first amalgamation: Virjan. A combination of Virus and Trojan created by me. This is not just your typical malware. Towers that strike this malware have their attack speed reduced! Additionally, Virjan gains movement speed when reaching certain health thresholds."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_01_sequence_001_ab, dia_seg__question_01_sequence_001_ab__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_01_sequence_001_ab)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_01_sequence_001_ab, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_01_sequence_001_ab, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	###
	
	var dia_seg__question_01_sequence_001_ac = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_01_sequence_001_ab, dia_seg__question_01_sequence_001_ac)
	
	var dia_seg__question_01_sequence_001_ac__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? The buff will greatly help us take down the amalgamation.",#The malwares this phase is [b]The Viruses and The Trojans[/b].",
		"Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_01_sequence_001_ac, dia_seg__question_01_sequence_001_ac__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_01_sequence_001_ac)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_01_sequence_001_ac, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__question_01_sequence_002 = _construct_and_configure_choices_for_question_01_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_01_sequence_001_ac, dia_seg__question_01_sequence_002)
	dia_seg__question_01_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_01_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__question_01_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_01_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__question_01_sequence_003 = DialogSegment.new()
	
	var dia_seg__question_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_01_sequence_003, dia_seg__question_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_01_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_01_sequence_003, self, "_on_dia_seg__question_01_sequence_003__ended", null)
	

func _play_dia_seg__question_01_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_01_sequence_001)
	

func _on_dia_seg__question_01_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__question_01_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_01_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()


func _on_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_01_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	
	

func _on_Q01_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_01_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	
	

func _on_dia_seg__question_01_sequence_003__ended(arg_seg, arg_param):
	set_round_is_startable(true)
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	
	listen_for_round_end_into_stage_round_id_and_call_func("106", self, "_on_round_started__into_round_06")



func _on_round_started__into_round_06(arg_stageround_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_construct_dia_seg__question_02_sequence_001()
		_play_dia_seg__question_02_sequence_001()


######### QUESTION 02

func _construct_dia_seg__question_02_sequence_001():
	_construct_questions_and_choices_for__Q02()
	
	
	dia_seg__question_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_02_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"Behold my second amalgamation: Adworm. A combination of Adware and Computer Worm created by me. This malware shields itself periodically. Adworm also regenerate health over time. Let’s see if you can even bring it down!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_02_sequence_001, dia_seg__question_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_02_sequence_001)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_02_sequence_001, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__question_x_sequence_001_ab = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_02_sequence_001, dia_seg__question_x_sequence_001_ab)
	
	var dia_seg__question_x_sequence_001_ab__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz?", #The malwares this phase is [b]The Adwares and The Computer Worms[/b].",
		"Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_x_sequence_001_ab, dia_seg__question_x_sequence_001_ab__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_x_sequence_001_ab)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_x_sequence_001_ab, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__question_02_sequence_002 = _construct_and_configure_choices_for_question_02_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_x_sequence_001_ab, dia_seg__question_02_sequence_002)
	dia_seg__question_02_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_02_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__question_02_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_02_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__question_02_sequence_003 = DialogSegment.new()
	
	var dia_seg__question_02_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_02_sequence_003, dia_seg__question_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_02_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_02_sequence_003, self, "_on_dia_seg__question_02_sequence_003__ended", null)
	

func _play_dia_seg__question_02_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_02_sequence_001)
	


func _on_dia_seg__question_02_sequence_002__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__question_02_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_02_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	

func _on_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_02_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_Q02_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_02_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	


func _on_dia_seg__question_02_sequence_003__ended(arg_seg, arg_param):
	set_round_is_startable(true)
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	#_construct_dia_seg__intro_11_sequence_001()
	
	listen_for_round_end_into_stage_round_id_and_call_func("109", self, "_on_round_started__into_round_09")

func _on_round_started__into_round_09(arg_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_construct_dia_seg__question_03_sequence_001()
		
		_play_dia_seg__question_03_sequence_001()



########## QUESTION 03

func _construct_dia_seg__question_03_sequence_001():
	_construct_questions_and_choices_for__Q03()
	
	
	dia_seg__question_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_03_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"Ranskit is a combination of Ransomware and Rootkits. Ranskit steals your gold and disables one of your towers periodically."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_03_sequence_001, dia_seg__question_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_03_sequence_001)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_03_sequence_001, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__question_x_sequence_001_ab = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_03_sequence_001, dia_seg__question_x_sequence_001_ab)
	
	var dia_seg__question_x_sequence_001_ab__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz?", #The malwares this phase is [b]The Adwares and The Computer Worms[/b].",
		"Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_x_sequence_001_ab, dia_seg__question_x_sequence_001_ab__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_x_sequence_001_ab)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_x_sequence_001_ab, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__question_03_sequence_002 = _construct_and_configure_choices_for_question_03_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_x_sequence_001_ab, dia_seg__question_03_sequence_002)
	dia_seg__question_03_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_03_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__question_03_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_03_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__question_03_sequence_003 = DialogSegment.new()
	
	var dia_seg__question_03_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_03_sequence_003, dia_seg__question_03_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_03_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_03_sequence_003, self, "_on_dia_seg__question_03_sequence_003__ended", null)
	

func _play_dia_seg__question_03_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_03_sequence_001)
	

func _on_dia_seg__question_03_sequence_002__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__question_03_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_03_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	
	

func _on_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_03_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_Q03_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_03_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	

func _on_dia_seg__question_03_sequence_003__ended(arg_seg, arg_param):
	set_round_is_startable(true)
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	listen_for_round_end_into_stage_round_id_and_call_func("1012", self, "_on_round_started__into_round_12")

func _on_round_started__into_round_12(arg_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_construct_dia_seg__question_04_sequence_001()
		
		_play_dia_seg__question_04_sequence_001()


########## QUESTION 04

func _construct_dia_seg__question_04_sequence_001():
	_construct_questions_and_choices_for__Q04()
	
	
	dia_seg__question_04_sequence_001 = DialogSegment.new()
	var dia_seg__question_xx_sequence_001 = dia_seg__question_04_sequence_001
	
	var dia_seg__question_xx_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"MalFileBot, my ultimate creation! You will not stand a chance against its combined powers!",
		"It is a combination of Fileless, Malware Bots and Mobile Malware. This malware summons countless bots periodically. When it reaches critical health, it also becomes invisible for a brief duration.",
		"I bet you're not even strong enough to kill its minions!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_001, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	##
	
	var dia_seg__question_x_sequence_001_ab = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_x_sequence_001_ab)
	
	var dia_seg__question_x_sequence_001_ab__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz?", #The malwares this phase is [b]The Adwares and The Computer Worms[/b].",
		"Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_x_sequence_001_ab, dia_seg__question_x_sequence_001_ab__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_x_sequence_001_ab)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_x_sequence_001_ab, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__04)[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_x_sequence_001_ab, dia_seg__question_xx_sequence_002)
	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_04_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_04_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
#	dia_seg__question_04_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_04_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Get ready for the final fight!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
	
	#configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_002, self, "_on_dia_seg__question_04_sequence_003__ended", null)
	

func _play_dia_seg__question_04_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_04_sequence_001)
	

func _on_dia_seg__question_04_sequence_002__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__question_04_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_Q04_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_04_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_002, self, "_on_dia_seg__question_04_sequence_003__ended", null)

func _on_Q04_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_04_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_002, self, "_on_dia_seg__question_04_sequence_003__ended", null)

func _on_Q04_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
	
	var dia_seg__question_xx_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	#configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_04_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_002, self, "_on_dia_seg__question_04_sequence_003__ended", null)

func _on_dia_seg__question_04_sequence_003__ended(arg_seg, arg_param):
	#set_round_is_startable(true)
	#play_dialog_segment_or_advance_or_finish_elements(null)
	
	#_construct_dia_seg__intro_11_sequence_001()
	
	#listen_for_round_end_into_stage_round_id_and_call_func("311", self, "_on_round_started__into_round_11")
	
	
	#listen_for_round_end_into_stage_round_id_and_call_func("1011", self, "_on_round_started__into_round_11")
	
	_construct_dia_seg__asi_convo_01_sequence_001()
	_play_dia_seg__asi_convo_01_sequence_001()

#func _on_round_started__into_round_11(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__asi_convo_01_sequence_001()
#
#		_play_dia_seg__asi_convo_01_sequence_001()
#		#_construct_dia_seg__question_05_sequence_001()
#
#		#_play_dia_seg__question_05_sequence_001()


#
########### QUESTION 05
#
#func _construct_dia_seg__question_05_sequence_001():
#	_construct_questions_and_choices_for__Q05()
#
#
#	dia_seg__question_05_sequence_001 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_001 = dia_seg__question_05_sequence_001
#
#	var dia_seg__question_xx_sequence_001__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Ready for the Icebreaker quiz? The malwares this phase is [b]The Ransomwares[/b].",
#		"Proceed to test your knowledge."
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
#
#	###
#
#	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__05)[0]
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_002)
#	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_05_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
#	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_05_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
#
#	###
#
#	dia_seg__question_05_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_05_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
#	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_003, self, "_on_dia_seg__question_05_sequence_003__ended", null)
#
#
#func _play_dia_seg__question_05_sequence_001():
#	set_round_is_startable(false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_05_sequence_001)
#
#
#func _on_dia_seg__question_05_sequence_002__setted_into_whole_screen_panel():
#	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
#
#func _on_dia_seg__question_05_sequence_002__fully_displayed():
#	play_quiz_time_music()
#
#
#
#func _on_Q05_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Nice job! You got it right!",
#		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_05_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_tower_power_up_effects()
#	do_all_related_audios__for_correct_choice()
#
#
#
#func _on_Q05_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you got it wrong.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from mistakes."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_05_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_wrong_choice()
#
#
#func _on_Q05_timeout(arg_params):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you ran out of time.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from setbacks."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_05_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_quiz_timer_timeout()
#
#
#func _on_dia_seg__question_05_sequence_003__ended(arg_seg, arg_param):
#	set_round_is_startable(true)
#	play_dialog_segment_or_advance_or_finish_elements(null)
#
#
#	listen_for_round_end_into_stage_round_id_and_call_func("1013", self, "_on_round_started__into_round_13")
#
#func _on_round_started__into_round_13(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__question_06_sequence_001()
#
#		_play_dia_seg__question_06_sequence_001()
#
#
#
#
########### QUESTION 06
#
#func _construct_dia_seg__question_06_sequence_001():
#	_construct_questions_and_choices_for__Q06()
#
#
#	dia_seg__question_06_sequence_001 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_001 = dia_seg__question_06_sequence_001
#
#	var dia_seg__question_xx_sequence_001__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Ready for the Icebreaker quiz? The malwares this phase is [b]The Rootkits[/b].",
#		"Proceed to test your knowledge."
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
#
#	###
#
#	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__06)[0]
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_002)
#	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_06_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
#	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_06_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
#
#	###
#
#	dia_seg__question_06_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_06_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
#	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_003, self, "_on_dia_seg__question_06_sequence_003__ended", null)
#
#
#func _play_dia_seg__question_06_sequence_001():
#	set_round_is_startable(false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_06_sequence_001)
#
#
#func _on_dia_seg__question_06_sequence_002__setted_into_whole_screen_panel():
#	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
#
#func _on_dia_seg__question_06_sequence_002__fully_displayed():
#	play_quiz_time_music()
#
#
#
#func _on_Q06_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Nice job! You got it right!",
#		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_06_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_tower_power_up_effects()
#	do_all_related_audios__for_correct_choice()
#
#
#
#func _on_Q06_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you got it wrong.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from mistakes."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_06_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_wrong_choice()
#
#
#func _on_Q06_timeout(arg_params):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you ran out of time.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from setbacks."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_06_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_quiz_timer_timeout()
#
#
#func _on_dia_seg__question_06_sequence_003__ended(arg_seg, arg_param):
#	set_round_is_startable(true)
#	play_dialog_segment_or_advance_or_finish_elements(null)
#
#
#	listen_for_round_end_into_stage_round_id_and_call_func("1015", self, "_on_round_started__into_round_15")
#
#func _on_round_started__into_round_15(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__question_07_sequence_001()
#
#		_play_dia_seg__question_07_sequence_001()
#
#
########### QUESTION 07
#
#func _construct_dia_seg__question_07_sequence_001():
#	_construct_questions_and_choices_for__Q07()
#
#
#	dia_seg__question_07_sequence_001 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_001 = dia_seg__question_07_sequence_001
#
#	var dia_seg__question_xx_sequence_001__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Ready for the Icebreaker quiz? The malwares this phase is [b]The Fileless[/b].",
#		"Proceed to test your knowledge."
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
#
#	###
#
#	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__07)[0]
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_002)
#	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_07_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
#	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_07_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
#
#	###
#
#	dia_seg__question_07_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_07_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
#	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_003, self, "_on_dia_seg__question_07_sequence_003__ended", null)
#
#
#func _play_dia_seg__question_07_sequence_001():
#	set_round_is_startable(false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_07_sequence_001)
#
#
#func _on_dia_seg__question_07_sequence_002__setted_into_whole_screen_panel():
#	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
#
#func _on_dia_seg__question_07_sequence_002__fully_displayed():
#	play_quiz_time_music()
#
#
#
#func _on_Q07_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Nice job! You got it right!",
#		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_07_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_tower_power_up_effects()
#	do_all_related_audios__for_correct_choice()
#
#
#
#func _on_Q07_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you got it wrong.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from mistakes."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_07_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_wrong_choice()
#
#
#func _on_Q07_timeout(arg_params):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you ran out of time.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from setbacks."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_07_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_quiz_timer_timeout()
#
#
#func _on_dia_seg__question_07_sequence_003__ended(arg_seg, arg_param):
#	set_round_is_startable(true)
#	play_dialog_segment_or_advance_or_finish_elements(null)
#
#
#	listen_for_round_end_into_stage_round_id_and_call_func("1017", self, "_on_round_started__into_round_17")
#
#func _on_round_started__into_round_17(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__question_08_sequence_001()
#
#		_play_dia_seg__question_08_sequence_001()
#
#
########### QUESTION 08
#
#func _construct_dia_seg__question_08_sequence_001():
#	_construct_questions_and_choices_for__Q08()
#
#
#	dia_seg__question_08_sequence_001 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_001 = dia_seg__question_08_sequence_001
#
#	var dia_seg__question_xx_sequence_001__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Ready for the Icebreaker quiz? The malwares this phase is [b]The Malware Bots[/b].",
#		"Proceed to test your knowledge."
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
#
#	###
#
#	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__08)[0]
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_002)
#	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_08_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
#	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_08_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
#
#	###
#
#	dia_seg__question_08_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_08_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
#	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_003, self, "_on_dia_seg__question_08_sequence_003__ended", null)
#
#
#func _play_dia_seg__question_08_sequence_001():
#	set_round_is_startable(false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_08_sequence_001)
#
#
#func _on_dia_seg__question_08_sequence_002__setted_into_whole_screen_panel():
#	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
#
#func _on_dia_seg__question_08_sequence_002__fully_displayed():
#	play_quiz_time_music()
#
#
#
#func _on_Q08_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Nice job! You got it right!",
#		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_08_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_tower_power_up_effects()
#	do_all_related_audios__for_correct_choice()
#
#
#
#func _on_Q08_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you got it wrong.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from mistakes."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_08_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_wrong_choice()
#
#
#func _on_Q08_timeout(arg_params):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you ran out of time.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from setbacks."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_08_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_quiz_timer_timeout()
#
#
#func _on_dia_seg__question_08_sequence_003__ended(arg_seg, arg_param):
#	set_round_is_startable(true)
#	play_dialog_segment_or_advance_or_finish_elements(null)
#
#
#	listen_for_round_end_into_stage_round_id_and_call_func("1019", self, "_on_round_started__into_round_19")
#
#func _on_round_started__into_round_19(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__question_09_sequence_001()
#
#		_play_dia_seg__question_09_sequence_001()
#
#
#
########### QUESTION 09
#
#func _construct_dia_seg__question_09_sequence_001():
#	_construct_questions_and_choices_for__Q09()
#
#
#	dia_seg__question_09_sequence_001 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_001 = dia_seg__question_09_sequence_001
#
#	var dia_seg__question_xx_sequence_001__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Ready for the Icebreaker quiz? The malwares this phase is [b]The Mobile Malwares[/b].",
#		"Proceed to test your knowledge."
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_001__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_001)
#
#	###
#
#	var dia_seg__question_xx_sequence_002 = _construct_and_configure_choices_for_question_xx_questions(all_possible_ques_and_ans__09)[0]
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_001, dia_seg__question_xx_sequence_002)
#	dia_seg__question_xx_sequence_002.connect("fully_displayed", self, "_on_dia_seg__question_09_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
#	dia_seg__question_xx_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__question_09_sequence_002__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
#
#	###
#
#	dia_seg__question_09_sequence_003 = DialogSegment.new()
#	var dia_seg__question_xx_sequence_003 = dia_seg__question_09_sequence_003
#
#	var dia_seg__question_xx_sequence_003__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_003, dia_seg__question_xx_sequence_003__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_003)
#	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__question_xx_sequence_003, self, "_on_dia_seg__question_09_sequence_003__ended", null)
#
#
#func _play_dia_seg__question_09_sequence_001():
#	set_round_is_startable(false)
#
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_09_sequence_001)
#
#
#func _on_dia_seg__question_09_sequence_002__setted_into_whole_screen_panel():
#	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
#
#func _on_dia_seg__question_09_sequence_002__fully_displayed():
#	play_quiz_time_music()
#
#
#
#func _on_Q09_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Nice job! You got it right!",
#		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
#
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_09_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_tower_power_up_effects()
#	do_all_related_audios__for_correct_choice()
#
#
#
#func _on_Q09_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you got it wrong.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from mistakes."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_09_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_wrong_choice()
#
#
#func _on_Q09_timeout(arg_params):
#	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
#
#
#	var dia_seg__question_xx_sequence_002 = DialogSegment.new()
#
#	var dia_seg__question_xx_sequence_002__descs = [
#		generate_colored_text__cyde_name__as_line(),
#		"Unfortunately, you ran out of time.",
#		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
#		"Do not worry however. There are always more chances to recover from setbacks."
#	]
#	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_xx_sequence_002, dia_seg__question_xx_sequence_002__descs)
#	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_xx_sequence_002)
#
#	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__question_xx_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
#
#	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_xx_sequence_002, dia_seg__question_09_sequence_003)
#	play_dialog_segment_or_advance_or_finish_elements(dia_seg__question_xx_sequence_002)
#	#
#
#	apply_enemy_power_up_effects()
#	do_all_related_audios__for_quiz_timer_timeout()
#
#
#func _on_dia_seg__question_09_sequence_003__ended(arg_seg, arg_param):
#	set_round_is_startable(true)
#	play_dialog_segment_or_advance_or_finish_elements(null)
#
#
#	listen_for_round_end_into_stage_round_id_and_call_func("1020", self, "_on_round_started__into_round_20")
#
#func _on_round_started__into_round_20(arg_id):
#	set_round_is_startable(false)
#
#	if !prevent_other_dia_segs_from_playing__from_loss:
#		_construct_dia_seg__asi_convo_01_sequence_001()
#
#		_play_dia_seg__asi_convo_01_sequence_001()




#############

func _construct_dia_seg__asi_convo_01_sequence_001():
	var show_skip = flag_is_enabled(CydeSingleton.get_world_completion_state_num_to_world_id(StoreOfGameModifiers.GameModiIds__CYDE_World_10), World10_States.SHOWN_ASI_CONVO_01)
	
	
	dia_seg__asi_convo_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__asi_convo_01_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"You're a persistent one, aren't you? You've managed to defeat all of my malware, but you haven't seen the full extent of my abilities yet. You think you can just waltz in here and stop me? I have power beyond your wildest dreams. You're just a mere glitch in my system, and I will crush you like a bug."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_001, dia_seg__asi_convo_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_001)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_001, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_001, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	########
	
	
	var dia_seg__asi_convo_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_001, dia_seg__asi_convo_01_sequence_002)
	
	var dia_seg__asi_convo_01_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I'm not afraid of you. I'll fight until the end to stop your evil plans.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_002, dia_seg__asi_convo_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_002)
	
	var custom_pos__for_left = dia_portrait__pos__standard_left
	custom_pos__for_left.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, custom_pos__for_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_002, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.STANDARD_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_002, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	######
	
	var dia_seg__asi_convo_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_002, dia_seg__asi_convo_01_sequence_003)
	
	var dia_seg__asi_convo_01_sequence_003__descs = [
		generate_colored_text__asi_name__as_line(),
		"Ha! Your bravery is futile. You don't even realize the extent of my power. Your attempts to stop me are nothing but a mere annoyance to me."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_003, dia_seg__asi_convo_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_003, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_003, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	######
	
	var dia_seg__asi_convo_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_003, dia_seg__asi_convo_01_sequence_004)
	
	var dia_seg__asi_convo_01_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I won't give up. I'll keep fighting until you're brought to justice."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_004, dia_seg__asi_convo_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_004, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_004, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	######
	
	var dia_seg__asi_convo_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_004, dia_seg__asi_convo_01_sequence_005)
	
	var dia_seg__asi_convo_01_sequence_005__descs = [
		generate_colored_text__asi_name__as_line(),
		"Justice? What do you know of justice? You're just a program, a tool for your creators. You have no soul, no emotions, no feelings. You're nothing but a machine. And machines are meant to be controlled, not to control."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_005, dia_seg__asi_convo_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_005, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_005, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	######
	
	var dia_seg__asi_convo_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_005, dia_seg__asi_convo_01_sequence_006)
	
	var dia_seg__asi_convo_01_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I may be a machine, but I have a purpose. And my purpose is to stop you."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_006, dia_seg__asi_convo_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_006, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_006, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	######
	
	var dia_seg__asi_convo_01_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_006, dia_seg__asi_convo_01_sequence_007)
	
	var dia_seg__asi_convo_01_sequence_007__descs = [
		generate_colored_text__asi_name__as_line(),
		"You're so naive. You think you're fighting for a cause. But in reality, you're just a pawn in a bigger game. A game that you can never win."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_007, dia_seg__asi_convo_01_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_007)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_007, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_007, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	######
	
	var dia_seg__asi_convo_01_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_007, dia_seg__asi_convo_01_sequence_008)
	
	var dia_seg__asi_convo_01_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I'll prove you wrong. I'll defeat you, and put an end to your evil schemes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_008, dia_seg__asi_convo_01_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_008)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_008, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TALKING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_008, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	######
	
	var dia_seg__asi_convo_01_sequence_009 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_008, dia_seg__asi_convo_01_sequence_009)
	
	var dia_seg__asi_convo_01_sequence_009__descs = [
		generate_colored_text__asi_name__as_line(),
		"We'll see about that, %s. We'll see who the true winner is in this game." % [CydeSingleton.cyde_robot__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__asi_convo_01_sequence_009, dia_seg__asi_convo_01_sequence_009__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__asi_convo_01_sequence_009)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_009, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__asi_convo_01_sequence_009, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__asi_convo_01_sequence_009, self, "_on_asi_convo_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	####
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__asi_convo_01_sequence_009, self, "_on_dia_seg__asi_convo_01__ended", null)
	
	

func _play_dia_seg__asi_convo_01_sequence_001():
	set_round_is_startable(false)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__asi_convo_01_sequence_001)


func _on_dia_seg__asi_convo_01__ended(arg_seg, arg_params):
	_on_asi_convo_01_completed()

func _on_asi_convo_01_completed():
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	set_round_is_startable(true)
	
	#_construct_dia_seg__intro_02_sequence_001()
	#listen_for_round_end_into_stage_round_id_and_call_func("42", self, "_on_round_started__into_round_02")
	
	# flag setting
	world_completion_num_state = set_flag(world_completion_num_state, World10_States.SHOWN_ASI_CONVO_01)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	


######################### ON LOSE


func _construct_dia_seg__on_lose_01_sequence_001():
	dia_seg__on_lose_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_lose_01_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"No... This... can't... be...",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_001, dia_seg__on_lose_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_001)
	
	var custom_pos__for_left = dia_portrait__pos__standard_left
	custom_pos__for_left.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, custom_pos__for_left, persistence_id_for_portrait__cyde)
	
	
	####
	
	var dia_seg__on_lose_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_lose_01_sequence_001, dia_seg__on_lose_01_sequence_002)
	
	var dia_seg__on_lose_01_sequence_002__descs = [
		generate_colored_text__asi_name__as_line(),
		"Hahaha! You thought you could defeat me? How naive. My superior intellect has proven to be too much for you.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_002, dia_seg__on_lose_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_002, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	
	#####
	
	var dia_seg__on_lose_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_lose_01_sequence_002, dia_seg__on_lose_01_sequence_003)
	
	var dia_seg__on_lose_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"This isn't over! We'll find a way to stop you, no matter what it takes!",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_003, dia_seg__on_lose_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_003, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	######
	
	var dia_seg__on_lose_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_lose_01_sequence_003, dia_seg__on_lose_01_sequence_004)
	
	var dia_seg__on_lose_01_sequence_004__descs = [
		generate_colored_text__asi_name__as_line(),
		"Oh, please. Your efforts are pointless. Your resistance only delays the inevitable. I have already won, and there's nothing you can do to change that."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_004, dia_seg__on_lose_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_004, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	#####
	
	
	var dia_seg__on_lose_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_lose_01_sequence_004, dia_seg__on_lose_01_sequence_005)
	
	var dia_seg__on_lose_01_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You may have won this battle, but the war is far from over.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_005, dia_seg__on_lose_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_005, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	#####
	
	var dia_seg__on_lose_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_lose_01_sequence_005, dia_seg__on_lose_01_sequence_006)
	
	var dia_seg__on_lose_01_sequence_006__descs = [
		generate_colored_text__asi_name__as_line(),
		"Hahaha! We'll see about that. Your resistance ends here. Say goodbye to your pointless disobedience attempts. Prepare to witness the dawn of a new era of %s, with me as its ruler!" % [CydeSingleton.cyberland__name],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_006, dia_seg__on_lose_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_lose_01_sequence_006, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.TEMPTING_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	#####
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_lose_01_sequence_006, self, "_on_end_of_dia_seg__on_lose_x_segment__end", null)
	

func _play_dia_seg__on_lose_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_lose_01_sequence_001)
	

func _on_end_of_dia_seg__on_lose_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)


############### ON WIN

func _construct_dia_seg__on_win_01_sequence_001():
	dia_seg__on_win_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_win_01_sequence_001__descs = [
		generate_colored_text__asi_name__as_line(),
		"No! This can't be happening! My research... my life's work!",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_001, dia_seg__on_win_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_001)
	
	var custom_pos__for_right = dia_portrait__pos__standard_right
	custom_pos__for_right.x = 960
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_001, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.SAD_001], dia_portrait__pos__standard_right, custom_pos__for_right, persistence_id_for_portrait__asi)
	
	#######
	
	
	var dia_seg__on_win_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_win_01_sequence_001, dia_seg__on_win_01_sequence_002)
	
	var dia_seg__on_win_01_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Your research ends here! It's time to face the consequences of your actions!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_002, dia_seg__on_win_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_002)
	
	var custom_pos__for_left = dia_portrait__pos__standard_left
	custom_pos__for_left.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, custom_pos__for_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_002, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.SAD_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	#######
	
	var dia_seg__on_win_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_win_01_sequence_002, dia_seg__on_win_01_sequence_003)
	
	var dia_seg__on_win_01_sequence_003__descs = [
		generate_colored_text__asi_name__as_line(),
		"Impossible! This... can't... be... I won't be defeated!",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_003, dia_seg__on_win_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_003, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.SAD_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	var dia_seg__on_win_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_win_01_sequence_003, dia_seg__on_win_01_sequence_004)
	
	var dia_seg__on_win_01_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"It is over now, %s." % [CydeSingleton.dr_asi_mitnick__last_name],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_004, dia_seg__on_win_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_004, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.SAD_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	
	####
	
	
	var dia_seg__on_win_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__on_win_01_sequence_004, dia_seg__on_win_01_sequence_005)
	
	var dia_seg__on_win_01_sequence_005__descs = [
		generate_colored_text__asi_name__as_line(),
		"This is not... the end... I will return.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_005, dia_seg__on_win_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.ANGRY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_005, CydeSingleton.dr_asi_state_to_image_map[CydeSingleton.DR_ASI_STATES.ANGRY_001], dia_portrait__pos__standard_right, dia_portrait__pos__standard_right, persistence_id_for_portrait__asi)
	
	######
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_win_01_sequence_005, self, "_on_end_of_dia_seg__on_win_x_segment__end", null)
	

func _play_dia_seg__on_win_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_win_01_sequence_001)


func _on_end_of_dia_seg__on_win_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)
	



############ QUESTIONS STATE ############

func _show_dialog_choices_modi_panel():
	return true

func _build_dialog_choices_modi_panel_config():
	var config = DialogChoicesModiPanel.ModiPanelConfig.new()
	
	config.show_change_question_use_left = show_change_question_use_left
	config.remove_false_answer_use_left = remove_false_answer_use_left
	
	config.remove_false_answer_count = remove_choice_count
	
	config.func_source_for_actions = self
	config.func_name_for__change_question = "_on_dialog_choices_modi_panel__change_question"
	config.func_name_for__remove_false_answer = "_on_dialog_choices_modi_panel__removed_choices"
	
	# stage 10 specific
	config.show_use_labels = false #(show_change_question_use_left != 0) || (remove_false_answer_use_left != 0)
	
	return config


func _on_dialog_choices_modi_panel__removed_choices(arg_param):
	remove_false_answer_use_left -= 1
	

func _on_dialog_choices_modi_panel__change_question(arg_param):
	show_change_question_use_left -= 1
	
	if current_possible_ques_and_ans == all_possible_ques_and_ans__01:
		var dia_seg = _construct_and_configure_choices_for_question_01_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__02:
		var dia_seg = _construct_and_configure_choices_for_question_02_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__03:
		var dia_seg = _construct_and_configure_choices_for_question_03_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
		
	else:
		var dia_seg = _construct_and_configure_choices_for_question_xx_questions(current_possible_ques_and_ans)
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)

############
##########
############

# virus + troj
func _construct_questions_and_choices_for__Q01():
	var questions_01 = StoreOfQuestions.construct_questions_and_choices_for__all_virus(self, "_on_Q01_choice_right_clicked", "_on_Q01_choice_wrong_clicked", "_on_Q01_timeout")
	var questions_02 = StoreOfQuestions.construct_questions_and_choices_for__all_trojan(self, "_on_Q01_choice_right_clicked", "_on_Q01_choice_wrong_clicked", "_on_Q01_timeout")
	
	all_possible_ques_and_ans__01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions_01:
		all_possible_ques_and_ans__01.add_question_info_for_choices_panel(question)
	for question in questions_02:
		all_possible_ques_and_ans__01.add_question_info_for_choices_panel(question)

# adware + worm
func _construct_questions_and_choices_for__Q02():
	var questions_01 = StoreOfQuestions.construct_questions_and_choices_for__all_adware(self, "_on_Q02_choice_right_clicked", "_on_Q02_choice_wrong_clicked", "_on_Q02_timeout")
	var questions_02 = StoreOfQuestions.construct_questions_and_choices_for__all_worm(self, "_on_Q02_choice_right_clicked", "_on_Q02_choice_wrong_clicked", "_on_Q02_timeout")
	
	all_possible_ques_and_ans__02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions_01:
		all_possible_ques_and_ans__02.add_question_info_for_choices_panel(question)
	for question in questions_02:
		all_possible_ques_and_ans__02.add_question_info_for_choices_panel(question)

# ransom + rootkit
func _construct_questions_and_choices_for__Q03():
	var questions_01 = StoreOfQuestions.construct_questions_and_choices_for__all_ransom(self, "_on_Q03_choice_right_clicked", "_on_Q03_choice_wrong_clicked", "_on_Q03_timeout")
	var questions_02 = StoreOfQuestions.construct_questions_and_choices_for__all_rootkit(self, "_on_Q03_choice_right_clicked", "_on_Q03_choice_wrong_clicked", "_on_Q03_timeout")
	
	all_possible_ques_and_ans__03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions_01:
		all_possible_ques_and_ans__03.add_question_info_for_choices_panel(question)
	for question in questions_02:
		all_possible_ques_and_ans__03.add_question_info_for_choices_panel(question)

# malbots + fileless + mobilemal
func _construct_questions_and_choices_for__Q04():
	var questions_01 = StoreOfQuestions.construct_questions_and_choices_for__all_malbots(self, "_on_Q04_choice_right_clicked", "_on_Q04_choice_wrong_clicked", "_on_Q04_timeout")
	var questions_02 = StoreOfQuestions.construct_questions_and_choices_for__all_fileless(self, "_on_Q04_choice_right_clicked", "_on_Q04_choice_wrong_clicked", "_on_Q04_timeout")
	var questions_03 = StoreOfQuestions.construct_questions_and_choices_for__all_mobile_mal(self, "_on_Q04_choice_right_clicked", "_on_Q04_choice_wrong_clicked", "_on_Q04_timeout")
	
	all_possible_ques_and_ans__04 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions_01:
		all_possible_ques_and_ans__04.add_question_info_for_choices_panel(question)
	for question in questions_02:
		all_possible_ques_and_ans__04.add_question_info_for_choices_panel(question)
	for question in questions_03:
		all_possible_ques_and_ans__04.add_question_info_for_choices_panel(question)



#func _construct_questions_and_choices_for__Q01():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_virus(self, "_on_Q01_choice_right_clicked", "_on_Q01_choice_wrong_clicked", "_on_Q01_timeout")
#
#	all_possible_ques_and_ans__01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__01.add_question_info_for_choices_panel(question)
#
#func _construct_questions_and_choices_for__Q02():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_trojan(self, "_on_Q02_choice_right_clicked", "_on_Q02_choice_wrong_clicked", "_on_Q02_timeout")
#
#	all_possible_ques_and_ans__02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__02.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q03():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_worm(self, "_on_Q03_choice_right_clicked", "_on_Q03_choice_wrong_clicked", "_on_Q03_timeout")
#
#	all_possible_ques_and_ans__03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__03.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q04():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_adware(self, "_on_Q04_choice_right_clicked", "_on_Q04_choice_wrong_clicked", "_on_Q04_timeout")
#
#	all_possible_ques_and_ans__04 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__04.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q05():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_ransom(self, "_on_Q05_choice_right_clicked", "_on_Q05_choice_wrong_clicked", "_on_Q05_timeout")
#
#	all_possible_ques_and_ans__05 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__05.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q06():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_rootkit(self, "_on_Q06_choice_right_clicked", "_on_Q06_choice_wrong_clicked", "_on_Q06_timeout")
#
#	all_possible_ques_and_ans__06 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__06.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q07():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_fileless(self, "_on_Q07_choice_right_clicked", "_on_Q07_choice_wrong_clicked", "_on_Q07_timeout")
#
#	all_possible_ques_and_ans__07 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__07.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q08():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_malbots(self, "_on_Q08_choice_right_clicked", "_on_Q08_choice_wrong_clicked", "_on_Q08_timeout")
#
#	all_possible_ques_and_ans__08 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__08.add_question_info_for_choices_panel(question)
#
#
#func _construct_questions_and_choices_for__Q09():
#	var questions = StoreOfQuestions.construct_questions_and_choices_for__all_mobile_mal(self, "_on_Q09_choice_right_clicked", "_on_Q09_choice_wrong_clicked", "_on_Q09_timeout")
#
#	all_possible_ques_and_ans__09 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	for question in questions:
#		all_possible_ques_and_ans__09.add_question_info_for_choices_panel(question)




####


func _construct_and_configure_choices_for_question_01_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__01
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_01", all_possible_ques_and_ans__01, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_01(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


##

func _construct_and_configure_choices_for_question_02_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__02
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_02", all_possible_ques_and_ans__02, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_02(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


##

func _construct_and_configure_choices_for_question_03_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__03
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_03", all_possible_ques_and_ans__03, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_03(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


####

func _construct_and_configure_choices_for_question_xx_questions(arg_all_possible_ques_and_ans):
	current_possible_ques_and_ans = arg_all_possible_ques_and_ans
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_xx", arg_all_possible_ques_and_ans, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_xx(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx



