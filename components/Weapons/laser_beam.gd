extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_position(start: Vector3, end: Vector3, up: Vector3):
	var center = start + end / 2
	var height = start.distance_to(end)
	$LaserBeam.MeshInstance3D.mesh.height = height
	global_position = center
