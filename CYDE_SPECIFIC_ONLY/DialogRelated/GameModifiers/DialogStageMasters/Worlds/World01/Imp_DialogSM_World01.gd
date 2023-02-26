extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"

######### WORLD 01, WHERE IT ALL STARTS ############


const tower_buff_desc_on_correct_ice_breaker = "If you got it correct, all towers become stronger for 1 minute."
const enemy_buff_desc_on_incorrect_ice_breaker = "Otherwise, if you got it wrong, all enemies become stronger for 1 minute."

#

enum World01_States {
	
	NONE = 1 << 0
	
	SHOWN_COMIC_SEQUENCE = 1 << 1,
	ENTERED_PLAYER_NAME = 1 << 2,
	INTRO_01_COMPLETED = 1 << 3,
	INTRO_02_COMPLETED = 1 << 4,
	
}


var dia_seg__comic_sequence_001 : DialogSegment
var dia_seg__comic_sequence_last : DialogSegment

var dia_seg__entered_player_name_001 : DialogSegment

var dia_seg__intro_01_sequence_001 : DialogSegment


# AFTER buying tower
var dia_seg__intro_02_sequence_005 : DialogSegment
var dia_seg__intro_02_sequence_008 : DialogSegment 


# Ice breaker quiz portion
var dia_seg__intro_03_sequence_001 : DialogSegment


# Other mechanics (player health/shield) portion
var dia_seg__intro_04_sequence_001 : DialogSegment
var dia_seg__intro_04_sequence_002 : DialogSegment  # after buying tower
var dia_seg__intro_04_sequence_004 : DialogSegment

# Info then quiz

var dia_seg__intro_05_sequence_001 : DialogSegment


#

var tower_id_to_buy_at_intro_tutorial = Towers.SPRINKLER
var tower_name_to_buy_at_intro_tutorial = "Sprinkler"
var tower_instance_bought_at_intro_tutorial

var tower_id_to_buy_at_intro_tutorial__002 = Towers.STRIKER
var tower_name_to_buy_at_intro_tutorial__002 = "Striker"
var tower_instance_bought_at_intro_tutorial__002

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
	
	#
	
	if !flag_is_enabled(world_completion_num_state, World01_States.SHOWN_COMIC_SEQUENCE):
		# TODO - SHOW COMIC SEQUENCE STYLE SEQUENCE
		
		_construct_and_play__comic_sequence_dialogs()
		
		
	elif !flag_is_enabled(world_completion_num_state, World01_States.ENTERED_PLAYER_NAME):
		
		_construct_and_play__enter_player_name_dialogs()
		
	elif !flag_is_enabled(world_completion_num_state, World01_States.INTRO_01_COMPLETED):
		
		_construct_and_play__intro_01_sequence_001()
		
	else:
		
		_construct_and_play__intro_02_sequence_001()

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
	
	#set_visiblity_of_all_placables(false)
	

#


#todo
func _construct_and_play__comic_sequence_dialogs():
	#dia_seg__comic_sequence_001 = DialogSegment.new()
	
	
	#todo
	# temporarily placed here
	world_completion_num_state = set_flag(world_completion_num_state, World01_States.SHOWN_COMIC_SEQUENCE)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	_construct_and_play__enter_player_name_dialogs()

#

func _construct_and_play__enter_player_name_dialogs():
	dia_seg__entered_player_name_001 = DialogSegment.new()
	
	if dia_seg__comic_sequence_last != null:
		configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__comic_sequence_last, dia_seg__entered_player_name_001)
	
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
		
		play_dialog_segment_or_advance_or_finish_elements(dia_seg__entered_player_name_001_AA__descs)
		
	else:
		CydeSingleton.player_name = arg_text
		
		world_completion_num_state = set_flag(world_completion_num_state, World01_States.ENTERED_PLAYER_NAME)
		set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
		
		_construct_and_play__intro_01_sequence_001()
		


