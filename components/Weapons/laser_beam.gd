extends Node3D

var ribbon_instance : MeshInstance3D
var mesh : ImmediateMesh

var start : Vector3
var end : Vector3
var normal : Vector3

@export var width: float

# Called when the node enters the scene tree for the first time.
func _ready():
	ribbon_instance = MeshInstance3D.new()
	mesh = ImmediateMesh.new()
	ribbon_instance.mesh = mesh
	
	pass # Replace with function body.

func _process(delta):
	mesh.clear_surfaces()
	
	
	if visible:
		var direction = end - start
		var sideways = normal.cross(direction).normalized()
		
		# Clean up before drawing.
		mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
		
		mesh.surface_add_vertex(start + sideways * width / 2)
		mesh.surface_add_vertex(start - sideways * width / 2)
		
		mesh.surface_add_vertex(end + sideways * width / 2)
		mesh.surface_add_vertex(end - sideways * width / 2)

		mesh.surface_end()
		
	visible = false
	pass

func update_position(start: Vector3, end: Vector3, normal: Vector3):
	self.start = start
	self.end = end
	self.normal = normal	
	visible = true
	pass
	#var center = start + direction * distance / 2
	
	#$".".mesh.height = distance
	
	#var str = "start:\t%s\ncenter:\t%s\nend:\t%s\n"
	#prints(str % [start, center, distance])
	
	#set_global_position( center )
