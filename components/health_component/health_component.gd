extends Node
class_name HealthComponent


@export var MAX_HEALTH : float = 1.0
@onready var health : float = MAX_HEALTH
var previous_health : float = health

signal changed
signal damaged
signal died
signal revived
signal healed
signal healed_max

func damage(attack:AttackInfo):
	health -= attack.attack_damage
	emit_signal("damaged")
	emit_signal("changed")
	prints(get_parent(), " took damage!")
	if health > 0: return
	emit_signal("died")
	get_parent().active = false
	get_parent().hide()

func heal(healing:float):
	health += healing
	emit_signal("healed")
	emit_signal("changed")
	prints(get_parent(), " received health!")
	if health < MAX_HEALTH: return
	emit_signal("healed_max")
	health = MAX_HEALTH


func revive(revive_health:float = MAX_HEALTH):
	if previous_health > 0: return
	heal(revive_health)
	emit_signal("revived")
	get_parent().active = true
	get_parent().show()
	
