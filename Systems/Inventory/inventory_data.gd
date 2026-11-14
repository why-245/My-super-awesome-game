extends Resource
class_name InventoryData 
 
signal inventory_updated(inventory_data : InventoryData)
signal inventory_interact(inventory_data : InventoryData, index : int, button : int)
@export var slot_datas : Array[SlotData]
 
func on_slot_clicked(index : int) -> void:
	inventory_interact.emit(self, index)

func use_slot_data(index : int) -> void:
	var slot_data : SlotData = slot_datas[index]
	slot_data.quantity -= 1
	
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
