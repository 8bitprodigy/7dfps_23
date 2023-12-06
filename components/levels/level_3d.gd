@tool
extends Marker3D
class_name Level3D

var segments_node  : Node = Node.new()
var vertices_node  : Node = Node.new()
var waypoints_node : Node = Node.new()
var walls_node     : Node = Node.new()

var segments_array : Array[Segment3D]
var vertices_array : Array[SegmentVertex3D]
var waypoints_array: Array[Waypoint3D]
var walls_array    : Array[Wall3D]

enum {
	SEL_SEGMENT,
	SEL_VERTEX,
	SEL_WAYPOINT,
	SEL_WALL
}

var selected_segment : Segment3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if !Engine.is_editor_hint(): return
	if !has_node("segments"):
		segments_node.name="segments"
		add_child(segments_node)
		segments_node.set_owner (get_tree().edited_scene_root)
	if !has_node("vertices"):
		vertices_node.name="vertices"
		add_child(vertices_node)
		vertices_node.set_owner (get_tree().edited_scene_root)
	if !has_node("waypoints"):
		waypoints_node.name="waypoints"
		add_child(waypoints_node)
		waypoints_node.set_owner(get_tree().edited_scene_root)
	if !has_node("walls"):
		walls_node.name="walls"
		add_child(walls_node)
		walls_node.set_owner    (get_tree().edited_scene_root)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_segment_vertex(vertex:SegmentVertex3D):
	segments_node.add_child(vertex)
	segments_array.append(vertex)


func add_wall(wall:Wall3D):
	walls_node.add_child(wall)
	walls_array.append(wall)


func add_segment(segment:Segment3D):
	segments_node.add_child(segment)
	segments_array.append(segment)


func add_waypoint(waypoint:Waypoint3D):
	waypoints_node.add_child(waypoint)
	waypoints_array.append(waypoint)
