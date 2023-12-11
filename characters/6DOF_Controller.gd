extends CharacterBody3D
class_name SixDOFController

@export var SPEED : float = 100.0
@export var THROTTLE_MULTIPLIER : float = 2.0
@export var ACCELERATION : float = 5.0

@export var CurrentWeapon : weapon_base

var angular_velocity : Vector3 = Vector3.ZERO



# Player synchronized input.
@onready var input : Node = $input_synchronizer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _enter_tree():
	if Engine.is_editor_hint(): return
	#prints("Player: ", player)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$Label3D.text = str(player)

func start_fire():
	CurrentWeapon._start_fire()
	pass
	
func stop_fire():
	CurrentWeapon._stop_fire()

func _physics_process(delta):
	if !input: return
	angular_velocity.x = lerp(angular_velocity.x,input.rotation_vector.x/200,delta*ACCELERATION)
	angular_velocity.y = lerp(angular_velocity.y,input.rotation_vector.y/200,delta*ACCELERATION)
	angular_velocity.z = lerp(angular_velocity.z,input.rotation_vector.z/50,delta*ACCELERATION)
	
	rotate(basis.x.normalized(), angular_velocity.x)
	rotate(basis.y.normalized(), angular_velocity.y)
	rotate(basis.z.normalized(), angular_velocity.z)
	
	var speed : float = clampf(Input.get_action_strength("throttle") * THROTTLE_MULTIPLIER , 1.0, THROTTLE_MULTIPLIER) * SPEED
	var direction : Vector3 = ((basis.x * input.movement_vector.x) + (basis.y * input.movement_vector.y) + (basis.z * input.movement_vector.z)).normalized() * delta * speed
	
	velocity = lerp(velocity,direction,delta*ACCELERATION)
	move_and_slide()
