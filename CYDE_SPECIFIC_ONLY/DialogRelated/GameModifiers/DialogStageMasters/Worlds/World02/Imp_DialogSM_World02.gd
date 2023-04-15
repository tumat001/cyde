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
var dia_seg__intro_02_sequence_005 : DialogSegment

# gold (EndofRound & interest) related
var dia_seg__intro_03_sequence_001 : DialogSegment


# level (reiteration of tower slot, but mostly about tiers)
var dia_seg__intro_04_sequence_001 : DialogSegment
var dia_seg__intro_04_sequence_008 : DialogSegment


# info 01

var dia_seg__intro_05_sequence_001 : DialogSegment

# question 01

var dia_seg__intro_06_sequence_001 : DialogSegment
var dia_seg__intro_06_sequence_003 : DialogSegment

# you're on your own...
var dia_seg__intro_07_sequence_001 : DialogSegment

# info 02

var dia_seg__intro_08_sequence_001 : DialogSegment

# question 02

var dia_seg__intro_09_sequence_001 : DialogSegment
var dia_seg__intro_09_sequence_003 : DialogSegment


# info 03
var dia_seg__intro_10_sequence_001 : DialogSegment

# question 03
var dia_seg__intro_11_sequence_001 : DialogSegment
var dia_seg__intro_11_sequence_003 : DialogSegment

## on lose

var dia_seg__on_lose_01_sequence_001 : DialogSegment


## on win

var dia_seg__on_win_01_sequence_001 : DialogSegment

####

#TODO once more towers are added, change this list (retain the 2 x typed tower)
var tower_ids_to_buy_at_intro_02__01 : Array = [Towers.SPRINKLER, Towers.MINI_TESLA, Towers.STRIKER, Towers.SPRINKLER, Towers.MINI_TESLA]
#TODO once the offical towers are added, change this
var tower_name_in_common_to_buy_at_intro_02__01__plural : String = "Sprinklers"
var tower_buy_slot_enabled_at_intro_02__01 : Array = [1, 4]
#TODO once the offical towers are added, change this
var tower_ids_to_listen_for_buy_for_intro_02__01 : Array = [Towers.SPRINKLER, Towers.SPRINKLER]


#TODO once more towers are added, change this list (retain the 1 x typed tower of the prev (in 02__01))
var tower_ids_to_buy_at_intro_02__04 : Array = [Towers.STRIKER, Towers.MINI_TESLA, Towers.SPRINKLER, Towers.MINI_TESLA, Towers.STRIKER]
#TODO once the offical towers are added, change this
var tower_name_in_common_to_buy_at_intro_02__04__singular : String = "Sprinkler"
var tower_buy_slot_enabled_at_intro_02__04 : Array = [3]
#TODO once the offical towers are added, change this
var tower_id_to_listen_for_buy_for_intro_02__04 = Towers.SPRINKLER


const starting_player_level_at_this_modi : int = 3


# QUESTIONS RELATED -- SPECIFIC FOR THIS

# 01 is missing cause of duplication...............................................................
var all_possible_ques_and_ans__for_trojan_02
var all_possible_ques_and_ans__for_trojan_03
var all_possible_ques_and_ans__for_trojan_04


# QUESTIONS RELATED -- CAN BE COPY PASTED TO OTHERS

var current_possible_ques_and_ans

var show_change_question_use_left : int = 1
var remove_false_answer_use_left : int = 1

var remove_choice_count : int = 1

# STATES

var prevent_other_dia_segs_from_playing__from_loss : bool

#

var persistence_id_for_portrait__cyde : int = 1

###########


func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_02,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World02_Modi"):
	
	pass

