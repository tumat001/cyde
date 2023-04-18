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
	
	CYDE__ADWARE_BACKGROUND_01 = 400
	CYDE__ADWARE_BEHAVIOR_01 = 401
	CYDE__ADWARE_PRACTICES_01 = 402
	
	CYDE__RANSOMWARE_BACKGROUND_01 = 500
	CYDE__RANSOMWARE_BEHAVIOR_01 = 501
	CYDE__RANSOMWARE_PRACTICES_01 = 502
	
	CYDE__SPYWARE_BACKGROUND_01 = 600
	CYDE__SPYWARE_BEHAVIOR_01 = 601
	CYDE__SPYWARE_PRACTICES_01 = 602
	
	CYDE__ROOTKIT_BACKGROUND_01 = 700
	CYDE__ROOTKIT_BEHAVIOR_01 = 701
	CYDE__ROOTKIT_PRACTICES_01 = 702
	
	CYDE__FILELESS_BACKGROUND_01 = 800
	CYDE__FILELESS_BEHAVIOR_01 = 801
	CYDE__FILELESS_PRACTICES_01 = 802
	
	CYDE__MALBOTS_BACKGROUND_01 = 900
	CYDE__MALBOTS_BEHAVIOR_01 = 901
	CYDE__MALBOTS_PRACTICES_01 = 902
	
	CYDE__MOBILE_MALWARE_BACKGROUND_01 = 1000
	CYDE__MOBILE_MALWARE_BEHAVIOR_01 = 1001
	CYDE__MOBILE_MALWARE_PRACTICES_01 = 1002
	
	
	LETTER_01 = 1100
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
	
	
	LETTERS = 20,
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
	
	TidbitCategory.LETTERS : "Others",
	
}

