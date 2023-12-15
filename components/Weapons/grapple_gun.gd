extends weapon_base

var grapple_point: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# ignore weapon_base process
func _process(delta):
	if is_firing:
		$LaserBeam.update_position(global_position, grapple_point, transform.basis.z)

func start_fire():
	super.start_fire()


func _on_hitscan_hit(hit_dict: Dictionary):
	grapple_point = hit_dict["position"]
	
	pass
