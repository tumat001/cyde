extends Node

const TextTidbitTypeInfo = preload("res://GeneralInfoRelated/TextTidbitRelated/TextTidbitTypeInfo.gd")

const TextFragmentInterpreter = preload("res://MiscRelated/TextInterpreterRelated/TextFragmentInterpreter.gd")
const NumericalTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/NumericalTextFragment.gd")
const TowerStatTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/TowerStatTextFragment.gd")
const OutcomeTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/OutcomeTextFragment.gd")
const PlainTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/PlainTextFragment.gd")



enum TidbitId {
	
	#ORANGE_12 = 1,
	
	#######
	
	CYDE__VIRUS_BACKGROUND_01 = 100
	CYDE__VIRUS_BEHAVIOR_01 = 101
	CYDE__VIRUS_PRACTICES_01 = 102
	
	CYDE__TROJAN_BACKGROUND_01 = 200
	CYDE__TROJAN_BEHAVIOR_01 = 201
	CYDE__TROJAN_PRACTICES_01 = 202
	
	CYDE__WORM_BACKGROUND_01 = 300
	CYDE__WORM_BEHAVIOR_01 = 301
	CYDE__WORM_PRACTICES_01 = 302
	
	
}

# IF ADDING TIDBIT CATEGORY, ADD CATEGORY IN ALAMANC_MANAGER's CategoryIds AS WELL
# DO NOT change numbers
enum TidbitCategory {
	VIRUS = 0,
	TROJAN = 1,
	WORM = 2,
	ADWARE = 3,
	RANSOMWARE = 4,
	SPYWARE = 5,
	ROOTKIT = 6,
	FILELESS = 7,
	MALWARE_BOTS = 8,
	MOBILE_MALWARE = 9,
}

const tidbit_category_id_to_tidbit_category_name : Dictionary = {
	TidbitCategory.VIRUS : "Virus",
	TidbitCategory.TROJAN : "Trojan",
	TidbitCategory.WORM : "Worm",
	TidbitCategory.ADWARE : "Adware",
	TidbitCategory.RANSOMWARE : "Ransomware",
	TidbitCategory.SPYWARE : "Spyware",
	TidbitCategory.ROOTKIT : "Rootkit",
	TidbitCategory.FILELESS : "Fileless",
	TidbitCategory.MALWARE_BOTS : "Malware Bots",
	TidbitCategory.MOBILE_MALWARE : "Mobile Malware",
	
}

const tidbit_id_to_category_id_map : Dictionary = {
	TidbitId.CYDE__VIRUS_BACKGROUND_01 : TidbitCategory.VIRUS,
	TidbitId.CYDE__VIRUS_BEHAVIOR_01 : TidbitCategory.VIRUS,
	TidbitId.CYDE__VIRUS_PRACTICES_01 : TidbitCategory.VIRUS,
	
	#
	
}

# programatically set using above "tidbit_id_to_category_id_map"
const tidbit_category_id_to_tidbit_ids_arr_map : Dictionary = {}


#

var tidbit_id_to_info_singleton_map : Dictionary

#

#func _init():

func _on_singleton_initialize():
	_initialize_tidbit_map()

func _initialize_tidbit_map():
	
	for tidbit_id in tidbit_id_to_category_id_map:
		var cat_id = tidbit_id_to_category_id_map[tidbit_id]
		if !tidbit_category_id_to_tidbit_ids_arr_map.has(cat_id):
			tidbit_category_id_to_tidbit_ids_arr_map[cat_id] = []
			
		tidbit_category_id_to_tidbit_ids_arr_map[cat_id].append(tidbit_id)
	
	
	##############
	
	# ORANGE 12
	#_construct_tidbit__orange_12()
	
	
	########## CYDE RELATED STUFFS #############
	# VIRUS
	
	_construct_tidbit__virus_background_01()
	_construct_tidbit__virus_behavior_01()
	_construct_tidbit__virus_practices_01()
	
	# TROJAN
	
	_construct_tidbit__trojan_background_01()
	_construct_tidbit__trojan_behavior_01()
	_construct_tidbit__trojan_practices_01()
	