func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	towers_offered_on_shop_refresh.append(tower_ids_to_buy_at_intro_02__01)
	towers_offered_on_shop_refresh.append(tower_ids_to_buy_at_intro_02__04)
	
	#
	
	_current_number_as_word__for_combination_count = number_to_as_word_map[game_elements.CombinationManager.base_combination_amount]
	
	
	stage_rounds_to_use = CydeMode_StageRounds_World02.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World02.new())
	
	#
	
	game_elements.synergy_manager.allow_synergies_clauses.attempt_insert_clause(game_elements.synergy_manager.AllowSynergiesClauseIds.CYDE__ANY_STAGE_CLAUS)
	
	#
	
	call_deferred("_deferred_applied")
	
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World03)
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
	
	clear_all_tower_cards_from_shop()
	set_round_is_startable(false)
	set_can_level_up(false)
	set_can_refresh_shop__panel_based(false)
	set_can_refresh_shop_at_round_end_clauses(false)
	set_enabled_buy_slots([])
	
	set_can_sell_towers(true)
	set_can_toggle_to_ingredient_mode(false)
	#set_can_towers_swap_positions_to_another_tower(false)
	#add_shop_per_refresh_modifier(-5)
	add_gold_amount(20)
	
	set_player_level(starting_player_level_at_this_modi - 1)
	
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
		generate_colored_text__cyde_name__as_line(),
		["Hey there, [b]%s[/b]! Let's talk about a new game mechanic: |0|. As you progress through the game, you will have the option to |1| your |2|. |3| have greatly increased strength." % [CydeSingleton.player_name], [plain_fragment__tower_upgrades, plain_fragment__upgrade, plain_fragment__towers, plain_fragment__Upgraded_towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	###
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		generate_colored_text__player_name__as_line(),
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
		generate_colored_text__cyde_name__as_line(),
		["Let me explain the tower upgrade system to you. Each tower that you buy from the shop is a |0|. To upgrade a |1| to a |2|, you need to |3| %s |4| of the same type. Once you have them, you can combine them to create a more powerful |5|, with even greater damage." % [_current_number_as_word__for_combination_count], [plain_fragment__1_star_tower, plain_fragment__tower, plain_fragment__2_star_tower, plain_fragment__combine, plain_fragment__1_star_towers, plain_fragment__2_star_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	###
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		generate_colored_text__player_name__as_line(),
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
		generate_colored_text__cyde_name__as_line(),
		["The final level is the |0|. To accomplish this, you need %s |1| of the same type. Once you have them, they |2| to create a powerful |3| that can deal massive damage to any malware that comes your way." % [_current_number_as_word__for_combination_count], [plain_fragment__3_star_upgrade, plain_fragment__2_star_towers, plain_fragment__combine, plain_fragment__3_star_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	
	###
	
	var plain_fragment__identical_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "identical towers")
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		generate_colored_text__player_name__as_line(),
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
		generate_colored_text__cyde_name__as_line(),
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
	

func _on_end_of_dia_seg__intro_01_sequence_007(arg_seg, arg_param):
	_play_dia_seg__intro_02_sequence_001()
	


###

func _construct_dia_seg__intro_02_sequence_001():
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	dia_seg__intro_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
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
		generate_colored_text__cyde_name__as_line(),
		["Buy all the |0| in the |1|.", [plain_fragment__x_named_towers, plain_fragment__shop]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_002)
	dia_seg__intro_02_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	
	#######
	var plain_fragment__identical_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "identical towers")
	
	
	dia_seg__intro_02_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["It is normal to not have the required amount of |0| in a single |1|.", [plain_fragment__identical_towers, plain_fragment__shop]],
		["Let's |0| one more time.", [plain_fragment__refresh_the_shop]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_003)
	dia_seg__intro_02_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	var plain_fragment__combination = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "combination")
	
	
	dia_seg__intro_02_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Buying this |0| will trigger the |1|.", [plain_fragment__tower, plain_fragment__combination]],
		["Please buy that |0|.", [plain_fragment__tower]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_004, dia_seg__intro_02_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_004)
	dia_seg__intro_02_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	var plain_fragment__1_star_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ONE_STAR__UPGRADE, "1-star towers")
	var plain_fragment__2_star_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TWO_STAR__UPGRADE, "2-star tower")
	
	
	
	dia_seg__intro_02_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Congratulations! Your %s |0| has turned into a |1|." % [_current_number_as_word__for_combination_count], [plain_fragment__1_star_towers, plain_fragment__2_star_tower]],
		["The advantage of this is your |0| only takes 1 tower slot.", [plain_fragment__2_star_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_005)
	dia_seg__intro_02_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	
	var dia_seg__intro_02_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_006)
	
	var dia_seg__intro_02_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's demonstrate the power of a |0| by placing it in the map and starting the round. Press %s or click this button." % InputMap.get_action_list("game_round_toggle")[0].as_text(), [plain_fragment__2_star_tower]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_006)
	dia_seg__intro_02_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_02_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_001)
	


func _on_dia_seg__intro_02_sequence_001__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	set_player_level(starting_player_level_at_this_modi)
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_02__sequence_001")
	

