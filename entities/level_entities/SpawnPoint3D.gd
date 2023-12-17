@tool
@icon("res://entities/level_entities/spawn_point.svg")
extends Area3D
class_name SpawnPoint3D

const       pixel_size         : float   = 0.0005
@export var radius             : float   = 0.5
@export var spawn_icon         : Texture = preload("res://entities/level_entities/spawn_point.png")
var         last_spawned_scene : Node

func _ready():
	add_to_group("spawn_points")

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	# Set up collider to check if player can spawn
	var new_collision_shape : CollisionShape3D = CollisionShape3D.new()
	new_collision_shape.shape                  = SphereShape3D.new()
	new_collision_shape.shape.radius           = radius
	add_child(new_collision_shape)
	
	#if !Engine.is_editor_hint(): return
	# This stuff is only to visualize the spawn point in the editor
	#add_gizmo(EditorNode3DGizmo.new())
	
	var new_marker : Marker3D = Marker3D.new()
	add_child(new_marker)
	
	var new_collision_visualizer : MeshInstance3D = MeshInstance3D.new()
	new_collision_visualizer.mesh                 = SphereMesh.new()
	new_collision_visualizer.mesh.surface_set_material(0,preload("res://entities/level_entities/spawn_visualizer.tres"))
	add_child(new_collision_visualizer)
	
	var new_icon : Sprite3D = Sprite3D.new()
	new_icon.alpha_cut      = SpriteBase3D.ALPHA_CUT_DISCARD
	new_icon.billboard      = BaseMaterial3D.BILLBOARD_ENABLED
	new_icon.fixed_size     = true
	new_icon.no_depth_test  = true
	new_icon.pixel_size     = pixel_size
	new_icon.texture        = spawn_icon
	add_child(new_icon)
	


func spawn(spawnable:Node) -> bool:
	if get_overlapping_bodies().size()>0:return false
	spawnable.global_transform = global_transform
	return true
