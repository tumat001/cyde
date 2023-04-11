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

# Info 01 (Round 5)
var dia_seg__intro_06_sequence_001 : DialogSegment

# Question 01
var dia_seg__intro_07_sequence_001 : DialogSegment
var dia_seg__intro_07_sequence_003 : DialogSegment

# Cyde dialog w/player
var dia_seg__intro_08_sequence_001 : DialogSegment

# Info 02
var dia_seg__intro_09_sequence_001 : DialogSegment

# Question 02
var dia_seg__intro_10_sequence_001 : DialogSegment
var dia_seg__intro_10_sequence_003 : DialogSegment

# Info 03
var dia_seg__intro_11_sequence_001 : DialogSegment

# Question 03
var dia_seg__intro_12_sequence_001 : DialogSegment
var dia_seg__intro_12_sequence_003 : DialogSegment


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

var starting_player_level_at_this_modi = 4

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
	towers_offered_on_shop_refresh.append(tower_ids_to_buy__integrity_02)
	
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
	
	#_construct_dia_seg__intro_06_sequence_001()
	#_play_dia_seg__intro_06_sequence_001()



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
	set_can_towers_swap_positions_to_another_tower(false)
	#add_shop_per_refresh_modifier(-5)
	add_gold_amount(20)
	
	set_player_level(starting_player_level_at_this_modi)
	
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
		["Now that we have made it this far, it is time for me to introduce the most exciting feature: |0|.", [plain_fragment__synergies]],
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
		["The |0| in this game is called the [b]CIA Triad Synergies[/b].", [plain_fragment__synergies]]
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
	
	if !prevent_other_dia_segs_from_playing__from_loss:
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
	tower_instances_bought__availability_01 = arg_towers
	for tower in arg_towers:
		set_tower_is_draggable(tower, true)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_002)


func _on_dia_seg__intro_02_sequence_002__fully_displayed():
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__availability_01, "_on_tower_placed_in_map__on_dia_seg__intro_02_sequence_002", self)
	

func _on_tower_placed_in_map__on_dia_seg__intro_02_sequence_002(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_003)
	
	

func _on_dia_seg__intro_02_sequence_003__fully_displayed():
	listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_02_sequence_003__synergies_updated")
	

func _on_dia_seg__intro_02_sequence_003__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Availability])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
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
	listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_02_sequence_007__synergies_updated")
	

func _on_dia_seg__intro_02_sequence_007__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Availability])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
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
	
	if !prevent_other_dia_segs_from_playing__from_loss:
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
		["Then finally, let's place all those |0|.", [plain_fragment__towers]]
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
	set_can_refresh_shop__panel_based(false)
	
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
	listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_03_sequence_006__synergies_updated")
	

func _on_dia_seg__intro_03_sequence_006__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Confidentiality])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
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
	
	if !prevent_other_dia_segs_from_playing__from_loss:
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
		["Then let's buy all the |0|, and place them in the map.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	
	dia_seg__intro_04_sequence_003.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_04_sequence_03__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
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

func _on_dia_seg__intro_04_sequence_001__sold_multiple_towers(arg_tower_ids):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_002)
	


func _on_dia_seg__intro_04_sequence_002__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_04__sequence_002")
	

func _on_shop_refreshed__intro_04__sequence_002(arg_tower_ids):
	set_can_refresh_shop__panel_based(false)
	
	set_enabled_buy_slots([])
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_003)
	

func _on_dia_seg__intro_04_sequence_03__setted_into_whole_screen_panel():
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__integrity_01, "on_dia_seg__intro_04_sequence_003__towers_with_ids_bought", self)
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__integrity_01, "_on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003", self)


func _on_dia_seg__intro_04_sequence_003__fully_displayed():
	set_enabled_buy_slots([1, 2, 3])


func on_dia_seg__intro_04_sequence_003__towers_with_ids_bought(arg_towers):
	tower_instances_bought__integrity_01 = arg_towers
	for tower in tower_instances_bought__integrity_01:
		set_tower_is_draggable(tower, true)
	

