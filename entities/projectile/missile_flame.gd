extends MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.z = randf()*TAU
