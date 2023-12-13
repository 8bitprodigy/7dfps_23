extends BaseInputController
class_name InputControllerEnemyAI

@export var AI_tick_rate_in_seconds : float = 1.0
@export var max_distance : float = 5.0
var timer : SceneTreeTimer
var tween : Tween
var target_player : PlayerController
static var player_list : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

func _process(delta):
	parent = get_parent()
	if parent.has_node("HealthComponent"):
		parent.get_node("HealthComponent").damaged.connect(AI_tick.bind())
	set_process(false)
	tween = get_tree().create_tween()
	#AI_tick()
	


func AI_tick():
	if ! player_list:
		player_list = get_tree().get_nodes_in_group("players")
	target_player = player_list[0]
	for player in player_list:
		if parent.global_position.distance_to(player.global_position) < parent.global_position.distance_to(target_player.global_position):
			target_player = player
	var target_position  : Vector3 = (target_player.global_position - parent.global_position)
	var move_distance    : float   = target_position.length()-max_distance
	var move_to_position : Vector3 = target_position.normalized() * move_distance
	#tween.tween_property(parent,"global_position",move_to_position,2*move_distance)
	
	var parent_transform : Transform3D = parent.global_transform
	var target_transform : Transform3D = target_player.global_transform
	
	target_transform = parent_transform.affine_inverse() * target_transform
	
	var dot_y_plane : float = Vector2(0,-1).dot(Vector2(target_transform.origin.z,target_transform.origin.x))
	var dot_x_plane : float = Vector2(1, 0).dot(Vector2(target_transform.origin.y,target_transform.origin.z))
	#var dot_z_plane : float = Vector2(1, 0).dot(Vector2(target_transform.origin.z,target_transform.origin.y))
	
	rotation_vector.x = dot_x_plane
	rotation_vector.y = dot_y_plane
	
	if move_distance > 0:
		movement_vector.z = (target_position.normalized().dot(parent.basis.z))
	else: movement_vector.z = 0
	
	var fire_dot : float = parent.basis.z.dot((parent.global_position-target_player.global_position).normalized())
	prints("Fire Dot Product: ", fire_dot)
	if fire_dot > 0.85:
		is_primary_firing = true
	else: is_primary_firing = false
	
	#parent.look_at(target_player.global_position)
	timer = get_tree().create_timer(AI_tick_rate_in_seconds)
	timer.timeout.connect(AI_tick.bind())
