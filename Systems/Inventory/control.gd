extends Control

@onready var inventory_grid: Control = $InventoryGrid


func set_player_inventory_data(inventory_data : InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	inventory_grid.set_inventory_data(inventory_data)

func on_inventory_interact(inventory_data : InventoryData,index : int, button : int) -> void:
	print("%s %s %s" % [inventory_data, index, button])
	