const tidbit_id_to_category_id_map : Dictionary = {
	TidbitId.CYDE__VIRUS_BACKGROUND_01 : TidbitCategory.VIRUS,
	TidbitId.CYDE__VIRUS_BEHAVIOR_01 : TidbitCategory.VIRUS,
	TidbitId.CYDE__VIRUS_PRACTICES_01 : TidbitCategory.VIRUS,
	
	#
	TidbitId.CYDE__TROJAN_BACKGROUND_01 : TidbitCategory.TROJAN,
	TidbitId.CYDE__TROJAN_BEHAVIOR_01 : TidbitCategory.TROJAN,
	TidbitId.CYDE__TROJAN_PRACTICES_01 : TidbitCategory.TROJAN,
	
	#
	TidbitId.CYDE__WORM_BACKGROUND_01 : TidbitCategory.WORM,
	TidbitId.CYDE__WORM_BEHAVIOR_01 : TidbitCategory.WORM,
	TidbitId.CYDE__WORM_PRACTICES_01 : TidbitCategory.WORM,
	
	#
	TidbitId.CYDE__ADWARE_BACKGROUND_01 : TidbitCategory.ADWARE,
	TidbitId.CYDE__ADWARE_BEHAVIOR_01 : TidbitCategory.ADWARE,
	TidbitId.CYDE__ADWARE_PRACTICES_01 : TidbitCategory.ADWARE,
	
	#
	TidbitId.CYDE__RANSOMWARE_BACKGROUND_01 : TidbitCategory.RANSOMWARE,
	TidbitId.CYDE__RANSOMWARE_BEHAVIOR_01 : TidbitCategory.RANSOMWARE,
	TidbitId.CYDE__RANSOMWARE_PRACTICES_01 : TidbitCategory.RANSOMWARE,
	
	#
	TidbitId.CYDE__SPYWARE_BACKGROUND_01 : TidbitCategory.SPYWARE,
	TidbitId.CYDE__SPYWARE_BEHAVIOR_01 : TidbitCategory.SPYWARE,
	TidbitId.CYDE__SPYWARE_PRACTICES_01 : TidbitCategory.SPYWARE,
	
	#
	TidbitId.CYDE__ROOTKIT_BACKGROUND_01 : TidbitCategory.ROOTKIT,
	TidbitId.CYDE__ROOTKIT_BEHAVIOR_01 : TidbitCategory.ROOTKIT,
	TidbitId.CYDE__ROOTKIT_PRACTICES_01 : TidbitCategory.ROOTKIT,
	
	#
	TidbitId.CYDE__FILELESS_BACKGROUND_01 : TidbitCategory.FILELESS,
	TidbitId.CYDE__FILELESS_BEHAVIOR_01 : TidbitCategory.FILELESS,
	TidbitId.CYDE__FILELESS_PRACTICES_01 : TidbitCategory.FILELESS,
	
	#
	TidbitId.CYDE__MALBOTS_BACKGROUND_01 : TidbitCategory.MALWARE_BOTS,
	TidbitId.CYDE__MALBOTS_BEHAVIOR_01 : TidbitCategory.MALWARE_BOTS,
	TidbitId.CYDE__MALBOTS_PRACTICES_01 : TidbitCategory.MALWARE_BOTS,
	
	#
	TidbitId.CYDE__MOBILE_MALWARE_BACKGROUND_01 : TidbitCategory.MOBILE_MALWARE,
	TidbitId.CYDE__MOBILE_MALWARE_BEHAVIOR_01 : TidbitCategory.MOBILE_MALWARE,
	TidbitId.CYDE__MOBILE_MALWARE_PRACTICES_01 : TidbitCategory.MOBILE_MALWARE,
	
	
	####
	
	TidbitId.LETTER_01 : TidbitCategory.LETTERS,
	
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
	
	# WORM
	
	_construct_tidbit__worm_background_01()
	_construct_tidbit__worm_behavior_01()
	_construct_tidbit__worm_practices_01()
	
	# ADWARE
	
	_construct_tidbit__adware_background_01()
	_construct_tidbit__adware_behavior_01()
	_construct_tidbit__adware_practices_01()
	
	# RANSOMWARE
	
	_construct_tidbit__ransomware_background_01()
	_construct_tidbit__ransomware_behavior_01()
	_construct_tidbit__ransomware_practices_01()
	
	# SPYWARE
	
	_construct_tidbit__spyware_background_01()
	_construct_tidbit__spyware_behavior_01()
	_construct_tidbit__spyware_practices_01()
	
	# ROOTKITS
	
	_construct_tidbit__rootkit_background_01()
	_construct_tidbit__rootkit_behavior_01()
	_construct_tidbit__rootkit_practices_01()
	
	# FILELESS
	
	_construct_tidbit__fileless_background_01()
	_construct_tidbit__fileless_behavior_01()
	_construct_tidbit__fileless_practices_01()
	
	# MALBOTS
	
	_construct_tidbit__malbots_background_01()
	_construct_tidbit__malbots_behavior_01()
	_construct_tidbit__malbots_practices_01()
	
	# MOBILE MALWARE
	
	_construct_tidbit__mobile_malware_background_01()
	_construct_tidbit__mobile_malware_behavior_01()
	_construct_tidbit__mobile_malware_practices_01()
	
	
	
	# OTHERS
	
	_construct_tidbit__letter_01()
	
	
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
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
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


###############


func _construct_tidbit__worm_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Computer Worms?"),
		"",
		"A computer worm is a type of malware whose primary function is to self-replicate and infect other computers while remaining active on infected systems. It often does this by exploiting parts of an operating system that are automatic and invisible to the user.",
		"",
		"On November 2, 1988, a computer science student at Cornell University named Robert Morris released the first worm onto the Internet from the Massachusetts Institute of Technology. The worm was an experimental self-propagating and replicating computer program that took advantage of flaws in certain e-mail protocols. Because of a mistake in its programming, rather than just sending copies of itself to other computers, this software kept replicating itself on each infected system, which had brought some 6,000 computers (one-tenth of the Internet) to a halt.",
		
	])
	
	tidbit.id = TidbitId.CYDE__WORM_BACKGROUND_01
	tidbit.name = "Worm -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__worm_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Computer Worms Infect Devices:"),
		"",
		"As a type of malware, computer worms can do various harmful things to your devices. Some simply self-replicate to the point that they eat up storage disk space and system memory, rendering your device unusable. Others modify or delete files, or even install additional malicious programs. And because computer worms can spread like wildfire, hackers may design them to install backdoor programs, giving cybercriminals access to their target’s devices.",
		"",
		"Computer worms can cause damage to end users like us, too. Depending on its payload – the code that carries out the malware’s mission – worms can change or delete our files, lock us out of important folders, or cause performance issues for our devices. Some hackers even use worms to steal data, which can lead to identity theft. That is why it is crucial to protect ourselves against computer worms."
	])
	
	tidbit.id = TidbitId.CYDE__WORM_BEHAVIOR_01
	tidbit.name = "Worm -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__worm_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best Practices to Prevent Computer Worms:"),
		"",
		"When it comes to computer worms, prevention is the best cure. Here are a few tips on how to protect yourself from computer worms:",
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Be cautious when opening email attachments or links[/b] - It’s best practice to not open an email link or attachment from an unknown sender. It could be a phishing scam or an email blast designed to spread malware.",
				"2) [b]Don’t click on pop-up ads while you’re browsing[/b] - Computer worms may inject adware into legitimate websites to force their way into devices. A common adware example is an ad that says you’ve won something, or that your computer or device has a virus.",
				"3) [b]Use a VPN when torrenting[/b] - Avoid using peer-to-peer platforms to download files from unknown sources, but if you really must torrent something, use a VPN.",
				"4) [b]Update software regularly[/b] - Keep your operating system and programs up to date to remove software vulnerabilities. If possible, enable automatic updates.",
				"5) [b]Update your passwords[/b] - Do not use default passwords on anything, especially your router configuration, as some worms use default credentials to infect various devices.",
				"6) [b]Protect your files[/b] - Encrypt important files to protect sensitive data on your devices and to keep them safe in case of malware infections."
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__WORM_PRACTICES_01
	tidbit.name = "Worm -- Practice"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit

