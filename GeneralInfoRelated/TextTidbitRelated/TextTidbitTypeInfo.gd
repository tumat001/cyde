extends Reference


signal current_page_number__for_almanac_use_changed(arg_val)

#var descriptions : Array = []
#var simple_descriptions : Array = []

var name
var id

var atlased_image
var altased_images_list : Array

var tidbit_tier : int   # similar to tower tiers 1-6, with 6 being the best


# Note: both must have the same page count
var page_num_to_descriptions_map : Dictionary
var page_num_to_simple_descsriptions_map : Dictionary

var current_page_number__for_almanac_use : int = 1 setget set_current_page_number__for_almanac_use


func has_simple_description() -> bool:
	#return simple_descriptions != null and simple_descriptions.size() != 0
	return page_num_to_simple_descsriptions_map.size() != 0

func get_description__for_almanac_use():
	#return descriptions
	return page_num_to_descriptions_map[current_page_number__for_almanac_use]

func get_simple_description__for_almanac_use():
	#return simple_descriptions
	return page_num_to_simple_descsriptions_map[current_page_number__for_almanac_use]

func get_atlased_image_as_list__for_almanac_use():
	if altased_images_list.size() == 0:
		return [atlased_image]
	else:
		return altased_images_list

func get_altasted_image_list_size():
	return altased_images_list.size()

func get_name__for_almanac_use():
	return name

func get_id__for_almanac_use():
	return id
	


############

func add_description(arg_desc : Array, arg_simple_desc : Array = []):
	var page_num = get_total_page_count() + 1
	
	page_num_to_descriptions_map[page_num] = arg_desc
	
	if arg_simple_desc.size() == 0:
		page_num_to_simple_descsriptions_map[page_num] = arg_desc
	else:
		page_num_to_simple_descsriptions_map[page_num] = arg_simple_desc


func get_total_page_count():
	return page_num_to_descriptions_map.size()


#

func set_current_page_number__for_almanac_use(arg_val):
	current_page_number__for_almanac_use = arg_val
	
	emit_signal("current_page_number__for_almanac_use_changed", arg_val)