func _on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_004)
	

func _on_dia_seg__intro_04_sequence_004__fully_displayed():
	listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_04_sequence_004__synergies_updated")
	

func _on_dia_seg__intro_04_sequence_004__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
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
	
	if !prevent_other_dia_segs_from_playing__from_loss:
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
		["But if we place at least |0|, we can upgrade the |1| to the next level.", [plain_fragment__5_Integrity_towers, plain_fragment__Integrity_synergy]],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_001)
	
	dia_seg__intro_05_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	
	
	var dia_seg__intro_05_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_05_sequence_001, dia_seg__intro_05_sequence_002)
	
	var dia_seg__intro_05_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Let's |0| to gain more |1|.", [plain_fragment__refresh_the_shop, plain_fragment__Integrity_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_002, dia_seg__intro_05_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_002)
	
	dia_seg__intro_05_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	
	#
	var plain_fragment__level = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.LEVEL_UP_ORANGE, "level")
	var plain_fragment__5_towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "5 towers")
	
	
	
	dia_seg__intro_05_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_05_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Buy all the |0| and place them in the map.", [plain_fragment__towers]],
		"",
		["I've set your |0| to 5, so that you can place |1|", [plain_fragment__level, plain_fragment__5_towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_003, dia_seg__intro_05_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_003)
	
	dia_seg__intro_05_sequence_003.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_05_sequence_03__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
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
		["I've sold all your |0| for you to have a fresh start.", [plain_fragment__towers]],
		["Use your |0| to |1| and buy the |2| you feel like playing with.", [plain_fragment__gold, plain_fragment__refresh_the_shop, plain_fragment__towers]],
		"Start the round whenever you are ready."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_05_sequence_006, dia_seg__intro_05_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_05_sequence_006)
	
	dia_seg__intro_05_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_05_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_05_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_001)


func _on_dia_seg__intro_05_sequence_001__fully_displayed():
	pass
	#listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_05_sequence_001__synergies_updated")
	

func _on_dia_seg__intro_05_sequence_001__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30
	

func _on_dia_seg__intro_05_sequence_002__fully_displayed():
	set_can_refresh_shop__panel_based(true)
	
	listen_for_shop_refresh(self, "_on_shop_refreshed__intro_05__sequence_002")

func _on_shop_refreshed__intro_05__sequence_002(arg_tower_ids):
	set_can_refresh_shop__panel_based(false)
	
	set_enabled_buy_slots([])
	set_next_shop_towers_and_increment_counter()
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_003)


func _on_dia_seg__intro_05_sequence_03__setted_into_whole_screen_panel():
	listen_for_towers_with_ids__bought__then_call_func(tower_ids_to_buy__integrity_02, "on_dia_seg__intro_05_sequence_003__towers_with_ids_bought", self)
	listen_for_towers_with_ids__placed_in_map__then_call_func(tower_ids_to_buy__integrity_02, "_on_tower_placed_in_map__on_dia_seg__intro_05_sequence_003", self)
	
	set_player_level(5)

func _on_dia_seg__intro_05_sequence_003__fully_displayed():
	set_enabled_buy_slots([1, 2])
	

func on_dia_seg__intro_05_sequence_003__towers_with_ids_bought(arg_towers):
	tower_instances_bought__integrity_02 = arg_towers
	for tower in arg_towers:
		set_tower_is_draggable(tower, true)

func _on_tower_placed_in_map__on_dia_seg__intro_05_sequence_003(arg_towers):
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_05_sequence_004)
	

func _on_dia_seg__intro_05_sequence_004__fully_displayed():
	listen_for_left_side_panel_synergies_updated(self, "_on_dia_seg__intro_05_sequence_004__synergies_updated")
	

