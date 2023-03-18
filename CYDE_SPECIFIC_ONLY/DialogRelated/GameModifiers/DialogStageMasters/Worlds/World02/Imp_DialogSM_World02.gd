extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"


const CydeMode_StageRounds_World02 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomStageRounds/CydeMode_StageRounds_World02.gd")
const CydeMode_EnemySpawnIns_World02 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomWaves/CydeMode_EnemySpawnIns_World02.gd")

#

var number_to_as_word_map : Dictionary = {
	3 : "three",
	4 : "four",
	5 : "five",
}
var _current_number_as_word__for_combination_count : String

#

var stage_rounds_to_use

# Intro for upgrades/combination
var dia_seg__intro_01_sequence_001 : DialogSegment

# Demo for upgrade
var dia_seg__intro_02_sequence_001 : DialogSegment
var dia_seg__intro_02_sequence_002 : DialogSegment
var dia_seg__intro_02_sequence_003 : DialogSegment
var dia_seg__intro_02_sequence_004 : DialogSegment 

####

#TODO once more towers are added, change this list (retain the 2 x typed tower)
var tower_ids_to_buy_at_intro_02__01 : Array = [Towers.SPRINKLER, Towers.MINI_TESLA, Towers.STRIKER, Towers.SPRINKLER, Towers.MINI_TESLA]
#TODO once the offical towers are added, change this
var tower_name_in_common_to_buy_at_intro_02__01__plural : String = "Sprinklers"
var tower_buy_slot_enabled_at_intro_02__01 : Array = [1, 4]
var tower_ids_to_listen_for_buy_for_intro_02__01 : Array = [Towers.SPRINKLER, Towers.SPRINKLER]


#TODO once more towers are added, change this list (retain the 1 x typed tower of the prev (in 02__01))
var tower_ids_to_buy_at_intro_02__04 : Array = [Towers.STRIKER, Towers.MINI_TESLA, Towers.SPRINKLER, Towers.MINI_TESLA, Towers.STRIKER]
#TODO once the offical towers are added, change this
var tower_name_in_common_to_buy_at_intro_02__04__singular : String = "Sprinkler"
var tower_buy_slot_enabled_at_intro_02__04 : Array = [3]
var tower_ids_to_listen_for_buy_for_intro_02__04 : Array = [Towers.SPRINKLER]



# QUESTIONS RELATED -- SPECIFIC FOR THIS

# 01 is missing cause of duplication...............................................................
var all_possible_ques_and_ans__for_trojan_02
var all_possible_ques_and_ans__for_trojan_03
var all_possible_ques_and_ans__for_trojan_04


# QUESTIONS RELATED -- CAN BE COPY PASTED TO OTHERS

var current_possible_ques_and_ans

var show_change_questions : bool = true
var remove_choice_count : int = 1

###########


func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_02,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World02_Modi"):
	
	pass

func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	towers_offered_on_shop_refresh.append(tower_ids_to_buy_at_intro_02__01)
	
	#
	
	_current_number_as_word__for_combination_count = number_to_as_word_map[game_elements.CombinationManager.base_combination_amount]
	
	
	stage_rounds_to_use = CydeMode_StageRounds_World02.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World02.new())
	
	#
	
	game_elements.synergy_manager.allow_synergies_clauses.attempt_insert_clause(game_elements.synergy_manager.AllowSynergiesClauseIds.CYDE__STAGE_01_CLAUSE)
	
	#
	
	call_deferred("_deferred_applied")
	


func _deferred_applied():
	
	_construct_dia_seg__intro_01_sequence_001()
	_play_dia_seg__intro_01_sequence_001()
	
	
	#_construct_dia_seg__intro_07_sequence_001()
	#_play_dia_seg__intro_07_sequence_001()


func _on_game_elements_before_game_start__base_class():
	._on_game_elements_before_game_start__base_class()
	
	clear_all_tower_cards_from_shop()
	set_round_is_startable(false)
	set_can_level_up(false)
	set_can_refresh_shop__panel_based(false)
	set_can_refresh_shop_at_round_end_clauses(false)
	set_enabled_buy_slots([])
	
	set_can_sell_towers(false)
	set_can_toggle_to_ingredient_mode(false)
	set_can_towers_swap_positions_to_another_tower(false)
	add_shop_per_refresh_modifier(-5)
	add_gold_amount(20)
	
	#TODO do this once done. Also make (1) placables visible on start
	#set_visiblity_of_all_placables(false)
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World02)
	game_elements.game_result_manager.show_main_menu_button = false
	
	