#####


func _construct_tidbit__adware_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Adware?"),
		"",
		"Adware, or advertising supported software, is software that displays unwanted advertisements on your computer. Adware programs will tend to serve you pop-up ads, can change your browser’s homepage, add spyware and just bombard your device with advertisements.",
		"",
		"Adware uses the browser to collect your web browsing history in order to ’target’ advertisements that seem tailored to your interests. At their most innocuous, adware infections are just annoying. For example, adware barrages you with pop-up ads that can make your Internet experience markedly slower and more labor intensive. The most common reason for adware is to collect information about you for the purpose of making advertising dollars. Adware is likely going to slow down your machine and or even make it more prone to crashing.",
		
	])
	
	tidbit.id = TidbitId.CYDE__ADWARE_BACKGROUND_01
	tidbit.name = "Adware -- Background"
	tidbit.atlased_image =  preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__adware_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Adware Infects Devices?"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Slow computer[/b] - Adware can slow down your device’s processor and take up lots of memory space, therefore causing a decrease in your computer’s overall performance.",
				"2) [b]Bombarded with Ads[/b] - If you are bombarded with pop-ups, get ads that seem difficult to close, or are redirected to full page ads, then your device may be infected with adware.",
				"3) [b]Constant crashing[/b] - Your programs are randomly crashing and your entire device is freezing up. These symptoms are a red flag for adware.",
				"4) [b]Browser homepage changes[/b] - Adware is also known for making changes to your browser’s home page. It may redirect you to a new page that might then install more adware and possibly other forms of malware on your computer.",
				"5) [b]Slow Internet connection[/b] - Adware can slow down your internet connection because it is downloading massive amounts of ads from the internet.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__ADWARE_BEHAVIOR_01
	tidbit.name = "Adware -- Behavior"
	tidbit.atlased_image =  preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__adware_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best practices to prevent adware:"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Use a trusted ad blocker[/b] - An ad blocker will prevent ads as you surf the web, which can eliminate drive-by downloads from infected websites.",
				"2) [b]Don’t click on ads that seem too good to be true[/b] - Any ads offering you a free iPhone, or something else that seems dazzlingly great, is most likely a scam.",
				"3) [b]Ignore fake warnings[/b] - Likewise, big flashing pop-ups with lots of exclamation points that warn of a virus are almost certainly fake.",
				"4) [b]Avoid shady websites[/b] - Make sure to avoid illegitimate websites, especially if you’re doing any online shopping.",
				"5) [b]Adjust your browser’s privacy settings[/b] - Depending on which browser you use, you should be able to prevent third parties from installing things like toolbars without your consent.",
				"6) [b]Use strong antivirus software[/b] - Even if you follow all of these tips, some stubborn malware can still find a way through. A robust antivirus program is your best line of defense, preventing any malicious software from getting through.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__ADWARE_PRACTICES_01
	tidbit.name = "Adware -- Practices"
	tidbit.atlased_image =  preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit

