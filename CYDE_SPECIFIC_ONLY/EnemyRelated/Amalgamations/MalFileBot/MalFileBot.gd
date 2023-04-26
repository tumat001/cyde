extends "res://EnemyRelated/AbstractEnemy.gd"



const _invis_health_ratio_threshold : float = 0.5
const _invis_duration : float = 3.0
const _invis_premature_cancel_distance : float = 250.0

var invis_effect : EnemyInvisibilityEffect
var _is_invis : bool

var invis_ability : BaseAbility

#####

var _summon_timer : Timer

const summon_cd : float = 13.0
const summon_count : int = 9

##

var _in_between_summon_timer : Timer
const in_between_summon_cd : float = 0.25

var _current_summon_count : int = 0


var rng_to_use : RandomNumberGenerator

#######

func _init():
	_stats_initialize(EnemyConstants.get_enemy_info(EnemyConstants.Enemies.AMALGAMATION_MALFILEBOT))

#

func _post_inherit_ready():
	rng_to_use = StoreOfRNG.get_rng(StoreOfRNG.RNGSource.NON_ESSENTIAL)
	
	._post_inherit_ready()
	_construct_summon_relateds()
	_summon_timer.start(summon_cd)

func _construct_summon_relateds():
	_summon_timer = Timer.new()
	_summon_timer.one_shot = false
	add_child(_summon_timer)
	_summon_timer.connect("timeout", self, "_summon_timer_expired")
	
	_in_between_summon_timer = Timer.new()
	_in_between_summon_timer.one_shot = false
	add_child(_in_between_summon_timer)
	_in_between_summon_timer.connect("timeout", self, "_in_betweeen_summon_timer_expired")
	


func _summon_timer_expired():
	_current_summon_count = summon_count
	
	_in_between_summon_timer.start(in_between_summon_cd)
	

func _in_betweeen_summon_timer_expired():
	_current_summon_count -= 1
	
	_summon_tiny_enemy()
	
	if _current_summon_count == 0:
		_in_between_summon_timer.stop()


func _summon_tiny_enemy():
	var rand_additional_offset = rng_to_use.randf_range(-0.07, 0.07)
	var final_offset = rand_additional_offset + unit_offset
	if final_offset > 0.95:
		final_offset = 0.95
	
	var enemy_to_spawn = game_elements.enemy_manager.spawn_enemy(EnemyConstants.Enemies.AMALGAMATION_MALFILEBOT_SUMMON)
	enemy_to_spawn.shift_unit_offset(final_offset)
	
	

##############


func _ready():
	connect("on_current_health_changed", self, "_on_health_threshold_reached")
	
	_construct_effect_d()
	_construct_and_connect_ability()

func _construct_effect_d():
	invis_effect = EnemyInvisibilityEffect.new(_invis_duration, StoreOfEnemyEffectsUUID.ASSASSIN_INVIS_EFFECT)
	invis_effect.is_from_enemy = true

func _construct_and_connect_ability():
	invis_ability = BaseAbility.new()
	
	invis_ability.is_timebound = false
	
	register_ability(invis_ability)


#

func _on_health_threshold_reached(curr_health):
	if curr_health / _last_calculated_max_health <= _invis_health_ratio_threshold:
		disconnect("on_current_health_changed", self, "_on_health_threshold_reached")
		if distance_to_exit > 50:
			_become_invisible()


func _become_invisible():
	invis_ability.on_ability_before_cast_start(invis_ability.ON_ABILITY_CAST_NO_COOLDOWN)
	
	connect("effect_removed", self, "_on_invis_effect_removed")
	
	var effect = _add_effect(invis_effect._get_copy_scaled_by(invis_ability.get_potency_to_use(last_calculated_final_ability_potency)))
	
	if effect != null:
		_is_invis = true
	else:
		disconnect("effect_removed", self, "_on_invis_effect_removed")
	
	invis_ability.on_ability_after_cast_ended(invis_ability.ON_ABILITY_CAST_NO_COOLDOWN)


func _on_invis_effect_removed(effect_removed, me):
	if effect_removed.effect_uuid == StoreOfEnemyEffectsUUID.ASSASSIN_INVIS_EFFECT:
		_is_invis = false
		disconnect("effect_removed", self, "_on_invis_effect_removed")


#

func _physics_process(delta):
	if _is_invis and distance_to_exit <= 50:
		_remove_effect(invis_effect)

