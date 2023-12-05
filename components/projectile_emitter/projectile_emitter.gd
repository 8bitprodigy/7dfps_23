extends Marker3D
class_name ProjectileEmitter
@onready var parent : Node = get_parent()
@export var shots_per_second : float = 5
@onready var refactory_time : float = 1/shots_per_second
var can_fire : bool = true

signal fire_projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _enter_tree():
	if multiplayer.is_server():
		prints("ProjectileEmitter entered tree!")
		MultiplayerManager.register_gun(multiplayer.get_unique_id(),self)
	pass

@rpc
func fire():
	if !can_fire: return
	can_fire = false
	MultiplayerManager.add_projectile(multiplayer.get_unique_id(), self)
	fire_projectile.emit(multiplayer.get_unique_id(), self)
	await get_tree().create_timer(refactory_time).timeout
	can_fire = true