func _on_dia_seg__intro_05_sequence_004__synergies_updated():
	var single_syn_disp = get_single_syn_displayer_with_synergy_name__from_left_panel(TowerDominantColors.synergy_id_to_syn_name_dictionary[TowerDominantColors.CYDE_SynergyID__Integrity])
	var arrows = display_white_arrows_pointed_at_node(single_syn_disp, true, true)
	arrows[0].x_offset = 180
	arrows[0].flip_h = true
	arrows[1].y_offset = -30
	


#func _on_dia_seg__intro_05_sequence_005__fully_displayed():
#	pass
#

func _on_dia_seg__intro_05_sequence_006__fully_displayed():
	for tower in tower_instances_bought__integrity_01:
		if is_instance_valid(tower):
			set_tower_is_sellable(tower, true)
			tower.sell_tower()
	for tower in tower_instances_bought__integrity_02:
		if is_instance_valid(tower):
			set_tower_is_sellable(tower, true)
			tower.sell_tower()
	
	set_can_refresh_shop__panel_based(true)
	set_can_level_up(true)
	set_can_refresh_shop_at_round_end_clauses(true)
	set_enabled_buy_slots([1, 2, 3, 4, 5])
	
	set_can_towers_swap_positions_to_another_tower(true)
	
	set_round_is_startable(true)
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_05", "_on_round_ended__into_round_05")

func _on_round_started__into_round_05():
	_construct_dia_seg__intro_06_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_05():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_06_sequence_001()



func _construct_dia_seg__intro_06_sequence_001():
	var plain_fragment__synergies = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SYNERGY, "synergies")
	
	
	dia_seg__intro_06_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_06_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		["Now that we've covered about the |0|, we can now focus on the malwares of this stage: the [b]Computer Worms[/b]", [plain_fragment__synergies]],
		"I'll be providing their background. Take note of the information that I'll give you."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_001)
	
	#######
	
	var dia_seg__intro_06_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_001, dia_seg__intro_06_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__WORM_BACKGROUND_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_06_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_06_sequence_002)
	dia_seg__intro_06_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	#dia_seg__intro_06_sequence_002.final_dialog_custom_size_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	#dia_seg__intro_06_sequence_002.final_dialog_top_left_pos_val_trans_mode = DialogSegment.ValTransition.ValueIncrementMode.INSTANT
	
	
	####
	
	var dia_seg__intro_06_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_06_sequence_002, dia_seg__intro_06_sequence_003)
	
	
	var dia_seg__intro_06_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Start the round whenever you're ready"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_06_sequence_003, dia_seg__intro_06_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_06_sequence_003)
	dia_seg__intro_06_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_06_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	

func _play_dia_seg__intro_06_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_06_sequence_001)


func _on_dia_seg__intro_06_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__intro_06_sequence_003__fully_displayed():
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_06", "_on_round_ended__into_round_06")


func _on_round_started__into_round_06():
	_construct_dia_seg__intro_07_sequence_001()
	
	play_dialog_segment_or_advance_or_finish_elements(null)

func _on_round_ended__into_round_06():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_07_sequence_001()

######

func _construct_dia_seg__intro_07_sequence_001():
	_construct_questions_and_choices_for__worm_Q01()
	
	
	dia_seg__intro_07_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_001, dia_seg__intro_07_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_001)
	
	###
	
	var dia_seg__intro_07_sequence_002 = _construct_and_configure_choices_for_intro_07_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_07_sequence_001, dia_seg__intro_07_sequence_002)
	dia_seg__intro_07_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_07_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_07_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_07_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_07_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_07_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_07_sequence_003, dia_seg__intro_07_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_07_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_07_sequence_003, self, "_on_dia_seg__intro_07_sequence_003__ended", null)
	
	

func _play_dia_seg__intro_07_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_07_sequence_001)


func _on_dia_seg__intro_07_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__intro_07_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_worm_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q01_timeout(arg_params):
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
	


