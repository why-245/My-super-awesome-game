extends Node
class_name InteractionComponent 

@export var key : String

signal interacted()

func interacted_with(inventory_data : InventoryData):
	var index = 0
	for slot : SlotData in inventory_data.slot_datas:
		if slot and slot.item_data.item_name == key:
			interacted.emit()
			inventory_data.use_slot_data(index, 1)
			return
		index += 1
	print("i need a ", key, " for this!!!")
