extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"

const CydeMode_StageRounds_World03 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomStageRounds/CydeMode_StageRounds_World03.gd")
const CydeMode_EnemySpawnIns_World03 = preload("res://CYDE_SPECIFIC_ONLY/CustomStageRoundsAndWaves/CustomWaves/CydeMode_EnemySpawnIns_World03.gd")


var stage_rounds_to_use

#

# Intro for synergy
var dia_seg__intro_01_sequence_001 : DialogSegment

# Intro to Availability
var dia_seg__intro_02_sequence_001 : DialogSegment
var dia_seg__intro_02_sequence_002 : DialogSegment
var dia_seg__intro_02_sequence_003 : DialogSegment
var dia_seg__intro_02_sequence_005 : DialogSegment
var dia_seg__intro_02_sequence_006 : DialogSegment
var dia_seg__intro_02_sequence_007 : DialogSegment

# Intro to Confidentiality from Availa
var dia_seg__intro_03_sequence_001 : DialogSegment
var dia_seg__intro_03_sequence_003 : DialogSegment
var dia_seg__intro_03_sequence_004 : DialogSegment
var dia_seg__intro_03_sequence_005 : DialogSegment
var dia_seg__intro_03_sequence_006 : DialogSegment

# Intro to Integrity from Confi
var dia_seg__intro_04_sequence_001 : DialogSegment
var dia_seg__intro_04_sequence_002 : DialogSegment
var dia_seg__intro_04_sequence_003 : DialogSegment 
var dia_seg__intro_04_sequence_004 : DialogSegment

# Intro to Integrity 2 (3 -> 5)
var dia_seg__intro_05_sequence_001 : DialogSegment
var dia_seg__intro_05_sequence_003 : DialogSegment
var dia_seg__intro_05_sequence_004 : DialogSegment

## on lose
var dia_seg__on_lose_01_sequence_001 : DialogSegment

## on win
var dia_seg__on_win_01_sequence_001 : DialogSegment


###########

var tower_ids_to_buy__availability_01 : Array = [Towers.MINI_TESLA, Towers.COIN, Towers.MAGNETIZER]
var tower_ids_to_buy__availability_02 : Array = [Towers.BEACON_DISH]
var tower_name_to_buy__availability_02 : String = "Beacon Dish"
var tower_instances_bought__availability_01
var tower_instances_bought__availability_02

var tower_ids_to_buy__confidentiality_01 : Array = [Towers.STRIKER, Towers.COAL_LAUNCHER, Towers.ENTROPY]
var tower_instances_bought__confidentiality_01

var tower_ids_to_buy__integrity_01 : Array = [Towers.SPRINKLER, Towers.VACUUM, Towers.BLEACH]
var tower_instances_bought__integrity_01

var tower_ids_to_buy__integrity_02 : Array = [Towers.ROYAL_FLAME, Towers.DOUSER]
var tower_instances_bought__integrity_02


# QUESTIONS RELATED -- CAN BE COPY PASTED TO OTHERS
var current_possible_ques_and_ans

var show_change_questions : bool = true
var remove_choice_count : int = 1

# STATES

var prevent_other_dia_segs_from_playing__from_loss : bool

#

var persistence_id_for_portrait__cyde : int = 1

#

var starting_player_level_at_this_modi = 3

#

func _init().(StoreOfGameModifiers.GameModiIds__CYDE_World_03,
		BreakpointActivation.BEFORE_GAME_START, 
		"Cyde_World03_Modi"):
	
	pass



func _apply_game_modifier_to_elements(arg_elements : GameElements):
	._apply_game_modifier_to_elements(arg_elements)
	
	#
	
	towers_offered_on_shop_refresh.append(tower_ids_to_buy__availability_01)
	towers_offered_on_shop_refresh.append(tower_ids_to_buy__availability_02)
	towers_offered_on_shop_refresh.append(tower_ids_to_buy__confidentiality_01)
	towers_offered_on_shop_refresh.append(tower_ids_to_buy__integrity_01)
	
	#
	
	stage_rounds_to_use = CydeMode_StageRounds_World03.new()
	game_elements.stage_round_manager.set_stage_rounds(stage_rounds_to_use, true)
	game_elements.stage_round_manager.set_spawn_ins(CydeMode_EnemySpawnIns_World03.new())
	
	#
	
	call_deferred("_deferred_applied")
	
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World04)
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
	
	set_can_sell_towers(false)
	set_can_toggle_to_ingredient_mode(false)
	#set_can_towers_swap_positions_to_another_tower(false)
	#add_shop_per_refresh_modifier(-5)
	add_gold_amount(20)
	
	set_player_level(starting_player_level_at_this_modi)
	
	_map_ids_to_make_available_when_completed.append(StoreOfMaps.MapsId_World03)
	game_elements.game_result_manager.show_main_menu_button = false
	
	

