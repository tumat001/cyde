extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"

const CenterBasedAttackParticle = preload("res://MiscRelated/AttackSpriteRelated/CenterBasedAttackSprite.gd")
const CenterBasedAttackParticle_Scene = preload("res://MiscRelated/AttackSpriteRelated/CenterBasedAttackSprite.tscn")

const CydeMode_StageRounds_World08 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomStageRounds/CydeMode_StageRounds_World08.gd")
const CydeMode_EnemySpawnIns_World08 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomWaves/CydeMode_EnemySpawnIns_World08.gd")


enum World08_States {
	
	NONE = 1 << 0
	
	SHOWN_CYDE_CONVO_01 = 1 << 1,
	
}

var stage_rounds_to_use

#

var dia_seg__intro_01_sequence_001 : DialogSegment


# Info 01
var dia_seg__info_01_sequence_001 : DialogSegment

# Question 01
var dia_seg__question_01_sequence_001 : DialogSegment
var dia_seg__question_01_sequence_003 : DialogSegment


# Info 02
var dia_seg__info_02_sequence_001 : DialogSegment

# Question 02
var dia_seg__question_02_sequence_001 : DialogSegment
var dia_seg__question_02_sequence_003 : DialogSegment


# Info 03
var dia_seg__info_03_sequence_001 : DialogSegment

# Question 03
var dia_seg__question_03_sequence_001 : DialogSegment
var dia_seg__question_03_sequence_003 : DialogSegment



## on lose
var dia_seg__on_lose_01_sequence_001 : DialogSegment

## on win
var dia_seg__on_win_01_sequence_001 : DialogSegment
var dia_seg__on_win_02_sequence_001 : DialogSegment


# world 8 specific

#var pos_of_final_enemy_killed : Vector2 = Vector2(200, 200) #default val
var letter_star_particle_pool_component : AttackSpritePoolComponent


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

#

var all_possible_ques_and_ans__for_malbots_01
var all_possible_ques_and_ans__for_malbots_02
var all_possible_ques_and_ans__for_malbots_03

####


func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_08,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World08_Modi"):
	
	pass


func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	stage_rounds_to_use = CydeMode_StageRounds_World08.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World08.new())
	
	#
	
	call_deferred("_deferred_applied")
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World09)
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
	add_gold_amount(15)
	
	#set_player_level(starting_player_level_at_this_modi)
	
	game_elements.game_result_manager.show_main_menu_button = false
	


func _construct_dia_seg__intro_01_sequence_001():
	var show_skip = flag_is_enabled(CydeSingleton.get_world_completion_state_num_to_world_id(StoreOfGameModifiers.GameModiIds__CYDE_World_08), World08_States.SHOWN_CYDE_CONVO_01)
	
	
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Greetings, %s! How are you feeling so far?" % [CydeSingleton.player_name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_001, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	####
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		generate_colored_text__player_name__as_line(),
		"Hi, %s. I'm feeling great, thanks! Why?" % [CydeSingleton.cyde_robot__name],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_002, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	####
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"That's wonderful to hear! I just wanted to see how you're feeling about our journey so far."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_003, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	####
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		generate_colored_text__player_name__as_line(),
		"It's pretty good because you're a great companion, and I'm grateful for that."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_004, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	####
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I should be the one thanking you. Well, let’s continue our journey then."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	if show_skip:
		configure_dia_seg_to_skip_to_next_on_player_skip__next_seg_as_func(dia_seg__intro_01_sequence_005, self, "_on_intro_01_completed", SKIP_BUTTON__SKIP_DIALOG_TEXT)
	
	
	####
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		generate_colored_text__player_name__as_line(),
		"Let’s go"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#####
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_006, self, "_on_dia_seg__intro_01__ended", null)
	
	


func _play_dia_seg__intro_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)
	
	#_initialize_letter_star_particle_pool_components()
	#_play_letter_star_particles(game_elements.get_middle_coordinates_of_playable_map())

func _on_dia_seg__intro_01__ended(arg_seg, arg_params):
	_on_intro_01_completed()
	

