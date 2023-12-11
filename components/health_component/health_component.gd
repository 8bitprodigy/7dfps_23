extends Node
class_name HealthComponent


@export var MAX_HEALTH : float = 1.0
@onready var health : float = MAX_HEALTH

signal changed
signal damaged
signal died
signal healed
signal healed_max

func damage(attack:AttackInfo):
	health -= attack.attack_damage
	emit_signal("damaged")
	emit_signal("changed")
	if health > 0: return
	emit_signal("died")
	get_parent().queue_free()

func heal(healing:float):
	health += healing
	emit_signal("healed")
	emit_signal("changed")
	if health <= MAX_HEALTH: return
	emit_signal("healed_max")
	health = MAX_HEALTH