###########

func _construct_dia_seg__intro_01_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "synergies")
	var plain_fragment__Synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "Synergies")
	var plain_fragment__synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "synergy")
	
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now that we have made it this far, it is time for me to introduce the most exciting feature: |0|", [plain_fragment__synergies]],
		["|0| give game changing effects!", [plain_fragment__Synergies]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	######
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["The |0| in this game is called the [b]CIA Triad Synergies[/b]."]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	######
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		generate_colored_text__player_name__as_line(),
		"What does the [b]CIA[/b] mean?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	######
	var plain_fragment__Confidentiality = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__CONFIDENTIALITY, "Confidentiality")
	var plain_fragment__Integrity = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__INTEGRITY, "Integrity")
	var plain_fragment__Availability = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__AVAILABILITY, "Accessibility")
	
	
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Each letter in [b]CIA[/b] means something.",
		["[b]C[/b] stands for |0|.", [plain_fragment__Confidentiality]],
		["[b]I[/b] stands for |0|.", [plain_fragment__Integrity]],
		["[b]A[/b] stands for |0|.", [plain_fragment__Availability]],
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	#####
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["To activate a |0|, certain types of |1| must be played.", [plain_fragment__synergy, plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_01_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_005,  self, "_on_end_of_dia_seg__intro_01_sequence_005", null)
	
	#####
	
	

func _play_dia_seg__intro_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)

func _on_end_of_dia_seg__intro_01_sequence_005(arg_seg, arg_params):
	_construct_dia_seg__intro_02_sequence_001()
	_play_dia_seg__intro_02_sequence_001()


#####

func _construct_dia_seg__intro_02_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "synergies")
	var plain_fragment__Synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "Synergies")
	var plain_fragment__synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "synergy")
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	
	var plain_fragment__Availability_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__AVAILABILITY, "Accessibility synergy")
	
	
	#
	
	dia_seg__intro_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's demonstrate activating the |0|.", [plain_fragment__Availability_synergy]],
		["Buy all the |0| in the |1|.", [plain_fragment__towers, plain_fragment__shop]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_001)
	
	dia_seg__intro_02_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	
	######
	
	dia_seg__intro_02_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now, place all the |0| in the map.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_002)
	
	dia_seg__intro_02_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	
	#######
	var plain_fragment__x_Availabilitty_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "4 Accessibility towers")
	var plain_fragment__Availabilitty_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Accessibility towers")
	
	
	dia_seg__intro_02_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Notice that in order to activate the |0|, we need |1|. This information can be found over here. You can hover over that to view more details about the synergy.", [plain_fragment__Availability_synergy, plain_fragment__x_Availabilitty_towers]],
		["|0| are colored yellow.", [plain_fragment__Availabilitty_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_003)
	
	dia_seg__intro_02_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	
	######
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	var dia_seg__intro_02_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_004)
	
	var dia_seg__intro_02_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Please |0| to hopefully get more |1|.", [plain_fragment__refresh_the_shop, plain_fragment__Availabilitty_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_004, dia_seg__intro_02_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_004)
	
	dia_seg__intro_02_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	var plain_fragment__x_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "%s" % tower_name_to_buy__availability_02)
	var plain_fragment__Availability_tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__AVAILABILITY, "Accessibility tower")
	
	
	dia_seg__intro_02_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Buy that |0|, which is an |1|.", [plain_fragment__x_tower, plain_fragment__Availability_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_005)
	
	dia_seg__intro_02_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	dia_seg__intro_02_sequence_006 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now place |0| in the map.", [plain_fragment__x_tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_006)
	
	dia_seg__intro_02_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	dia_seg__intro_02_sequence_007 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Nice job! Notice that the |0| is now active, since we placed |1| in the map.", [plain_fragment__Availability_synergy, plain_fragment__x_Availabilitty_towers]],
		"You can hover here to see what effects are applied when this synergy is activated."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_007, dia_seg__intro_02_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_007)
	
	dia_seg__intro_02_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	var dia_seg__intro_02_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_007, dia_seg__intro_02_sequence_008)
	
	var dia_seg__intro_02_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Let's start the round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_008, dia_seg__intro_02_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_008)
	
	dia_seg__intro_02_sequence_008.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_008__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_02_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_001)



