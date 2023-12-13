extends Node3D
class_name WeaponController


@export var CurrentWeapon : weapon_base

var is_primary_firing : bool = false
var is_secondary_firing : bool = false

var was_primary_firing : bool = false
var was_secondary_firing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if is_primary_firing && !was_primary_firing: start_primary_fire()
	if !is_primary_firing && was_primary_firing: stop_primary_fire()
	
	if is_secondary_firing && !was_secondary_firing: start_secondary_fire()
	if !is_secondary_firing && was_secondary_firing: stop_secondary_fire()
	
	was_primary_firing = is_primary_firing
	was_secondary_firing = is_secondary_firing
	pass

func start_primary_fire():
	CurrentWeapon.start_primary_fire()
	pass
	
func stop_primary_fire():
	CurrentWeapon.stop_primary_fire()
	pass

func start_secondary_fire():
	CurrentWeapon.start_secondary_fire()
	pass
	
func stop_secondary_fire():
	CurrentWeapon.stop_secondary_fire()
	pass
