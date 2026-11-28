extends StaticBody3D

class_name GunScript

@onready var player : Player = find_parent("Player")
@onready var marker_3d: Marker3D = $Marker3D
@onready var aiming_ray: AimingRay = player.find_child("AimingRay")
@onready var reload_timer: Timer = $ReloadTimer
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var gun_node = self
@export var max_ammo : int
@export var reload_time : float
@export var bullet_count : int
@export var shoot_cooldown : float

var can_shoot : bool = true

#@export var ammo_count : int

func _ready() -> void:
	pass
	#var ammo_count = PlayerData.test_gun_ammo_count

func shoot():
	if PlayerData.test_gun_ammo_count > 0 and can_shoot != false:
		var new_bullet = preload("res://Entities/Objects/Weapons/Revolver/Bullet/bullet_3d.tscn").instantiate()
		marker_3d.add_child(new_bullet)
		new_bullet.transform = marker_3d.global_transform
		
		if aiming_ray.is_colliding():
			var target : AimTarget = aiming_ray.get_collider()
			target._on_health_component_damage_taken(50)
		
		PlayerData.test_gun_ammo_count -= 1
		#can_shoot = false
		#fire_rate_timer.start(shoot_cooldown)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("aim") and Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("reload") and can_shoot == true:
		reload()
	if Input.is_action_just_pressed("sprint"):
		print(PlayerData.test_gun_ammo_count)
		print(can_shoot)

func reload():
	can_shoot = false
	if player.inventory_data.get_item_count("TestObject") > 0 and PlayerData.test_gun_ammo_count < max_ammo:
		reload_timer.start(reload_time)

func _on_reload_timer_timeout() -> void:
	var index : int = player.inventory_data.get_slot_index("TestObject")
	var quantity : int = player.inventory_data.get_item_count("TestObject") 
	if index != null:
		if quantity > max_ammo:
			player.inventory_data.use_slot_data(index, -(PlayerData.test_gun_ammo_count-max_ammo))
			PlayerData.test_gun_ammo_count = max_ammo
			can_shoot = true
			return
		if 0 < quantity and quantity < max_ammo:
			PlayerData.test_gun_ammo_count = quantity
			player.inventory_data.use_slot_data(index, quantity)
			can_shoot = true
			

#func _on_fire_rate_timer_timeout() -> void:
	#can_shoot = true
	
