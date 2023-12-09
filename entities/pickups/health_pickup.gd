extends BasePickup
class_name HealthPickup


@export var healing_amount : float = 5.0


func _on_body_entered(body):
	if !body.has_node("health_component"):return
	if !body.get_node("health_component") is HealthComponent: return
	body.get_node("health_component").heal(healing_amount)
	super._on_body_entered(body)
