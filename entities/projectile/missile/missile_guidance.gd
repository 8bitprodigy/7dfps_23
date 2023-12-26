extends Node

@export var approach_accel : float = 20
@export var correction_accel : float  = 30
@export var min_correction_strength : float = 0.3

var projectile : Projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	projectile = $".."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if projectile.target != null:
		var velocity = projectile.velocity
		var target_direction = (projectile.target.global_position - projectile.global_position).normalized()
		
		var dot = velocity.dot(target_direction)
		
		var towards_target = target_direction * dot
		var off_target = velocity - towards_target
		
		prints("%s - \t %s = \t %s" % [towards_target.length(), off_target.length(), (towards_target - off_target).length()])
		
		# closer to 1 when travelling perpendicular to target direction, 0 when travelling towards it
		var correction_strength = 1 - abs(velocity.normalized().dot(target_direction))
		correction_strength = clamp(correction_strength, min_correction_strength, 1)
		prints(correction_strength)
		
		# form 2 thrust vectors, one that corrects velocity towards target_direction, and one that increases speed towards target
		# the strength of the correction vector is stronger when less accurate, and approch speed will increase more when travelling directly at target
		var correction_thrust = -off_target.normalized() * correction_accel * correction_strength
		var approach_thrust = target_direction * approach_accel
		
		var thrust = correction_thrust + approach_thrust
				
		projectile.velocity += thrust * delta
		projectile.orient_mesh(projectile.velocity)
	pass
