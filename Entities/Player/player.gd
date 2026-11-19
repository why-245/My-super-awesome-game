extends CharacterBody3D
class_name Player

@export var aiming_ray : AimingRay
@export var inventory_data : InventoryData

var  SPEED = 5.0
var  sprint_speed = 10.00
var current_speed = SPEED
var rotation_speed = 10

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir != Vector2(0,0):
			%Body.rotation.y = lerp_angle(%Body.rotation.y, atan2(-direction.x, -direction.z), delta * rotation_speed)
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	move_and_slide()
	
	if Input.is_action_pressed("aim"):
		look_at_aiming_ray()
	
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = SPEED

func auto_aim():
	var target = aiming_ray.find_closest_target()
	if target == null:
		return
		
	var target_position = Vector3(target.global_position.x, self.global_position.y, target.global_position.z)
	aiming_ray.look_at(target_position)
	aiming_ray.rotation.x = 90

func look_at_aiming_ray():
	
	%Body.look_at(aiming_ray.get_child(0).global_position)
	%Body.rotation.x = 0
