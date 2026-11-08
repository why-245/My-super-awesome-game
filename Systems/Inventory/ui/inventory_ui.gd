extends CanvasLayer
class_name InventoryUI

@onready var inventory_grid: Control = $Control/InventoryGrid

var equipped_slot : int = -1
var item_position : int = 0

func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right") and item_position < inventory_grid.get_child_count() -1 and visible:
		_update_inventory_position(1)
	if Input.is_action_just_pressed('ui_left') and item_position > 0 and visible:
		_update_inventory_position(-1)

func _process(_delta: float) -> void:
		if Input.is_action_just_pressed("inventory"):
			if visible == true:
				close_inventory()
				get_tree().paused = false
			else:
				open_inventory()
				get_tree().paused = true

func _update_inventory_position(value: int) -> void:
	item_position += value
	for inv_slot: InventorySlot in inventory_grid.get_children():
		inv_slot.set_id(value)

func open_inventory():
	visible = true

func close_inventory():
	visible = false
