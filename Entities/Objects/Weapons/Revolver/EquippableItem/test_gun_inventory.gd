extends StaticBody3D

@onready var marker_3d: Marker3D = $Marker3D
@onready var player = get_owner()
@export var inventory_controller : InventoryController
@export var reload_timer : Timer

var max_ammo = 6
var ammo : int = max_ammo

func shoot():
	var new_bullet = preload("res://Entities/Objects/Weapons/Revolver/Bullet/bullet_3d.tscn").instantiate()
	if ammo > 0:
		marker_3d.add_child(new_bullet)
		new_bullet.transform = marker_3d.global_transform
		ammo -= 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and Input.is_action_pressed("aim"):
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()

func reload():
	ammo = max_ammo
	
