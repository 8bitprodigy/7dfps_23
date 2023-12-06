extends Marker3D
class_name Level3D

var segments : Node = Node.new()
var vertices : Node = Node.new()
var waypoints: Node = Node.new()
var walls    : Node = Node.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(segments)
	add_child(vertices)
	add_child(waypoints)
	add_child(walls)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_segment_vertex(vertex:SegmentVertex3D):
	pass


func add_wall(wall:Wall3D):
	pass


func add_segment(segment:Segment3D):
	pass


func add_waypoint(waypoint:Waypoint3D):
	pass
