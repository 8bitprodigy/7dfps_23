extends Area3D
class_name BasePickup

@export var radius : float = 0.125

func _ready():
	if has_node("CollisionShape3D"): return
	var new_collision_shape = CollisionShape3D.new()
	new_collision_shape.shape = SphereShape3D.new()
	new_collision_shape.connect("body_entered",_on_body_entered)
	add_child(new_collision_shape)

func _on_body_entered(body):
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
