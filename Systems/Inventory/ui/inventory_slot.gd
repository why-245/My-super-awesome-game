extends Button
class_name InventorySlot

signal SlotClicked(index : int, button : int)

const max_stack_size = 20

@export var icon_slot : TextureRect

@onready var item_count: Label = $TextureRect/ItemCount
@onready var equipped_item: Panel = $EquippedItem

var position_id : int = 0
var inventory_slot_id = -1
var slot_filled: bool = false

func set_slot_data(slot_data : SlotData) -> void:
	var item_data = slot_data.item_data
	icon_slot.texture = item_data.icon
	
	if slot_data.quantity > 1:
		item_count.text = str(slot_data.quantity)
		item_count.show()

func set_id(pos: int) -> void:
	position_id += pos
	var offset = Vector2(50 * 1.2, 50)
	var offset_main = Vector2(50 * 1.7, 50)
	match position_id:
		0: _configure(Vector2(640, 480) - offset_main, Vector2.ONE * 1.7, true)
		1: _configure(Vector2(440, 460) - offset, Vector2.ONE * 1.2, true)
		2: _configure(Vector2(240, 440) - offset, Vector2.ONE * 1.2, true)
		3: _configure(Vector2(40, 440) - offset, Vector2.ONE * 1.2, false) 
		-1: _configure(Vector2(840, 460) - offset, Vector2.ONE * 1.2, true)
		-2: _configure(Vector2(1040, 440) - offset, Vector2.ONE * 1.2, true)
		-3: _configure(Vector2(1240, 440) - offset, Vector2.ONE * 1.2, false) 
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