#########


func _construct_tidbit__ransomware_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Ransomware?"),
		"",
		"Ransomware is a type of malicious software that gains access to files or systems and blocks user access to those files or systems. Then, all files, or even entire devices, are held hostage using encryption until the victim pays a ransom in exchange for a decryption key. The key allows the user to access the files or systems encrypted by the program. Ransomware can be traced back to 1989 when the “AIDS virus” was used to extort funds from recipients of the ransomware. Payments for that attack were made by mail to Panama, at which point a decryption key was also mailed back to the user."
	])
	
	tidbit.id = TidbitId.CYDE__RANSOMWARE_BACKGROUND_01
	tidbit.name = "Ransomware -- Background"
	tidbit.atlased_image =  preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__ransomware_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Ransomware Works?"),
		"",
		"In order to be successful, ransomware needs to gain access to a target system, encrypt the files there, and demand a ransom from the victim. While the implementation details vary from one ransomware variant to another, all share the same core three stages:",
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Stage 1: Infection and Distribution Vectors Ransomware[/b] - Ransomware operators tend to prefer a few specific infection vectors. One of these is phishing emails. If the email recipient falls for the phish, then the ransomware is downloaded and executed on their computer.",
				"2) [b]Stage 2: Data Encryption[/b] - After ransomware has gained access to a system, it can begin encrypting its files. Since encryption functionality is built into an operating system, this simply involves accessing files, encrypting them with an attacker-controlled key, and replacing the originals with the encrypted versions.",
				"3) [b]Stage 3: Ransom Demand[/b] - Once file encryption is complete, the ransomware is prepared to make a ransom demand. If the ransom is paid, the ransomware operator will either provide a copy of the private key used to protect the symmetric encryption key or a copy of the symmetric encryption key itself.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__RANSOMWARE_BEHAVIOR_01
	tidbit.name = "Ransomware -- Behavior"
	tidbit.atlased_image =  preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__ransomware_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best Practices to Prevent Ransomware Attacks:"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Frequent, Tested Backups[/b] - Backing up every vital file and system is one of the strongest defenses against ransomware. All data can be restored to a previous save point.",
				"2) [b]Structured, Regular Updates[/b] - Most software used by businesses is regularly updated by the software creator. These updates can include patches to make the software more secure against known threats.",
				"3) [b]Sensible Restrictions[/b] - Certain limitations should be placed on employees and contractors who:",
				PlainTextFragment.get_text__indented(
					PlainTextFragment.get_text__as_unordered_list([
						"- Work with devices that contain company files, records and/or programs.",
						"- Use devices attached to company networks that could be made vulnerable.",
						"- Are third-party or temporary workers."
					])
				),
				"4) [b]Proper Credential Tracking[/b] - Any employee, contractor, and person who is given access to systems create a potential vulnerability point for ransomware. Turnover, failure to update passwords, and improper restrictions can result in even higher probabilities of attack at these points.",
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__RANSOMWARE_PRACTICES_01
	tidbit.name = "Ransomware -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


