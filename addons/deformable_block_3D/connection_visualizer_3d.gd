@tool
extends MeshInstance3D
class_name ConnectionVisualizer3D



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("connection_visualizer")
	if Engine.is_editor_hint(): return
	hide()


func _setup(position_1:Vector3, position_2:Vector3):
	var half_span = (position_2-position_1)/2
	global_position = position_1 + half_span
	var vertex_1 : Vector3 =  half_span
	var vertex_2 : Vector3 = -half_span
	
	var vertices = PackedVector3Array()
	vertices.push_back(vertex_1)
	vertices.push_back(vertex_2)
	
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	
	mesh = m