func _on_shop_refreshed__intro_02__sequence_001(arg_tower_ids):
	set_next_shop_towers_and_increment_counter()
	
	set_can_refresh_shop__panel_based(false)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_002)

func _on_dia_seg__intro_02_sequence_002__fully_displayed():
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_listen_for_buy_for_intro_02__01, "on_dia_seg__intro_02_sequence_002__towers_with_ids_bought", self)
	
	set_enabled_buy_slots(tower_buy_slot_enabled_at_intro_02__01)
	

func on_dia_seg__intro_02_sequence_002__towers_with_ids_bought(arg_towers):
	set_enabled_buy_slots([])
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_003)


func _on_dia_seg__intro_02_sequence_003__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	display_white_arrows_pointed_at_node(get_reroll_button_from_shop_panel())
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_02__sequence_003")


func _on_shop_refreshed__intro_02__sequence_003(arg_tower_ids):
	set_can_refresh_shop__panel_based(false)
	
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_004)
	

func _on_dia_seg__intro_02_sequence_004__fully_displayed():
	set_enabled_buy_slots(tower_buy_slot_enabled_at_intro_02__04)
	
	var tower_buy_card = get_tower_buy_card_at_buy_slot_index(tower_buy_slot_enabled_at_intro_02__04[0] - 1)
	if is_instance_valid(tower_buy_card):
		display_white_arrows_pointed_at_node(tower_buy_card)
	
	
	listen_for_tower_with_id__bought__then_call_func(tower_id_to_listen_for_buy_for_intro_02__04, "_on_tower_bought__on_dia_seg__intro_02_sequence_004", self)

func _on_tower_bought__on_dia_seg__intro_02_sequence_004(arg_tower):
	set_enabled_buy_slots([])
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_005)


func _on_dia_seg__intro_02_sequence_005__fully_displayed():
	call_deferred("_circle_upgraded_tower__deferred")

func _circle_upgraded_tower__deferred():
	var upgraded_tower = get_towers_with_id(tower_id_to_listen_for_buy_for_intro_02__04)[0]   # Note: this does an assumption that should always be true anyway (assert)
	
	display_white_circle_at_node(upgraded_tower)



func _on_dia_seg__intro_02_sequence_006__fully_displayed():
	set_round_is_startable(true)
	
	var arrows = display_white_arrows_pointed_at_node(get_round_status_button(), 9)
	arrows[1].y_offset = -20
	
	_construct_dia_seg__intro_03_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_02", "_on_round_ended__into_round_02")

func _on_round_started__into_round_02():
	play_dialog_segment_or_advance_or_finish_elements(null)
	

func _on_round_ended__into_round_02():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_03_sequence_001()

###


func _construct_dia_seg__intro_03_sequence_001():
	var plain_fragment__gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "gold")
	
	
	dia_seg__intro_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Nearly everything done in this game involves |0|. And so, it is important to know how to earn it.", [plain_fragment__gold]],
		["Your current |0| is displayed here", [plain_fragment__gold]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_001)
	dia_seg__intro_03_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	
	####
	var plain_fragment__end_of_the_round = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "end of the round")
	
	var plain_fragment__1_extra_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "1 extra gold")
	var plain_fragment__10_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "10 gold")
	var plain_fragment__5_extra_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "5 extra gold")
	var plain_fragment__50_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "50 gold")
	
	
	var dia_seg__intro_03_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_002)
	
	var dia_seg__intro_03_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["You earn |0| every |1|. There are three main sources of earning |0|.", [plain_fragment__gold, plain_fragment__end_of_the_round]],
		"First, you always gain a baseline amount. This amount increases as the stage goes on for longer.",
		["Second, you gain |0| per |1|. This has a limit however, which is |2| on |3|.", [plain_fragment__1_extra_gold, plain_fragment__10_gold, plain_fragment__5_extra_gold, plain_fragment__50_gold]],
		"Lastly, you earn more gold when you win more, or when you lose more."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_002)
	
	
	###
	var plain_fragment__spend_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "spend gold")
	var plain_fragment__upgrade = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "upgrade")
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_03_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_003)
	
	var dia_seg__intro_03_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["So while you'd want to |0| to |1| |2|, you'd also want to save |3| to earn more |3|.", [plain_fragment__spend_gold, plain_fragment__upgrade, plain_fragment__towers, plain_fragment__gold]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_003)
	
	
	###
	
	var dia_seg__intro_03_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_004)
	
	var dia_seg__intro_03_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["You can click here to see how much |0| you (might) earn at the |1|.", [plain_fragment__gold, plain_fragment__end_of_the_round]],
		"This is only a \"might\" since your win or lose streak may be broken."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_004)
	dia_seg__intro_03_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_03_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_005)
	
	var dia_seg__intro_03_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Buy the other |0| and place them in the map.", [plain_fragment__towers]],
		"After that, let's start the round to progress through the game.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_005)
	dia_seg__intro_03_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_03_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_001)
	