#
#func _construct_tidbit__orange_12():
#	var tidbit = TextTidbitTypeInfo.new()
#
#	var orange_tower_count_for_activation : int = 12 #TowerDominantColors.get_synergy_with_id(TowerDominantColors.SynergyID__Orange).number_of_towers_in_tier[0]
#	var plain_fragment__max_orange_synergy = PlainTextFragment.new(PlainTextFragment.STAT_TYPE.COLOR_ORANGE, "%s orange synergy" % orange_tower_count_for_activation)
#
##	tidbit.descriptions = [
##		"Beyond all limitations.",
##		"",
##		["Gained from activating |0|.", [plain_fragment__max_orange_synergy]]
##	]
#
#	tidbit.add_description([
#		"Beyond all limitations.",
#		"",
#		["Gained from activating |0|.", [plain_fragment__max_orange_synergy]]
#	])
#
#	tidbit.id = TidbitId.ORANGE_12
#	tidbit.name = "%s Orange" % orange_tower_count_for_activation
#	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")
#	tidbit.tidbit_tier = 6
#
#	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit

######

func _construct_tidbit__virus_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Computer Virus?"),
		"",
		"A computer virus is a particular kind of software that, when run, copies itself by altering other programs and incorporating its own code into those programs. They exist in various forms and have different modes of operation to cause harm, like destroying data or corrupting files, while others are merely designed to spread without causing any damage. The first computer virus called Creeper program was released In 1971 by Bob Thomas of BBN."
	])
	
	tidbit.id = TidbitId.CYDE__VIRUS_BACKGROUND_01
	tidbit.name = "Virus -- Background"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__virus_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	# FOR SOME REASON [b] does not make the text bold but instead italics???? HELLOOOOOOO
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Malware Virus Works?"),
		"",
		"To understand how computer viruses work, it’s helpful to understand its four phases which are inspired by biologists’ classification of a real-life virus’s life cycle.",
		PlainTextFragment.get_text__indented(PlainTextFragment.get_text__as_unordered_list([
			"[b]Dormant phase:[/b] This is when the virus is hidden on your system, waiting for an opportunity to infect other files or areas of the computer.",
			"[b]Propagation phase:[/b] This is when the virus begins to self-replicate, stashing copies of itself in files, programs, or other parts of your disk.",
			"[b]Triggering phase:[/b] A specific action is generally required to trigger or activate the virus. This could be a user action, like clicking an icon or opening an app.",
			"[b]Execution phase:[/b] Now the virus’s program is executed and releases its payload, the malicious code that harms your device.",
		], false, PlainTextFragment.BulletPicType.CIRCLE_5X5)),
		
	])
	
	tidbit.id = TidbitId.CYDE__VIRUS_BEHAVIOR_01
	tidbit.name = "Virus -- Behavior"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__virus_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best Practices to Prevent Virus Attacks:"),
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				###
				"[b]1) Follow Basic Rules[/b]",
				PlainTextFragment.get_text__indented(
				PlainTextFragment.get_text__as_unordered_list([
					"Don’t open email attachments or click on hyperlinks from unknown senders.",
					"Use passwords that are hard to guess and change them regularly. Do not store user names and passwords on websites.",
					"Exercise caution when downloading files from the Internet. Only download from trusted sources."
				], false, PlainTextFragment.BulletPicType.CIRCLE_5X5)
				),
				"",
				###
				"[b]2) Protect Your Computer[/b]",
				PlainTextFragment.get_text__indented(
				PlainTextFragment.get_text__as_unordered_list([
					"Backup files on your personal computers regularly using an external hard drive.",
					"Don’t keep sensitive or private information stored on your computer. If you get hacked, information can be found."
				], false, PlainTextFragment.BulletPicType.CIRCLE_5X5)
				),
				"",
				###
				"[b]3) Antivirus Software[/b]",
				PlainTextFragment.get_text__indented(
				PlainTextFragment.get_text__as_unordered_list([
					"New viruses are always being created so it is best to have an antivirus program that automatically downloads updates",
					"Run a full virus scan every week to detect any threats. Do note that some antiviruses scan automatically from time to time."
				], false, PlainTextFragment.BulletPicType.CIRCLE_5X5)
				),
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__VIRUS_PRACTICES_01
	tidbit.name = "Virus -- Practices"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit

########


