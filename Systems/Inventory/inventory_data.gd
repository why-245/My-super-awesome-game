extends Resource
class_name InventoryData 
 
signal inventory_updated(inventory_data : InventoryData)
signal inventory_interact(inventory_data : InventoryData, index : int, button : int)
@export var slot_datas : Array[SlotData]
 
func on_slot_clicked(index : int) -> void:
	inventory_interact.emit(self, index)

func use_slot_data(index : int, amount : int) -> void:
	var slot_data : SlotData = slot_datas[index]
	slot_data.quantity -= amount
	
	if slot_data.quantity <= 0:
		slot_datas[index] = null
	inventory_updated.emit(self)

func pick_up_slot_data(slot_data : SlotData) -> bool:
	for index in slot_datas.size():
		if slot_datas[index] and slot_datas[index].can_merge_with(slot_data):
			slot_datas[index].merge_with(slot_data)
			inventory_updated.emit(self)
			return true
	
	for index in slot_datas.size():
		if not slot_datas[index]:
			slot_datas[index] = slot_data
			inventory_updated.emit(self)
			return true
	return false

func get_slot_index(item : String):
	var index = 0
	for slot_data : SlotData in slot_datas:
		if slot_data and slot_data.item_data.item_name == item:
			return index
		index += 1
	return index

func get_item_count(item : String) -> int:
	for slot_data : SlotData in slot_datas:
		if slot_data and slot_data.item_data.item_name == item:
			return slot_data.quantity
	return 0
