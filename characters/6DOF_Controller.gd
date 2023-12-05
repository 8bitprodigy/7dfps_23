extends CharacterBody3D
class_name SixDOFController

@export var SPEED : float = 100.0
@export var THROTTLE_MULTIPLIER : float = 2.0
@export var ACCELERATION : float = 5.0

var angular_velocity : Vector3 = Vector3.ZERO

# Set by the authority, synchronized on spawn.
@export var player : int = 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$input_synchronizer.set_multiplayer_authority(id)

# Player synchronized input.
@onready var input = $input_synchronizer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	if player == multiplayer.get_unique_id():
		$Camera3D.current = true
		$MeshInstance3D.hide()
	

func _enter_tree():
	if Engine.is_editor_hint(): return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#prints("Player: ", player)
	$Label3D.text = str(player)

func _physics_process(delta):
	
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
