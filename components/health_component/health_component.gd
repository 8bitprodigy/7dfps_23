extends Node
class_name HealthComponent


@export var MAX_HEALTH : float = 1.0
@onready var health : float = MAX_HEALTH

signal damaged
signal died
signal healed
signal healed_max

func damage(attack:AttackInfo):
	health -= attack.attack_damage
	emit_signal("damaged")
	if health <= 0:
		emit_signal("died")
		get_parent().queue_free()

func heal(healing:float):
	health += healing
	emit_signal("healed")
	if health > MAX_HEALTH:
		emit_signal("healed_max")
		health = MAX_HEALTH
