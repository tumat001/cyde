extends "res://EnemyRelated/AbstractEnemy.gd"

func _init():
	_stats_initialize(EnemyConstants.get_enemy_info(EnemyConstants.Enemies.AMALGAMATION_ADWORM_DISTRACTION))
	
	blocks_from_round_ending = false


#

func _ready():
	modulate.a = 0
	
	visible = false

func start_show():
	var tweener = create_tween()
	tweener.tween_property(self, "modulate:a", 1, 0.4)
	
	visible = true
	

