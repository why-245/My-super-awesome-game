extends RayCast3D

@onready var player: CharacterBody3D = $"../.."
@export var slot_data : SlotData

var current_object = get_collider()

func  _process(_delta: float) -> void:
	if is_colliding():
		var object = get_collider() as Node
		if object != current_object:
			if current_object != null:
				for children in current_object.get_children():
					if children is ItemPickUpPrompt:
						children.make_invisible() 
			current_object = object
			if object != null:
				for children in object.get_children():
					if children is ItemPickUpPrompt:
						children.make_visible()
		if Input.is_action_just_pressed("interact"):
			if object.is_in_group("InventoryItems") == true and object.slot_data:
				player.get_node("PickUpPrompt").on_item_pick_up(object.slot_data, object)
				
			if object.is_in_group("Interactables") and object.has_node("InteractionComponent"):
				player.get_node("DialogueUi").start_dialogue(object.get_node("DialogueTrigger"), object)
			return
			
	else:
		if current_object:
			for children in current_object.get_children():
				if children is ItemPickUpPrompt:
					children.make_invisible()
			current_object = null