func _construct_tidbit__trojan_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Trojan Horse?"),
		"",
		"A Trojan Horse (Trojan) is a type of malware that disguises itself as legitimate code or software. Once inside the network, attackers can carry out any action that a legitimate user could perform, such as exporting files, modifying data, deleting files or otherwise altering the contents of the device. Trojans may be packaged in downloads for games, tools, apps or even software patches. Many Trojan attacks also leverage social engineering tactics, as well as spoofing and phishing, to prompt the desired action in the user.",
		"",
		"[b]Common Types of Trojan Horse Malware[/b]",
		PlainTextFragment.get_text__indented(PlainTextFragment.get_text__as_unordered_list([
			"[b]Exploit Trojan[/b] - As the name implies, these Trojans identify and exploit vulnerabilities within software applications in order to gain access to the system.",
			"[b]Downloader Trojan[/b] - This type of malware typically targets infected devices and installs a new version of a malicious program onto the device.",
			"[b]Backdoor Trojan[/b] - The attacker uses the malware to set up access points to the network.",
		], false)),
		
	])
	
	tidbit.id = TidbitId.CYDE__TROJAN_BACKGROUND_01
	tidbit.name = "Trojan -- Background"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__trojan_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How does the Trojan Horse infect devices?"),
		"",
		"Some of the most common ways for devices to become infected with Trojans can be linked to user behavior, such as:",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) Downloading pirated media, including music, video games, movies, books, software or paid content.",
				"2) Downloading any unsolicited material, such as attachments, photos or documents, even from familiar sources.",
				"3) Accepting or allowing a pop-up notification without reading the message or understanding the content.",
				"4) Failing to read the user agreement when downloading legitimate applications or software.",
				"5) Failing to stay current with updates and patches for browsers, the OS, applications and software.",
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__TROJAN_BEHAVIOR_01
	tidbit.name = "Trojan -- Behavior"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__trojan_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best Practices to Prevent Trojan Horse Attacks?"),
		"",
		"Some of the most common ways for devices to become infected with Trojans can be linked to user behavior, such as:",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) Never click unsolicited links or download unexpected attachments.",
				"2) Use strong, unique passwords for all online accounts, as well as devices.",
				"3) Only access URLs that begin with HTTPS.",
				"4) Log into your account through a new browser tab or official app — not a link from an email or text.",
				"5) Use a password manager, which will automatically enter a saved password into a recognized site (but not a spoofed site).",
				"6) Use a spam filter to prevent a majority of spoofed emails from reaching your inbox.",
				"7) Enable two-way authentication whenever possible, which makes it far more difficult for attackers to exploit.",
				"8) Ensure updates for software programs and the OS are completed immediately.",
				"9) Backup files regularly to help restore the computer in the event of an attack."
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__TROJAN_PRACTICES_01
	tidbit.name = "Trojan -- Practices"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


###############


func _construct_tidbit__worm_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Trojan Horse?"),
		"",
		"A Trojan Horse (Trojan) is a type of malware that disguises itself as legitimate code or software. Once inside the network, attackers can carry out any action that a legitimate user could perform, such as exporting files, modifying data, deleting files or otherwise altering the contents of the device. Trojans may be packaged in downloads for games, tools, apps or even software patches. Many Trojan attacks also leverage social engineering tactics, as well as spoofing and phishing, to prompt the desired action in the user.",
		"",
		"[b]Common Types of Trojan Horse Malware[/b]",
		PlainTextFragment.get_text__indented(PlainTextFragment.get_text__as_unordered_list([
			"[b]Exploit Trojan[/b] - As the name implies, these Trojans identify and exploit vulnerabilities within software applications in order to gain access to the system.",
			"[b]Downloader Trojan[/b] - This type of malware typically targets infected devices and installs a new version of a malicious program onto the device.",
			"[b]Backdoor Trojan[/b] - The attacker uses the malware to set up access points to the network.",
		], false)),
		
	])
	
	tidbit.id = TidbitId.CYDE__TROJAN_BACKGROUND_01
	tidbit.name = "Trojan -- Background"
	tidbit.atlased_image = load("res://GeneralGUIRelated/AlmanacGUI/Assets/TidbitPage_RightSide/Icons/TidbitIcon_Orange12.png")  #todo
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


