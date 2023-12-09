@tool
extends Marker3D
class_name Level3D

# Declare prototypes to instantiate
var segment_prototype  : PackedScene = preload("res://addons/deformable_block_3D/Segment_3D.tscn")
var vertex_prototype   : PackedScene = preload("res://addons/deformable_block_3D/segment_vertex_3d.tscn")
var waypoint_prototype : PackedScene = preload("res://addons/deformable_block_3D/waypoint_3d.tscn")
var side_prototype     : PackedScene = preload("res://addons/deformable_block_3D/wall_3D.tscn")

# Nodes to add those instantiations to as children
var segments_node  : Node = Node.new()
var vertices_node  : Node = Node.new()
var waypoints_node : Node = Node.new()
var sides_node     : Node = Node.new()

# Arrays to keep track of those instantiations for quick access.
@export var segments_array : Array[Segment3D]
@export var vertices_array : Array[SegmentVertex3D]
@export var waypoints_array: Array[Waypoint3D]
@export var sides_array    : Array[Wall3D]

enum {
	SEL_SEGMENT,
	SEL_VERTEX,
	SEL_WAYPOINT,
	SEL_side
}

var navigation       : AStar3D

@export var root_segment     : Segment3D
var selected_segment : Segment3D


# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	pass

func init():
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
	if !has_node("sides"):
		sides_node.name="sides"
		add_child(sides_node)
		sides_node.set_owner    (get_tree().edited_scene_root)
	
	if segments_array.size()  == 0:
		for segment_index in segments_node.get_children():
			segments_array.append(segment_index)
	if vertices_array.size()  == 0:
		for vertex_index in vertices_node.get_children():
			vertices_array.append(vertex_index)
	if waypoints_array.size() == 0:
		for waypoint_index in waypoints_node.get_children():
			waypoints_array.append(waypoint_index)
	if sides_array.size()     == 0:
		for side_index in sides_node.get_children():
			sides_array.append(side_index)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func insert_new_segment(segment:Segment3D=null, direction:Vector3=Vector3.ZERO):
	if !segment: # Placing starting segment
		add_vertices(Vector3.UP)
		add_vertices(Vector3.DOWN)
		var new_segment = segment_prototype.instantiate()
		new_segment.global_position = Vector3.ZERO
		add_segment(new_segment)
	pass


func add_segment(segment:Segment3D):
	segments_node.add_child(segment)
	segments_array.append(segment)
	selected_segment = segment


func add_vertices(direction:Vector3):
	var vertices = Array[SegmentVertex3D]


func add_vertex(vertex:SegmentVertex3D):
	segments_node.add_child(vertex)
	segments_array.append(vertex)


func add_waypoint(waypoint:Waypoint3D):
	waypoints_node.add_child(waypoint)
	waypoints_array.append(waypoint)


func add_side(side:Wall3D):
	sides_node.add_child(side)
	sides_array.append(side)
