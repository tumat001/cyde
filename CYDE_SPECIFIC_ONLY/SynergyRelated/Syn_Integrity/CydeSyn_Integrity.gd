extends "res://GameInfoRelated/ColorSynergyRelated/AbstractGameElementsModifyingSynergyEffect.gd"


const CydeSyn_Integ_OnReachedOffsetEffect = preload("res://GameInfoRelated/EnemyEffectRelated/MiscEffects/SynergySourced/CydeSyn_Integ_OnReachedOffsetEffect.gd")

#

const tier_3_block_enemy_count : int = 4
var _current_block_enemy_count : int

const tier_2_shield_inc_per_round : float = 4.0

const tier_1_knockback_trigger_unit_offset : float = 0.90

#

var game_elements : GameElements
var curr_tier : int

func _apply_syn_to_game_elements(arg_game_elements : GameElements, tier : int):
	if game_elements == null:
		game_elements = arg_game_elements
	curr_tier = tier
	
	if !game_elements.stage_round_manager.is_connected("round_ended", self, "_on_round_ended"):
		game_elements.stage_round_manager.connect("round_ended", self, "_on_round_ended", [], CONNECT_PERSIST)
	game_elements.stage_round_manager.connect("round_started", self, "_on_round_started", [], CONNECT_PERSIST)
	
	if curr_tier <= 3:
		_activate_block_first_x_enemies()
	
	if curr_tier <= 2:
		_activate_shield_regen_at_round_end()
	
	if curr_tier <= 1:
		_activate_knock_back_on_offset()
	
	


func _remove_syn_from_game_elements(game_elements : GameElements, tier : int):
	curr_tier = 0
	
	if game_elements.stage_round_manager.is_connected("round_ended", self, "_on_round_ended"):
		game_elements.stage_round_manager.disconnect("round_ended", self, "_on_round_ended")
		game_elements.stage_round_manager.disconnect("round_started", self, "_on_round_started")
	
	_deactivate_block_first_x_enemies()
	_deactivate_shield_regen_at_round_end()
	_deactivate_knock_back_on_offset()
	
	._remove_syn_from_game_elements(game_elements, tier)

####

func _on_round_ended(arg_stageround):
	_current_block_enemy_count = tier_3_block_enemy_count
	

func _on_round_started(arg_stageround):
	_current_block_enemy_count = tier_3_block_enemy_count
	



#####

func _activate_block_first_x_enemies():
	if !game_elements.enemy_manager.is_connected("before_enemy_escape", self, "_before_enemy_escape"):
		game_elements.enemy_manager.connect("before_enemy_escape", self, "_before_enemy_escape", [], CONNECT_PERSIST)
	

func _deactivate_block_first_x_enemies():
	if game_elements.enemy_manager.is_connected("before_enemy_escape", self, "_before_enemy_escape"):
		game_elements.enemy_manager.disconnect("before_enemy_escape", self, "_before_enemy_escape")
	 
	_current_block_enemy_count = 0


func _before_enemy_escape(arg_enemy):
	if _current_block_enemy_count > 0:
		_current_block_enemy_count -= 1
		
		arg_enemy.deal_damage_and_emit_escape_signals_when_escaping = false
		

###

func _activate_shield_regen_at_round_end():
	if !game_elements.stage_round_manager.is_connected("round_ended", self, "_on_round_ended__for_shield_regen"):
		game_elements.stage_round_manager.connect("round_ended", self, "_on_round_ended__for_shield_regen", [], CONNECT_PERSIST)
	

func _deactivate_shield_regen_at_round_end():
	if game_elements.stage_round_manager.is_connected("round_ended", self, "_on_round_ended__for_shield_regen"):
		game_elements.stage_round_manager.disconnect("round_ended", self, "_on_round_ended__for_shield_regen")
	

func _on_round_ended__for_shield_regen(arg_stageround):
	game_elements.health_manager.increase_health_by(tier_2_shield_inc_per_round, game_elements.HealthManager.IncreaseHealthSource.SYNERGY)

###

func _activate_knock_back_on_offset():
	if !game_elements.enemy_manager.is_connected("enemy_spawned", self, "_on_enemy_spawned__give_knockback_detect_effect"):
		game_elements.enemy_manager.connect("enemy_spawned", self, "_on_enemy_spawned__give_knockback_detect_effect")
	

func _deactivate_knock_back_on_offset():
	if game_elements.enemy_manager.is_connected("enemy_spawned", self, "_on_enemy_spawned__give_knockback_detect_effect"):
		game_elements.enemy_manager.disconnect("enemy_spawned", self, "_on_enemy_spawned__give_knockback_detect_effect")
	


func _on_enemy_spawned__give_knockback_detect_effect(arg_enemy):
	var effect = CydeSyn_Integ_OnReachedOffsetEffect.new()
	effect.unit_offset_for_knockback = tier_1_knockback_trigger_unit_offset
	
	arg_enemy._add_effect__use_provided_effect(effect)