func _construct_and_play__intro_01_sequence_001():
	dia_seg__intro_01_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_01_sequence_001__descs = [
		"Hello [i]%s[/i], I am %s. I was created by the late %s to protect the city of %s from any data threats." % [CydeSingleton.player_name, CydeSingleton.cyde_robot__name, CydeSingleton.dr_kevin_murphy__full_name, CydeSingleton.cyberland__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_001)
	
	###
	
	var dia_seg__intro_01_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_001, dia_seg__intro_01_sequence_002)
	
	var dia_seg__intro_01_sequence_002__descs = [
		"Hi %s, nice to meet you." % [CydeSingleton.cyde_robot__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_002)
	
	###
	
	var dia_seg__intro_01_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_002, dia_seg__intro_01_sequence_003)
	
	var dia_seg__intro_01_sequence_003__descs = [
		"I am glad to meet you too. After %s's death, the laboratory was taken over by %s, who changed its name to the wicked laboratory and its vision." % [CydeSingleton.dr_kevin_murphy__last_name, CydeSingleton.dr_asi_mitnick__full_name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_003)
	
	###
	
	var dia_seg__intro_01_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_003, dia_seg__intro_01_sequence_004)
	
	var dia_seg__intro_01_sequence_004__descs = [
		"What happened then?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_004)
	
	###
	
	var dia_seg__intro_01_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_004, dia_seg__intro_01_sequence_005)
	
	var dia_seg__intro_01_sequence_005__descs = [
		"%s created a malicious software called Malware that was specifically designed to gain unauthorised access to %s's database and use it to gain control of the entire city." % [CydeSingleton.dr_asi_mitnick__last_name, CydeSingleton.cyberland__name],
		"But before %s died, he programmed me to awaken and protect the city from these threats. And that's why I am here now, to find worthy heroes like you to assist me in saving the city from destruction." % [CydeSingleton.dr_kevin_murphy__last_name],
		
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_005)
	
	###
	
	var dia_seg__intro_01_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_005, dia_seg__intro_01_sequence_006)
	
	var dia_seg__intro_01_sequence_006__descs = [
		"I’m sorry to hear that. How can I help you?",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_006)
	
	###
	
	var dia_seg__intro_01_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_006, dia_seg__intro_01_sequence_007)
	
	var dia_seg__intro_01_sequence_007__descs = [
		"You can help by playing this game with me. In each round, you will learn about different types of malware and how to prevent them. You will also have to defend your data from these malwares. Are you ready to be a hero?"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_007)
	
	###
	
	var dia_seg__intro_01_sequence_008 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_007, dia_seg__intro_01_sequence_008)
	
	var dia_seg__intro_01_sequence_008__descs = [
		"Yes, I am ready!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_008__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_008)
	
	###
	
	var dia_seg__intro_01_sequence_009 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_01_sequence_008, dia_seg__intro_01_sequence_009)
	
	var dia_seg__intro_01_sequence_009__descs = [
		"Great! Let's start our journey to save %s." % [CydeSingleton.cyberland__name]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_01_sequence_009, dia_seg__intro_01_sequence_009__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_01_sequence_009)
	
	configure_dia_seg_to_call_func_on_player_click_or_enter(dia_seg__intro_01_sequence_009, self, "_on_end_of_dia_seg__intro_01_sequence_009", null)
	
	
	##### very last for this func
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_01_sequence_001)
	


func _on_end_of_dia_seg__intro_01_sequence_009(arg_dia_seg, arg_params):
	world_completion_num_state = set_flag(world_completion_num_state, World01_States.INTRO_01_COMPLETED)
	set_CYDE_Singleton_world_completion_state_num(world_completion_num_state)
	
	_construct_and_play__intro_02_sequence_001()


func _construct_and_play__intro_02_sequence_001():
	var dia_seg__intro_02_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_001__descs = [
		"Now that you know the story, let's proceed to the next phase of the game. In each stage, there are at least three (3) rounds. You will encounter different types of malware in each stage",
		"Before starting, I will to provide you with information about the malware you'll face in the stage."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_001)
	
	###
	
	var dia_seg__intro_02_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_001, dia_seg__intro_02_sequence_002)
	
	var dia_seg__intro_02_sequence_002__descs = [
		"It's important to know about the malware you'll face in each stage to be able to defeat it effectively. Make sure to read the information carefully and remember it. The information will also appear in the icebreaker quiz, so be prepared."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_002)
	
	###
	
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	
	var dia_seg__intro_02_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_002, dia_seg__intro_02_sequence_003)
	
	var dia_seg__intro_02_sequence_003__descs = [
		["In this game, you have access to a shop where you can buy |0|. There are many different types of |0| available in the game, each with its unique abilities and strengths.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_003)
	
	###
	
	var plain_fragment__tower = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "tower")
	
	var dia_seg__intro_02_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_003, dia_seg__intro_02_sequence_004)
	
	var dia_seg__intro_02_sequence_004__descs = [
		"Now let's talk about buying and placing towers.",
		["To buy a |0|, simply click on this card.", [plain_fragment__tower]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_004, dia_seg__intro_02_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_004)
	dia_seg__intro_02_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_02_sequence_005 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_005__descs = [
		["After buying |0|, they appear on the bench. You can think of the bench as a storage space, or inventory of towers.", [plain_fragment__towers]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_005)
	
	
	
	var dia_seg__intro_02_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_005, dia_seg__intro_02_sequence_006)
	
	var dia_seg__intro_02_sequence_006__descs = [
		"But towers placed on the bench do not attack, or do anything! After all, it is in the inventory.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_006)
	
	###
	
	var dia_seg__intro_02_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_006, dia_seg__intro_02_sequence_007)
	
	var dia_seg__intro_02_sequence_007__descs = [
		"Let's place this tower in the map by dragging it to this placable.",
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_02_sequence_007, dia_seg__intro_02_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_02_sequence_007)
	dia_seg__intro_02_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_02_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_02_sequence_008 = DialogSegment.new()
	
	var dia_seg__intro_02_sequence_008__descs = [
		"Good job! %s will now defend your data against the enemies!" % tower_name_to_buy_at_intro_tutorial
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
	
	#todo display circle node at placable
	#todo make placable visible
	
	_construct_dia_seg__intro_03_sequence_001()
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_id_to_buy_at_intro_tutorial], "_on_tower_placed_in_map__on_dia_seg__intro_02_sequence_007", self)