func _on_dia_seg__intro_07_sequence_003__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	set_round_is_startable(true)
	
	listen_for_round_start__then_listen_for_round_end__call_func_for_both(self, "_on_round_started__into_round_07", "_on_round_ended__into_round_07")


func _on_round_started__into_round_07():
	_construct_dia_seg__intro_08_sequence_001()

func _on_round_ended__into_round_07():
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_08_sequence_001()


###########

func _construct_dia_seg__intro_08_sequence_001():
	
	dia_seg__intro_08_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_08_sequence_001__descs = [
		generate_colored_text__player_name__as_line(),
		"Hi %s, are you really programmed to detect malware?" % CydeSingleton.cyde_robot__name,
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_001, dia_seg__intro_08_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_001)
	
	var custom_pos = dia_portrait__pos__standard_left
	custom_pos.x = 0
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_001, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, custom_pos, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_08_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_001, dia_seg__intro_08_sequence_002)
	
	var dia_seg__intro_08_sequence_002__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Yes, %s. I am programmed by %s to detect and help prevent malware infections." % [CydeSingleton.player_name, CydeSingleton.dr_kevin_murphy__last_name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_002, dia_seg__intro_08_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_002)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_002, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	
	var dia_seg__intro_08_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_002, dia_seg__intro_08_sequence_003)
	
	var dia_seg__intro_08_sequence_003__descs = [
		generate_colored_text__player_name__as_line(),
		"That's great to hear. How do you do that?"
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_003, dia_seg__intro_08_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_003)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_003, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_08_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_003, dia_seg__intro_08_sequence_004)
	
	var dia_seg__intro_08_sequence_004__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I use a variety of techniques to detect malware, including scanning files and programs for known malicious code, analyzing suspicious behavior and network traffic, and monitoring for signs of compromise. I also keep an updated database of known malware threats and use that information to identify potential threats."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_004, dia_seg__intro_08_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_004)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_004, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_08_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_004, dia_seg__intro_08_sequence_005)
	
	var dia_seg__intro_08_sequence_005__descs = [
		generate_colored_text__player_name__as_line(),
		"How do you protect against new and unknown malware threats?"
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_005, dia_seg__intro_08_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_005)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_005, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	###
	
	var dia_seg__intro_08_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_005, dia_seg__intro_08_sequence_006)
	
	var dia_seg__intro_08_sequence_006__descs = [
		generate_colored_text__cyde_name__as_line(),
		"I use advanced machine learning algorithms and behavioral analysis techniques to identify and detect new and unknown malware threats. By analyzing patterns of behavior, I can identify suspicious activity and prevent it before it causes harm to your device or data."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_006, dia_seg__intro_08_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_006)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_006, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#####
	
	var dia_seg__intro_08_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_006, dia_seg__intro_08_sequence_007)
	
	var dia_seg__intro_08_sequence_007__descs = [
		generate_colored_text__player_name__as_line(),
		"That's really impressive. Thank you, Cyde. It's good to know that you're here to help keep cyberland safe from malware."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_007, dia_seg__intro_08_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_007)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_007, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	
	#######
	
	
	var dia_seg__intro_08_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_08_sequence_007, dia_seg__intro_08_sequence_008)
	
	var dia_seg__intro_08_sequence_008__descs = [
		generate_colored_text__cyde_name__as_line(),
		"You're welcome, %s." % [CydeSingleton.player_name]
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_08_sequence_008, dia_seg__intro_08_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_08_sequence_008)
	
	_configure_dia_seg_to_default_templated_background_ele_dia_texture_image(dia_seg__intro_08_sequence_008, CydeSingleton.cyde_state_to_image_map[CydeSingleton.CYDE_STATE.STANDARD_001], dia_portrait__pos__standard_left, dia_portrait__pos__standard_left, persistence_id_for_portrait__cyde)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_08_sequence_008, self, "_on_dia_seg__intro_08_sequence_008__ended", null)

func _play_dia_seg__intro_08_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_08_sequence_001)
	

