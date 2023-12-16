extends Node3D

class_name weapon_base

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var hitscan_range : float = 100000
@export var projectile_type : PackedScene = preload("res://entities/projectile/projectile.tscn")

# < 1 = full auto, 1 = single shot, x = x-round burst
@export var burst_mode : int = 0
@onready var burst_counter : int = burst_mode

@export var is_projectile_weapon : bool = true

@export var shots_per_second : float = 5
@onready var refactory_time : float = 1/shots_per_second

#how long between last shot and start of next burst
@export var burst_cooldown : float = 0
@onready var burst_timer : float = burst_cooldown

@onready var shot_timer : float = refactory_time

var is_firing : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if can_fire() && is_firing: 
		if burst_counter == 0: burst_counter = burst_mode
		_handle_fire()
	
	burst_timer += delta
	shot_timer += delta

func start_fire():
	is_firing = true
	pass

func stop_fire():
	is_firing = false
	burst_counter = 0
	pass

func can_fire():
	return  shot_timer >= refactory_time && (
		( burst_mode <= 0 ) || #full-auto fire mode, disregard burst
		( burst_mode > 0 && burst_counter > 0) || #burst fire mode, and still have burst shot(s) left
		( burst_mode > 0 && burst_counter <= 0 && burst_timer >= burst_cooldown )  #burst mode, out of shots, but burst can be reset
	)

func _handle_fire():
	shot_timer = 0
	burst_timer = 0
	burst_counter -= 1
	
	if projectile_type != null:
		fire_projectile(transform.basis.z)
	else:
		var hit: Dictionary = fire_hitscan()
		if !hit.is_empty(): _on_hitscan_hit(hit)

func fire_hitscan(direction: Vector3 = Vector3(0,0,0)) -> Dictionary:
	var space = get_world_3d().direct_space_state
	
	# if no direction is given, use transform Z as forward
	if direction == Vector3(0,0,0): 
		direction = -get_owning_controller().basis.z
	
	var origin = global_position
	var end = origin + direction.normalized() * hitscan_range
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)	
	
	query.hit_from_inside = false
	
	var hit = space.intersect_ray(query)
		
	return hit
	
func fire_projectile(direction: Vector3 = Vector3(0,0,0)):
	# if no direction is given, use transform Z as forward
	if direction == Vector3(0,0,0): 
		direction = transform.basis.z
	
	var new_projectile = projectile_type.instantiate()
	get_tree().root.add_child(new_projectile)
	new_projectile.add_exception(get_owning_controller())
	new_projectile.spawn_from_weapon(self)

func _on_hitscan_hit(hit_dict: Dictionary):
	# DICTIONARY CONTENTS:
		#collider: The colliding object
		#collider_id: The colliding object's ID
		#normal: The object's surface normal at the intersection point, or Vector3(0, 0, 0) if the ray starts inside the shape and PhysicsRayQueryParameters3D.hit_from_inside is true.
		#position: The intersection point
		#face_index: The face index at the intersection point. Note - Returns a valid number only if the intersected shape is a ConcavePolygonShape3D. Otherwise, -1 is returned
		#rid: The intersecting object's RID
		#shape: The shape index of the colliding shape	
	pass

func get_owning_controller() -> SixDOFController:
	return get_parent().get_owning_controller()
