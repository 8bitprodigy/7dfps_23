@tool
extends Node
class_name SpatialNavigationServer


var astar : AStar3D
var waypoints           : Array[Node]
var old_connections     : Array[WaypointConnectionData]
@export var connections : Array[WaypointConnectionData]:
	set(value):
		prints("Connection: ", value)
		connections = value
		if connections.size() > old_connections.size():
			#stuff here
			return
		elif connections.size() < old_connections.size():
			#stuff here
			return
		

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.is_editor_hint(): return
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_connection():
	pass


func remove_connection():
	pass


func build_connections():
	if !get_tree().has_group("waypoints"): return
	waypoints = get_tree().get_nodes_in_group("waypoints")
	for waypoint in waypoints:#range(0,waypoints.size()-1):
		astar.add_point(waypoint.get_instance_id(), waypoint.global_position)
	for connection in connections:
		astar.connect_points(
			connection.waypoint_0.get_instance_id(),
			connection.waypoint_1.get_instance_id()
			)
