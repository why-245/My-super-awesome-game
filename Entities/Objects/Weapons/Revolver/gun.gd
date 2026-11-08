extends Node3D
@onready var marker_3d: Marker3D = $Marker3D

func shoot():
	var new_bullet = preload("res://Entities/Objects/Weapons/bullet_3d.tscn").instantiate()
	marker_3d.add_child(new_bullet)
	new_bullet.transform = marker_3d.global_transform

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and Input.is_action_pressed("aim"):
		shoot()
