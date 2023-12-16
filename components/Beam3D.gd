@tool
extends Sprite3D
class_name Beam3D

const HALF_PI = PI/2

@export var               target_node  : Node3D
@export var               target_point : Vector3   = Vector3.FORWARD
var                       raycast      : RayCast3D = RayCast3D.new()
@export var               spin         : bool      = true
@export_range(1,1024) var frames       : int       = 1
@export var               use_frame    : bool      = false
@export_range(0,1023) var beam_frame   : int       = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(raycast)
	alpha_cut =SpriteBase3D.ALPHA_CUT_DISCARD
	axis = Vector3.AXIS_Y


func _physics_process(delta):
	flip_h = randi_range(0,1)
	flip_v = randi_range(0,1)
	region_rect.position.x = randi_range(0,2)*texture.get_size().x/4
	if use_frame:
		region_rect.position.x = beam_frame*texture.get_size().x/frames
	region_rect.position.y = randf()*texture.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_node:
		target_point = target_node.global_position
	
	var target_transform  : Transform3D = global_transform.affine_inverse()*Transform3D(Basis.IDENTITY,target_point)#target_point - global_position
	var real_target_point : Vector3     = target_transform.origin
	
	var length : float = real_target_point.length()/pixel_size
	region_rect.size.y = length
	
	look_at(target_point)
	if !spin: return
	rotation.z = randf()*TAU