func _on_dia_seg__intro_02_sequence_001__fully_displayed():
	set_enabled_buy_slots([1, 2, 3])
	set_next_shop_towers_and_increment_counter()
	
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__availability_01, "on_dia_seg__intro_02_sequence_001__towers_with_ids_bought", self)

func on_dia_seg__intro_02_sequence_001__towers_with_ids_bought(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_002)
	
	tower_instances_bought__availability_01 = arg_towers
	for tower in arg_towers:
		set_tower_is_draggable(tower, true)


func _on_dia_seg__intro_02_sequence_002__fully_displayed():
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_ids_to_buy__availability_01], "_on_tower_placed_in_map__on_dia_seg__intro_02_sequence_002", self)
	

func _on_tower_placed_in_map__on_dia_seg__intro_02_sequence_002(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_003)
	
	

func _on_dia_seg__intro_02_sequence_003__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Availability]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30
	

func _on_dia_seg__intro_02_sequence_004__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_02__sequence_004")

func _on_shop_refreshed__intro_02__sequence_004(arg_tower_ids):
	set_can_refresh_shop__panel_based(false)
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_005)


func _on_dia_seg__intro_02_sequence_005__fully_displayed():
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__availability_02, "on_dia_seg__intro_02_sequence_005__towers_with_ids_bought", self)
	

func on_dia_seg__intro_02_sequence_005__towers_with_ids_bought(arg_towers):
	tower_instances_bought__availability_02 = arg_towers
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_006)


func _on_dia_seg__intro_02_sequence_006__fully_displayed():
	for tower in tower_instances_bought__availability_02:
		set_tower_is_draggable(tower, true)
	
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__availability_02, "_on_tower_placed_in_map__on_dia_seg__intro_02_sequence_006", self)

func _on_tower_placed_in_map__on_dia_seg__intro_02_sequence_006(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_007)
	
	

func _on_dia_seg__intro_02_sequence_007__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Availability]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30
	

func _on_dia_seg__intro_02_sequence_008__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_03_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_02", "_on_round_ended__into_round_02")

func _on_round_started__into_round_02():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_02():
	set_round_is_startable(false)
	
	_play_dia_seg__intro_03_sequence_001()

##

func _construct_dia_seg__intro_03_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__Availability_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__AVAILABILITY, "Accessibility synergy")
	var plain_fragment__Confidentiality_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__CONFIDENTIALITY, "Confidentiality synergy")
	var plain_fragment__Confidentiality_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Confidentiality towers")
	
	#
	
	dia_seg__intro_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now that we've seen the effects of the |0|, its time to explore the effects of the |1|.", [plain_fragment__Availability_synergy, plain_fragment__Confidentiality_synergy]]
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_001)
	
	###
	
	var dia_seg__intro_03_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_002)
	
	var dia_seg__intro_03_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["First, let's sell all the |0| in the map, to make space for the |1| we'll be placing.", [plain_fragment__towers, plain_fragment__Confidentiality_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_002)
	
	dia_seg__intro_03_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	
	###
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	
	dia_seg__intro_03_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Next, let's |0|.", [plain_fragment__refresh_the_shop]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_003)
	
	dia_seg__intro_03_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	dia_seg__intro_03_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now, let's buy all the |0|.", [plain_fragment__Confidentiality_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_004)
	
	dia_seg__intro_03_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	
	dia_seg__intro_03_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Then finally, let's place all those |0|", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_005)
	
	dia_seg__intro_03_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_03_sequence_006 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Good work! The |0| is now active. This synergy makes your towers much stronger!", [plain_fragment__Confidentiality_synergy]],
		["|0| are colored red or orange.", [plain_fragment__Confidentiality_towers]],
		"You can view the synergy's effects by hovering here.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_006, dia_seg__intro_03_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_006)
	
	dia_seg__intro_03_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	
	var dia_seg__intro_03_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_006, dia_seg__intro_03_sequence_007)
	
	var dia_seg__intro_03_sequence_007__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's start the round to see the power of the |0|", [plain_fragment__Confidentiality_synergy]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_007, dia_seg__intro_03_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_007)
	
	dia_seg__intro_03_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	

