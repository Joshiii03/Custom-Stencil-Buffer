@tool
class_name StencilCamera
extends Node3D

@export var stencil_viewport : Viewport
@export var screen_viewport : Viewport

@export var stencil_camera : Camera3D 
@export var screen_camera : Camera3D
@onready var stencil_debug_screen = $ScrrenSubViewport/ScreenViewport/Camera3D/StencilDebugScreen


@export var debug_screen : bool = false:
	set(value) :
		debug_screen = value
		update_debugscreen()


func set_camera_transform() -> void:
	if is_instance_valid(stencil_camera):
		stencil_camera.transform = global_transform
	if is_instance_valid(screen_camera):
		screen_camera.transform = global_transform


func _ready() -> void:
	update_debugscreen()

func update_debugscreen() -> void:
	if stencil_debug_screen:
		stencil_debug_screen.visible = debug_screen


func _process(_delta: float) -> void:
	set_camera_transform()