##########

func _construct_dia_seg__intro_01_sequence_001():
	var plain_fragment__tower_upgrades = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "tower upgrades")
	var plain_fragment__upgrade = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "upgrade")
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__Upgraded_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Upgraded towers")
	
	###
	
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		["Hey there, [b]%s[/b]! Let's talk about |0|. As you progress through the game, you will have the option to |1| your |2|. |3| have greatly increased strength." % [CydeSingleton.player_name], [plain_fragment__tower_upgrades, plain_fragment__upgrade, plain_fragment__towers, plain_fragment__Upgraded_towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	###
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		["Okay, that sounds useful. How do I upgrade my towers?", [plain_fragment__upgrade, plain_fragment__towers]]
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	
	###
	
	var plain_fragment__1_star_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ONE_STAR__UPGRADE, "1-star tower")
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	var plain_fragment__2_star_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TWO_STAR__UPGRADE, "2-star tower")
	var plain_fragment__combine = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "combine")
	var plain_fragment__1_star_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ONE_STAR__UPGRADE, "1-star towers")
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		["Let me explain the tower upgrade system to you. Each tower that you buy from the shop is a |0|. To upgrade a |1| to a |2|, you need to |3| %s |4| of the same type. Once you have them, you can combine them to create a more powerful |5|, with even greater damage." % [_current_number_as_word__for_combination_count], [plain_fragment__1_star_tower, plain_fragment__tower, plain_fragment__2_star_tower, plain_fragment__combine, plain_fragment__1_star_towers, plain_fragment__2_star_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	###
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		"And how do I achieve the final level of upgrade?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	
	###
	
	var plain_fragment__3_star_upgrade = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.THREE_STAR__UPGRADE, "3-star upgrade")
	var plain_fragment__2_star_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TWO_STAR__UPGRADE, "2-star towers")
	var plain_fragment__3_star_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.THREE_STAR__UPGRADE, "3-star tower")
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		["The final level is the |0|. To accomplish this, you need %s |1| of the same type. Once you have them, they |2| to create a powerful |3| that can deal massive damage to any malware that comes your way." % [_current_number_as_word__for_combination_count], [plain_fragment__3_star_upgrade, plain_fragment__2_star_towers, plain_fragment__combine, plain_fragment__3_star_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	
	###
	
	var plain_fragment__identical_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "identical towers")
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		["Great, thanks for explaining that to me. How do I get the |0| to |1| them?", [plain_fragment__identical_towers, plain_fragment__upgrade]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_006)
	
	
	###
	
	var plain_fragment__Towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Towers")
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	var plain_fragment__end_of_the_round = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "end of the round")
	var plain_fragment__refreshing_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refreshing the shop")
	var plain_fragment__Refreshing = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "Refreshing")
	var plain_fragment__x_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "2 Gold")
	
	
	var dia_seg__intro_01_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_007)
	
	var dia_seg__intro_01_sequence_007__descs = [
		["|0| appear in the |1| every |2|. But this is slow.", [plain_fragment__Towers, plain_fragment__shop, plain_fragment__end_of_the_round]],
		["For faster results, |0| allows you to find many |1|, with the chance that you find identical ones. This way costs |2| however.", [plain_fragment__refreshing_the_shop, plain_fragment__towers, plain_fragment__x_gold]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_007)
	
	dia_seg__intro_01_sequence_007.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_01_sequence_07__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_007, self, "_on_end_of_dia_seg__intro_01_sequence_007", null)
	
	###
	
	
	

func _play_dia_seg__intro_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)
	



func _on_dia_seg__intro_01_sequence_07__setted_into_whole_screen_panel():
	_construct_dia_seg__intro_02_sequence_001()
	

func _on_end_of_dia_seg__intro_01_sequence_007():
	_play_dia_seg__intro_02_sequence_001()
	


###

