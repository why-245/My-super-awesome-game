extends StaticBody3D

@onready var marker_3d: Marker3D = $Marker3D
@onready var player : Player

var max_ammo = 6
var ammo : int = max_ammo

#gets the player node
func _ready() -> void:
	player = get_parent().get_parent().get_parent()

#creats a bullet as a child of the Marker3D Node
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
	#index is which inventory slot AMMO is inventory
	#quantity is how much AMMO is in inventory
	var index : int = player.inventory_data.get_slot_index("TestObject")
	var quantity : int = player.inventory_data.get_item_count("TestObject")
	#null check for if AMMO exsists in inventory 
	if index != null:
		#subtracts how much AMMO you reload from inventory
		if quantity > max_ammo:
			player.inventory_data.use_slot_data(index, -(ammo-max_ammo))
			ammo = max_ammo
		if 0 < quantity and quantity < max_ammo:
			player.inventory_data.use_slot_data(index, quantity)
			ammo = quantity
