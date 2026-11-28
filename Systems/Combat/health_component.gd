extends Node
class_name HealthComponent

signal damage_taken(damage : float)
signal died

@export var max_health : float 
@onready var health = max_health

func _physics_process(_delta: float) -> void:
	if health <= 0:
		died.emit()
