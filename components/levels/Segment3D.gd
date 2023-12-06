extends Node
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

@export var connections : Array[WaypointConnectionData]
@export var walls       : Array[Wall]
@export var vertices    : Array[SegmentVertex3D]
@export var center      : WayPoint3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
