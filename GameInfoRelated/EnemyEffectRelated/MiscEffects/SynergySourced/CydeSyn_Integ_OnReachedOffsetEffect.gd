extends "res://GameInfoRelated/EnemyEffectRelated/BaseEnemyModifyingEffect.gd"


const EnemyKnockUpEffect = preload("res://GameInfoRelated/EnemyEffectRelated/EnemyKnockUpEffect.gd")
const EnemyForcedPathOffsetMovementEffect = preload("res://GameInfoRelated/EnemyEffectRelated/EnemyForcedPathOffsetMovementEffect.gd")


#

var unit_offset_for_knockback : float

const knockup_accel : float = 30.0
const knockup_time : float = 0.6
const stun_duration : float = 1.5

const mov_speed : float = -90.0
const mov_speed_deceleration : float = -65.0

#

func _init().(StoreOfEnemyEffectsUUID.CYDE_INTEGRITY_ON_OFFSET_DETECTOR_EFFECT):
	pass


func _make_modifications_to_enemy(enemy):
	if !enemy.is_connected("moved__from_process", self, "_on_enemy_moved__from_process"):
		enemy.connect("moved__from_process", self, "_on_enemy_moved__from_process", [enemy])
	

func _undo_modifications_to_enemy(enemy):
	if enemy.is_connected("moved__from_process", self, "_on_enemy_moved__from_process"):
		enemy.disconnect("moved__from_process", self, "_on_enemy_moved__from_process")
	
	

#####

func _on_enemy_moved__from_process(arg_has_moved_from_natural_means, arg_prev_angle_dir, arg_curr_angle_dir, arg_enemy):
	print("enemy offset: %s, offset for knock: %s" % [arg_enemy.unit_offset, unit_offset_for_knockback])
	if arg_enemy.unit_offset >= unit_offset_for_knockback:
		_apply_knockback_effect(arg_enemy)
		
		if arg_enemy.is_connected("moved__from_process", self, "_on_enemy_moved__from_process"):
			arg_enemy.disconnect("moved__from_process", self, "_on_enemy_moved__from_process")
	

func _apply_knockback_effect(arg_enemy):
	var knockup_effect = EnemyKnockUpEffect.new(knockup_time, knockup_accel, StoreOfEnemyEffectsUUID.CYDE_INTEGRITY_ON_OFFSET_KNOCK_UP_EFFECT)
	knockup_effect.custom_stun_duration = stun_duration
	
	var forced_path_mov_effect = EnemyForcedPathOffsetMovementEffect.new(mov_speed, mov_speed_deceleration, StoreOfEnemyEffectsUUID.CYDE_INTEGRITY_ON_OFFSET_FORCED_MOV_EFFECT)
	forced_path_mov_effect.is_timebound = true
	forced_path_mov_effect.time_in_seconds = stun_duration
	
	
	arg_enemy._add_effect(knockup_effect)
	arg_enemy._add_effect(forced_path_mov_effect)

