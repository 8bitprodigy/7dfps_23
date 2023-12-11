extends Area3D
class_name HitboxComponent

var health_component : HealthComponent

func _ready():
	var parent : Node = get_parent()
	if !parent.has_node("HealthComponent"): return
	var hlth_cmpnt : Node = parent.get_node("HealthComponent")
	if !(hlth_cmpnt is HealthComponent): return
	health_component = hlth_cmpnt
	

func damage(attack:AttackInfo):
	if !health_component: return
	health_component.damage(attack)