func _on_dia_seg__intro_03_sequence_001__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_gold_panel())
	arrows[0].x_offset = -80
	arrows[1].y_offset = -35

func _on_dia_seg__intro_03_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_gold_panel())
	arrows[0].x_offset = -80
	arrows[1].y_offset = -35


func _on_dia_seg__intro_03_sequence_005__fully_displayed():
	set_round_is_startable(true)
	
	set_enabled_buy_slots([1, 2, 3, 4, 5])
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_03", "_on_round_ended__into_round_03")

func _on_round_started__into_round_03():
	play_dialog_segment_or_advance_or_finish_elements(null)
	

func _on_round_ended__into_round_03():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		set_player_level(starting_player_level_at_this_modi + 1)
		
		_construct_dia_seg__intro_04_sequence_001()
		_play_dia_seg__intro_04_sequence_001()


###

func _construct_dia_seg__intro_04_sequence_001():
	var plain_fragment__leveled_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "leveled up")
	var plain_fragment__gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "gold")
	var plain_fragment__end_of_round = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "end of round")
	
	var plain_fragment__Leveling_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "Leveling up")
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__leveling_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "leveling up")
	
	var plain_fragment__tiers_of_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_04, "tiers of tower")
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	var plain_fragment__Higher_tiered = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_04, "Higher tiered")
	var plain_fragment__lower_tiered = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_01, "lower tiered")
	
	var plain_fragment__tier_3_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_03, "tier 3 towers")
	var plain_fragment__tier_2_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_02, "tier 2 towers")
	
	
	dia_seg__intro_04_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Congratulations, [i]%s[/i]! You have completed another round, and because of that, you |0|. Leveling up costs a lot of |1|, but it becomes cheaper every |2|." % CydeSingleton.player_name, [plain_fragment__leveled_up, plain_fragment__gold, plain_fragment__end_of_round]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_001, dia_seg__intro_04_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_001)
	#dia_seg__intro_04_sequence_001.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_04_sequence_01__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_04_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_001, dia_seg__intro_04_sequence_002)
	
	var dia_seg__intro_04_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["|0| allows you to place more |1|, as stated before.", [plain_fragment__Leveling_up, plain_fragment__towers]],
		["But another benefit of |0| is the increase of |1| offered in the |2|.", [plain_fragment__leveling_up, plain_fragment__tiers_of_tower, plain_fragment__shop]],
		["|0| |1| are usually stronger than |2| |1|. So |3| are generally stronger than |4|.", [plain_fragment__Higher_tiered, plain_fragment__towers, plain_fragment__lower_tiered, plain_fragment__tier_3_towers, plain_fragment__tier_2_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_002)
	
	
	###
	var plain_fragment__tier_4 = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_04, "tier 4")
	var plain_fragment__level_7 = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level 7")
	var plain_fragment__level_8 = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level 8")
	var plain_fragment__tier_4_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_04, "tier 4 towers")
	
	var dia_seg__intro_04_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_003)
	
	var dia_seg__intro_04_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["In this game, the |0| is the strongest tier of them all.", [plain_fragment__tier_4]],
		["However, you have to be at least |0| to have the chance to see them in the |1|. At |2|, the highest level, you also have the greatest chance of finding |3|.", [plain_fragment__level_7, plain_fragment__shop, plain_fragment__level_8, plain_fragment__tier_4_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	
	
	###
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	var plain_fragment__tower_tier = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_04, "tower tier")
	
	var dia_seg__intro_04_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_004)
	
	var dia_seg__intro_04_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Speaking of chance, you are never guaranteed a |0|, or a |1|.", [plain_fragment__tower, plain_fragment__tower_tier]],
		["The chances of finding a |0| can be found here.", [plain_fragment__tower_tier]]
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_004)
	dia_seg__intro_04_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	var _chance_for_tier_2_at_curr_level = get_tower_tier_odds_at_player_level(2, game_elements.level_manager.current_level)
	
	var plain_fragment__level_x = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level %s" % game_elements.level_manager.current_level)
	
	
	var dia_seg__intro_04_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_005)
	
	var dia_seg__intro_04_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["What this means is, since you're at |0|, you have a %s%% of finding |1|." % [_chance_for_tier_2_at_curr_level], [plain_fragment__level_x, plain_fragment__tier_2_towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_005, dia_seg__intro_04_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_005)
	dia_seg__intro_04_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	var plain_fragment__tier_1_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER_TIER_01, "tier 1 towers")
	
	
	var dia_seg__intro_04_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_005, dia_seg__intro_04_sequence_006)
	
	var dia_seg__intro_04_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["But don't ignore the |0|. They are the weakest, but also the most affordable. They're a good starting point for the early game. But as you progress through the game, you'll find that the malware becomes stronger and harder to defeat, so you'll need to upgrade your towers to keep up, or replace them.", [plain_fragment__tier_1_towers]],
		["The same can be said about |0|.", [plain_fragment__tier_2_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_006, dia_seg__intro_04_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_006)
	
	
	###
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	var dia_seg__intro_04_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_006, dia_seg__intro_04_sequence_007)
	
	var dia_seg__intro_04_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Please |0| to add more |1|, and let luck decide your fate.", [plain_fragment__refresh_the_shop, plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_007, dia_seg__intro_04_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_007)
	dia_seg__intro_04_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	
	dia_seg__intro_04_sequence_008 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round whenever you're ready."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_008, dia_seg__intro_04_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_008)
	dia_seg__intro_04_sequence_008.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_008__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_04_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_001)
	


