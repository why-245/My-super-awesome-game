extends CharacterBody3D

@onready var interaction_ray = %interaction_ray
@onready var sprint_speed = 10.00
@onready var inventory_controller: InventoryController = $inventory_contoller

const SPEED = 5.0

var current_interactable = null
var current_speed = SPEED
var interaction_system = InteractionSystem.new()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	move_and_slide()
	look_at_mouse()
	#check_hover_collision()
	interaction_system.check_hover_collision(interaction_ray)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
	
	if Input.is_action_just_pressed("interact"):
		activate()
	
	if Input.is_action_just_pressed("inventory"):
		if inventory_controller.is_visible():
			inventory_controller.make_invisble()

		else:
			inventory_controller.make_visible()

	
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = SPEED

func _process(_delta: float) -> void:
	pass


func shoot_bullet():
	const bullet3D = preload("res://Entities/Objects/bullet_3d.tscn")
	var new_bullet = bullet3D.instantiate()
	%Marker3D2.add_child(new_bullet)
	new_bullet.transform = %Marker3D2.global_transform

func look_at_mouse():
	
	
	var plane_mouse = Plane(Vector3(0,1,0 ), position.y)
	var ray_length = 1000
	var mouse_position = get_viewport().get_mouse_position()
	var from = %Camera3D.project_ray_origin(mouse_position)
	var to = from + %Camera3D.project_ray_normal(mouse_position) * ray_length
	var mouse_position_on_screen = plane_mouse.intersects_ray(from, to)
	
	%Body.look_at(mouse_position_on_screen, Vector3.UP, 0)
	%Body.rotation.x = 0

func activate():
	var object = interaction_ray.get_collider()
	if object and object.has_method("interact"):
		object.interact()

	if current_interactable:
		current_interactable.hide_prompt()
		current_interactable = null