#############


func _construct_tidbit__spyware_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the malware: What is spyware?"),
		"",
		"Spyware is a form of malware that hides on your device, monitors your activity, and steals  sensitive information like bank details and passwords. Spyware is a kind of malware that secretly gathers information about a person or organization and relays this data to other parties. It is actually one of the most common threats on the internet today. It can easily infiltrate your device and, because of its covert nature, it can be hard to detect.",
		"",
		"The first use of the term “spyware” appeared was in 1995 in a Usenet article that targeted Microsoft’s Business Model. In early 2000, the founder of Zone Labs, Gregor Freund, used the term “Spyware” in a press release for the ZoneAlarm Personal Firewall. This marked the beginning and acceptance of the “spyware” term.",
		
	])
	
	tidbit.id = TidbitId.CYDE__SPYWARE_BACKGROUND_01
	tidbit.name = "Spyware -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__spyware_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Spyware Infects devices?"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Infiltrates your device[/b] - This could happen when you visit a malicious website, unwittingly install a malicious app, or even open a file attachment.",
				"2) [b]Captures your data[/b] - Once the spyware is on your  device, it begins to collect data, which could be anything from your web activity to screen captures or even your keystrokes.",
				"3) [b]Provides data to a third party[/b] - The captured data is then supplied to the spyware creator, where it is either used directly or sold to third parties.",
				
				#PlainTextFragment.get_text__as_ordered_list([
				#	"[b]Infiltrates your device[/b] - This could happen when you visit a malicious website, unwittingly install a malicious app, or even open a file attachment.",
				#	"[b]Captures your data[/b] - Once the spyware is on your  device, it begins to collect data, which could be anything from your web activity to screen captures or even your keystrokes.",
				#	"[b]Provides data to a third party[/b] - The captured data is then supplied to the spyware creator, where it is either used directly or sold to third parties.",
				#]),
				
				"The data collected through spyware may include things like:",
				PlainTextFragment.get_text__indented(
					PlainTextFragment.get_text__as_unordered_list([
						"- Web browsing history",
						"- Keyboard strokes",
						"- Email address Login credentials (usernames and passwords)",
						"- Credit card details and account PINs"
					])
				),
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__SPYWARE_BEHAVIOR_01
	tidbit.name = "Spyware -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit




func _construct_tidbit__spyware_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best practices to prevent spyware attacks:"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Use an anti-spyware scanner[/b] - Most packages provide ongoing anti-spyware protection against the real-time installation of new spyware by scanning incoming traffic and blocking any potential threats.",
				"2) [b]Adjust browser security settings[/b] - Most browsers allow you to adjust their security levels along a scale from “high” to “low.” Get to know these options, as some browsers can function like a firewall against unwanted operations.",
				"3) [b]Be very wary of pop-ups[/b] - Ads and offers displayed in pop-up windows, especially those that appear unexpectedly, often mask deceptive purposes. Never click \"agree\" or \"OK\" to close a window; instead click the red \"x\" in the corner of the window to close.",
				"4) [b]Understand that \"free\" is never \"free.\"[/b] - In most cases with free apps, you implicitly agree to trade tracking for services. You “pay” for the app by agreeing to receive targeted ads.",
				"5) [b]Always read terms & conditions[/b] - Most users don’t even bother to read them. If you are particularly adamant about protecting your online privacy, it’s best to know exactly what you are signing up for.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__SPYWARE_PRACTICES_01
	tidbit.name = "Spyware -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



#############