#func _on_dia_seg__intro_04_sequence_01__setted_into_whole_screen_panel():
#	pass

func _on_dia_seg__intro_04_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_shop_odds_panel(), true, true)
	arrows[0].x_offset = 60
	arrows[1].y_offset = -30

func _on_dia_seg__intro_04_sequence_005__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_shop_odds_panel(), true, true)
	arrows[0].x_offset = 60
	arrows[1].y_offset = -30

func _on_dia_seg__intro_04_sequence_007__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_04__sequence_007")


func _on_shop_refreshed__intro_04__sequence_007(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_008)
	

func _on_dia_seg__intro_04_sequence_008__fully_displayed():
	set_round_is_startable(true)
	
	set_can_level_up(true)
	
	_construct_dia_seg__intro_05_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_04", "_on_round_ended__into_round_04")

func _on_round_started__into_round_04():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_04():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_05_sequence_001()


####

func _construct_dia_seg__intro_05_sequence_001():
	dia_seg__intro_05_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Hopefully you have not forgotten that I give information about the malwares as well!",
		"In this stage, the malwares present here are the [b]Trojans[/b].",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_001)
	
	
	###
	
	var dia_seg__intro_05_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_002)
	
	var dia_seg__intro_05_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Here's the first piece of information about them: their background."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_002)
	
	###
	
	var dia_seg__intro_05_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_003)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__TROJAN_BACKGROUND_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_05_sequence_003, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_05_sequence_003)
	dia_seg__intro_05_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_003__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	
	
	###
	
	var dia_seg__intro_05_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_003, dia_seg__intro_05_sequence_004)
	
	var dia_seg__intro_05_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You can always choose to review all informations I give you by clicking the almanac button here.",
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_004)
	dia_seg__intro_05_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_05_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_005)
	
	var dia_seg__intro_05_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round, when you're ready."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_005, dia_seg__intro_05_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_005)
	dia_seg__intro_05_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	

func _play_dia_seg__intro_05_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_001)
	


func _on_dia_seg__intro_05_sequence_003__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)
	

func _on_dia_seg__intro_05_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_almanac_button_bot_right())
	
	arrows[1].x_offset = -15
	arrows[1].y_offset = 40


func _on_dia_seg__intro_05_sequence_005__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_06_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_05", "_on_round_ended__into_round_05")


func _on_round_started__into_round_05():
	play_dialog_segment_or_advance_or_finish_elements(null)
	

func _on_round_ended__into_round_05():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_06_sequence_001()


######

