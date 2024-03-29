extends "res://MiscRelated/AttackSpriteRelated/AttackSprite.gd"

const mod_a : float = 0.8
const tier_1_color := Color(0.4, 0.4, 0.4, mod_a)
const tier_2_color := Color(31/255.0, 227/255.0, 2/255.0, mod_a)
const tier_3_color := Color(2/255.0, 139/255.0, 218/255.0, mod_a)
const tier_4_color := Color(165/255.0, 78/255.0, 253/255.0, mod_a)
const tier_5_color := Color(253/255.0, 73/255.0, 76/255.0, mod_a)
const tier_6_color := Color(253/255.0, 207/255.0, 68/255.0, mod_a)

const tier_to_color_map : Dictionary = {
	1 : tier_1_color,
	2 : tier_2_color,
	3 : tier_3_color,
	4 : tier_4_color,
	5 : tier_5_color,
	6 : tier_6_color
}


var tier : int setget set_tier__to_set_particle_color

func set_tier__to_set_particle_color(arg_tier):
	tier = arg_tier
	modulate = tier_to_color_map[arg_tier]

#

func _ready():
	z_index = ZIndexStore.PARTICLE_EFFECTS_BELOW_TOWERS


