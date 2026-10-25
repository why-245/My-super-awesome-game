extends Node
class_name InteractionSystem
var current_interactable = null

func check_hover_collision(interaction_ray:RayCast3D):
	if interaction_ray.is_colliding():
		var hover_colider = interaction_ray.get_collider()
		if hover_colider and is_instance_valid(hover_colider) and hover_colider.has_method("interact") and hover_colider.has_method("show_prompt"):
			if current_interactable != hover_colider:
				if current_interactable:
					current_interactable.hide_prompt()
				current_interactable = hover_colider
				current_interactable.show_prompt()
		else:
			hide_current_prompt()
	else:
		hide_current_prompt()

func hide_current_prompt():
	if current_interactable:
		current_interactable.hide_prompt()
		current_interactable = null
