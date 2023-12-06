extends Area3D
class_name Segment3D

enum {
	UP    = 0,
	DOWN  = 1,
	NORTH = 2,
	EAST  = 3,
	SOUTH = 4,
	WEST  = 5
}
enum {
	TOP_NE = 0,
	TOP_SE = 1,
	TOP_SW = 2,
	TOP_NW = 3,
	BOT_NE = 4,
	BOT_SE = 5,
	BOT_SW = 6,
	BOT_NW = 7
}

const EXTEND_DIRECTIONS: Dictionary = {
	UP    : [TOP_NE,TOP_SE,TOP_SW,TOP_NW],
	DOWN  : [BOT_NE,BOT_SE,BOT_SW,BOT_NW],
	NORTH : [TOP_NE,BOT_SE,BOT_SW,TOP_NW],
	EAST  : [TOP_SE,BOT_SE,BOT_NE,TOP_NE],
	SOUTH : [TOP_SW,BOT_SW,BOT_SE,TOP_SE],
	WEST  : [TOP_NW,BOT_NW,BOT_SW,TOP_SW]
}

const OPPOSITE_DIRECTIONS: Dictionary = {
	UP    : DOWN,
	DOWN  : UP,
	NORTH : SOUTH,
	SOUTH : NORTH,
	EAST  : WEST,
	WEST  : EAST
}

const DIRECTION_VECTORS: Dictionary = {
	UP    : Vector3.UP,
	DOWN  : Vector3.DOWN,
	NORTH : Vector3.FORWARD,
	EAST  : Vector3.RIGHT,
	SOUTH : Vector3.BACK,
	WEST  : Vector3.LEFT
}

const VECTOR_DIRECTIONS: Dictionary = {
	Vector3.UP      : UP,
	Vector3.DOWN    : DOWN,
	Vector3.FORWARD : NORTH,
	Vector3.RIGHT   : EAST,
	Vector3.BACK    : SOUTH,
	Vector3.LEFT    : WEST
}

const default_vertices: Array[Vector3] = [
	Vector3(1,1,-1),
	Vector3(1,1,1),
	Vector3(-1,1,1),
	Vector3(-1,1,-1),
	Vector3(1,-1,-1),
	Vector3(1,-1,1),
	Vector3(-1,-1,1),
	Vector3(-1,-1,-1)
]

@export var connections : Array[WaypointConnectionData]
@export var walls       : Array[Wall3D]
@export var vertices    : Array[SegmentVertex3D]
@export var center      : Waypoint3D
@export var entities    : Array

var collision_shape : CollisionShape3D = CollisionShape3D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func init(segment_vertices:Array[SegmentVertex3D]):
	if !segment_vertices.size() != 8:
		assert(false,"Failed to initialize Segment3D -- vertex array either too big or too small!")
	add_child(collision_shape)
	var new_shape : ConvexPolygonShape3D = ConvexPolygonShape3D.new()
	for vertex in segment_vertices:
		new_shape.points.append(vertex.global_position)
	collision_shape.set_shape(new_shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

