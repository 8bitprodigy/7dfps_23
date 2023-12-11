extends Resource
class_name WaypointConnectionData

@export_node_path("Waypoint3D") var WAYPOINT_0 : NodePath
var waypoint_0 : Waypoint3D:
	set(value):
		set_waypoint_0(value)
@export_node_path("Waypoint3D") var WAYPOINT_1 : NodePath
var waypoint_1 : Waypoint3D:
	set(value):
		set_waypoint_1(value)
var visualizer : ConnectionVisualizer3D = preload("res://addons/deformable_block_3D/connection_visualizer_3d.tscn").initialize()
var distance : float


func _init():
	pass

func deinit():
	visualizer.queue_free()

func set_waypoint_0(wp_0:Waypoint3D):
	waypoint_0 = wp_0
	visualizer._setup(waypoint_0.global_position,waypoint_1.global_position)


func set_waypoint_1(wp_1:Waypoint3D):
	waypoint_1 = wp_1
	visualizer._setup(waypoint_0.global_position,waypoint_1.global_position)
