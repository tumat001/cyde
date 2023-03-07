extends "res://MiscRelated/DialogRelated/StageMaster/BaseDialogStageMaster.gd"




var all_possible_ques_and_ans__for_rootkit_01
var all_possible_ques_and_ans__for_rootkit_02
var all_possible_ques_and_ans__for_rootkit_03


func _construct_questions_and_choices_for__rootkit_Q01():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Access"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_rootkit_Q01_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Remission"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Removal"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Command"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"In rootkit, the word “root” refers to the admin or superuser, who, by default,\nhas access to all files and commands on a Linux system.\n“Kit” is the software that grants ______?"
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_rootkit_Q01_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Linux"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_rootkit_Q01_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Mac"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Windows"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "None of the choices"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_rootkit_Q01_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Rootkits appeared in the 1990s, and initially targeted _____ systems. "
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_rootkit_Q01_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_rootkit_01 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_rootkit_01.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_rootkit_01.add_question_info_for_choices_panel(question_info__02)

func _on_rootkit_Q01_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q01_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q01_timeout(arg_params):
	pass
	


############


func _construct_questions_and_choices_for__rootkit_Q02():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Tools"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_rootkit_Q02_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Software"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Program"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "All of the Choices"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"Rootkits contain malicious ________, including banking credential stealers,\npassword stealers, keyloggers, antivirus disablers\n and bots for distributed denial-of-service attacks."
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_rootkit_Q02_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Disconnecting to shared drives that have been compromised\nor downloading software infected with the rootkit from risky websites."
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_rootkit_Q02_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Email phishing campaigns"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Executable malicious files"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Crafted malicious PDF files or Microsoft Word documents"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_rootkit_Q02_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Which of the following are not common vectors installed in Rootkits?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_rootkit_Q02_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_rootkit_02 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_rootkit_02.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_rootkit_02.add_question_info_for_choices_panel(question_info__02)

func _on_rootkit_Q02_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q02_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q02_timeout(arg_params):
	pass
	

##################


func _construct_questions_and_choices_for__rootkit_Q03():
	var choice_01__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_01.id = 1
	choice_01__ques_01.display_text = "Scanner"
	choice_01__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_01.func_source_on_click = self
	choice_01__ques_01.func_name_on_click = "_on_rootkit_Q03_choice_right_clicked"
	choice_01__ques_01.choice_result_type = choice_01__ques_01.ChoiceResultType.CORRECT
	
	var choice_02__ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_01.id = 2
	choice_02__ques_01.display_text = "Examiner"
	choice_02__ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_01.func_source_on_click = self
	choice_02__ques_01.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_02__ques_01.choice_result_type = choice_02__ques_01.ChoiceResultType.WRONG
	
	var choice_03_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_01.id = 3
	choice_03_ques_01.display_text = "Anti-rootkit"
	choice_03_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_01.func_source_on_click = self
	choice_03_ques_01.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_03_ques_01.choice_result_type = choice_03_ques_01.ChoiceResultType.WRONG
	
	var choice_04_ques_01 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_01.id = 3
	choice_04_ques_01.display_text = "Sensor"
	choice_04_ques_01.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_01.func_source_on_click = self
	choice_04_ques_01.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_04_ques_01.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__01 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__01.add_choice(choice_01__ques_01)
	choices_for_question_info__01.add_choice(choice_02__ques_01)
	choices_for_question_info__01.add_choice(choice_03_ques_01)
	choices_for_question_info__01.add_choice(choice_04_ques_01)
	
	
	var question_01_desc = [
		"_________ are software programs aimed to analyze a system to get rid of active rootkits.\nThis is usually effective in detecting and removing application rootkits. "
	]
	
	var question_info__01 = QuestionInfoForChoicesPanel.new()
	question_info__01.choices_for_questions = choices_for_question_info__01
	question_info__01.question_as_desc = question_01_desc
	question_info__01.time_for_question = dia_time_duration__long
	question_info__01.timeout_func_source = self
	question_info__01.timeout_func_name = "_on_rootkit_Q03_timeout"
	
	#######
	
	var choice_01__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_01__ques_02.id = 1
	choice_01__ques_02.display_text = "Upgrade your hardware"
	choice_01__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_01__ques_02.func_source_on_click = self
	choice_01__ques_02.func_name_on_click = "_on_rootkit_Q03_choice_right_clicked"
	choice_01__ques_02.choice_result_type = choice_01__ques_02.ChoiceResultType.CORRECT
	
	var choice_02__ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_02__ques_02.id = 2
	choice_02__ques_02.display_text = "Scan your devices"
	choice_02__ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_02__ques_02.func_source_on_click = self
	choice_02__ques_02.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_02__ques_02.choice_result_type = choice_02__ques_02.ChoiceResultType.WRONG
	
	var choice_03_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_03_ques_02.id = 3
	choice_03_ques_02.display_text = "Monitor network traffic"
	choice_03_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_03_ques_02.func_source_on_click = self
	choice_03_ques_02.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_03_ques_02.choice_result_type = choice_03_ques_02.ChoiceResultType.WRONG
	
	var choice_04_ques_02 = DialogChoicesPanel.ChoiceButtonInfo.new()
	choice_04_ques_02.id = 3
	choice_04_ques_02.display_text = "Avoid phishing attempts"
	choice_04_ques_02.choice_type = DialogChoicesPanel.ChoiceButtonInfo.ChoiceType.STANDARD
	choice_04_ques_02.func_source_on_click = self
	choice_04_ques_02.func_name_on_click = "_on_rootkit_Q03_choice_wrong_clicked"
	choice_04_ques_02.choice_result_type = choice_04_ques_01.ChoiceResultType.WRONG
	
	
	var choices_for_question_info__02 = ChoicesForQuestionsInfo.new(rng_to_use_for_randomized_questions_and_ans, 3)
	choices_for_question_info__02.add_choice(choice_01__ques_02)
	choices_for_question_info__02.add_choice(choice_02__ques_02)
	choices_for_question_info__02.add_choice(choice_03_ques_02)
	choices_for_question_info__02.add_choice(choice_04_ques_02)
	
	
	var question_02_desc = [
		"Which of the following is not the best practice to prevent rootkit?"
	]
	
	var question_info__02 = QuestionInfoForChoicesPanel.new()
	question_info__02.choices_for_questions = choices_for_question_info__02
	question_info__02.question_as_desc = question_02_desc
	question_info__02.time_for_question = dia_time_duration__short
	question_info__02.timeout_func_source = self
	question_info__02.timeout_func_name = "_on_rootkit_Q03_timeout"
	
	
	#######
	#######
	
	all_possible_ques_and_ans__for_rootkit_03 = AllPossibleQuestionsAndChoices_AndMiscInfo.new(rng_to_use_for_randomized_questions_and_ans)
	all_possible_ques_and_ans__for_rootkit_03.add_question_info_for_choices_panel(question_info__01)
	all_possible_ques_and_ans__for_rootkit_03.add_question_info_for_choices_panel(question_info__02)

func _on_rootkit_Q03_choice_right_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q03_choice_wrong_clicked(arg_id, arg_button_info : DialogChoicesPanel.ChoiceButtonInfo, arg_panel : DialogChoicesPanel):
	pass
	

func _on_rootkit_Q03_timeout(arg_params):
	pass
	


#############



