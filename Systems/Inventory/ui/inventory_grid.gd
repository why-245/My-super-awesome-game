extends Node

@export var inventory_slot_prefab : PackedScene = preload("res://Systems/Inventory/ui/inventory_slot.tscn")
@export var item_slot_count : int = 8

var inventory_slots: Array[InventorySlot] = []

func set_inventory_data(inventory_data : InventoryData) -> void:
	add_slots_to_inventory(inventory_data)
	inventory_data.inventory_updated.connect(add_slots_to_inventory)

func add_slots_to_inventory(inventory_data : InventoryData) -> void:
	var i : int = 0
	for slot: InventorySlot in get_children():
		slot.set_id(-slot.get_index())
		slot.queue_free()

	for slot_data in inventory_data.slot_datas:
		var slot = inventory_slot_prefab.instantiate() as InventorySlot
		i += 1
		add_child(slot)
		slot.SlotClicked.connect(inventory_data.on_slot_clicked)
		slot.inventory_slot_id = -i
		slot.position_id = i -8
		slot.set_id(0)
		
		if slot_data != null:
			slot.set_slot_data(slot_data)
