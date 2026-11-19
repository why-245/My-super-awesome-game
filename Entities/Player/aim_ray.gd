extends RayCast3D
class_name AimingRay


func _physics_process(_delta: float) -> void:
	look_at_mouse()

#func find_closest_target() -> AimTarget:
#	var closest_distance_found = INF
#	var closest_target : AimTarget = null
#	
#	for target in get_tree().get_nodes_in_group("AimTargets"):
#		look_at(target.global_position)
#		force_raycast_update()
#		if get_collider() == target:
#			continue
#			print("wda")
#		var distance_to_target = self.global_position.distance_to(target.global_position)
#		
#		if distance_to_target < closest_distance_found:
#			closest_distance_found = distance_to_target
#			closest_target = target
#	self.rotation = Vector3.ZERO
#	return closest_target

func look_at_mouse():
	var plane_mouse = Plane(Vector3(0,1,0 ), position.y)
	var ray_length = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = %Camera3D.project_ray_origin(mouse_position)
	var to = from + %Camera3D.project_ray_normal(mouse_position) * ray_length
	var mouse_position_on_screen = plane_mouse.intersects_ray(from, to)
	
	look_at(mouse_position_on_screen, Vector3.UP, 0)
	rotation.x = 0
	