func _construct_dia_seg__intro_06_sequence_001():
	_construct_questions_and_choices_for__trojan_Q02()  #starting at 02, cause there is no 01
	
	
	dia_seg__intro_06_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_001)
	
	###
	
	var dia_seg__intro_06_sequence_002 = _construct_and_configure_choices_for_intro_06_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_002)
	dia_seg__intro_06_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_06_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_06_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	
	###
	
	dia_seg__intro_06_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_003, dia_seg__intro_06_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_003)
	
	
	###
	
	var dia_seg__intro_06_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_003, dia_seg__intro_06_sequence_004)
	
	var dia_seg__intro_06_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_004, dia_seg__intro_06_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_004)
	dia_seg__intro_06_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	

func _play_dia_seg__intro_06_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_001)
	


func _on_dia_seg__intro_06_sequence_002__fully_displayed():
	play_quiz_time_music()
	

func _on_dia_seg__intro_06_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
	


func _on_dia_seg__intro_06_sequence_004__fully_displayed():
	set_round_is_startable(true)
	_construct_dia_seg__intro_07_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_06", "_on_round_ended__into_round_06")

func _on_round_started__into_round_06():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_06():
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_07_sequence_001()
	set_round_is_startable(false)


func _on_trojan_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_06_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	

func _on_trojan_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_06_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_trojan_Q02_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_06_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_06_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	

##############

func _construct_dia_seg__intro_07_sequence_001():
	var plain_fragment__earn_gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "earn gold")
	var plain_fragment__buy_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "buy towers")
	var plain_fragment__upgrade_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COMBINATION, "upgrade towers")
	var plain_fragment__level_up = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level up")
	
	
	dia_seg__intro_07_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"At this point, I'll give you control over the game plan.",
		["Just remember to |0|, |1|, |2|, |3| and start the round whenever you're ready.", [plain_fragment__earn_gold, plain_fragment__buy_towers, plain_fragment__upgrade_towers, plain_fragment__level_up]]
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_001, dia_seg__intro_07_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_001)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_07_sequence_001, self, "_on_end_of_dia_seg__intro_07_sequence_001", null)
	
	
	############
	
	
	

func _play_dia_seg__intro_07_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_001)
	


func _on_end_of_dia_seg__intro_07_sequence_001(arg_seg, arg_param):
	set_round_is_startable(true)
	
	#remove_shop_per_refresh_modifier()
	set_can_refresh_shop_at_round_end_clauses(true)
	
	_construct_dia_seg__intro_08_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_07", "_on_round_ended__into_round_07")
	
	play_dialog_segment_or_advance_or_finish_elements(null)


func _on_round_started__into_round_07():
	pass

func _on_round_ended__into_round_07():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_08_sequence_001()
	


###

func _construct_dia_seg__intro_08_sequence_001():
	
	dia_seg__intro_08_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_08_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"New information regarding our enemies, the Trojans, has been researched. This time, it is about their behavior on devices.",
		"I'll put it on display for you to review."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_001, dia_seg__intro_08_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_001)
	
	#
	
	var dia_seg__intro_08_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_001, dia_seg__intro_08_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__TROJAN_BEHAVIOR_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_08_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_08_sequence_002)
	dia_seg__intro_08_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_08_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_08_sequence_002, self, "_on_dia_seg__intro_08_sequence_002__ended", null)
	
	

func _play_dia_seg__intro_08_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_08_sequence_001)
	

func _on_dia_seg__intro_08_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)
	


func _on_dia_seg__intro_08_sequence_002__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_09_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("28", self, "_on_round_started__into_round_08")
	set_round_is_startable(true)

func _on_round_started__into_round_08(arg_stageround_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_09_sequence_001()

#########

func _construct_dia_seg__intro_09_sequence_001():
	_construct_questions_and_choices_for__trojan_Q03()
	
	
	dia_seg__intro_09_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_001)
	
	
	###
	
	var dia_seg__intro_09_sequence_002 = _construct_and_configure_choices_for_intro_09_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_002)
	dia_seg__intro_09_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_09_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_09_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_09_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_09_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_003, dia_seg__intro_09_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_09_sequence_003, self, "_on_dia_seg__intro_09_sequence_003__ended", null)
	
	
	###
	

func _play_dia_seg__intro_09_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_001)
	

func _on_dia_seg__intro_09_sequence_002__fully_displayed():
	play_quiz_time_music()

func _on_dia_seg__intro_09_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()


func _on_trojan_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_09_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_09_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	

func _on_trojan_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_09_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_09_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	

func _on_trojan_Q03_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_09_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_09_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_002, dia_seg__intro_09_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	


