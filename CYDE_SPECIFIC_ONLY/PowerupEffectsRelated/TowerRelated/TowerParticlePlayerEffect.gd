extends "res://GameInfoRelated/TowerEffectRelated/BaseTowerModifyingEffect.gd"

signal before_particle_is_shown(arg_particle)
signal copy_is_created(arg_effect)

const CommonAttackSpriteTemplater = preload("res://MiscRelated/AttackSpriteRelated/CommonTemplates/CommonAttackSpriteTemplater.gd")


## IF adding more vars, add to get_copy_scaled_by()

var particle_pool_component

var particle_show_delta : float = 0.4

var non_essential_rng : RandomNumberGenerator

var apply_common_attack_sprite_template_float_slow : bool = true

#

var _particle_timer : Timer

var _effects_applied : bool

var _tower


###########

func _init(arg_effect_uuid).(arg_effect_uuid):
	pass



func _make_modifications_to_tower(tower):
	_tower = tower
	
	if !_effects_applied:
		_effects_applied = true
		
		_construct_and_add_particle_timer()
		
		_particle_timer.start(particle_show_delta)

func _construct_and_add_particle_timer():
	_particle_timer = Timer.new()
	_particle_timer.one_shot = false
	_particle_timer.connect("timeout", self, "_on_particle_timer_timeout", [], CONNECT_PERSIST)
	_tower.add_child(_particle_timer)

#

func _on_particle_timer_timeout():
	var particle = particle_pool_component.get_or_create_attack_sprite_from_pool()
	
	if apply_common_attack_sprite_template_float_slow:
		CommonAttackSpriteTemplater.configure_properties_of_attk_sprite(particle, CommonAttackSpriteTemplater.TemplateIDs.COMMON_UPWARD_DECELERATING_PARTICLE)
		particle.position = _tower.global_position
		var tower_half_size : Vector2 = _tower.get_current_anim_size() / 2.0
		particle.position.x += non_essential_rng.randi_range(-tower_half_size.x, tower_half_size.x)
		particle.position.y += non_essential_rng.randi_range(-8, 5)
		
		particle.modulate.a = 0.8
	
	emit_signal("before_particle_is_shown", particle)
	particle.visible = true
	

########

func _get_copy_scaled_by(arg_scale):
	var copy = get_script().new(effect_uuid)
	_configure_copy_to_match_self(copy)
	
	copy.particle_pool_component = particle_pool_component
	copy.particle_show_delta = particle_show_delta
	copy.non_essential_rng = non_essential_rng
	copy.apply_common_attack_sprite_template_float_slow = apply_common_attack_sprite_template_float_slow
	
	emit_signal("copy_is_created", copy)
	
	return copy