func _on_intro_01_completed():
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	set_round_is_startable(true)
	
	#_construct_dia_seg__intro_02_sequence_001()
	#listen_for_round_end_into_stage_round_id_and_call_func("42", self, "_on_round_started__into_round_02")
	
	# flag setting
	world_completion_num_state = set_flag(world_completion_num_state, World08_States.SHOWN_CYDE_CONVO_01)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	####
	
	listen_for_round_end_into_stage_round_id_and_call_func("85", self, "_on_round_started__into_round_05")

func _on_round_started__into_round_05(arg_stageround_id):
	if !prevent_other_dia_segs_from_playing__from_loss:
		_construct_dia_seg__info_01_sequence_001()
		_play_dia_seg__info_01_sequence_001()
		

########### INFO 01

func _construct_dia_seg__info_01_sequence_001():
	
	dia_seg__info_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__info_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I have now researched about the malwares of this stage: the [b]Malware Bots[/b]",
		"I'll be providing their background. Take note of the information that I'll give you."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_01_sequence_001, dia_seg__info_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_01_sequence_001)
	
	#######
	
	var dia_seg__info_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_01_sequence_001, dia_seg__info_01_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__MALBOTS_BACKGROUND_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__info_01_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__info_01_sequence_002)
	dia_seg__info_01_sequence_002.connect("fully_displayed", self, "_on_dia_seg__info_01_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	#dia_seg__info_01_sequence_002.final_dialog_custom_size_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	#dia_seg__info_01_sequence_002.final_dialog_top_left_pos_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	
	
	####
	
	var dia_seg__info_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_01_sequence_002, dia_seg__info_01_sequence_003)
	
	
	var dia_seg__info_01_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can start the round whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_01_sequence_003, dia_seg__info_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_01_sequence_003)
	dia_seg__info_01_sequence_003.connect("fully_displayed", self, "_on_dia_seg__info_01_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__info_01_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__info_01_sequence_001)


func _on_dia_seg__info_01_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__info_01_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_06", "_on_round_ended__into_round_06")



func _on_round_started__into_round_06():
	_construct_dia_seg__question_01_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_06():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__question_01_sequence_001()




########### QUESTION 01

func _construct_dia_seg__question_01_sequence_001():
	_construct_questions_and_choices_for__malbots_Q01()
	
	
	dia_seg__question_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_01_sequence_001, dia_seg__question_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_01_sequence_001)
	
	###
	
	var dia_seg__question_01_sequence_002 = _construct_and_configure_choices_for_question_01_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_01_sequence_001, dia_seg__question_01_sequence_002)
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



func _on_malbots_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	
	

func _on_malbots_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	
	

func _on_malbots_Q01_timeout(arg_params):
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
	
	_construct_dia_seg__info_02_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("88", self, "_on_round_started__into_round_08")

func _on_round_started__into_round_08(arg_stageround_id):
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__info_02_sequence_001()



########## INFO 02

func _construct_dia_seg__info_02_sequence_001():
	
	dia_seg__info_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__info_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"New information regarding our enemies, the Malware Bots, has been researched. This time, it is about their behavior on devices.",
		"I'll put it on display for you to review."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_02_sequence_001, dia_seg__info_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_02_sequence_001)
	
	#######
	
	var dia_seg__info_02_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_02_sequence_001, dia_seg__info_02_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__MALBOTS_BEHAVIOR_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__info_02_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__info_02_sequence_002)
	dia_seg__info_02_sequence_002.connect("fully_displayed", self, "_on_dia_seg__info_02_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	#dia_seg__info_01_sequence_002.final_dialog_custom_size_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	#dia_seg__info_01_sequence_002.final_dialog_top_left_pos_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	
	
	####
	
	var dia_seg__info_02_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_02_sequence_002, dia_seg__info_02_sequence_003)
	
	
	var dia_seg__info_02_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can start the round whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_02_sequence_003, dia_seg__info_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_02_sequence_003)
	dia_seg__info_02_sequence_003.connect("fully_displayed", self, "_on_dia_seg__info_02_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__info_02_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__info_02_sequence_001)

func _on_dia_seg__info_02_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__info_02_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_09", "_on_round_ended__into_round_09")



func _on_round_started__into_round_09():
	_construct_dia_seg__question_02_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_09():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__question_02_sequence_001()



######### QUESTION 02

func _construct_dia_seg__question_02_sequence_001():
	_construct_questions_and_choices_for__malbots_Q02()
	
	
	dia_seg__question_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_02_sequence_001, dia_seg__question_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_02_sequence_001)
	
	###
	
	var dia_seg__question_02_sequence_002 = _construct_and_configure_choices_for_question_02_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_02_sequence_001, dia_seg__question_02_sequence_002)
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



