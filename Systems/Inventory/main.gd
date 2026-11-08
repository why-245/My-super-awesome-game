extends Node

@onready var player: CharacterBody3D = %Player
@onready var control: Control = $Player/InventoryUi/Control


func _ready() -> void:
	control.set_player_inventory_data(player.inventory_data)
