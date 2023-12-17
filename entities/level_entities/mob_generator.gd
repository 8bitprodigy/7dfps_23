extends StaticBody3D

@export var spawn_radius          : float       = 2.0
@export var activation_radius     : float       = 25.0
@export var MAX_MOB_COUNT         : int         = 10.0
@export var mob                   : PackedScene 
@export var spawn_every_x_seconds : float       = 5.0
var         mob_list              : Array[Node]
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
	var new_mob : Node = mob.instantiate()
	assert(new_mob is SixDOFController, "MOB SPAWN ERROR: Provided packedscene is not of type SixDOFController!")
	new_mob.free()
	for i in range(0,MAX_MOB_COUNT):
		new_mob = mob.instantiate()
		new_mob.get_node("HealthComponent").health = 0
		new_mob.active = false
		new_mob.hide()
		mob_list.append(mob.instantiate())


func _physics_process(delta):
	for i in mob_list:
		MultiplayerManager.add_scene(i)
		prints(i)
	set_physics_process(false)


func spawn():
	#prints("Attempting to spawn mob.")
	if !can_spawn: return
	#prints("Can spawn mob.")
	var has_spawned : bool = false
	#while !has_spawned:
	$ShapeCast3D.target_position.z = -spawn_radius
	randomize()
	$ShapeCast3D.rotate(Vector3.UP, randf()*TAU)
	$ShapeCast3D.rotate(Vector3.LEFT, randf()*PI)
	$ShapeCast3D.force_shapecast_update()
	var cast_length : float   = $ShapeCast3D.get_collision_point(1).length()
	$ShapeCast3D/Marker3D.position.z = -spawn_radius
	$SpawnPoint3D.global_transform = $ShapeCast3D/Marker3D.global_transform
	var new_mob : Node
	for i in mob_list:
		if i.get_node("HealthComponent").health <= 0:
			prints("Found mob!")
			new_mob = i
	if !new_mob: 
		prints("Couldn't spawn new node :'(")
		can_spawn = false
		return
	new_mob.get_node("HealthComponent").revive()
	has_spawned = $SpawnPoint3D.spawn(new_mob)
	if !has_spawned:
		can_spawn = true
		start_timer(0.01)
		return
	
	#prints("Mob list: ", mob_list)
	new_mob.get_node("HealthComponent").died.connect(remove_mob.bind(new_mob))
	start_timer()


func start_timer(time:float=spawn_every_x_seconds):
	get_tree().create_timer(time).timeout.connect(spawn.bind())


func remove_mob(mob:Node):
	can_spawn = true
	start_timer()

func _on_area_3d_body_entered(body):
	#prints("Body ", body, " entered Mob Generator ", self, " activation range!")
	if !(body is PlayerController): return
	players_in_proximity += 1
	spawn()


func _on_area_3d_body_exited(body):
	prints("Body ", body, " left Mob Generator ", self, " activation range!")
	if !(body is PlayerController): return
	players_in_proximity -= 1
	assert(players_in_proximity >= 0, "MOB GENERATOR PROXIMITY ERROR: Number of players in activation proximity < 0! This is physically impossible!")
	
