extends Area3D
class_name AimTarget

@export var health_component : HealthComponent

func _on_health_component_damage_taken(damage: float) -> void:
	health_component.health -= damage