func _play_dia_seg__intro_03_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_001)


func _on_dia_seg__intro_03_sequence_002__fully_displayed():
	var all_tower_ids = []
	all_tower_ids.append_array(tower_ids_to_buy__availability_01)
	all_tower_ids.append_array(tower_ids_to_buy__availability_02)
	
	for tower in tower_instances_bought__availability_02:
		set_tower_is_sellable(tower, true)
	for tower in tower_instances_bought__availability_01:
		set_tower_is_sellable(tower, true)
	
	listen_for_towers_with_ids__sold__then_call_func(all_tower_ids, "_on_dia_seg__intro_03_sequence_002__sold_multiple_towers", self)
	

func _on_dia_seg__intro_03_sequence_002__sold_multiple_towers(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_003)
	

func _on_dia_seg__intro_03_sequence_003__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_03__sequence_003")

func _on_shop_refreshed__intro_03__sequence_003(arg_tower_ids):
	set_enabled_buy_slots([])
	set_next_shop_towers_and_increment_counter()
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_004)


func _on_dia_seg__intro_03_sequence_004__fully_displayed():
	set_enabled_buy_slots([1, 2, 3])
	
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__confidentiality_01, "on_dia_seg__intro_03_sequence_004__towers_with_ids_bought", self)

func on_dia_seg__intro_03_sequence_004__towers_with_ids_bought(arg_towers):
	tower_instances_bought__confidentiality_01 = arg_towers
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_005)
	

func _on_dia_seg__intro_03_sequence_005__fully_displayed():
	for tower in tower_instances_bought__confidentiality_01:
		set_tower_is_draggable(tower, true)
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__confidentiality_01, "_on_tower_placed_in_map__on_dia_seg__intro_03_sequence_005", self)

func _on_tower_placed_in_map__on_dia_seg__intro_03_sequence_005(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_006)
	


func _on_dia_seg__intro_03_sequence_006__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Confidentiality]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30
	

func _on_dia_seg__intro_03_sequence_007__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_04_sequence_001()
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_03", "_on_round_ended__into_round_03")

func _on_round_started__into_round_03():
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_03():
	set_round_is_startable(false)
	
	_play_dia_seg__intro_04_sequence_001()



func _construct_dia_seg__intro_04_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__Integrity_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__INTEGRITY, "Integrity synergy")
	var plain_fragment__Confidentiality_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__CONFIDENTIALITY, "Confidentiality synergy")
	var plain_fragment__Integrity_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Integrity towers")
	
	#
	
	dia_seg__intro_04_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Last but not the least, the power of the |0| should be seen.", [plain_fragment__Integrity_synergy]],
		["Let's first sell all the |0|.", [plain_fragment__towers]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_001, dia_seg__intro_04_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_001)
	
	dia_seg__intro_04_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	####
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	dia_seg__intro_04_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Then let's |0|.", [plain_fragment__refresh_the_shop]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_002)
	
	dia_seg__intro_04_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	#####
	
	dia_seg__intro_04_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Then let's buy all the |0|, and place them in the map", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	
	dia_seg__intro_04_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	
	####
	
	dia_seg__intro_04_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Good work! The |0| is now active. This synergy makes you more resistant against enemies!", [plain_fragment__Integrity_synergy]],
		["|0| are colored blue.", [plain_fragment__Integrity_towers]],
		"You can view the synergy's effects by hovering here.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_004)
	
	dia_seg__intro_04_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_04_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_005)
	
	var dia_seg__intro_04_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now that the |0| is set up, let's start the round.", [plain_fragment__Integrity_synergy]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_005, dia_seg__intro_04_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_005)
	
	dia_seg__intro_04_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_04_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_001)