func _on_dia_seg__intro_08_sequence_008__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_09_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("38", self, "_on_round_started__into_round_08")


func _on_round_started__into_round_08(arg_stageround_id):
	set_round_is_startable(false)
		
	if !prevent_other_dia_segs_from_playing__from_loss:
		
		_play_dia_seg__intro_09_sequence_001()


func _construct_dia_seg__intro_09_sequence_001():
	dia_seg__intro_09_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_09_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"New information regarding our enemies, the Computer Worms, has been researched. This time, it is about their behavior on devices.",
		"I'll put it on display for you to review."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_09_sequence_001)
	
	##
	
	var dia_seg__intro_09_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_09_sequence_001, dia_seg__intro_09_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__WORM_BEHAVIOR_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_09_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_09_sequence_002)
	dia_seg__intro_09_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_09_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_09_sequence_002, self, "_on_dia_seg__intro_09_sequence_002__ended", null)
	
	

func _play_dia_seg__intro_09_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_09_sequence_001)
	


func _on_dia_seg__intro_09_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__intro_09_sequence_002__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_10_sequence_001()
	set_round_is_startable(true)
	listen_for_round_end_into_stage_round_id_and_call_func("39", self, "_on_round_started__into_round_09")


func _on_round_started__into_round_09(arg_stageorund):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_10_sequence_001()

#####

func _construct_dia_seg__intro_10_sequence_001():
	_construct_questions_and_choices_for__worm_Q02()
	
	
	dia_seg__intro_10_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the Icebreaker quiz? Proceed to test your knowledge."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_001)
	
	###
	
	var dia_seg__intro_10_sequence_002 = _construct_and_configure_choices_for_intro_10_questions()[0]
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_10_sequence_001, dia_seg__intro_10_sequence_002)
	dia_seg__intro_10_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_10_sequence_002__fully_displayed", [], CONNECT_ONESHOT)
	dia_seg__intro_10_sequence_002.connect("setted_into_whole_screen_panel", self, "_on_dia_seg__intro_10_sequence_02__setted_into_whole_screen_panel", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_10_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_10_sequence_003__descs = [
		generate_colored_text__cyde_name__as_line(),
		"But that is not all. There is so much more knowledge to gain against the enemies. Be prepared for more!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_10_sequence_003, dia_seg__intro_10_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_10_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_10_sequence_003, self, "_on_dia_seg__intro_10_sequence_003__ended", null)
	

func _play_dia_seg__intro_10_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_10_sequence_001)
	


func _on_dia_seg__intro_10_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__intro_10_sequence_002__fully_displayed():
	play_quiz_time_music()



func _on_worm_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q02_timeout(arg_params):
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
	


func _on_dia_seg__intro_10_sequence_003__ended(arg_seg, arg_param):
	set_round_is_startable(true)
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_11_sequence_001()
	
	# intentionally skip 310.
	listen_for_round_end_into_stage_round_id_and_call_func("311", self, "_on_round_started__into_round_11")
	

func _on_round_started__into_round_11(arg_stageround_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_11_sequence_001()

####


func _construct_dia_seg__intro_11_sequence_001():
	dia_seg__intro_11_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_11_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"One last information regarding our enemies, the Computer Worms, has been researched. This time, it is about how to avoid them, in general.",
		"I'll put it on display for you to review."
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_11_sequence_001)
	
	##
	
	var dia_seg__intro_11_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_11_sequence_001, dia_seg__intro_11_sequence_002)
	
	var tidbit_to_view_and_enable = StoreOfTextTidbit.TidbitId.CYDE__WORM_PRACTICES_01
	var x_type_item_entry_data = AlmanacManager.tidbit_id_to_tidbit_item_entry_data_option_map[tidbit_to_view_and_enable]
	_configure_dia_seg_to_default_templated_dialog_almanac_x_type_info_panel(dia_seg__intro_11_sequence_002, x_type_item_entry_data, AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT)
	_configure_dia_set_to_x_type_info_tidbit_pos_and_size(dia_seg__intro_11_sequence_002)
	dia_seg__intro_11_sequence_002.connect("fully_displayed", self, "_on_dia_seg__intro_11_sequence_002__fully_displayed", [tidbit_to_view_and_enable], CONNECT_ONESHOT)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_11_sequence_002, self, "_on_dia_seg__intro_11_sequence_002__ended", null)
	
	

