extends StaticBody3D

@export var slot_data : SlotData


#func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	#print("wse")
	#if body.inventory_data_pick_up(slot_data):
		#queue_free()
