extends CharacterBody3D

var health = 3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
func take_damage():
		health -= 1
		
		if health == 0:
			queue_free()
