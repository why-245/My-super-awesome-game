extends RayCast3D
signal OnItemPickUp(item)

var current_object = get_collider()
@export var item_types : Array [ItemData] = []

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
			if object is TEST:
				object.queue_free()
				var object_prefab = object.scene_file_path
				for i in item_types.size():
					if (item_types[i].item_model_prefab != null and item_types[i].item_model_prefab.resource_path == object_prefab):
						print("Item id:" + str(i) + " Item Name:" + item_types[i].item_name)
						OnItemPickUp.emit(item_types[i])
						return
	else:
		if current_object:
			for children in current_object.get_children():
				if children is ItemPickUpPrompt:
					children.make_invisible()
			current_object = null
	
