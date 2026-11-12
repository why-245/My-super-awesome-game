extends Resource
class_name SlotData
const max_stack_size = 20

@export var item_data : ItemData
@export_range(1, max_stack_size) var quantity : int = 1 : set = set_quantity

func can_merge_with(item_pick_up : SlotData) -> bool:
	return item_data == item_pick_up.item_data and item_data.stackable \
	and quantity + item_pick_up.quantity < max_stack_size
	
func merge_with(item_pick_up : SlotData) -> void:
	quantity = quantity + item_pick_up.quantity
	

func set_quantity(value : int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
