extends CharacterBody3D

const SPEED =3

@onready var cube_scene : PackedScene = preload("uid://dhh3hkblmc45")

func _input(event):
	if event.is_action_pressed("1"):
		var new_cube = cube_scene.instantiate()
		new_cube.position = Vector3(0,5,0)
		get_parent().add_child(new_cube)

func _physics_process(_delta):
	if not Engine.is_editor_hint():
		var input_dir = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		).normalized()
		
		#var direction = (camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var speed_factor = max(1 - Input.get_action_strength("shift"), 0.2)
		
		if input_dir != Vector2.ZERO:
			velocity.x = input_dir.x * SPEED * speed_factor
			velocity.z = input_dir.y * SPEED * speed_factor
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.z = lerp(velocity.z, 0.0, 0.1)

		move_and_slide()


func _on_area_3d_body_entered(body):
	if body.get("is_near_hole")  != null :
		body.is_near_hole = true
	else:
		print(body.name)


func _on_area_3d_body_exited(body):
	if body.get("is_near_hole") != null:
		body.is_near_hole = false
	else:
		print(body.name)
