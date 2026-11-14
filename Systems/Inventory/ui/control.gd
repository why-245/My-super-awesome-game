extends Control

@onready var inventory_grid: Control = $InventoryGrid
@onready var context_menu: PopupMenu = PopupMenu.new()
@onready var player: CharacterBody3D = $"../.."

@onready var slot_datas : Array = player.inventory_data.slot_datas
@onready var inventory_data : InventoryData = player.inventory_data

func _ready() -> void:
	set_player_inventory_data(player.inventory_data)
	context_menu.connect("id_pressed", Callable(self, "_on_context_menu_select"))
	add_child(context_menu)

func set_player_inventory_data(inventory_data_ : InventoryData) -> void:
	inventory_grid.set_inventory_data(inventory_data_)

func on_inventory_interact(index) -> void:
	context_menu.clear()
	var slot_data : SlotData = slot_datas[index]
	if slot_data == null:
		return
	
	match _get_item_action_type(slot_data.item_data):
		ActionData.ACTIONTYPE.TEST_1:
			context_menu.add_item("TEST", 0)
			context_menu.add_item("USE", 1)
			
	context_menu.set_meta("slot_id", index)
	var mous_pos : Vector2 = get_viewport().get_mouse_position()
	var rect : Rect2i = Rect2i(mous_pos.floor(), Vector2i(1, 1))
	context_menu.popup(rect)

func _on_context_menu_select(index : int) -> void:
	var slot_id = context_menu.get_meta("slot_id")
	var slot_data : SlotData = slot_datas[slot_id]
	
	match _get_item_action_type(slot_data.item_data):
		ActionData.ACTIONTYPE.TEST_1:
			match index:
				0: print("TEST")
				1: inventory_data.use_slot_data(slot_id)

func _get_item_action_type(item_data : ItemData) -> ActionData.ACTIONTYPE:
	if item_data == null:
		return ActionData.ACTIONTYPE.INVALID
	return item_data.action_data.action_type
	