func _construct_dia_seg__intro_02_sequence_001():
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	dia_seg__intro_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_001__descs = [
		["Let's demonstrate this. Please |0|.", [plain_fragment__refresh_the_shop]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_001)
	dia_seg__intro_02_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	##########
	
	var plain_fragment__x_named_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "%s" % tower_name_in_common_to_buy_at_intro_02__01__plural)
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	
	
	dia_seg__intro_02_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_002__descs = [
		["Buy all the |0| in the |1|.", [plain_fragment__x_named_towers, plain_fragment__shop]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_002)
	dia_seg__intro_02_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	
	#######
	var plain_fragment__identical_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "identical towers")
	
	
	dia_seg__intro_02_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_003__descs = [
		["It is normal to not have the required amount of |0| in a single |1|.", [plain_fragment__identical_towers, plain_fragment__shop]],
		["Let's |0| one more time.", [plain_fragment__refresh_the_shop]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_003)
	dia_seg__intro_02_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	
	dia_seg__intro_02_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_004__descs = [
		
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_004, dia_seg__intro_02_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_004)
	dia_seg__intro_02_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_02_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_001)
	


func _on_dia_seg__intro_02_sequence_001__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	set_player_level(2)
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_02__sequence_001")
	

func _on_shop_refreshed__intro_02__sequence_001(arg_tower_ids):
	set_next_shop_towers_and_increment_counter()
	
	set_can_refresh_shop__panel_based(false)

func _on_dia_seg__intro_02_sequence_002__fully_displayed():
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_listen_for_buy_for_intro_02__01, "on_dia_seg__intro_02_sequence_002__towers_with_ids_bought", self)
	
	set_enabled_buy_slots(tower_buy_slot_enabled_at_intro_02__01)
	

func on_dia_seg__intro_02_sequence_002__towers_with_ids_bought(arg_towers):
	set_enabled_buy_slots([])
	


func _on_dia_seg__intro_02_sequence_003__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_02__sequence_003")
	
	

func _on_shop_refreshed__intro_02__sequence_003(arg_tower_ids):
	pass
	



#########

func _construct_questions_and_choices_for__trojan_Q02():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Software"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_trojan_Q02_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Hardware"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "File"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Program"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Trojan Horse is a malware that disguises itself as legitimate code or _____"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_trojan_Q02_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Downloader Trojan"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_trojan_Q02_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Backdoor Trojan"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Exploit Trojan"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "None of the Choices"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"This type of trojan horse that typically targets infected devices and installs a new version of a malicious program onto the device."
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_trojan_Q02_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_trojan_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_trojan_02.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_trojan_02.add_question_info_for_choices_panel(question_info__02)

func _on_trojan_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q02_timeout(arg_params):
	pass
	


######


func _construct_questions_and_choices_for__trojan_Q03():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "User Agreement"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_trojan_Q03_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Contract"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Policies"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Rules"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Failure to read the __________ when downloading legitimate applications or software can result in Trojan infecting your devices."
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_trojan_Q03_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Staying current with updates and patches for browsers,\nthe OS, applications and software."
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_trojan_Q03_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Downloading any unsolicited material, such as attachments, photos or documents,\neven from familiar sources."
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Accepting or allowing a pop-up notification without reading the message\nor understanding the content."
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Not reading the user agreement when\ndownloading legitimate applications or software."
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Which of the following is a common way for devices to stay uninfected with Trojans Horses?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_trojan_Q03_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_trojan_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_trojan_03.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_trojan_03.add_question_info_for_choices_panel(question_info__02)

func _on_trojan_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q03_timeout(arg_params):
	pass
	


#############


func _construct_questions_and_choices_for__trojan_Q04():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Enable two-way authentication whenever possible,\nwhich makes it far more difficult for attackers to exploit."
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_trojan_Q04_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Click unsolicited links or download unexpected attachments."
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Use weak, common passwords for all online accounts."
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Log into your account a link from an email or text."
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Which of the following is the best practice to prevent Trojan Horse attacks?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_trojan_Q04_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Enable one-way authentication whenever possible,\nwhich makes it far more difficult for attackers to exploit."
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_trojan_Q04_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Use a password manager,\nwhich will automatically enter a saved password into a recognized site\n(but not a spoofed site)."
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Use a spam filter\nto prevent a majority of spoofed emails from reaching your inbox."
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Ensure updates for software programs\nand the OS are completed immediately."
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"What is not the best practice to prevent Trojan Horse attacks?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_trojan_Q04_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_trojan_04 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_trojan_04.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_trojan_04.add_question_info_for_choices_panel(question_info__02)

func _on_trojan_Q04_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q04_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q04_timeout(arg_params):
	pass
	




