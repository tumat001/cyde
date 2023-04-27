extends "res://EnemyRelated/AbstractEnemy.gd"

const base_health_regen_per_sec : float = 1.0

var heal_modi : FlatModifier
var heal_effect : EnemyHealEffect

var heal_modi_uuid : int
var _heal_timer : Timer

#var _distraction_timer : Timer

var rng_to_use : RandomNumberGenerator


#

var expert_faction_passive

const _shield_ratio : float = 25.0
const _shield_duration : float = 5.0
var shield_effect : EnemyShieldEffect

var _shield_timer : Timer
const _shield_cd : float = 16.0

#######

func _init():
	_stats_initialize(EnemyConstants.get_enemy_info(EnemyConstants.Enemies.AMALGAMATION_ADWORM))



func _post_inherit_ready():
	rng_to_use = StoreOfRNG.get_rng(StoreOfRNG.RNGSource.NON_ESSENTIAL)
	
	._post_inherit_ready()
	_construct_heal_related_effects()
	_heal_timer.start(1)
	
	_construct_shield_effect_and_relateds()
	
	#######
	
	#_construct_and_start_distraction_timer()
	

func _construct_heal_related_effects():
	heal_modi_uuid = StoreOfEnemyEffectsUUID.DEITY_HEALTH_REGEN_EFFECT
	heal_modi = FlatModifier.new(heal_modi_uuid)
	heal_modi.flat_modifier = base_health_regen_per_sec
	
	heal_effect = EnemyHealEffect.new(heal_modi, heal_modi_uuid)
	heal_effect.is_from_enemy = true
	
	_heal_timer = Timer.new()
	_heal_timer.one_shot = false
	add_child(_heal_timer)
	_heal_timer.connect("timeout", self, "_heal_timer_expired")
	
	

func _heal_timer_expired():
	_add_effect(heal_effect)


######

func _construct_shield_effect_and_relateds():
	var shield_modi : PercentModifier = PercentModifier.new(StoreOfEnemyEffectsUUID.ENCHANTRESS_SHIELD_EFFECT)
	shield_modi.percent_amount = _shield_ratio
	shield_modi.percent_based_on = PercentType.MISSING
	shield_modi.flat_minimum = 10.0
	shield_modi.flat_maximum = 9999999.0
	shield_modi.ignore_flat_limits = false
	
	shield_effect = EnemyShieldEffect.new(shield_modi, StoreOfEnemyEffectsUUID.ENCHANTRESS_SHIELD_EFFECT)
	shield_effect.time_in_seconds = _shield_duration
	shield_effect.is_timebound = true
	shield_effect.is_from_enemy = true
	
	
	_shield_timer = Timer.new()
	_shield_timer.one_shot = false
	add_child(_shield_timer)
	_shield_timer.connect("timeout", self, "_shield_timer_expired")
	
	_shield_timer.start(_shield_cd)

func _shield_timer_expired():
	# shield related
	var copy_of_shield_effect = shield_effect._get_copy_scaled_by(1)
	
	# do the bool check only for signal connects. dont put the "add_effect" method here.
	if !last_calculated_has_effect_shield_against_enemies:
		expert_faction_passive.connect_enemy_shielded_by_enchantress(self, copy_of_shield_effect)
	
	_add_effect__use_provided_effect(copy_of_shield_effect)
	


#
#func _construct_and_start_distraction_timer():
#	_distraction_timer = Timer.new()
#	_distraction_timer.one_shot = false
#	add_child(_distraction_timer)
#	_distraction_timer.connect("timeout", self, "_distraction_timer_expired")
#
#	_distraction_timer.start(7)
#
#
#func _distraction_timer_expired():
#	_summon_distraction()
#
#
#func _summon_distraction():
#	var enemy_to_spawn = game_elements.enemy_manager.spawn_enemy(EnemyConstants.Enemies.AMALGAMATION_ADWORM_DISTRACTION)
#	enemy_to_spawn.shift_unit_offset(unit_offset)
#
#
#	var rand_offset_01 = _generate_rand_num_from_30_to_60()
#	var rand_offset_02 = _generate_rand_num_from_30_to_60()
#	var rand_angle = _generate_rand_angle()
#	enemy_to_spawn.global_offset += Vector2(rand_offset_01, rand_offset_02).rotated(rand_angle)
#	enemy_to_spawn.start_show()
#
#func _generate_rand_num_from_30_to_60():
#	return rng_to_use.randi_range(30, 60)
#
#func _generate_rand_angle():
#	return rng_to_use.randf_range(0, 2*PI)
#
#
########