func _on_dia_seg__intro_04_sequence_001__fully_displayed():
	for tower in tower_instances_bought__confidentiality_01:
		set_tower_is_sellable(tower, true)
	
	listen_for_towers_with_ids__sold__then_call_func(tower_ids_to_buy__confidentiality_01, "_on_dia_seg__intro_04_sequence_001__sold_multiple_towers", self)

func _on_dia_seg__intro_04_sequence_001__sold_multiple_towers():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_002)
	


func _on_dia_seg__intro_04_sequence_002__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_04__sequence_002")
	

func _on_shop_refreshed__intro_04__sequence_002(arg_tower_ids):
	set_enabled_buy_slots([])
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_003)
	

func _on_dia_seg__intro_04_sequence_003__fully_displayed():
	set_enabled_buy_slots([1, 2, 3])
	
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__integrity_01, "on_dia_seg__intro_04_sequence_003__towers_with_ids_bought", self)
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__integrity_01, "_on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003", self)

func on_dia_seg__intro_04_sequence_003__towers_with_ids_bought(arg_towers):
	tower_instances_bought__integrity_01 = arg_towers
	for tower in tower_instances_bought__integrity_01:
		set_tower_is_draggable(tower, true)
	

func _on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_004)
	

func _on_dia_seg__intro_04_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30

func _on_dia_seg__intro_04_sequence_005__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_04", "_on_round_ended__into_round_04")

func _on_round_started__into_round_04():
	play_dialog_segment_or_advance_or_finish_elements(null)
	_construct_dia_seg__intro_05_sequence_001()

func _on_round_ended__into_round_04():
	set_round_is_startable(false)
	
	_play_dia_seg__intro_05_sequence_001()



func _construct_dia_seg__intro_05_sequence_001():
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__Integrity_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__INTEGRITY, "Integrity synergy")
	var plain_fragment__Integrity_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "Integrity towers")
	var plain_fragment__3_Integrity_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "3 Integrity towers")
	var plain_fragment__5_Integrity_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "5 Integrity towers")
	var plain_fragment__8_Integrity_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "8 Integrity towers")
	
	var plain_fragment__CIA_synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "CIA synergies")
	var plain_fragment__Confidentiality_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__CONFIDENTIALITY, "Confidentiality synergy")
	var plain_fragment__Availability_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.CYDE_SYN__AVAILABILITY, "Accessiblity synergy")
	
	
	dia_seg__intro_05_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Right now, we have |0|, which is the bare minimum to activate the |1|.", [plain_fragment__3_Integrity_towers, plain_fragment__Integrity_synergy]],
		["But looking here, if we place at least |0|, we can upgrade the |1| to the next level.", [plain_fragment__5_Integrity_towers, plain_fragment__Integrity_synergy]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_001)
	
	dia_seg__intro_05_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	var dia_seg__intro_05_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's |0| to gain more |1|.", [plain_fragment__refresh_the_shop, plain_fragment__Integrity_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_002)
	
	dia_seg__intro_05_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	
	dia_seg__intro_05_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Buy all the |0| and place them in the map.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_003, dia_seg__intro_05_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_003)
	
	dia_seg__intro_05_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	
	dia_seg__intro_05_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Nice! As you can see here, we have activated an upgraded version of the |0|, since we placed at least |1|.", [plain_fragment__Integrity_synergy, plain_fragment__5_Integrity_towers]],
		["We can go up to |0|, but this should be enough for now.", [plain_fragment__8_Integrity_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_004)
	
	dia_seg__intro_05_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	var plain_fragment__gold = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.GOLD, "gold")
	
	
	var dia_seg__intro_05_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_004, dia_seg__intro_05_sequence_005)
	
	var dia_seg__intro_05_sequence_005__descs = [
		generate_colored_text__cyde_name__as_line(),
		["That covers all that you need to know about the [b]|0|[/b].", [plain_fragment__CIA_synergies]],
		["Use the might of the |0| if you want to easily destroy the malware!", [plain_fragment__Confidentiality_synergy]],
		["Utilize the protective effects of |0| if you want to survive against strong attacks!", [plain_fragment__Integrity_synergy]],
		["And finally, earn lots of |0| using |1| if you want to prosper in the future rounds!", [plain_fragment__gold, plain_fragment__Availability_synergy]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_005, dia_seg__intro_05_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_005)
	
	#dia_seg__intro_05_sequence_005.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_005__fully_displayed", [], CONNECT_ONESHOT)
	
	##
	
	var dia_seg__intro_05_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_005, dia_seg__intro_05_sequence_006)
	
	var dia_seg__intro_05_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_006, dia_seg__intro_05_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_006)
	
	
	

