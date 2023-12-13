extends weapon_base
class_name laser_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire() -> void:
	get_node("projectile_emitter").fire()
