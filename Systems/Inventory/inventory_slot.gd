extends Button
class_name InventorySlot

@export var icon_slot : TextureRect
 
var position_id : int = 0
var inventory_slot_id = -1
var slot_filled: bool = false

var slot_data : ItemData

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

func fill_slot(data : ItemData):
	slot_data = data
	slot_filled = true
	icon_slot.texture = data.icon
