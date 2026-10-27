extends RayCast3D
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
			if object is TEST:
				object.queue_free()
				
	else:
		if current_object:
			for children in current_object.get_children():
				if children is ItemPickUpPrompt:
					children.make_invisible()
			current_object = null
	
	