func _on_malbots_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_malbots_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_malbots_Q02_timeout(arg_params):
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
	
	_construct_dia_seg__info_03_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("811", self, "_on_round_started__into_round_11")

func _on_round_started__into_round_11(arg_stageround_id):
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__info_03_sequence_001()



########## INFO 03

func _construct_dia_seg__info_03_sequence_001():
	
	dia_seg__info_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__info_03_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"One last information regarding our enemies, the Malware Bots, has been researched. This time, it is about how to avoid them, in general.",
		"I'll put it on display for you to review."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_03_sequence_001, dia_seg__info_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_03_sequence_001)
	
	#######
	
	var dia_seg__info_03_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_03_sequence_001, dia_seg__info_03_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__MALBOTS_PRACTICES_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__info_03_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__info_03_sequence_002)
	dia_seg__info_03_sequence_002.connect("fully_displayed", self, "_on_dia_seg__info_03_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	#dia_seg__info_01_sequence_002.final_dialog_custom_size_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	#dia_seg__info_01_sequence_002.final_dialog_top_left_pos_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	
	
	####
	
	var dia_seg__info_03_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__info_03_sequence_002, dia_seg__info_03_sequence_003)
	
	
	var dia_seg__info_03_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can start the round whenever you're ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__info_03_sequence_003, dia_seg__info_03_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__info_03_sequence_003)
	dia_seg__info_03_sequence_003.connect("fully_displayed", self, "_on_dia_seg__info_03_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__info_03_sequence_001():
	set_round_is_startable(false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__info_03_sequence_001)


func _on_dia_seg__info_03_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__info_03_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_12", "_on_round_ended__into_round_12")


func _on_round_started__into_round_12():
	_construct_dia_seg__question_03_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_12():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__question_03_sequence_001()




########## QUESTION 03


func _construct_dia_seg__question_03_sequence_001():
	_construct_questions_and_choices_for__malbots_Q03()
	
	
	dia_seg__question_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__question_03_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Last Icebreaker quiz of this stage? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__question_03_sequence_001, dia_seg__question_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__question_03_sequence_001)
	
	###
	
	var dia_seg__question_03_sequence_002 = _construct_and_configure_choices_for_question_03_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__question_03_sequence_001, dia_seg__question_03_sequence_002)
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



func _on_malbots_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	
	

func _on_malbots_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_fileless_Q03_timeout(arg_params):
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
	
	#_construct_dia_seg__intro_11_sequence_001()
	
	listen_for_round_end_into_stage_round_id_and_call_func("813", self, "_on_round_started__into_round_13")


func _on_round_started__into_round_13(arg_stageround_id):
	game_elements.enemy_manager.connect("last_enemy_standing_killed_by_damage_no_revives", self, "_on_round_13_last_enemy_standing_killed_by_damage_no_revives", [], CONNECT_ONESHOT)

func _on_round_13_last_enemy_standing_killed_by_damage_no_revives(damage_instance_report, enemy):
	#pos_of_final_enemy_killed = enemy.global_position
	pass


##########

func _construct_questions_and_choices_for__malbots_Q01():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Malware that can gain control of the infected device or devices.\nThey can collect your data and passwords once installed on your device."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_malbots_Q01_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Software that uses encryption\nto disable a target's access to its data until a ransom is paid."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Leaves no footprint because it is not a file-based attack\nthat requires the downloading of executable files on the infected system."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Known to compromise internet of Things (IoT) devices\nin order to conduct large-scale DDoS attacks."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
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
#		"What are malware bots?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_malbots_Q01_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Botnet"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_malbots_Q01_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Internet Bot"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "DDos Bot"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Malicious Bot"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_malbots_Q01_choice_wrong_clicked"
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
#		"Most malware bots are designed to infect a large number of computers.\nSuch a large network of computers infected by bots is called?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_malbots_Q01_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__malbots_Q01(self, "_on_malbots_Q01_choice_right_clicked", "_on_malbots_Q01_choice_wrong_clicked", "_on_malbots_Q01_timeout")
	
	all_possible_ques_and_ans__for_malbots_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_malbots_01.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_malbots_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_malbots_01.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_malbots_01.add_question_info_for_choices_panel(question_info__02)


