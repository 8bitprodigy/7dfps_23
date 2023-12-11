extends Node3D

class_name weapon_base

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var hitscan_range : float = 100000
@export var projectile_type : PackedScene = null

@export var shots_per_second : float = 5
@onready var refactory_time : float = 1/shots_per_second

var shot_timer : float = 0

var is_firing : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shot_timer < refactory_time: shot_timer += delta
	elif is_firing: _handle_fire()
	
	pass

func _start_fire():
	is_firing = true
	_handle_fire()
	pass

func _stop_fire():
	is_firing = false
	pass

func _handle_fire():
	shot_timer = 0
	
	if projectile_type != null:
		prints("Should fire projectile")
		#instantiate and fire projectile
	else:
		var hit_dict = fire_hitscan(transform.basis.z)
		for hit in hit_dict:
			prints("hit " + hit)
	pass

func fire_hitscan(direction: Vector3 = Vector3(0,0,0)) -> Dictionary:
	var space = get_world_3d().direct_space_state
	
	#if no direction is given, use transform Z as forward
	if direction == Vector3(0,0,0): 
		direction = transform.basis.z
	
	var origin = transform.origin
	var end = origin + direction.normalized() * hitscan_range
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)	
	var hit = space.intersect_ray(query)
		
	return hit
