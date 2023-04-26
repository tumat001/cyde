extends "res://EnemyRelated/AbstractEnemy.gd"

const TowerDetectingRangeModule_Scene = preload("res://EnemyRelated/TowerInteractingRelated/TowerInteractingModules/TowerDetectingRangeModule.tscn")
const TowerDetectingRangeModule = preload("res://EnemyRelated/TowerInteractingRelated/TowerInteractingModules/TowerDetectingRangeModule.gd")
const ExplosionParticle_Scene = preload("res://EnemyRelated/CommonParticles/ExplosionParticle/ExplosionParticle.tscn")

const Wizard_Beam_Scene = preload("res://EnemyRelated/CommonParticles/Wizard_Beam/Wizard_Beam.tscn")
const TowerStunEffect = preload("res://GameInfoRelated/TowerEffectRelated/TowerStunEffect.gd")



var beam_explosion_interval_timer : Timer
const _beam_explosion_interval_delay : float = 0.25
const _base_beam_explosion_count : int = 3
var _current_beam_count_left : int
var _current_target_for_beam

#

const _base_range : float = 140.0

const _explosion_dmg : float = 0.0
const _explosion_modulate : Color = Color(0.25, 0, 1, 1)

var _targeting_for_explosion : int = Targeting.RANDOM

var tower_detecting_range_module : TowerDetectingRangeModule

####

var gold_reduc_count__normal : int = 2

var tower_stun_count : int = 1
var tower_stun_count__no_gold : int = 2
var tower_stun_duration : float = 8.0

var _ability_timer : Timer


##########

func _init():
	_stats_initialize(EnemyConstants.get_enemy_info(EnemyConstants.Enemies.AMALGAMATION_RANSKIT))


func _ready():
	beam_explosion_interval_timer = Timer.new()
	beam_explosion_interval_timer.connect("timeout", self, "_on_beam_explosion_interval_timer_timeout")
	beam_explosion_interval_timer.one_shot = false
	add_child(beam_explosion_interval_timer)
	
	tower_detecting_range_module = TowerDetectingRangeModule_Scene.instance()
	tower_detecting_range_module.can_display_range = false
	tower_detecting_range_module.detection_range = _base_range
	
	add_child(tower_detecting_range_module)
	
	
	_construct_and_start_ability_timer()
	

###

func _construct_and_start_ability_timer():
	_ability_timer = Timer.new()
	_ability_timer.one_shot = false
	add_child(_ability_timer)
	_ability_timer.connect("timeout", self, "_ability_timer_expired")
	
	_ability_timer.start(8)


func _ability_timer_expired():
	var count : int = 0
	
	if game_elements.gold_manager.current_gold >= gold_reduc_count__normal:
		count = tower_stun_count
		game_elements.gold_manager.decrease_gold_by(gold_reduc_count__normal, game_elements.gold_manager.DecreaseGoldSource.SYNERGY)
	else:
		count = tower_stun_count__no_gold
		game_elements.gold_manager.decrease_gold_by(gold_reduc_count__normal, game_elements.gold_manager.DecreaseGoldSource.SYNERGY)
	
	#
	
	_target_tower_with_beams()


func _target_tower_with_beams():
	var targets = tower_detecting_range_module.get_all_in_map_and_active_towers_in_range()
	
	if targets.size() != 0:
		var valid_targets = Targeting.enemies_to_target(targets, _targeting_for_explosion, 1, global_position)
		
		if valid_targets.size() > 0:
			_current_beam_count_left = _base_beam_explosion_count
			_current_target_for_beam = valid_targets[0]
			_consume_beam_charge_for_summon_beam_to_target(_current_target_for_beam)
			beam_explosion_interval_timer.start(_beam_explosion_interval_delay)
	


func _summon_beam_to_target(target, final_potency : float):
	if is_instance_valid(target):
		var beam = Wizard_Beam_Scene.instance()
		beam.connect("time_visible_is_over", self, "_summon_explosion_to_target", [target, final_potency], CONNECT_ONESHOT)
		
		beam.time_visible = 0.15
		beam.frames.set_animation_speed("default", 8 / 0.15)
		beam.visible = true
		beam.global_position = global_position
		beam.frame = 0
		beam.modulate = _explosion_modulate
		
		CommsForBetweenScenes.ge_add_child_to_other_node_hoster(beam)
		beam.update_destination_position(target.global_position)


func _summon_explosion_to_target(target, final_potency):
	if is_instance_valid(target):
		#target.take_damage(final_potency * _explosion_dmg, self)
		_create_and_show_expl_particle(target.global_position)
		
		var stun_effect = TowerStunEffect.new(tower_stun_duration, StoreOfTowerEffectsUUID.ARTILLERY_STUN_EFFECT)
		stun_effect.is_from_enemy = true
		
		target.add_tower_effect(stun_effect)


func _create_and_show_expl_particle(pos):
	var particle = ExplosionParticle_Scene.instance()
	particle.position = pos
	particle.modulate = _explosion_modulate
	particle.scale *= 1.5
	
	CommsForBetweenScenes.deferred_ge_add_child_to_other_node_hoster(particle)

#

func _on_beam_explosion_interval_timer_timeout():
	_consume_beam_charge_for_summon_beam_to_target(_current_target_for_beam)


func _consume_beam_charge_for_summon_beam_to_target(arg_tower):
	if _current_beam_count_left > 0:
		if !is_instance_valid(_current_target_for_beam) or _current_target_for_beam.is_queued_for_deletion():
			var targets = tower_detecting_range_module.get_all_in_map_and_active_towers_in_range()
			var valid_targets = Targeting.enemies_to_target(targets, _targeting_for_explosion, 1, global_position)
			if valid_targets.size() > 0:
				_current_target_for_beam = valid_targets[0]
		
		#
		
		_summon_beam_to_target(arg_tower, 1)
		
		_current_beam_count_left -= 1
		
	else:
		beam_explosion_interval_timer.stop()

