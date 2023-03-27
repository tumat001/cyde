extends MarginContainer

# NOT CONTINUED DUE TO SIZE ISSUES


onready var spin_box = $MarginContainer/SpinBox

######


func set_num_value(arg_val : int):
	spin_box.value = arg_val

func get_num_value() -> int:
	return spin_box.value