func _play_dia_seg__intro_11_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_11_sequence_001)
	

func _on_dia_seg__intro_11_sequence_002__fully_displayed(arg_tidbit_id):
	set_stats_tidbit_val_of_id_to_enabled(arg_tidbit_id)

func _on_dia_seg__intro_11_sequence_002__ended(arg_seg, arg_params):
	play_dialog_segment_or_advance_or_finish_elements(null)
	
	_construct_dia_seg__intro_12_sequence_001()
	set_round_is_startable(true)
	listen_for_round_end_into_stage_round_id_and_call_func("312", self, "_on_round_started__into_round_12")

func _on_round_started__into_round_12(arg_stageround_id):
	set_round_is_startable(false)
	
	if !prevent_other_dia_segs_from_playing__from_loss:
		_play_dia_seg__intro_12_sequence_001()

###


func _construct_dia_seg__intro_12_sequence_001():
	_construct_questions_and_choices_for__worm_Q03()
	
	
	dia_seg__intro_12_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_12_sequence_001__descs = [
		generate_colored_text__cyde_name__as_line(),
		"Ready for the last Icebreaker quiz of this stage? Proceed to test your knowledge."
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
		"The Computer Worm boss appears in the next round. Prepare yourself!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_12_sequence_003, dia_seg__intro_12_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_12_sequence_003)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_12_sequence_003, self, "_on_dia_seg__intro_12_sequence_003__ended", null)
	


func _play_dia_seg__intro_12_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_12_sequence_001)
	


func _on_dia_seg__intro_12_sequence_02__setted_into_whole_screen_panel():
	game_elements.linearly_set_game_play_theme_db_to_inaudiable()

func _on_dia_seg__intro_12_sequence_002__fully_displayed():
	play_quiz_time_music()


func _on_worm_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
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
	

func _on_worm_Q03_timeout(arg_params):
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
	


func _on_dia_seg__intro_12_sequence_003__ended(arg_seg, arg_params):
	set_round_is_startable(true)
	play_dialog_segment_or_advance_or_finish_elements(null)
	
#	listen_for_round_end_into_stage_round_id_and_call_func("313", self, "_on_round_started__into_round_13")
#
#func _on_round_started__into_round_13():
#	pass
#



###############

var all_possible_ques_and_ans__for_worm_01
var all_possible_ques_and_ans__for_worm_02
var all_possible_ques_and_ans__for_worm_03

func _construct_questions_and_choices_for__worm_Q01():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Robert Morris"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_worm_Q01_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "John Walker"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Amjad Farooq Alvi"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "John von Neumann"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
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
#		"Who released the first computer worm?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__short
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_worm_Q01_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "A standalone malware computer program that replicates itself\nin order to spread to other computers."
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_worm_Q01_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Disguise as legitimate software but hack your computers."
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "An animal that eats dirt."
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "A software that protect your computers"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_worm_Q01_choice_wrong_clicked"
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
#		"What is a computer worm?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_worm_Q01_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__worm_Q01(self, "_on_worm_Q01_choice_right_clicked", "_on_worm_Q01_choice_wrong_clicked", "_on_worm_Q01_timeout")
	
	all_possible_ques_and_ans__for_worm_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_worm_01.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_worm_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_worm_01.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_worm_01.add_question_info_for_choices_panel(question_info__02)


###################



