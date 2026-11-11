extends Node

@onready var player: CharacterBody3D = $".."
@onready var control: Control = $"../InventoryUi/Control"

func _ready() -> void:
	control.set_player_inventory_data(player.inventory_data)
