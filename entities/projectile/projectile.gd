extends ShapeCast3D

@export var speed : float = 10.0
@export var lifespan : float = 10.0
@export var projectile_length : float = 1.0
@export var attack : AttackInfo
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func spawn(firer:ProjectileEmitter) -> void:
	global_transform = firer.global_transform
	target_position = Vector3.FORWARD*projectile_length #firer.global_transform.basis.z * projectile_length
	add_exception(firer.parent)
	if lifespan > 0.0:
		await get_tree().create_timer(lifespan).timeout
		queue_free()
		

#var old_position : Vector3 = Vector3.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	global_position = global_position + (target_position.length()*-global_transform.basis.z.normalized())
	target_position =(Vector3.FORWARD*speed) * delta
	force_shapecast_update()