func _construct_questions_and_choices_for__worm_Q02():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Slow your internet connection"
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_worm_Q02_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Eat up storage disk space and system memory"
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Rendering your device unusable"
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Modify or delete files"
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
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
#		"Which of the following is not a harmful thing a computer worm can do to your computer?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_worm_Q02_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "By sending WLAN passwords to each other."
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_worm_Q02_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "A computer worm infection spreads without user interaction"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "All that is necessary is for the computer worm to become active on an infected system."
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "USB drives."
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_worm_Q02_choice_wrong_clicked"
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
#		"Which of the following is not how the computer worms spread?"
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_worm_Q02_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__worm_Q02(self, "_on_worm_Q02_choice_right_clicked", "_on_worm_Q02_choice_wrong_clicked", "_on_worm_Q02_timeout")
	
	all_possible_ques_and_ans__for_worm_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_worm_02.add_question_info_for_choices_panel(question)
	
	
#	all_possible_ques_and_ans__for_worm_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_worm_02.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_worm_02.add_question_info_for_choices_panel(question_info__02)


###########



func _construct_questions_and_choices_for__worm_Q03():
#	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_01.id = 1
#	choice_01__ques_01.display_text = "Don’t click on pop-up ads while you’re browsing."
#	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_01.func_source_on_click = self
#	choice_01__ques_01.func_name_on_click = "_on_worm_Q03_choice_right_clicked"
#	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
#
#	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_01.id = 2
#	choice_02__ques_01.display_text = "Opening email attachments or links."
#	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_01.func_source_on_click = self
#	choice_02__ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
#	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
#
#	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_01.id = 3
#	choice_03_ques_01.display_text = "Keep an eye on your hard drive space.\nWhen worms repeatedly replicate themselves, they start to use up the free space on your computer."
#	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_01.func_source_on_click = self
#	choice_03_ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
#	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
#
#	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_01.id = 3
#	choice_04_ques_01.display_text = "Download unusual files."
#	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_01.func_source_on_click = self
#	choice_04_ques_01.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
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
#		"Which of the following is one of the best practices to prevent computer worms?"
#	]
#
#	var question_info__01 = QuestionInfoForChoicesPanel.new()
#	question_info__01.choices_for_questions = choices_for_question_info__01
#	question_info__01.question_as_desc = question_01_desc
#	question_info__01.time_for_question = dia_time_duration__long
#	question_info__01.timeout_func_source = self
#	question_info__01.timeout_func_name = "_on_worm_Q03_timeout"
#
#	#######
#
#	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_01__ques_02.id = 1
#	choice_01__ques_02.display_text = "Be cautious when opening email attachments or links"
#	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_01__ques_02.func_source_on_click = self
#	choice_01__ques_02.func_name_on_click = "_on_worm_Q03_choice_right_clicked"
#	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
#
#	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_02__ques_02.id = 2
#	choice_02__ques_02.display_text = "Don’t click on pop-up ads while you’re browsing"
#	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_02__ques_02.func_source_on_click = self
#	choice_02__ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
#	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
#
#	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_03_ques_02.id = 3
#	choice_03_ques_02.display_text = "Use VPN when torrenting"
#	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_03_ques_02.func_source_on_click = self
#	choice_03_ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
#	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
#
#	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
#	choice_04_ques_02.id = 3
#	choice_04_ques_02.display_text = "Update software regularly"
#	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
#	choice_04_ques_02.func_source_on_click = self
#	choice_04_ques_02.func_name_on_click = "_on_worm_Q03_choice_wrong_clicked"
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
#		"It’s best practice to not open an email link or attachment from an unknown sender. It could be a phishing scam or an email blast designed to spread malware."
#	]
#
#	var question_info__02 = QuestionInfoForChoicesPanel.new()
#	question_info__02.choices_for_questions = choices_for_question_info__02
#	question_info__02.question_as_desc = question_02_desc
#	question_info__02.time_for_question = dia_time_duration__short
#	question_info__02.timeout_func_source = self
#	question_info__02.timeout_func_name = "_on_worm_Q03_timeout"
#
	
	#######
	#######
	
	var questions = StoreOfQuestions.construct_questions_and_choices_for__worm_Q03(self, "_on_worm_Q03_choice_right_clicked", "_on_worm_Q03_choice_wrong_clicked", "_on_worm_Q03_timeout")
	
	all_possible_ques_and_ans__for_worm_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	for question in questions:
		all_possible_ques_and_ans__for_worm_03.add_question_info_for_choices_panel(question)
	
	
	
