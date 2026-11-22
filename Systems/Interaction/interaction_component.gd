extends Node
class_name InteractionComponent 

@export var key : String

signal interacted()

var current_index

func inventory_check(inventory_data : InventoryData) -> bool:
	var index = 0
	for slot : SlotData in inventory_data.slot_datas:
		if slot and slot.item_data.item_name == key:
			current_index = index
			return true
		index += 1
	return false

func interact(inventory_data : InventoryData):
	interacted.emit()
	inventory_data.use_slot_data(current_index, 1)
