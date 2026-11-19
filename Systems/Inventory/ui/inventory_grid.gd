extends Node

@onready var player: CharacterBody3D = $"../../.."
@onready var control: Control = $".."

@export var inventory_slot_prefab : PackedScene = preload("res://Systems/Inventory/ui/inventory_slot.tscn")
@export var item_slot_count : int = 8

func set_inventory_data(inventory_data : InventoryData) -> void:
	add_slots_to_inventory(inventory_data)
	inventory_data.inventory_updated.connect(add_slots_to_inventory)

func add_slots_to_inventory(inventory_data : InventoryData) -> void:
	var i : int = 0
	var slot_ids : Array = []
	for slot : InventorySlot in get_children():
		slot_ids.append(slot.position_id)
		slot.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot = inventory_slot_prefab.instantiate() as InventorySlot
		add_child(slot)
		slot.inventory_slot_id = -i
		slot.position_id = slot_ids[i] if i < slot_ids.size() else -i
		var offset = Vector2(50 * 1.2, 50)
		var offset_main = Vector2(50 * 1.7, 50)
		i += 1
		
		match slot.position_id:
			
			0: 
				slot.position = (Vector2(640, 480) - offset_main) 
				slot.scale = Vector2.ONE * 1.7
				slot.visible = true
				slot.disabled = false
				
			1: 
				slot.position = (Vector2(440, 460) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = true
				slot.disabled = true
			2: 
				slot.position = (Vector2(240, 440) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = true
				slot.disabled = true
			3: 
				slot.position = (Vector2(40, 440) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = false 
				slot.disabled = true
				
			-1: 
				slot.position = (Vector2(840, 460) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = true
				slot.disabled = true
				
			-2: 
				slot.position = (Vector2(1040, 440) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = true
				slot.disabled = true
				
			-3: 
				slot.position = (Vector2(1240, 440) - offset) 
				slot.scale = Vector2.ONE * 1.2
				slot.visible = false 
				slot.disabled = true
				
			_: 
				slot.visible = false
				slot.disabled = true
		
		slot.SlotClicked.connect(inventory_data.on_slot_clicked)
		slot.SlotClicked.connect(control.on_inventory_interact)
		if slot_data != null:
			slot.set_slot_data(slot_data)
