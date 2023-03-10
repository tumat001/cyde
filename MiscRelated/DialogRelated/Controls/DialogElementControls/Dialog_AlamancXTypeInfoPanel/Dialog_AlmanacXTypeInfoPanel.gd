extends "res://MiscRelated/DialogRelated/Controls/DialogElementControls/BaseDialogElementControl.gd"


onready var almanac_x_type_info_panel = $Almanac_XTypeInfoPanel


# NOTE: Made to work with only TIDBITs so far.
var x_type_info   # setget set_x_type_info
var x_type

#######


#func set_x_type_info__as_tidbit(arg_info):
#	_x_type_info = arg_info
#	_x_type = AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT
#
#	if is_inside_tree():
#		almanac_x_type_info_panel.set_properties(_x_type_info, AlmanacManager.tidbit_multi_stats_data)


func _ready():
	if x_type_info != null:
		if x_type == AlmanacManager.Almanac_ItemListEntry_Data.TypeInfoClassification.TEXT_TIDBIT:
			almanac_x_type_info_panel.set_properties(x_type_info, AlmanacManager.tidbit_multi_stats_data)
		