######################


func _construct_questions_and_choices_for__malbots_Q02():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "A number of internet-connected devices, each running one or more bots,\noften without the device owners’ knowledge."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_malbots_Q02_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Programmed/hacked to break into user accounts, scan the internet for contact information,\nto send spam, or perform other harmful acts."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "An attack or infection vector is how malware obtains access."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Infect a computer through various methods, such as phishing emails,\ninfected software downloads, or vulnerabilities in outdated software."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
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
#		"To carry out these attacks and disguise the source of the attack traffic,\nattackers may distribute bad bots in a botnet – i.e., a bot network.\nWhat is a botnet?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_malbots_Q02_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "All of the choices"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_malbots_Q02_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Break into user accounts"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Scan the internet for contact information"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Send spam"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_malbots_Q02_choice_wrong_clicked"
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
#		"Malware bots and internet bots can be programmed/hacked to?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_malbots_Q02_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__malbots_Q02(self, "_on_malbots_Q02_choice_right_clicked", "_on_malbots_Q02_choice_wrong_clicked", "_on_malbots_Q02_timeout")
	
	all_possible_ques_and_ans__for_malbots_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_malbots_02.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_malbots_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_malbots_02.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_malbots_02.add_question_info_for_choices_panel(question_info__02)


########################


func _construct_questions_and_choices_for__malbots_Q03():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Use a long and complicated password\nthat contains numbers and symbols."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_malbots_Q03_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Install apps from trusted sources only"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Don’t Click on links or attachments\nin unsolicited emails or text messages"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Monitor your network’s traffic"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
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
#		"Which of the following is one of the best practices to prevent Malware Bots attacks?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_malbots_Q03_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Don’t Click on links or attachments\nin unsolicited emails or text messages"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_malbots_Q03_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Install firewalls to block\nmalicious attacks and never turn them off."
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Use a long and complicated password\nthat contains numbers and symbols."
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Never use the same password for multiple programs."
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_malbots_Q03_choice_wrong_clicked"
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
#		"Which of the following is not one of the best practices to prevent Malware Bots attacks?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_malbots_Q03_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__malbots_Q03(self, "_on_malbots_Q03_choice_right_clicked", "_on_malbots_Q03_choice_wrong_clicked", "_on_malbots_Q03_timeout")
	
	all_possible_ques_and_ans__for_malbots_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_malbots_03.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_malbots_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_malbots_03.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_malbots_03.add_question_info_for_choices_panel(question_info__02)


######################### ON LOSE


func _construct_dia_seg__on_lose_01_sequence_001():
	dia_seg__on_lose_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_lose_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, your data has been breached..."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_lose_01_sequence_001, dia_seg__on_lose_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_lose_01_sequence_001)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_lose_01_sequence_001, self, "_on_end_of_dia_seg__on_lose_x_segment__end", null)
	
	#########
	
	
	

func _play_dia_seg__on_lose_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_lose_01_sequence_001)
	

func _on_end_of_dia_seg__on_lose_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)


############### BEFORE PICK UP OF LETTER (ON WIN)

func _construct_dia_seg__on_win_01_sequence_001():
	dia_seg__on_win_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_win_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Looks like a letter was dropped on the ground. Let's click on it to pick it up."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_001, dia_seg__on_win_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	######
	
	_initialize_letter_star_particle_pool_components()
	
	# drop letter
	
	var pickable_adv_param := PickupableAdvParams.new()
	
	pickable_adv_param.original_location = game_elements.get_middle_coordinates_of_playable_map() #pos_of_final_enemy_killed
	pickable_adv_param.configure_final_location_towards_center(0, 0, game_elements.get_middle_coordinates_of_playable_map())
	pickable_adv_param.max_height = 80
	pickable_adv_param.speed = 0.5
	
	pickable_adv_param.queue_free_on_animation_end = true
	
	pickable_adv_param.texture_normal = preload("res://CYDE_SPECIFIC_ONLY/TestTemp/Test_LetterNormal.png") #= #todo
	pickable_adv_param.texture_hover = preload("res://CYDE_SPECIFIC_ONLY/TestTemp/Test_LetterGlow.png") #= #todo
	
	pickable_adv_param.func_source = self
	pickable_adv_param.func_name_for__on_click = "_on_letter_clicked"
	pickable_adv_param.func_name_for__on_end_of_animation = "_on_letter_end_of_animation"
	
	create_pickupable(pickable_adv_param)
	

