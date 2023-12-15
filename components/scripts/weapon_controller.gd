extends Node3D

class_name WeaponController

@export var weapon_array: Array

func _enter_tree():
	# store child weapons in weapon_array
	for child in get_children():
		if child is weapon_base:
			weapon_array.push_back(child)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func start_fire(weapon_idx: int):
	if weapon_idx >= weapon_array.size():
		prints("Trying to start_fire() on nonexistent weapon in weapon_array!!!")
		return
	weapon_array[weapon_idx].start_fire()
	pass
	
func stop_fire(weapon_idx: int):
	if weapon_idx >= weapon_array.size():
		prints("Trying to stop_fire() on nonexistent weapon in weapon_array!!!")
		return
	weapon_array[weapon_idx].stop_fire()

func get_owning_controller() -> SixDOFController:
	return get_parent()
