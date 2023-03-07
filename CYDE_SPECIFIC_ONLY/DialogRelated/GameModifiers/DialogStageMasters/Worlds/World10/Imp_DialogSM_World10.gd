extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"



var all_possible_ques_and_ans__for_mobile_mal_01
var all_possible_ques_and_ans__for_mobile_mal_02
var all_possible_ques_and_ans__for_mobile_mal_03


func _construct_questions_and_choices_for__mobile_mal_Q01():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Tablets"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_mobile_mal_Q01_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Telephone"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Computers"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Server"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Mobile Malware is specifically designed to target mobile devices, such as smartphones and ________,\nwith the goal of gaining access to private data."
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_mobile_mal_Q01_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Cabir"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_mobile_mal_Q01_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Skulls"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "FakePlayer"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "HummingBad"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_mobile_mal_Q01_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"What is the first real worm, which spread from phone to phone in 2004,\nwhich spread through Bluetooth on Nokia's Symbian devices?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_mobile_mal_Q01_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_mobile_mal_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_mobile_mal_01.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_mobile_mal_01.add_question_info_for_choices_panel(question_info__02)

func _on_mobile_mal_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q01_timeout(arg_params):
	pass
	


########################


func _construct_questions_and_choices_for__mobile_mal_Q02():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Downloading infected apps"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_mobile_mal_Q02_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Visiting malicious websites"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Using infected USB drives"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Opening malicious email attachments"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Mobile malware can be hidden in apps available for download from app stores or third-party websites.\nWhen a user downloads and installs the app, malware is also installed on their device."
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_mobile_mal_Q02_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Using infected USB drives"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_mobile_mal_Q02_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Visiting malicious websites"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Downloading infected apps"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Opening malicious email attachments"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_mobile_mal_Q02_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Mobile malware can be spread through USB drives that are infected with the malware.\nWhen a user connects the USB drive to their device, the malware is transferred to the device."
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_mobile_mal_Q02_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_mobile_mal_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_mobile_mal_01.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_mobile_mal_01.add_question_info_for_choices_panel(question_info__02)

func _on_mobile_mal_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q02_timeout(arg_params):
	pass
	

############



func _construct_questions_and_choices_for__mobile_mal_Q03():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Install apps from trusted sources only"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_mobile_mal_Q03_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Root your phone"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Click on links or attachments in unsolicited emails or text messages"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Don't use the phone except on a data plan"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Which of the following is one of the best ways to prevent mobile malware?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_mobile_mal_Q03_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Factory reset your device"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_mobile_mal_Q03_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Never save usernames and passwords in your mobile browsers or apps"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Install apps from trusted sources only"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Don’t bank or shop online using public Wi-Fi connections"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_mobile_mal_Q03_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Which of the following is not one of the best ways to prevent mobile malware?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_mobile_mal_Q03_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_mobile_mal_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_mobile_mal_03.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_mobile_mal_03.add_question_info_for_choices_panel(question_info__02)

func _on_mobile_mal_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_mobile_mal_Q03_timeout(arg_params):
	pass
	