func _on_tower_placed_in_map__on_dia_seg__intro_02_sequence_007(arg_towers : Array):
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial, false)
	
	#call_deferred("_deferred_check")
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_02_sequence_008)

#func _deferred_check():
#	#todo
#	var tower = tower_instance_bought_at_intro_tutorial
#	print("tower: %s. tower_in_queue_free: %s, tower_visible: %s" % [tower, tower.is_queued_for_deletion(), tower.visible])
#	#end todo


func _construct_dia_seg__intro_03_sequence_001():
	dia_seg__intro_03_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_03_sequence_001__descs = [
		"Alright, now let's talk about the Icebreaker Quiz. This is an important part of the game and will test your knowledge on the malware that you're fighting against."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_001)
	
	###
	
	var dia_seg__intro_03_sequence_002 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_001, dia_seg__intro_03_sequence_002)
	
	var dia_seg__intro_03_sequence_002__descs = [
		"When you're in the middle of a round, the game will pause and an Icebreaker question will appear for a few seconds.",
		"But don't worry. You have two single-use support features in your disposal.",
		"First, you can [i]Reduce[/i] the amount of incorrect choices. This will allow you to clear up uncertainties.",
		"Second, you can [i]Change[/i] the question. This is provided in case you really cannot answer the problem."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_002)
	
	###
	
	var dia_seg__intro_03_sequence_003 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_002, dia_seg__intro_03_sequence_003)
	
	var dia_seg__intro_03_sequence_003__descs = [
		"Effects occur whether you get the answer correct or not.",
		tower_buff_desc_on_correct_ice_breaker,
		enemy_buff_desc_on_incorrect_ice_breaker,
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_003)
	
	###
	
	var dia_seg__intro_03_sequence_004 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_003, dia_seg__intro_03_sequence_004)
	
	var dia_seg__intro_03_sequence_004__descs = [
		"So make sure to pay attention to the information about the malware, and answer the questions carefully. Good luck!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_004)
	
	###
	
	var dia_seg__intro_03_sequence_005 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_004, dia_seg__intro_03_sequence_005)
	
	var dia_seg__intro_03_sequence_005__descs = [
		"....."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_005__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_005)
	
	###
	
	var dia_seg__intro_03_sequence_006 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_005, dia_seg__intro_03_sequence_006)
	
	var dia_seg__intro_03_sequence_006__descs = [
		"Now that the basics are covered, let's start the round.",
		"When starting the round, enemies and malwares will spawn in the entrance(s), indicated by the flags."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_006, dia_seg__intro_03_sequence_006__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_006)
	dia_seg__intro_03_sequence_006.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_006__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	var dia_seg__intro_03_sequence_007 = DialogSegment.new()
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_03_sequence_006, dia_seg__intro_03_sequence_007)
	
	var dia_seg__intro_03_sequence_007__descs = [
		"Please click the Start button, or press %s, to start the round." % InputMap.get_action_list("game_round_toggle")[0].as_text()
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_03_sequence_007, dia_seg__intro_03_sequence_007__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_03_sequence_007)
	dia_seg__intro_03_sequence_007.connect("fully_displayed", self, "_on_dia_seg__intro_03_sequence_007__fully_displayed", [], CONNECT_ONESHOT)
	
	#########################
	
	configure_dia_seg_to_progress_to_next_on_player_click_or_enter(dia_seg__intro_02_sequence_008, dia_seg__intro_03_sequence_001)

func _play_dia_seg__intro_03_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_03_sequence_001)



