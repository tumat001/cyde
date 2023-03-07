extends "res://MapsRelated/BaseMap.gd"


const DialogSegment = preload("res://MiscRelated/DialogRelated/DataClasses/DialogSegment.gd")
const DialogDescsPanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogDescsPanel/DialogDescsPanel.gd")
const DialogDescsPanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogDescsPanel/DialogDescsPanel.tscn")
const DialogTextInputPanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogTextInputPanel/DialogTextInputPanel.gd")
const DialogTextInputPanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogTextInputPanel/DialogTextInputPanel.tscn")
const DialogChoicesPanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogChoicesPanel/DialogChoicesPanel.gd")
const DialogChoicesPanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogChoicesPanel/DialogChoicesPanel.tscn")
const DialogTimeBarPanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogTimeBarPanel/DialogTimeBarPanel.gd")
const DialogTimeBarPanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogTimeBarPanel/DialogTimeBarPanel.tscn")
const DialogChoicesModiPanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogChoicesModiPanel/DialogChoicesModiPanel.gd")
const DialogImagePanel = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogImagePanel/DialogImagePanel.gd")
const DialogImagePanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogElementControls/DialogImagePanel/DialogImagePanel.tscn")

const BackDialogImagePanel = preload("res://MiscRelated/DialogRelated/Controls/DialogBackgroundElementsControls/BackDialogImagePanel/BackDialogImagePanel.gd")
const BackDialogImagePanel_Scene = preload("res://MiscRelated/DialogRelated/Controls/DialogBackgroundElementsControls/BackDialogImagePanel/BackDialogImagePanel.tscn")

const TextFragmentInterpreter = preload("res://MiscRelated/TextInterpreterRelated/TextFragmentInterpreter.gd")
const NumericalTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/NumericalTextFragment.gd")
const TowerStatTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/TowerStatTextFragment.gd")
const OutcomeTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/OutcomeTextFragment.gd")
const PlainTextFragment = preload("res://MiscRelated/TextInterpreterRelated/TextFragments/PlainTextFragment.gd")



const NO_MAP_ID_TO_UNLOCK : int = -9769

var _map_id_to_make_available_when_completed

func _init(arg_map_id_to_make_available_when_completed):
	_map_id_to_make_available_when_completed = arg_map_id_to_make_available_when_completed
	

func _record_next_map_id_to_be_available_in_map_selection_panel():
	StatsManager.unlock_map_id(_map_id_to_make_available_when_completed)
	


