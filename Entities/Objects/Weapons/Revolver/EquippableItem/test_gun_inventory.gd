extends StaticBody3D

@onready var player : Player
@onready var marker_3d: Marker3D = $Marker3D
@onready var aiming_ray: AimingRay

var max_ammo = 6
var ammo : int = max_ammo

func _ready() -> void:
	player = find_parent("Player")
	aiming_ray = player.find_child("AimingRay")

func shoot():
	var new_bullet = preload("res://Entities/Objects/Weapons/Revolver/Bullet/bullet_3d.tscn").instantiate()
	if ammo > 0:
		marker_3d.add_child(new_bullet)
		new_bullet.transform = marker_3d.global_transform
		if aiming_ray.is_colliding():
			var target : AimTarget = aiming_ray.get_collider()
			target._on_health_component_damage_taken(50)
			print("fe")
		ammo -= 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("aim") and Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()

func reload():
	var index : int = player.inventory_data.get_slot_index("TestObject")
	var quantity : int = player.inventory_data.get_item_count("TestObject") 
	if index != null:
		if quantity > max_ammo:
			player.inventory_data.use_slot_data(index, -(ammo-max_ammo))
			ammo = max_ammo
		if 0 < quantity and quantity < max_ammo:
			player.inventory_data.use_slot_data(index, quantity)
			ammo = quantity