func _construct_tidbit__rootkit_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is a rootkit?"),
		"",
		"A rootkit is one of the most difficult types of malware to find and remove. It is a highly sophisticated type of malware that provides the creator (usually an attacker) with a backdoor into systems. This gives the creator admin-level remote access and control over a computer system or network.  Attackers frequently use them to remotely control your computer, eavesdrop on your network communication, or execute botnet attacks.",
		"",
		"First appearing in the 1990s, rootkits initially targeted Linux systems. The word “root” refers to the admin or superuser, who, by default, has access to all files and commands on a Unix/Linux system. “Kit” is the software that grants access.",
		
	])
	
	tidbit.id = TidbitId.CYDE__ROOTKIT_BACKGROUND_01
	tidbit.name = "Rootkit -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__rootkit_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Rootkits infect devices?"),
		"",
		"Since rootkits cannot spread by themselves, they depend on clandestine methods to infect computers. When unsuspecting users give rootkit installer programs permission to be installed on their systems, the rootkits install and conceal themselves until hackers activate them. Rootkits contain malicious tools, including banking credential stealers, password stealers, keyloggers, antivirus disablers and bots for distributed denial-of-service attacks.",
		"",
		"Rootkits are installed through the same common vectors as any malicious software, including by email phishing campaigns, executable malicious files, crafted malicious PDF files or Microsoft Word documents, connecting to shared drives that have been compromised or downloading software infected with the rootkit from risky websites.",
		
	])
	
	tidbit.id = TidbitId.CYDE__ROOTKIT_BEHAVIOR_01
	tidbit.name = "Rootkit -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__rootkit_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best practices to prevent rootkit attacks:"),
		"",
		"Rootkit attacks are dangerous and harmful, but they only infect your computer if you somehow launched the malicious software that carries the rootkit. The tips below outline the basic steps you should follow to prevent rootkit infection.",
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Scan your systems[/b] - Scanners are software programs aimed to analyze a system to get rid of active rootkits. Rootkit scanners are usually effective in detecting and removing application rootkits.",
				"2) [b]Avoid phishing attempts[/b] - Phishing is a type of social engineering attack in which hackers use email to deceive users into clicking on a malicious link or downloading an infected attachment.",
				"3) [b]Update your software[/b] - Keep all programs and your operating system up-to-date, and you can avoid rootkit attacks that take advantage of vulnerabilities.",
				"4) [b]Monitor network traffic[/b] - Network traffic monitoring techniques analyze network packets in order to identify potentially malicious network traffic.",
				
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__ROOTKIT_PRACTICES_01
	tidbit.name = "Rootkit -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit

#####

func _construct_tidbit__fileless_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Fileless?"),
		"",
		"Fileless malware is a malicious technique that uses existing software, legitimate applications, operating system files and the authorized protocols of the victim’s machine to achieve their goals. Fileless malware leaves no footprint because it is not a file-based attack that requires the downloading of executable files on the infected system. Rather, this attack is memory-based, and this is why detecting it is a daunting task.",
		"",
		"The earliest known usage of fileless malware dates back to around 2001 with the emergence of a computer known as Code Red, which used a buffer overflow vulnerability in Microsoft Internet Information Services (IIS) to write commands to a server's working memory. No one knows who invented the concept of fileless malware. But it was first discovered and researched by eEye Digital Security employees Marc Maiffret and Ryan Permeh.",
	])
	
	tidbit.id = TidbitId.CYDE__FILELESS_BACKGROUND_01
	tidbit.name = "Fileless -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__fileless_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How  Fileless infect devices?"),
		"",
		"While not considered a traditional virus, fileless malware does work in a similar way—it operates in memory. Without being stored in a file or installed directly on a machine, fileless infections go straight into memory and the malicious content never touches the hard drive.",
		"",
		"Fileless threats leave no trace after execution, making it challenging to detect and remove. Fileless techniques allow attackers to access the system, thereby enabling subsequent malicious activities. By manipulating exploits, legitimate tools, macros, and scripts, attackers can compromise systems, elevate privileges, or spread laterally across the network.",
		
	])
	
	tidbit.id = TidbitId.CYDE__FILELESS_BEHAVIOR_01
	tidbit.name = "Fileless -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__fileless_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best practices to prevent Fileless:"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Don’t click on suspicious links[/b] - This fileless malware protection tip is both deceptively easy and difficult at the same time: “suspicious” links are becoming increasingly less suspicious-looking.",
				"2) [b]Keep your devices up-to-date[/b] - Always use the latest version of whatever operating system is available for your devices. Install all patches and updates when prompted.",
				"3) [b]Disable non-essential tools[/b] - If you’re on a Windows machine, you should disable PowerShell, Windows Management Instrumentation, and macros — unless these tools are vital to your organization’s operations because they’re the most vulnerable when it comes to fileless attacks.",
				"4) [b]Monitor your network’s traffic[/b] - You should monitor your network’s activity to see if there are sudden spikes in traffic for which your team can’t account.",
				"5) [b]Consider third-party solutions[/b] - Although antivirus programs aren’t very good at detecting or preventing fileless attacks, there are a growing number of third-party providers that claim to provide protection.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__FILELESS_PRACTICES_01
	tidbit.name = "Fileless -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


