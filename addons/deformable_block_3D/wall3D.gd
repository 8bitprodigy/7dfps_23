extends MeshInstance3D
class_name Wall3D

enum{ # Wall types
	NORMAL      = 0, # Normal Wall
	BREAKABLE   = 1, # Breakable Wall
	DOOR        = 2, # Door
	NOCOLLIDE   = 3, # Don't generate collision shape
	OPEN        = 4  # Remove from scene
}

enum{ # Wall flags
	
}

@export_flags("TRANSPARENT") var flags : int
@export var texture : Texture
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
