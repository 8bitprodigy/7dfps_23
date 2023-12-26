extends weapon_base

class_name TargetingWeapon

var target_area : Area3D

@export var target_required : bool
var target : Node3D

func _ready():
	super._ready()
	$TargetArea.body_entered.connect(body_entered)

func can_fire() -> bool:
	return super.can_fire() && (!target_required || target != null)

func fire_projectile(direction: Vector3 = Vector3(0,0,0)) -> Projectile:
	var projectile = super.fire_projectile(direction)
	projectile.target = target
	return projectile

func body_entered(body : Node3D):
	if body == get_owning_controller() || !body is CharacterBody3D: return
	target = body
	pass
