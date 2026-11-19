extends StaticBody3D

func _on_interaction_component_interacted() -> void:
	queue_free()
