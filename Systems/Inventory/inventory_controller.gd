extends CanvasLayer
class_name InventoryUi

@onready var inventory_items: Control = $InventoryItems
@onready var context_menu : PopupMenu = PopupMenu.new()

var item_position : int = 0

@export var item_slot_count : int = 8
@export var inventory_grid : Control
@export var inventory_slot_prefab : PackedScene = preload("res://Systems/Inventory/inventory_slot.tscn")

var inventory_slots: Array[InventorySlot] = []
var equipped_slot : int = -1


func _unhandled_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("ui_right") and item_position < inventory_items.get_child_count() -1 and visible:
		_update_inventory_position(1)
	if Input.is_action_just_pressed('ui_left') and item_position > 0 and visible:
		_update_inventory_position(-1)

func _ready() -> void:
	for inv_slot: InventorySlot in inventory_items.get_children():
		inv_slot.set_id(-inv_slot.get_index())
	for i in item_slot_count:
		var slot = inventory_slot_prefab.instantiate() as InventorySlot
		inventory_grid.add_child(slot)
		slot.inventory_slot_id = i
		slot.position_id = i - 7
		slot.set_id(0)
		slot.OnItemEquiped.connect(_on_item_select)
		slot.OnItemEquiped.connect(item_equipped.bind())
		inventory_slots.append(slot)
		
	add_child(context_menu)
	context_menu.connect("id_pressed", Callable(self, "_on_context_menu_select"))

func _process(_delta: float) -> void:
		if Input.is_action_just_pressed("inventory"):
			if visible == true:
				close_inventory()
				get_tree().paused = false
			else:
				open_inventory()
				get_tree().paused = true

func _update_inventory_position(value: int) -> void:
	item_position += value
	for inv_slot: InventorySlot in inventory_items.get_children():
		inv_slot.set_id(value)

func pickup_item(item : ItemData, object : Node3D):
	inventory_slots.reverse()
	for slot in inventory_slots:
		if (!slot.slot_filled):
			slot.fill_slot(item, false)
			object.queue_free()
			break
	inventory_slots.reverse()

func item_equipped(slotID : int):
	if (equipped_slot != -1):
		inventory_slots[equipped_slot].fill_slot(inventory_slots[equipped_slot].slot_data, false)
	
	if (slotID != equipped_slot && inventory_slots[slotID].slot_data != null):
		inventory_slots[slotID].fill_slot(inventory_slots[slotID].slot_data, true)
		equipped_slot = slotID
	else:
		equipped_slot = -1

func open_inventory():
	visible = true

func close_inventory():
	visible = false

func _on_item_select(slot_id : int) -> void:
	var slot : InventorySlot = inventory_slots[slot_id]
	context_menu.clear()
	match _get_item_type(slot.slot_data):
		ActionData.ACTIONTYPE.TEST_1:
			context_menu.add_item("TEST", 0)
			context_menu.add_item("TEST", 1)
	context_menu.set_meta("slot_id", slot_id)
	var mous_pos: Vector2 = get_viewport().get_mouse_position()
	var rect: Rect2i = Rect2i(mous_pos.floor(), Vector2i(1,1))
	context_menu.popup(rect)

func _on_context_menu_select(id : int) -> void:
	return

func _get_item_type(item_data : ItemData) -> ActionData.ACTIONTYPE:
	return item_data.action_data.action_type