#######

func _construct_tidbit__malbots_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What are Malware Bots?"),
		"",
		"The name \"bots\" is short for internet robots, which are also known as spiders, web bots, and crawlers. Nowadays, bots are used for various different purposes. Most simply explained, a bot is an app that can perform a specific automated task. However, hackers realized the potential of bots a long time ago and started to use them for their own illegal purposes.",
		"",
		"Some bots are used as malware that can gain control of the infected device or devices. The reason why bots are so dangerous is that they can collect your data and passwords once installed on your device. All this information gets sent to the hacker’s device, which can lead to a series of issues.",
		
	])
	
	tidbit.id = TidbitId.CYDE__MALBOTS_BACKGROUND_01
	tidbit.name = "Malware Bots -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__malbots_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How Malware Bots Infect Devices?"),
		"",
		"Malware bots and internet bots can be programmed/hacked to break into user accounts, scan the internet for contact information, to send spam, or perform other harmful acts. To carry out these attacks and disguise the source of the attack traffic, attackers may distribute bad bots in a botnet – i.e., a bot network. A botnet is a number of internet-connected devices, each running one or more bots, often without the device owners’ knowledge. Because each device has its own IP address, botnet traffic comes from numerous IP addresses, making it harder to identify and block the source of the malicious bot traffic.",
		"",
		"If your computer is acting slower than usual and having trouble connecting to the internet, it could be a sign that something in the background is draining its power. Other signs that a device might be infected include system crashes out of nowhere and your computer settings getting changed on their own. If you notice any of these signs, chances are your device was infected by a malicious bot.",
		
	])
	
	tidbit.id = TidbitId.CYDE__MALBOTS_BEHAVIOR_01
	tidbit.name = "Malware Bots -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__malbots_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best Practices to Prevent Malware Bots Attacks:"),
		"",
		"It’s very possible to protect your computer from bots, but it takes diligence and knowing what to look for. Use the following tips to keep your computer safe:",
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) Install firewalls to block malicious attacks and never turn them off.",
				"2) Use a long and complicated password that contains numbers and symbols.",
				"3) Never use the same password for multiple programs.",
				"4) Install quality anti-malware software to protect your device. Ensure software is up to date, and never ignore system updates.",
				"5) Refrain from using flash drives, or thumb drives, in an infected computer.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__MALBOTS_PRACTICES_01
	tidbit.name = "Malware Bots -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


############

func _construct_tidbit__mobile_malware_background_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Background of the Malware: What is Mobile Malware?"),
		"",
		"Mobile malware is malicious software specifically designed to target mobile devices, such as smartphones and tablets, with the goal of gaining access to private data. Although mobile malware is not currently as pervasive as malware that attacks traditional workstations, it’s a growing threat because many companies now allow employees to access corporate networks using their personal devices, potentially bringing unknown threats into the environment.",
		"",
		"The first real worm, which spread from phone to phone, was the Cabir worm of 2004, which spread through Bluetooth on Nokia's Symbian devices. Spyware made its first appearance in 2007, and ransomware appeared the same year as its PC based counterpart with FakeDefender in 2013."
	])
	
	tidbit.id = TidbitId.CYDE__MOBILE_MALWARE_BACKGROUND_01
	tidbit.name = "Mobile Malware -- Background"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/information123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


