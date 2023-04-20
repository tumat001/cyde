extends TextureButton

signal on_final_location_reached(arg_final_pos)
signal on_pressed(arg_self)
signal exit_animation_finished()



var original_location : Vector2 setget set_original_location
var final_location : Vector2
var max_height : float

var speed  # the time it takes to reach final_location
var current_life_distance   # current timeline of speed from 0 to speed

var queue_free_on_animation_end : bool = false

var _midpoint : float
var _x_speed : float
var _y_speed : float

var _reached_final_location : bool = false

var _clicked_and_during_animation : bool = false


var lifetime : float

#

const glow_frequency : float = 2.5
const glow_min_val : float = 0.6
#const glow_min_mag : float = 0.0
const glow_mag_multiplier : float = 1 - glow_min_val

############

#func _ready():
#	set_original_location(Vector2(200, 00))
#	final_location = Vector2(250, 250)
#	speed = 0.75
#	max_height = 300
#
#	texture_normal = preload("res://CYDE_SPECIFIC_ONLY/TestTemp/Test_LetterNormal.png")
#	texture_hover = preload("res://CYDE_SPECIFIC_ONLY/TestTemp/Test_LetterGlow.png")
#
#	start_flight_to_final_location()

#

func set_original_location(arg_val):
	original_location = arg_val
	
	if is_inside_tree():
		rect_global_position = original_location
	else:
		rect_position = original_location

#

func start_flight_to_final_location():
	original_location = rect_global_position
	_x_speed = _calculate_constant_x_speed()
	_y_speed = _calculate_constant_y_speed()
	current_life_distance = speed
	_midpoint = speed / 2
	
	disabled = true
	
	_reached_final_location = false


func end_flight_to_final_location():
	_reached_final_location = true
	
	rect_global_position = final_location
	
	_x_speed = 0
	_y_speed = 0
	
	disabled = false
	
	
	emit_signal("on_final_location_reached", final_location)

# movement

func _calculate_constant_x_speed() -> float:
	var diff = final_location.x - original_location.x
	return diff / speed

func _calculate_constant_y_speed() -> float:
	var diff = final_location.y - original_location.y
	return diff / speed

func _calculate_current_y_speed(delta) -> float:
	return delta * ((max_height) * ((current_life_distance - _midpoint) / speed))

#func _calculate_scale():
#	# 0.5 -> 0 -> 0.5
#	var timebased_shrink = (0.25 + ((abs(current_life_distance - _midpoint) / speed) / 2))
#	# 1 -> 0.5 -> 1
#	var diff = 0.5 + timebased_shrink
#	# 0 -> 0.1 -> 0
#	var n = (diff - 1) / -5
#
#	# 
#	var heightbased_shrink = (1 - ((max_height / 1200) * n))
#
#	return (heightbased_shrink * diff)



#

func _process(delta):
	lifetime += delta
	
	if !_reached_final_location:
		_move(delta)
	
	if _reached_final_location and !_clicked_and_during_animation:
		_oscillate_self_glow()


func _move(delta):
	current_life_distance -= delta
	
	if current_life_distance <= 0:
		if !_reached_final_location:
			end_flight_to_final_location()
		
	else:
		var movement : Vector2 = Vector2(0, 0)
		var final_y_mov = _y_speed * delta
		final_y_mov -= _calculate_current_y_speed(delta)
		
		movement.y = final_y_mov
		movement.x = _x_speed * delta
		
		#var sc = _calculate_scale()
		#scale = Vector2(sc, sc)
		
		rect_global_position += movement


func _oscillate_self_glow():
	var mag = glow_min_val + (sin(lifetime * glow_frequency) * 0.5 * glow_mag_multiplier)
	
	modulate.r = mag
	modulate.g = mag
	modulate.b = mag
	

func _on_BasePickupable_pressed():
	_clicked_and_during_animation = true
	
	_start_fade_out_tween_transition()
	emit_signal("on_pressed", self)



func _start_fade_out_tween_transition():
	var tween = create_tween()
	tween.connect("finished", self, "_on_fade_out_tween_finished")
	tween.tween_property(self, "modulate:a", 0.0, 0.25)

func _on_fade_out_tween_finished():
	if queue_free_on_animation_end:
		queue_free()
	
	emit_signal("exit_animation_finished", self)
	