func _on_dia_seg__intro_03_sequence_006__fully_displayed():
	for flag in game_elements.map_manager.base_map.flag_to_path_map.keys():
		display_white_circle_at_node(flag)
	

func _on_dia_seg__intro_03_sequence_007__fully_displayed():
	set_round_is_startable(true)
	
	_construct_dia_seg__intro_04_sequence_001()
	listen_for_round_end_into_stage_round_id_and_call_func("02", self, "_on_round_ended__into_stage_02")


####

func _on_round_ended__into_stage_02(arg_stageround_id):
	set_round_is_startable(false)
	
	_play_dia_seg__intro_04_sequence_001()
	

func _construct_dia_seg__intro_04_sequence_001():
	var plain_fragment__refresh_the_shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "refresh the shop")
	var plain_fragment__shop = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.SHOP, "shop")
	var plain_fragment__towers = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.TOWER, "towers")
	var plain_fragment__round_ends = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.ON_ROUND_END, "round ends")
	
	dia_seg__intro_04_sequence_001 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_001__descs = [
		"That was easy! Only one enemy showed up. But soon even more will show up.",
		"Because of that, we need more towers.",
		["Click this button or press %s to |0| for us to access more towers.", [plain_fragment__refresh_the_shop]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_001, dia_seg__intro_04_sequence_001__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_001)
	dia_seg__intro_04_sequence_001.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_001__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_04_sequence_002 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_002__descs = [
		["Nice. Now the |0| is refreshed with new |1|.", [plain_fragment__shop, plain_fragment__towers]],
		["Every time a |0|, the shop is refreshed for free! So you have time to spare, you can just wait for a free refresh.", [plain_fragment__round_ends]]
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_002, dia_seg__intro_04_sequence_002__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_002)
	
	###
	
	var dia_seg__intro_04_sequence_003 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_003__descs = [
		"Now let's place that tower in the map, so that it can defend against the malware!"
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_003, dia_seg__intro_04_sequence_003__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	dia_seg__intro_04_sequence_003.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_003__fully_displayed", [], CONNECT_ONESHOT)
	
	###
	
	dia_seg__intro_04_sequence_004 = DialogSegment.new()
	
	var dia_seg__intro_04_sequence_004__descs = [
		"Great! Let's begin the next round."
	]
	_configure_dia_seg_to_default_templated_dialog_with_descs_only(dia_seg__intro_04_sequence_004, dia_seg__intro_04_sequence_004__descs)
	_configure_dia_set_to_standard_pos_and_size(dia_seg__intro_04_sequence_003)
	dia_seg__intro_04_sequence_004.connect("fully_displayed", self, "_on_dia_seg__intro_04_sequence_004__fully_displayed", [], CONNECT_ONESHOT)
	
	###

func _play_dia_seg__intro_04_sequence_001():
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_001)
	

func _on_dia_seg__intro_04_sequence_001__fully_displayed():
	listen_for_tower_with_id__bought__then_call_func(tower_id_to_buy_at_intro_tutorial, "_on_tower_bought__on_dia_seg__intro_04_sequence_001", self)

func on_tower_bought__on_dia_seg__intro_04_sequence_001(arg_tower_instance):
	tower_instance_bought_at_intro_tutorial__002 = arg_tower_instance
	set_tower_is_draggable(arg_tower_instance, false)
	set_tower_is_sellable(arg_tower_instance, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_002)
	


func _on_dia_seg__intro_04_sequence_003__fully_displayed():
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__002, true)
	
	display_white_circle_at_node(tower_instance_bought_at_intro_tutorial__002)
	#todo display circle node at placable
	#todo make placable visible
	
	listen_for_towers_with_ids__placed_in_map__then_call_func([tower_id_to_buy_at_intro_tutorial__002], "_on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003", self)

func _on_tower_placed_in_map__on_dia_seg__intro_04_sequence_003(arg_tower_ids):
	set_tower_is_draggable(tower_instance_bought_at_intro_tutorial__002, false)
	
	play_dialog_segment_or_advance_or_finish_elements(dia_seg__intro_04_sequence_004)


func _on_dia_seg__intro_04_sequence_004__fully_displayed():
	set_round_is_startable(true)
	_construct_dia_seg__intro_05_sequence_001()
	
	listen_for_round_end_into_stage_round_id_and_call_func("03", self, "_on_round_ended__into_stage_03")

func _on_round_ended__into_stage_03(arg_stageround_id):
	_play_dia_seg__intro_05_sequence_001()
	

#####

func _construct_dia_seg__intro_05_sequence_001():
	pass
	#todo

func _play_dia_seg__intro_05_sequence_001():
	pass

