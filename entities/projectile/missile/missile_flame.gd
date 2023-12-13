@tool
extends MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation.z = randf()*TAU
