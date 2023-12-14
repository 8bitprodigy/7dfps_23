@tool
@icon("res://entities/level_entities/player_spawn.svg")
extends SpawnPoint3D
class_name PlayerSpawn3D


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	add_to_group("player_spawn")


func _enter_tree():
	spawn_icon = preload("res://entities/level_entities/player_spawn.png")
	super._enter_tree()
