@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("Segment3D", "Marker3D", preload("res://addons/deformable_block_3D/level_3d.gd"), preload("res://addons/deformable_block_3D/icons/level_3D.svg"))
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
