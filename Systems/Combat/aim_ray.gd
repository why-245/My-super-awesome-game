extends RayCast3D
class_name AimingRay

func find_closest_enemy() -> AimTarget:
	var closest_distance_found = INF
	var closest_enemy : AimTarget = null
	
	for enemy in get_tree().get_nodes_in_group("aim_targets"):
		look_at(enemy.global_position) 
		force_raycast_update()
		
		if get_collider() != enemy:
			continue
		
		var distance_to_enemy = self.global_position.distance_to(enemy.global_position)
		
		if distance_to_enemy < closest_distance_found:
			closest_distance_found = distance_to_enemy
			closest_enemy = enemy
	self.rotation = Vector3.ZERO
	return closest_enemy
