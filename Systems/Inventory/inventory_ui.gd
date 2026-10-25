extends Control
class_name InvetoryUi


var item_slots_count: int = 8
var inventory_slots_prefab: PackedScene = load("res://Systems/Inventory/inventory_slot.tscn")
var inventory_slots: Array[InventorySlot] = []
var inventory_full: bool = false
@onready var grid_container: GridContainer = %GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in item_slots_count:
		var slot = inventory_slots_prefab.instantiate() as InventorySlot
		grid_container.add_child(slot)
		inventory_slots.append(slot)
