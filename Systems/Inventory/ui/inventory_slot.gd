extends Button
class_name InventorySlot

#signal OnSlotSelect(SlotID)
signal SlotClicked(index : int, button : int)

const max_stack_size = 20

#@export_range(1, max_stack_size) var quantity: int = 1: set = set_quantity
@export var icon_slot : TextureRect
#@export var item_data : ItemData

var position_id : int = 0
var inventory_slot_id = -1
var slot_filled: bool = false

@onready var item_count: Label = $TextureRect/ItemCount
@onready var equipped_item: Panel = $EquippedItem

#func _gui_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton and item_data != null:
#		if (event.button_index == MOUSE_BUTTON_LEFT):
#			OnSlotSelect.emit(inventory_slot_id)

func set_slot_data(slot_data : SlotData) -> void:
	var item_data = slot_data.item_data
	icon_slot.texture = item_data.icon
	
	if slot_data.quantity > 1:
		item_count.text = str(slot_data.quantity)
		item_count.show()


func set_id(pos: int) -> void:
	position_id += pos
	match position_id:
		0: _configure(Vector2.ZERO, Vector2.ONE * 1.5, true)
		1: _configure(Vector2(-200, -20), Vector2.ONE * 1.2, true)
		2: _configure(Vector2(-400, -40), Vector2.ONE * 1.2, true)
		3: _configure(Vector2(-600, -40), Vector2.ONE * 1.2, false) 
		-1: _configure(Vector2(200, -20), Vector2.ONE * 1.2, true)
		-2: _configure(Vector2(400, -40), Vector2.ONE * 1.2, true)
		-3: _configure(Vector2(600, -40), Vector2.ONE * 1.2, false) 
		_: _configure(position, scale, false)

func _configure(new_position: Vector2, new_scale: Vector2, value : bool) -> void:
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(self, "position", new_position, 0.2)
	tween.tween_property(self, "scale", new_scale, 0.2)
	
	if not value:
		await tween.finished
	
	visible = value

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		SlotClicked.emit(get_index(), event.button_index)
