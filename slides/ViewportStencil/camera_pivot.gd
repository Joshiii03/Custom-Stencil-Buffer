extends Node3D

const MOUSE_SENSETIVITY = 0.01
var vertical_look_angle = 0.0

@onready var camera_3d_stencil = $SubViewport/Camera3D
@onready var camera_3d = $SubViewportContainer/SubViewport/Camera3D

@onready var sub_viewport = $SubViewportContainer/SubViewport
@onready var sub_viewport_stencil = $SubViewport

func _ready():
	sub_viewport_stencil.size = sub_viewport.size


func _process(_delta):
	camera_3d_stencil.transform = transform
	camera_3d.transform = transform

func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		if event is InputEventMouseMotion:
			# Horizontal rotation (Y-axis)
			rotate_y(-event.relative.x * MOUSE_SENSETIVITY)
			
			vertical_look_angle = clamp(
				vertical_look_angle - event.relative.y * MOUSE_SENSETIVITY,
				deg_to_rad(-80),
				deg_to_rad(80)
			)
			rotation.x = vertical_look_angle
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif event.is_action_pressed("close"):
			get_tree().quit()