func _play_dia_seg__intro_05_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_001)


func _on_dia_seg__intro_05_sequence_001__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30

func _on_dia_seg__intro_05_sequence_002__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_05__sequence_002")

func _on_shop_refreshed__intro_05__sequence_002(arg_tower_ids):
	set_enabled_buy_slots([])
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_003)


func _on_dia_seg__intro_05_sequence_003__fully_displayed():
	set_enabled_buy_slots([1, 2])
	
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__integrity_02, "on_dia_seg__intro_05_sequence_003__towers_with_ids_bought", self)
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__integrity_02, "_on_tower_placed_in_map__on_dia_seg__intro_05_sequence_003", self)

func on_dia_seg__intro_05_sequence_003__towers_with_ids_bought(arg_towers):
	tower_instances_bought__integrity_02 = arg_towers
	for tower in arg_towers:
		set_tower_is_draggable(tower, true)

func _on_tower_placed_in_map__on_dia_seg__intro_05_sequence_003(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_004)
	

func _on_dia_seg__intro_05_sequence_004__fully_displayed():
	var arrows = display_white_arrows_pointed_at_node(get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity]), true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30


#func _on_dia_seg__intro_05_sequence_005__fully_displayed():
#	pass
#





###############

var all_possible_ques_and_ans__for_worm_01
var all_possible_ques_and_ans__for_worm_02
var all_possible_ques_and_ans__for_worm_03

func _construct_questions_and_choices_for__worm_Q01():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Robert Morris"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_worm_Q01_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "John Walker"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Amjad Farooq Alvi"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "John von Neumann"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Who released the first computer worm?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_worm_Q01_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "A standalone malware computer program that replicates itself\nin order to spread to other computers."
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_worm_Q01_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Disguise as legitimate software but hack your computers."
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "An animal that eats dirt."
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "A software that protect your computers"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"What is a computer worm?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_worm_Q01_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_worm_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_worm_01.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_worm_01.add_question_info_for_choices_panel(question_info__02)

func _on_worm_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q01_timeout(arg_params):
	pass
	

###################



func _construct_questions_and_choices_for__worm_Q02():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Slow your internet connection"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_worm_Q02_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Eat up storage disk space and system memory"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Rendering your device unusable"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Modify or delete files"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Which of the following is not a harmful thing a computer worm can do to your computer?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_worm_Q02_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "By sending WLAN passwords to each other."
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_worm_Q02_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "A computer worm infection spreads without user interaction"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "An animal that eats dirt."
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "A software that protect your computers"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Which of the following is not how the computer worms spread?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_worm_Q02_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_worm_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_worm_02.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_worm_02.add_question_info_for_choices_panel(question_info__02)

func _on_worm_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q02_timeout(arg_params):
	pass
	


###########



func _construct_questions_and_choices_for__worm_Q03():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Don’t click on pop-up ads while you’re browsing."
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_worm_Q03_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Opening email attachments or links."
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Keep an eye on your hard drive space.\nWhen worms repeatedly replicate themselves, they start to use up the free space on your computer."
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Download unusual files."
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Which of the following is one of the best practices to prevent computer worms?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_worm_Q03_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Be cautious when opening email attachments or links"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_worm_Q03_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Don’t click on pop-up ads while you’re browsing"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Use VPN when torrenting"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Update software regularly"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"It’s best practice to not open an email link or attachment from an unknown sender. It could be a phishing scam or an email blast designed to spread malware."
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_worm_Q03_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_worm_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_worm_03.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_worm_03.add_question_info_for_choices_panel(question_info__02)

func _on_worm_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_worm_Q03_timeout(arg_params):
	pass
	

####################




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
	
