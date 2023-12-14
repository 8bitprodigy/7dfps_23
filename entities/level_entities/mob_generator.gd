extends StaticBody3D

@export var spawn_radius          : float       = 2.5
@export var activation_radius     : float       = 25.0
@export var MAX_MOB_COUNT         : int         = 10.0
@export var mob                   : PackedScene 
@export var spawn_every_x_seconds : float       = 5.0
var         mob_list              : Array[PackedScene]
var         can_spawn             : bool        = true
const       HALF_PI = PI/2


var         spawn_timer          : SceneTreeTimer
var         players_in_proximity : int   = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("mob_generator")
	$ShapeCast3D.shape = SphereShape3D
	$ShapeCast3D.add_exception(self)
	$Area3D/CollisionShape3D.shape.radius = activation_radius
	#$SpringArm3D.shape.radius = $SpawnPoint3D.radius


func spawn():
	prints("Attempting to spawn mob.")
	#if !can_spawn: return
	#prints("Can spawn mob.")
	var new_mob : Node = mob.instantiate()
	assert(new_mob is SixDOFController, "MOB SPAWN ERROR: Provided packedscene is not of type SixDOFController!")
	var has_spawned : bool = false
	#while !has_spawned:
	$ShapeCast3D.basis = $ShapeCast3D.basis.rotated(Vector3.LEFT, randf()*PI)
	$ShapeCast3D.basis = $ShapeCast3D.basis.rotated(Vector3.FORWARD, randf()*TAU)
	$ShapeCast3D.target_position.y = -spawn_radius
	$ShapeCast3D.force_shapecast_update()
	var cast_length : float   = $ShapeCast3D.get_collision_point(1).length()
	$SpawnPoint3D.global_position = $ShapeCast3D.global_position + $ShapeCast3D.target_position
	$SpawnPoint3D.global_transform.basis = $ShapeCast3D.global_transform.basis
	has_spawned = $SpawnPoint3D.spawn(new_mob)
	if !has_spawned:
		can_spawn = true
		new_mob.free()
		start_timer()
		return
	
	prints("New Mob: ", new_mob)
	#new_mob.look_at($ShapeCast3D.target_position)
	MultiplayerManager.add_scene(new_mob)
	mob_list.append(new_mob)
	if mob_list.size() >= MAX_MOB_COUNT:
		can_spawn = false
		return
	prints("Mob list: ", mob_list)
	new_mob.get_node("HealthComponent").died.connect(remove_mob.bind(new_mob))
	start_timer()


func start_timer():
	get_tree().create_timer(spawn_every_x_seconds).timeout.connect(spawn.bind())


func remove_mob(mob:Node):
	mob_list.pop_at(mob_list.find(mob))
	if mob_list.size() >= MAX_MOB_COUNT: return
	can_spawn = true

func _on_area_3d_body_entered(body):
	prints("Body ", body, " entered Mob Generator ", self, " activation range!")
	if !(body is PlayerController): return
	players_in_proximity += 1
	spawn()


func _on_area_3d_body_exited(body):
	prints("Body ", body, " left Mob Generator ", self, " activation range!")
	if !(body is PlayerController): return
	players_in_proximity -= 1
	assert(players_in_proximity >= 0, "MOB GENERATOR PROXIMITY ERROR: Number of players in activation proximity < 0! This is physically impossible!")
	
