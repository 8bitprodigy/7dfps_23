extends BaseInputController
class_name PlayerInputSynchronizer

var parent : Node

func _ready():
	parent = get_parent()
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	set_process_input(get_multiplayer_authority() == multiplayer.get_unique_id())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _enter_tree():
	if !Engine.is_editor_hint(): return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#event.relative
		rotation_vector.x = -event.relative.y
		rotation_vector.y = -event.relative.x
	
	if Input.is_action_just_pressed("quit"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) or Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta):
	rotation_vector.z = Input.get_action_strength("counter-clockwise")-Input.get_action_strength("clockwise")
	
	rotation_basis = Basis.IDENTITY
	rotation_basis = rotation_basis.rotated(Vector3.RIGHT, rotation_vector.x)
	rotation_basis = rotation_basis.rotated(Vector3.UP, rotation_vector.y)
	rotation_basis = rotation_basis.rotated(Vector3.FORWARD, rotation_vector.z)
	
	movement_vector = Vector3(Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("up")-Input.get_action_strength("down"),
		Input.get_action_strength("backward")-Input.get_action_strength("forward")
	)
	
	var weapon_controller = parent.weapon_controller
	if weapon_controller != null:
		weapon_controller.is_primary_firing = Input.is_action_pressed("primary_fire")
		weapon_controller.is_secondary_firing = Input.is_action_pressed("secondary_fire")
	
	rotation_vector.x = 0.0
	rotation_vector.y = 0.0
