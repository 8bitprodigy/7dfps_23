extends SixDOFController
class_name PlayerController


# Set by the authority, synchronized on spawn.
@export var player : int = 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		if !input_node:
			prints("Set up Input Node first!")
			return
		input_node.set_multiplayer_authority(id)


func _ready():
	add_to_group("players")
	if player != multiplayer.get_unique_id(): return
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if has_node("Camera3D"):
		$Camera3D.current = true
	if has_node("MeshInstance3D"):
		$MeshInstance3D.hide()
	