func _on_dia_seg__intro_09_sequence_003__ended(arg_seg, arg_params):
	set_round_is_startable(true)
	
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	# intentionally make 1 round have no dialog.
	listen_for_round_end_into_stage_round_id_and_call_func("210", self, "_on_round_started__into_round_10")

func _on_round_started__into_round_10(arg_stageround_id):
	_construct_dia_seg__intro_10_sequence_001()
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		set_round_is_startable(false)
		
		_play_dia_seg__intro_10_sequence_001()



func _construct_dia_seg__intro_10_sequence_001():
	dia_seg__intro_10_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"One last information regarding our enemies, the Trojans, has been researched. This time, it is about how to avoid them, in general.",
		"I'll put it on display for you to review."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_001)
	
	
	#
	
	var dia_seg__intro_10_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__TROJAN_PRACTICES_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_10_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_10_sequence_002)
	dia_seg__intro_10_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_10_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_10_sequence_002, self, "_on_dia_seg__intro_10_sequence_002__ended", null)
	
	#
	

func _play_dia_seg__intro_10_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_001)
	


func _on_dia_seg__intro_10_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)


func _on_dia_seg__intro_10_sequence_002__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_11_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("211", self, "_on_round_started__into_round_11")
	set_round_is_startable(true)

func _on_round_started__into_round_11(arg_stageround_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_11_sequence_001()
	


func _construct_dia_seg__intro_11_sequence_001():
	_construct_questions_and_choices_for__trojan_Q04()
	
	
	dia_seg__intro_11_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the last Icebreaker quiz of this stage? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_001)
	
	
	
	var dia_seg__intro_11_sequence_002 = _construct_and_configure_choices_for_intro_11_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_002)
	dia_seg__intro_11_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_11_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_11_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_11_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_11_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"The Trojan boss appears in the next round. Prepare yourself!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_003, dia_seg__intro_11_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_11_sequence_003, self, "_on_dia_seg__intro_11_sequence_003__ended", null)
	

func _play_dia_seg__intro_11_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_001)
	

func _on_dia_seg__intro_11_sequence_002__fully_displayed():
	play_quiz_time_music()

func _on_dia_seg__intro_11_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()
	



func _on_trojan_Q04_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	
	var dia_seg__intro_11_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Nice job! You got it right!",
		["With the proper knowledge used at the right time, your |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__towers]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_11_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.HAPPY_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_002)
	#
	
	apply_tower_power_up_effects()
	do_all_related_audios__for_correct_choice()
	
	

func _on_trojan_Q04_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_11_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you got it wrong.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from mistakes."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_11_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_wrong_choice()
	
	

func _on_trojan_Q04_timeout(arg_params):
	var plain_fragment__enemies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ENEMY, "enemies")
	
	
	var dia_seg__intro_11_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Unfortunately, you ran out of time.",
		["With our weakness exposed, the |0| are empowered for %s seconds." % [POWER_UP__DEFAULT_DURATION], [plain_fragment__enemies]],
		"Do not worry however. There are always more chances to recover from setbacks."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_11_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.SAD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_002, dia_seg__intro_11_sequence_003)
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_002)
	#
	
	apply_enemy_power_up_effects()
	do_all_related_audios__for_quiz_timer_timeout()
	
	



func _on_dia_seg__intro_11_sequence_003__ended(arg_seg, arg_params):
	set_round_is_startable(true)
	
	play_dialog_segment_or_advance_or_finish_elements(null)


#########

func _construct_questions_and_choices_for__trojan_Q02():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Software"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_trojan_Q02_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Hardware"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "File"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Program"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
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
#		"Trojan Horse is a malware that disguises itself as legitimate code or _____"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_trojan_Q02_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Downloader Trojan"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_trojan_Q02_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Backdoor Trojan"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Exploit Trojan"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "None of the Choices"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_trojan_Q02_choice_wrong_clicked"
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
#		"This type of trojan horse that typically targets infected devices and installs a new version of a malicious program onto the device."
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_trojan_Q02_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__trojan_Q02(self, "_on_trojan_Q02_choice_right_clicked", "_on_trojan_Q02_choice_wrong_clicked", "_on_trojan_Q02_timeout")
	
	all_possible_ques_and_ans__for_trojan_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_trojan_02.add_question_info_for_choices_panel(question)
	
	
	#all_possible_ques_and_ans__for_trojan_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	#all_possible_ques_and_ans__for_trojan_02.add_question_info_for_choices_panel(question_info__01)
	#all_possible_ques_and_ans__for_trojan_02.add_question_info_for_choices_panel(question_info__02)


