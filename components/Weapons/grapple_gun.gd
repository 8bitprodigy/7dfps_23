extends weapon_base

var grapple_point: Vector3
var grapple_hit : bool = false

@export var grapple_accel: float = 35

# Called when the node enters the scene tree for the first time.
func _ready():
	$SimpleBeam.visible = false
	$Beam3D.visible = false
	projectile_type = null
	pass # Replace with function body.


# ignore weapon_base process
func _process(delta):
	#super._process(delta)
	if is_firing && grapple_hit:
		#$LaserBeam.update_position(global_position, grapple_point, transform.basis.y)
		var distance = global_position.distance_to(grapple_point)
		#$SimpleBeam.set_length(distance)
		#$SimpleBeam.look_at(grapple_point)
		get_owning_controller().velocity += (grapple_point - global_position).normalized() * grapple_accel * delta

func start_fire():
	super.start_fire()
	grapple_hit = false
	_handle_fire()
	#$SimpleBeam.visible = grapple_hit
	$Beam3D.visible = grapple_hit

func stop_fire():
	super.stop_fire()
	#$SimpleBeam.visible = false
	$Beam3D.visible = false

func _on_hitscan_hit(hit_dict: Dictionary):
	grapple_point = hit_dict["position"]
	grapple_hit = true
	$Beam3D.target_point = grapple_point
	pass
