@tool
extends Marker3D
class_name Waypoint3D



func _enter_tree():
	add_to_group("waypoints")


func _ready():
	pass#emit_signal("connect", connections)


# Creating a connection in-editor
func _connect(connect_to:Waypoint3D):
	pass#emit_signal("add_connection", self, connect_to)
