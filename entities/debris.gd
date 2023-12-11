extends RigidBody3D
class_name Debris

@export var MAX_DAMAGE         : float = 0.0
@export var MAX_DAMAGE_SPEED   : float = 0.0
@export var SPEED_DAMAGE_CURVE : Curve
var attack : AttackInfo
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if !body.has_node("health_component"):return
	body.get_node("health_component").damage(attack)