func _play_dia_seg__on_win_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_win_01_sequence_001)
	


func _on_letter_clicked(arg_letter, arg_custom_params):
	_play_letter_star_particles(arg_letter.rect_global_position + (arg_letter.rect_size / 2))
	
	_construct_dia_seg__on_win_02_sequence_001()

func _on_letter_end_of_animation(arg_letter, arg_custom_params):
	_play_dia_seg__on_win_02_sequence_001()
	


# star particles related

func _initialize_letter_star_particle_pool_components():
	letter_star_particle_pool_component = AttackSpritePoolComponent.new()
	letter_star_particle_pool_component.node_to_parent_attack_sprites = CommsForBetweenScenes.current_game_elements__other_node_hoster
	letter_star_particle_pool_component.node_to_listen_for_queue_free = CommsForBetweenScenes.current_game_elements__other_node_hoster
	letter_star_particle_pool_component.source_for_funcs_for_attk_sprite = self
	letter_star_particle_pool_component.func_name_for_creating_attack_sprite = "_create_letter_star_particle"

func _create_letter_star_particle():
	var particle = CenterBasedAttackParticle_Scene.instance()
	
	particle.texture_to_use = preload("res://CYDE_SPECIFIC_ONLY/DialogRelated/Assets/LetterRelated/Letter_StarParticle.png")
	
	particle.speed_accel_towards_center = 270
	particle.initial_speed_towards_center = non_essential_rng.randf_range(-230, -270)
	
	particle.max_speed_towards_center = -5
	
	particle.lifetime_to_start_transparency = 0.45
	particle.transparency_per_sec = 1 / 0.45
	
	particle.min_starting_angle = 0
	particle.max_starting_angle = 359
	
	return particle


func _play_letter_star_particles(arg_pos):
	for i in 10:
		var particle = letter_star_particle_pool_component.get_or_create_attack_sprite_from_pool()
		
		particle.center_pos_of_basis = arg_pos
		particle.lifetime = 0.9
		
		particle.reset_for_another_use()
		particle.is_enabled_mov_toward_center = true
		particle.rotation = particle.global_position.angle_to_point(arg_pos)
		
		particle.visible = true
		particle.modulate.a = 0.8


############## ON PICK UP OF LETTER (ON WIN)

func _construct_dia_seg__on_win_02_sequence_001():
	dia_seg__on_win_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_win_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"TODO put new things here",
		
		#"Congratulations for winning the stage! [b]The Malware Bots[/b] have been defeated.",
		#"You can proceed to the next map to continue the story."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_02_sequence_001, dia_seg__on_win_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_02_sequence_001)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__on_win_02_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	
	####
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_win_02_sequence_001, self, "_on_end_of_dia_seg__on_win_x_segment__end", null)
	


func _play_dia_seg__on_win_02_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_win_02_sequence_001)


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
	
	return config


func _on_dialog_choices_modi_panel__removed_choices(arg_param):
	remove_false_answer_use_left -= 1

func _on_dialog_choices_modi_panel__change_question(arg_param):
	show_change_question_use_left -= 1
	
	if current_possible_ques_and_ans == all_possible_ques_and_ans__for_malbots_01:
		var dia_seg = _construct_and_configure_choices_for_question_01_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_malbots_02:
		var dia_seg = _construct_and_configure_choices_for_question_02_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_malbots_03:
		var dia_seg = _construct_and_configure_choices_for_question_03_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)



############

func _construct_and_configure_choices_for_question_01_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_malbots_01
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_01", all_possible_ques_and_ans__for_malbots_01, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_01(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


##

func _construct_and_configure_choices_for_question_02_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_malbots_02
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_02", all_possible_ques_and_ans__for_malbots_02, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_02(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


##

func _construct_and_configure_choices_for_question_03_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_malbots_03
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__question_03", all_possible_ques_and_ans__for_malbots_03, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__question_03(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx


