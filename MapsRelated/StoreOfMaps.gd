extends Node

const BaseMap = preload("res://MapsRelated/BaseMap.gd")
const MapTypeInformation = preload("res://MapsRelated/MapTypeInformation.gd")

const Map_Glade_PreviewImage = preload("res://MapsRelated/MapList/Map_Glade/Glade_PreviewImage.png")

const Map_WIP_PreviewImage = preload("res://MapsRelated/MapList/TestMap/Map_WIP_ImagePreview.png")

#

const SynTD_HeaderIDName = "SynTD_"

const MapsId_Glade = "%s%s" % [SynTD_HeaderIDName, "Glade"]

const MapsId_Riverside = "%s%s" % [SynTD_HeaderIDName, "Riverside"]
const MapsId_Ridged = "%s%s" % [SynTD_HeaderIDName, "Ridged"]
const MapsId_Mesa = "%s%s" % [SynTD_HeaderIDName, "Mesa"]
const MapsId_Passage = "%s%s" % [SynTD_HeaderIDName, "Passage"]
const MapsId_Enchant = "%s%s" % [SynTD_HeaderIDName, "Enchant"]

#

const Cyde_HeaderIDName = "Cyde_"

const MapsId_World01 = "%s%s" % [Cyde_HeaderIDName, "World01"]
const MapsId_World02 = "%s%s" % [Cyde_HeaderIDName, "World02"]
const MapsId_World03 = "%s%s" % [Cyde_HeaderIDName, "World03"]
const MapsId_World04 = "%s%s" % [Cyde_HeaderIDName, "World04"]
const MapsId_World05 = "%s%s" % [Cyde_HeaderIDName, "World05"]
const MapsId_World06 = "%s%s" % [Cyde_HeaderIDName, "World06"]
const MapsId_World07 = "%s%s" % [Cyde_HeaderIDName, "World07"]
const MapsId_World08 = "%s%s" % [Cyde_HeaderIDName, "World08"]
const MapsId_World09 = "%s%s" % [Cyde_HeaderIDName, "World09"]
const MapsId_World10 = "%s%s" % [Cyde_HeaderIDName, "World10"]


#######

const all_syn_td_map_ids : Array = [
#	MapsId_Glade,
	MapsId_Riverside,
#	MapsId_Ridged,
#	MapsId_Mesa,
#	MapsId_Passage,
#	MapsId_Enchant,
	
	#####################
	
	MapsId_World01,
	MapsId_World02,
	MapsId_World03,
	MapsId_World04,
	MapsId_World05,
	MapsId_World06,
	MapsId_World07,
	MapsId_World08,
	MapsId_World09,
	MapsId_World10,
	
	
]

#

#enum MapsIds {
#	GLADE = -10,
#	# -1 is reserved.
#
#	RIVERSIDE = 0,
#	RIDGED = 1,
#	MESA = 2,
#	PASSAGE = 3,
#	ENCHANT = 4,
#}

# Maps appear at the order specified here. First in array is first in list.
const MapIdsAvailableFromMenu : Array = [
	#MapsIds.GLADE, # completely remove this soon
	MapsId_Riverside,
	
	#MapsId_Ridged,
	#MapsId_Mesa,  #todo enable again if FOV algo is improved/changed.
	
	#MapsId_Enchant,
	
	#MapsId_Passage,
	
	###########
	
	MapsId_World01,
	MapsId_World02,
	MapsId_World03,
	MapsId_World04,
	MapsId_World05,
	MapsId_World06,
	MapsId_World07,
	MapsId_World08,
	MapsId_World09,
	MapsId_World10,
	
]

# Can be used as the official list of all maps
const map_id_to_map_name_dict : Dictionary = {}
const map_name_to_map_id_dict : Dictionary = {}

const map_id_to_map_scene_name_dict : Dictionary = {}
const map_id_to__map_type_info_func_source_and_name : Dictionary = {}

#

var default_map_id_for_empty setget ,get_default_map_id_for_empty

#

func get_default_map_id_for_empty():
	if MapIdsAvailableFromMenu.size() > 0:
		return MapIdsAvailableFromMenu[0]
	else:
		return null

#

func _init():
	var world_id__01 = MapsId_World01
	add_map(world_id__01, "World 01",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_01",
			MapIdsAvailableFromMenu.has(world_id__01))
	
	var world_id__02 = MapsId_World02
	add_map(world_id__02, "World 02",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_02",
			MapIdsAvailableFromMenu.has(world_id__02))
	
	var world_id__03 = MapsId_World03
	add_map(world_id__03, "World 03",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_03",
			MapIdsAvailableFromMenu.has(world_id__03))
	
	var world_id__04 = MapsId_World04
	add_map(world_id__04, "World 04",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_04",
			MapIdsAvailableFromMenu.has(world_id__04))
	
	var world_id__05 = MapsId_World05
	add_map(world_id__05, "World 05",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_05",
			MapIdsAvailableFromMenu.has(world_id__05))
	
	var world_id__06 = MapsId_World06
	add_map(world_id__06, "World 06",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_06",
			MapIdsAvailableFromMenu.has(world_id__06))
	
	var world_id__07 = MapsId_World07
	add_map(world_id__07, "World 07",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_07",
			MapIdsAvailableFromMenu.has(world_id__07))
	
	var world_id__08 = MapsId_World08
	add_map(world_id__08, "World 08",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_08",
			MapIdsAvailableFromMenu.has(world_id__08))
	
	var world_id__09 = MapsId_World09
	add_map(world_id__09, "World 09",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_09",
			MapIdsAvailableFromMenu.has(world_id__09))
	
	var world_id__10 = MapsId_World10
	add_map(world_id__10, "World 10",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn", #todo
			self,
			"_construct_map_type_info__map_world_10",
			MapIdsAvailableFromMenu.has(world_id__10))
	
	
	
	
#	var glade_id = MapsId_Glade
#	add_map(glade_id, "Glade",
#			"res://MapsRelated/MapList/Map_Glade/Map_Glade.tscn",
#			self,
#			"_construct_map_type_info__map_glade",
#			MapIdsAvailableFromMenu.has(glade_id))
#
#	##
	var riverside_id = MapsId_Riverside
	add_map(riverside_id, "Riverside",
			"res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn",
			self,
			"_construct_map_type_info__map_riverside",
			MapIdsAvailableFromMenu.has(riverside_id))
#
#	##
#	var ridged_id = MapsId_Ridged
#	add_map(ridged_id, "Ridged",
#			"res://MapsRelated/MapList/Map_Ridged/Map_Ridged.tscn",
#			self,
#			"_construct_map_type_info__map_ridged",
#			MapIdsAvailableFromMenu.has(ridged_id))
#
#	##
#	var mesa_id = MapsId_Mesa
#	add_map(mesa_id, "Mesa",
#			"res://MapsRelated/MapList/Map_Mesa/Map_Mesa.tscn",
#			self,
#			"_construct_map_type_info__map_mesa",
#			MapIdsAvailableFromMenu.has(mesa_id))
#
#	##
#	var passage_id = MapsId_Passage
#	add_map(passage_id, "Passage",
#			"res://MapsRelated/MapList/Map_Passage/Map_Passage.tscn",
#			self,
#			"_construct_map_type_info__map_passage",
#			MapIdsAvailableFromMenu.has(passage_id))
#
#	##
#	var enchant_id = MapsId_Enchant
#	add_map(enchant_id, "Enchant",
#			"res://MapsRelated/MapList/Map_Enchant/Map_Enchant.tscn",
#			self,
#			"_construct_map_type_info__map_enchant",
#			MapIdsAvailableFromMenu.has(enchant_id))
	

func _on_singleton_initialize():
	pass


#

static func get_map_from_map_id(id):
	if map_id_to_map_scene_name_dict.has(id):
		return load(map_id_to_map_scene_name_dict[id])
	else:
		return load(map_id_to_map_scene_name_dict[MapsId_Riverside])
	
#	if id == MapsId_Glade:
#		return load("res://MapsRelated/MapList/Map_Glade/Map_Glade.tscn")
#
#	elif id == MapsId_Riverside:
#		return load("res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn")
#
#	elif id == MapsId_Ridged:
#		return load("res://MapsRelated/MapList/Map_Ridged/Map_Ridged.tscn")
#
#	elif id == MapsId_Mesa:
#		return load("res://MapsRelated/MapList/Map_Mesa/Map_Mesa.tscn")
#
#	elif id == MapsId_Passage:
#		return load("res://MapsRelated/MapList/Map_Passage/Map_Passage.tscn")
#
#	elif id == MapsId_Enchant:
#		return load("res://MapsRelated/MapList/Map_Enchant/Map_Enchant.tscn")
#
#	else:
#		return load("res://MapsRelated/MapList/Map_Riverside/Map_Riverside.tscn")


static func get_map_type_information_from_id(id):
	
	if map_id_to__map_type_info_func_source_and_name.has(id):
		var info = MapTypeInformation.new()
		info.map_id = id
		
		var func_source_and_name = map_id_to__map_type_info_func_source_and_name[id]
		func_source_and_name[0].call(func_source_and_name[1], info)
		
		return info
		
	else:
		return null

#

func _construct_map_type_info__map_world_01(info : MapTypeInformation):
	info.map_name = "World 01"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 1
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_02(info : MapTypeInformation):
	info.map_name = "World 02"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 1
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_03(info : MapTypeInformation):
	info.map_name = "World 03"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 2
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_04(info : MapTypeInformation):
	info.map_name = "World 04"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 2
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_05(info : MapTypeInformation):
	info.map_name = "World 05"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 3
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_06(info : MapTypeInformation):
	info.map_name = "World 06"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 3
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_07(info : MapTypeInformation):
	info.map_name = "World 07"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 4
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_08(info : MapTypeInformation):
	info.map_name = "World 08"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 4
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_09(info : MapTypeInformation):
	info.map_name = "World 09"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 5
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_world_10(info : MapTypeInformation):
	info.map_name = "World 10"  #name todo
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 5
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info


###

func _construct_map_type_info__map_glade(info : MapTypeInformation):
	info.map_name = "Glade"
	info.map_display_texture = Map_Glade_PreviewImage
	info.map_tier = 1
	#info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	return info

func _construct_map_type_info__map_riverside(info : MapTypeInformation):
	info.map_name = "Riverside"
	info.map_display_texture = preload("res://MapsRelated/MapList/Map_Riverside/Map_Riverside_PreviewImage.png")
	info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	info.map_tier = 1
	return info

func _construct_map_type_info__map_ridged(info : MapTypeInformation):
	info.map_name = "Ridged"
	info.map_display_texture = preload("res://MapsRelated/MapList/Map_Ridged/Map_Ridged_ImagePreview.png")
	info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	info.map_tier = 2
	return info

func _construct_map_type_info__map_mesa(info : MapTypeInformation):
	info.map_name = "Mesa"
	info.map_display_texture = Map_WIP_PreviewImage #todo
	info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	info.map_tier = 3
	return info

func _construct_map_type_info__map_passage(info : MapTypeInformation):
	info.map_name = "Passage"
	info.map_display_texture = preload("res://MapsRelated/MapList/Map_Passage/Map_Passage_PreviewImage.png")
	info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	info.map_tier = 4
	return info

func _construct_map_type_info__map_enchant(info : MapTypeInformation):
	info.map_name = "Enchant"
	info.map_display_texture = preload("res://MapsRelated/MapList/Map_Enchant/Map_Enchant_PreviewImage.png")
	info.game_mode_ids_accessible_from_menu = [StoreOfGameMode.Mode.STANDARD_BEGINNER, StoreOfGameMode.Mode.STANDARD_EASY, StoreOfGameMode.Mode.STANDARD_NORMAL]
	info.map_tier = 3
	return info

######

# must be done ON PreGameModifiers (BreakpointActivation.BEFORE_SINGLETONS_INIT). Not at any other time
func add_map(arg_map_id, arg_map_name, arg_scene_name, arg_map_type_info_func_source, arg_map_type_info_func_name, is_available_from_menu : bool):
	map_id_to_map_name_dict[arg_map_id] = arg_map_name
	map_name_to_map_id_dict[arg_map_name] = arg_map_id
	
	map_id_to_map_scene_name_dict[arg_map_id] = arg_scene_name
	map_id_to__map_type_info_func_source_and_name[arg_map_id] = [arg_map_type_info_func_source, arg_map_type_info_func_name]
	
	set_map_is_available_from_menu(arg_map_id, is_available_from_menu)

# must be done ON PreGameModifiers (BreakpointActivation.BEFORE_SINGLETONS_INIT). Not at any other time
func set_map_is_available_from_menu(arg_map_id, arg_is_available):
	if arg_is_available and !MapIdsAvailableFromMenu.has(arg_map_id):
		MapIdsAvailableFromMenu.append(arg_map_id)
	elif !arg_is_available and MapIdsAvailableFromMenu.has(arg_map_id):
		MapIdsAvailableFromMenu.remove(arg_map_id)
	

