extends CharacterBody3D
class_name SixDOFController

@export var SPEED : float = 100.0
@export var THROTTLE_MULTIPLIER : float = 2.0
@export var ACCELERATION : float = 5.0


var angular_velocity : Vector3 = Vector3.ZERO


@onready var weapon_controller = $weapon_controller

# Player synchronized input.
@export var input_node : Node

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	if input_node: return
	set_physics_process(false)
	set_process(false)

func _enter_tree():
	if Engine.is_editor_hint(): return
	#prints("Player: ", player)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#$Label3D.text = str(player)


func _physics_process(delta):
	if !input_node: return
	angular_velocity.x = lerp(angular_velocity.x,input_node.rotation_vector.x/200,delta*ACCELERATION)
	angular_velocity.y = lerp(angular_velocity.y,input_node.rotation_vector.y/200,delta*ACCELERATION)
	angular_velocity.z = lerp(angular_velocity.z,input_node.rotation_vector.z/50,delta*ACCELERATION)
	
	rotate(basis.x.normalized(), angular_velocity.x)
	rotate(basis.y.normalized(), angular_velocity.y)
	rotate(basis.z.normalized(), angular_velocity.z)
	
	if input_node.is_primary_firing:
		$ProjectileEmitter.fire()
	
	var speed : float = clampf(Input.get_action_strength("throttle") * THROTTLE_MULTIPLIER , 1.0, THROTTLE_MULTIPLIER) * SPEED
	var direction : Vector3 = (
		(basis.x * input_node.movement_vector.x) +
		(basis.y * input_node.movement_vector.y) + 
		(basis.z * input_node.movement_vector.z)
		).normalized() * delta * speed
	
	velocity = lerp(velocity,direction,delta*ACCELERATION)
	move_and_slide()
