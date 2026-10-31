extends CanvasLayer
class_name InventoryUi

@onready var inventory_items: Control = $InventoryItems

var item_position: int = 0

@export var item_slot_count : int = 8
@export var inventory_grid : Control
@export var inventory_slot_prefab : PackedScene = preload("res://Systems/Inventory/inventory_slot.tscn")

var inventory_slots: Array[InventorySlot] = []


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right") and item_position < inventory_items.get_child_count() -1:
		_update_inventory_position(1)
	if Input.is_action_just_pressed('ui_left') and item_position > 0:
		_update_inventory_position(-1)

func _ready() -> void:
	for inv_slot: InventorySlot in inventory_items.get_children():
		inv_slot.set_id(-inv_slot.get_index())
	for i in item_slot_count:
		var slot = inventory_slot_prefab.instantiate() as InventorySlot
		inventory_grid.add_child(slot)
		slot.inventory_slot_id = i
		inventory_slots.append(slot)

func _update_inventory_position(value: int) -> void:
	item_position += value
	for inv_slot: InventorySlot in inventory_items.get_children():
		inv_slot.set_id(value)

func pickup_item(item : ItemData):
	for slot in inventory_slots:
		if (!slot.slot_filled):
			slot.fill_slot(item)
			break

func open_inventory():
	visible = true

func close_inventory():
	visible = false