#	all_possible_ques_and_ans__for_worm_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
#	all_possible_ques_and_ans__for_worm_03.add_question_info_for_choices_panel(question_info__01)
#	all_possible_ques_and_ans__for_worm_03.add_question_info_for_choices_panel(question_info__02)



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
		"Congratulations for winning the stage! [b]The Computer Worms[/b] have been defeated.",
		"You can proceed to the next map to continue the story."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__on_win_01_sequence_001, dia_seg__on_win_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__on_win_01_sequence_001)
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__on_win_01_sequence_001, self, "_on_end_of_dia_seg__on_win_x_segment__end", null)
	
	


func _play_dia_seg__on_win_01_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__on_win_01_sequence_001)


func _on_end_of_dia_seg__on_win_x_segment__end(arg_seg, arg_params):
	CommsForBetweenScenes.goto_starting_screen(game_elements)
	


############ QUESTIONS STATE ############

func _show_dialog_choices_modi_panel():
	return false #true

func _build_dialog_choices_modi_panel_config():
	var config = DialogChoicesModiPanel.ModiPanelConfig.new()
	
	config.remove_false_answer_count = remove_choice_count
	config.show_change_question = show_change_questions
	
	config.func_source_for_actions = self
	config.func_name_for__change_question = "_on_dialog_choices_modi_panel__change_question"
	config.func_name_for__remove_false_answer = "_on_dialog_choices_modi_panel__removed_choices"
	
	return config


func _on_dialog_choices_modi_panel__removed_choices(arg_param):
	remove_choice_count -= 1

func _on_dialog_choices_modi_panel__change_question(arg_param):
	show_change_questions = false
	
	if current_possible_ques_and_ans == all_possible_ques_and_ans__for_worm_01:
		var dia_seg = _construct_and_configure_choices_for_intro_07_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_worm_02:
		var dia_seg = _construct_and_configure_choices_for_intro_10_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)
	elif current_possible_ques_and_ans == all_possible_ques_and_ans__for_worm_03:
		var dia_seg = _construct_and_configure_choices_for_intro_12_questions()[0]
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg)

####

func _construct_and_configure_choices_for_intro_07_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_worm_01
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_07", all_possible_ques_and_ans__for_worm_01, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")


func _construct_dia_seg_for_questions__intro_07(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx

#

func _construct_and_configure_choices_for_intro_10_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_worm_02
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_10", all_possible_ques_and_ans__for_worm_02, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")

func _construct_dia_seg_for_questions__intro_10(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx

#

func _construct_and_configure_choices_for_intro_12_questions():
	current_possible_ques_and_ans = all_possible_ques_and_ans__for_worm_03
	return _construct_dia_seg_to_default_templated__questions_from_pool(self, "_construct_dia_seg_for_questions__intro_12", all_possible_ques_and_ans__for_worm_03, self, "_show_dialog_choices_modi_panel", "_build_dialog_choices_modi_panel_config")

func _construct_dia_seg_for_questions__intro_12(arg_rand_ques_for_choices_selected):
	var dia_seg_question__for_intro_xx = DialogSegment.new()
	
	_set_dialog_segment_to_block_almanac_button(dia_seg_question__for_intro_xx, AlmanacButtonPanel.IsDisabledClauseId.QUESTION_IN_PROGRESS)
	
	_configure_dia_set_to_plate_middle_pos_and_size(dia_seg_question__for_intro_xx)
	
	return dia_seg_question__for_intro_xx