func _construct_tidbit__mobile_malware_behavior_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Behavior of the Malware: How  Mobile Malware infects devices?"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) [b]Downloading infected apps[/b] - Malware can be hidden in apps available for download from app stores or third-party websites. When a user downloads and installs the app, malware is also installed on their device.",
				"2) [b]Visiting malicious websites[/b] - Malware can be delivered to a mobile device through a website designed to exploit vulnerabilities in the device’s web browser.",
				"3) [b]Opening malicious email attachments[/b] - Malware can be delivered through email attachments, such as PDF files or Word documents. The malware is installed on their device when a user opens the attachment.",
				"4) [b]Using infected USB drives[/b] - Malware can be spread through USB drives that are infected with the malware. When a user connects the USB drive to their device, the malware is transferred to the device.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__MOBILE_MALWARE_BEHAVIOR_01
	tidbit.name = "Mobile Malware -- Behavior"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/behavior123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit



func _construct_tidbit__mobile_malware_practices_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("Best practices to prevent mobile malware:"),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"1) Install apps from trusted sources only. Before downloading an app, research both the app and its publishers. Check other users’ reviews and ratings if available.",
				"2) Be cautious of links you receive in email and text messages that might trick you into installing apps from third party or unknown sources.",
				"3) Double-check shortened URLs and QR codes, they could lead to harmful websites or directly download malware to your device.",
				"4) Never save usernames and passwords in your mobile browser or apps.",
				"5) Don’t bank or shop online using public Wi-Fi connections.",
				"6) Keep your operating system and apps updated.",
				"7) Backup your data. By creating a backup for your smartphone or tablet, you can easily restore your personal data if the device is ever lost, stolen or damaged.",
				"8) Install a mobile security app. If available, use a mobile security solution that detects and prevents malware, spyware and malicious apps, alongside other privacy and anti-theft features.",
				
			])
		)
	])
	
	tidbit.id = TidbitId.CYDE__MOBILE_MALWARE_PRACTICES_01
	tidbit.name = "Mobile Malware -- Practices"
	tidbit.atlased_image = preload("res://CYDE_SPECIFIC_ONLY/TidbitRelated/Assets/practice123.png")
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


#######


func _construct_tidbit__letter_01():
	var tidbit = TextTidbitTypeInfo.new()
	
	
	tidbit.add_description([
		PlainTextFragment.get_text__with_center_BBCode("The secrets will be uncovered, the truth will come forth."),
		"",
		PlainTextFragment.get_text__indented(
			PlainTextFragment.get_text__as_unordered_list([
				"I'm writing to you today with a heavy heart, knowing that this letter will most likely surprise you. I will have died by the time you read this letter. It is difficult for me to write these words, but I want you to know the truth about what happened.",
				"",
				"I found out recently that someone is secretly planning my death. Knowing about it upset me, but knowing that it was someone I trusted, someone I treated not only as my one true friend but like a brother to me; it made me feel betrayed. But I cherish him so much that I couldn't stop him and just want to accept my fate. I know you have someone in mind right now, yes, it is Asi.",
				"",
				"I'm not asking you for vengeance, but I do want you to stop him and save my beloved land. Do everything in your power to restore peace. I believe you will do the right thing. I want you to know that I am always there for you and that you are the best thing that has ever happened to me. Take care of yourself, and know that I am always proud of you.",
				"",
				"",
				"With love, Dr. Kevin Murphy",
			])
		)
	])
	
	tidbit.id = TidbitId.LETTER_01
	tidbit.name = "Letter"
	tidbit.atlased_image #=  #todo 
	tidbit.tidbit_tier = 1
	
	tidbit_id_to_info_singleton_map[tidbit.id] = tidbit


