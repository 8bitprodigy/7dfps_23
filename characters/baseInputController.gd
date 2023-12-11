extends MultiplayerSynchronizer
class_name BaseInputController


@export var movement_vector : Vector3 = Vector3.ZERO
@export var rotation_vector : Vector3 = Vector3.ZERO
@export var rotation_basis : Basis = Basis.IDENTITY

@export var is_primary_firing : bool = false
@export var is_secondary_firing : bool = false
var parent : Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
