extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"


var all_possible_ques_and_ans__for_trojan_01
var all_possible_ques_and_ans__for_trojan_02
var all_possible_ques_and_ans__for_trojan_03
var all_possible_ques_and_ans__for_trojan_04

  

func _construct_questions_and_choices_for__trojan_Q01():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Software"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_trojan_Q01_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Hardware"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "File"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Program"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
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
	question_info__01.timeout_func_name = "_on_trojan_Q01_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Downloader Trojan"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_trojan_Q01_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Backdoor Trojan"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Exploit Trojan"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "None of the Choices"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_trojan_Q01_choice_wrong_clicked"
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
	question_info__02.timeout_func_name = "_on_trojan_Q01_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_trojan_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_trojan_01.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_trojan_01.add_question_info_for_choices_panel(question_info__02)

func _on_trojan_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_trojan_Q01_timeout(arg_params):
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
	choice_01__ques_01.display_text = ""
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_trojan_Q03_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = ""
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = ""
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_trojan_Q03_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = ""
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
		""
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
	




