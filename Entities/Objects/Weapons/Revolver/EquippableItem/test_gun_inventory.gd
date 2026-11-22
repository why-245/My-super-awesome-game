extends StaticBody3D

class_name GunScript

@onready var player : Player = find_parent("Player")
@onready var marker_3d: Marker3D = $Marker3D
@onready var aiming_ray: AimingRay = player.find_child("AimingRay")
@onready var reload_timer: Timer = $ReloadTimer
@onready var fire_rate_timer: Timer = $FireRateTimer

@export var max_ammo : int
@export var reload_time : float
@export var bullet_count : int
@export var shoot_cooldown : float

var can_shoot : bool = false
var ammo : int

func shoot():
	if ammo > 0 and can_shoot != false:
		var new_bullet = preload("res://Entities/Objects/Weapons/Revolver/Bullet/bullet_3d.tscn").instantiate()
		marker_3d.add_child(new_bullet)
		new_bullet.transform = marker_3d.global_transform
		
		if aiming_ray.is_colliding():
			var target : AimTarget = aiming_ray.get_collider()
			target._on_health_component_damage_taken(50)
		
		ammo -= 1
		#can_shoot = false
		#fire_rate_timer.start(shoot_cooldown)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("aim") and Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()

func reload():
	can_shoot = false
	if player.inventory_data.get_item_count("TestObject") >= 0:
		reload_timer.start(reload_time)

func _on_reload_timer_timeout() -> void:
	var index : int = player.inventory_data.get_slot_index("TestObject")
	var quantity : int = player.inventory_data.get_item_count("TestObject") 
	if index != null:
		if quantity > max_ammo:
			player.inventory_data.use_slot_data(index, -(ammo-max_ammo))
			ammo = max_ammo
		if 0 < quantity and quantity < max_ammo:
			player.inventory_data.use_slot_data(index, quantity)
			ammo = quantity
	can_shoot = true

#func _on_fire_rate_timer_timeout() -> void:
	#can_shoot = true
	