######


func _construct_questions_and_choices_for__trojan_Q03():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "User Agreement"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_trojan_Q03_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Contract"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Policies"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Rules"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
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
#		"Failure to read the __________ when downloading legitimate applications or software can result in Trojan infecting your devices."
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_trojan_Q03_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Staying current with updates and patches for browsers,\nthe OS, applications and software."
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_trojan_Q03_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Downloading any unsolicited material, such as attachments, photos or documents,\neven from familiar sources."
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Accepting or allowing a pop-up notification without reading the message\nor understanding the content."
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Not reading the user agreement when\ndownloading legitimate applications or software."
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
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
#		"Which of the following is a common way for devices to stay uninfected with Trojans Horses?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_trojan_Q03_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__trojan_Q03(self, "_on_trojan_Q03_choice_right_clicked", "_on_trojan_Q03_choice_wrong_clicked", "_on_trojan_Q03_timeout")
	
	all_possible_ques_and_ans__for_trojan_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_trojan_03.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_trojan_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_trojan_03.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_trojan_03.add_question_info_for_choices_panel(question_info__02)


#############


func _construct_questions_and_choices_for__trojan_Q04():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Enable two-way authentication whenever possible,\nwhich makes it far more difficult for attackers to exploit."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_trojan_Q04_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Click unsolicited links or download unexpected attachments."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Use weak, common passwords for all online accounts."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Log into your account a link from an email or text."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
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
#		"Which of the following is the best practice to prevent Trojan Horse attacks?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_trojan_Q04_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Enable one-way authentication whenever possible,\nwhich makes it far more difficult for attackers to exploit."
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_trojan_Q04_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Use a password manager,\nwhich will automatically enter a saved password into a recognized site\n(but not a spoofed site)."
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Use a spam filter\nto prevent a majority of spoofed emails from reaching your inbox."
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Ensure updates for software programs\nand the OS are completed immediately."
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_trojan_Q04_choice_wrong_clicked"
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
#		"What is not the best practice to prevent Trojan Horse attacks?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_trojan_Q04_timeout"

	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__trojan_Q04(self, "_on_trojan_Q04_choice_right_clicked", "_on_trojan_Q04_choice_wrong_clicked", "_on_trojan_Q04_timeout")
	
	all_possible_ques_and_ans__for_trojan_04 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_trojan_04.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_trojan_04 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_trojan_04.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_trojan_04.add_question_info_for_choices_panel(question_info__02)


############ QUESTIONS STATE ############

func _show_dialog_choices_modi_panel():
	return false #true

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
	
	if current_possible_ques_and_ans == all_possible_ques_and_ans__for_trojan_02:
		var dia_seg = _construct_and_configure_choices_for_intro_06_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_trojan_03:
		var dia_seg = _construct_and_configure_choices_for_intro_09_questions()[0]
	
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_trojan_04:
		var dia_seg = _construct_and_configure_choices_for_intro_11_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)


#

func _construct_and_configure_choices_for_intro_06_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_trojan_02
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_06", all_possible_ques_and_ans__for_trojan_02, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__intro_06(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_06 = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_06, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_06)
	
	return dia_seg_question__for_intro_06

#

func _construct_and_configure_choices_for_intro_09_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_trojan_03
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_09", all_possible_ques_and_ans__for_trojan_03, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")

func _construct_dia_seg_for_questions__intro_09(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_09 = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_09, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_09)
	
	return dia_seg_question__for_intro_09

#

func _construct_and_configure_choices_for_intro_11_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_trojan_04
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_11", all_possible_ques_and_ans__for_trojan_04, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")

func _construct_dia_seg_for_questions__intro_11(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_11 = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_11, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_11)
	
	return dia_seg_question__for_intro_11


##


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
	


############### ON WIN

func _construct_dia_seg__on_win_01_sequence_001():
	dia_seg__on_win_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__on_win_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Congratulations for winning the stage! [b]The Trojans[/b] have been defeated.",
		"You can proceed to the next map to continue the story."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_001, dia_seg__on_win_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_001)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_win_01_sequence_001, self, "_on_end_of_dia_seg__on_win_x_segment__end", null)
	
	


func _play_dia_seg__on_win_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_win_01_sequence_001)


func _on_end_of_dia_seg__on_win_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)
	

