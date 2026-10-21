@tool
class_name Player
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 7
const MOUSE_SENSETIVITY = 0.01
const GRAVITY = 9.8

@onready var stencil_camera: StencilCamera = $CameraPivot/StencilCamera
@onready var camera_pivot: Node3D = $CameraPivot

@export var stencil_layer : int = 0 :
	set(new_value):
		new_value = clamp(new_value, 0, 25)
		stencil_layer = new_value
		update_stencil()

var vertical_look_angle = 0.0


func _ready():
	update_stencil()


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
	if event.is_action_pressed("ui_accept"):
		print("test")
		change_stencil_layer()


func update_stencil() -> void:
	if is_inside_tree():
		if stencil_camera:
			stencil_camera.backround_stencil_layer = stencil_layer
		for stencil_reader in get_tree().get_nodes_in_group("Stencil_Reader"):
			stencil_reader.current_stencil_layer = stencil_layer
		for portal in get_tree().get_nodes_in_group("Portal"):
			portal.update_portal_layer()
		update_colision()


## changes the colision-layer and -mask of every direct child
func update_colision() -> void:
	collision_layer = get_stencil_mask() | int(pow(2, 25))
	collision_mask = get_stencil_mask() | int(pow(2, 25))


func get_stencil_mask() -> int:
	return int(pow(2, stencil_layer))


## Cycles the Stencil Layer
func change_stencil_layer() -> int:
	stencil_layer = (stencil_layer + 1) % 4
	return stencil_layer
