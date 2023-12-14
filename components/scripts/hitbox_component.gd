extends Area3D
class_name HitboxComponent

var health_component : HealthComponent
@export var shape    : Shape3D         = SphereShape3D.new()

func _ready():
	var parent : Node = get_parent()
	if !parent.has_node("HealthComponent"): return
	var hlth_cmpnt : Node = parent.get_node("HealthComponent")
	if !(hlth_cmpnt is HealthComponent): return
	health_component = hlth_cmpnt
	var new_collision_shape : CollisionShape3D = CollisionShape3D.new()
	new_collision_shape.shape = shape
	add_child(new_collision_shape)


func damage(attack:AttackInfo):
	if !health_component: return
	health_component.damage(attack)
