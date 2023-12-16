extends BasePickup
class_name HealthPickup


@export var healing_amount : float = 5.0


func _on_body_entered(body):
	if !body.has_node("HealthComponent"):return
	if !(body.get_node("HealthComponent") is HealthComponent): return
	var health_component : HealthComponent = body.get_node("HealthComponent")
	if health_component.health == health_component.MAX_HEALTH: return
	health_component.heal(healing_amount)
	super._on_body_entered(body)
