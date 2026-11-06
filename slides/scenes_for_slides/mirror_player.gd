class_name MirrorPlayer
extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 7
const MOUSE_SENSETIVITY = 0.01
const GRAVITY = 9.8

@onready var camera_pivot: Node3D = $CameraPivot
@onready var other_me = $OtherMe

@export var mirror : Node3D

var vertical_look_angle = 0.0



func _physics_process(delta):
	if not Engine.is_editor_hint():
		var input_dir = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		).normalized()
		
		var direction = (camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var speed_factor = max(1 - Input.get_action_strength("shift"), 0.2)
		
		if direction != Vector3.ZERO:
			velocity.x = direction.x * SPEED * speed_factor
			velocity.z = direction.z * SPEED * speed_factor
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
			velocity.z = lerp(velocity.z, 0.0, 0.1)
		
		# Gravity and Jump
		if not is_on_floor():
			velocity.y -= GRAVITY * delta
		else:
			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMP_VELOCITY
		move_and_slide()
		other_me.global_position = Vector3(-mirror.global_position.x + global_position.x, global_position.y , mirror.global_position.z * 2 - global_position.z)
		other_me.rotation = Vector3(-camera_pivot.rotation.x, -camera_pivot.rotation.y, camera_pivot.rotation.z)

func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		if event is InputEventMouseMotion:
			# Horizontal rotation (Y-axis)
			camera_pivot.rotate_y(-event.relative.x * MOUSE_SENSETIVITY)
			
			vertical_look_angle = clamp(
				vertical_look_angle - event.relative.y * MOUSE_SENSETIVITY,
				deg_to_rad(-80),
				deg_to_rad(80)
			)
			
			camera_pivot.rotation.x = vertical_look_angle
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("close"):
			get_tree().quit()
