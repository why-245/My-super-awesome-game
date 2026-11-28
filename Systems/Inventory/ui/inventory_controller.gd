extends Control
class_name InventoryController

@onready var inventory_grid: Control = $InventoryGrid
@onready var context_menu: PopupMenu = PopupMenu.new()
@onready var player: CharacterBody3D = $"../.."
@onready var hand: Marker3D = $"../../Body/Hand"

@onready var slot_datas : Array = player.inventory_data.slot_datas
@onready var inventory_data : InventoryData = player.inventory_data

var item_equipped : bool = false
var equipped_item : Node3D

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
			
		ActionData.ACTIONTYPE.EQUIPPAPLE:
			context_menu.add_item("Equip", 0)
			context_menu.add_item("Inspect", 1)
			
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
				0: print(slot_id)
				1: inventory_data.use_slot_data(slot_id, 1)
		ActionData.ACTIONTYPE.EQUIPPAPLE:
			match index:
				0: equipp_slot_data(slot_id)
				1: return

func _get_item_action_type(item_data : ItemData) -> ActionData.ACTIONTYPE:
	if item_data == null:
		return ActionData.ACTIONTYPE.INVALID
	return item_data.action_data.action_type

func on_item_equip(item : Node3D) -> void:
	if item_equipped == false:
		hand.add_child(item)
		item.transform.origin = hand.transform.origin
		item.position = Vector3(0.0, 0.0, 0.0)
		item.rotation_degrees = Vector3(0, 90, 0)
		item_equipped = true
		equipped_item = item
	else:
		if item.has_method("store_data"):
			item.store_data()
		hand.get_child(0).free()
		item_equipped = false

func equipp_slot_data(index : int) -> void:
	var slot_data : SlotData = slot_datas[index]
	if slot_data == null:
		return
	var instance = slot_data.item_data.item_prefab.instantiate() as Node3D
	on_item_equip(instance)


 
