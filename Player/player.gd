extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _process(_delta: float) -> void:
	look_at_mouse()
func look_at_mouse():
	var plane_mouse = Plane(Vector3(0,1,0 ), position.y)
	var ray_length = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = %Camera3D.project_ray_origin(mouse_position)
	var to = from + %Camera3D.project_ray_normal(mouse_position) * ray_length
	var mouse_position_on_screen = plane_mouse.intersects_ray(from, to)

	%Body.look_at(mouse_position_on_screen, Vector3.UP, 0)


	%Body.rotation.x = 0
	
