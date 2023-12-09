extends Node

var scene_tree = SceneTree.new()

func sig(x : float, amplitude : float, y_translate : float):
	return ( (amplitude) / (1 + exp(x)) ) + y_translate

func radius_to_cube_vertex(length:float):
	return (length/2)*sqrt(3)

func angle_to_vec2(angle : float):
	return Vector2(cos(angle),sin(angle))

var impact_materials : Dictionary
#var default_impact_material : ImpactMaterialData

