@tool
class_name Player
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 7
const MOUSE_SENSETIVITY = 0.01
const GRAVITY = 9.8

@onready var stencil_camera: StencilCamera = $CameraPivot/StencilCamera
@onready var camera_pivot: Node3D = $CameraPivot

var vertical_look_angle = 0.0


func _physics_process(delta):
	if not Engine.is_editor_hint():
		var input_dir = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		).normalized()
		
		var direction = (camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction != Vector3.ZERO:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
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
