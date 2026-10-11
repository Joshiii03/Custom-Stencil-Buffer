@tool
class_name StencilCamera
extends Node3D

@export var stencil_viewport : Viewport
@export var screen_viewport : Viewport

@export var stencil_camera : Camera3D 
@export var screen_camera : Camera3D
@onready var stencil_debug_screen = $ScrrenSubViewport/ScreenViewport/Camera3D/StencilDebugScreen
@onready var backround_stencil = $BackroundStencil

@export var backround_stencil_layer : int = 0:
	set(value):
		backround_stencil_layer = value
		if backround_stencil:
			backround_stencil.stencil_layer = backround_stencil_layer


@export var debug_screen : bool = false:
	set(value) :
		debug_screen = value
		update_debugscreen()


func set_camera_transform() -> void:
	if Engine.is_editor_hint():
		if is_instance_valid(stencil_camera):
			stencil_camera.transform = EditorInterface.get_editor_viewport_3d(0).get_camera_3d().global_transform
		#if is_instance_valid(screen_camera):
			#screen_camera.transform = EditorInterface.get_editor_viewport_3d(0).get_camera_3d().global_transform
	else:
		if is_instance_valid(stencil_camera):
			stencil_camera.transform = global_transform
		if is_instance_valid(screen_camera):
			screen_camera.transform = global_transform


func _ready() -> void:
	update_debugscreen()
	backround_stencil.visible = true

func update_debugscreen() -> void:
	if stencil_debug_screen:
		stencil_debug_screen.visible = debug_screen


func _process(_delta: float) -> void:
	set_camera_transform()
