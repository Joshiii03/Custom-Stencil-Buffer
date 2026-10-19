@tool
class_name StencilCamera
extends Node3D

@export var stencil_viewport : Viewport
@export var screen_viewport : Viewport

@export var stencil_camera : Camera3D 
@export var screen_camera : Camera3D
@onready var backround_stencil = $BackroundStencil
@onready var debug_screen : Control = $ScrrenSubViewport/ScreenViewport/DebugScreen

@export var backround_stencil_layer : int = 0:
	set(value):
		backround_stencil_layer = value
		if backround_stencil:
			backround_stencil.stencil_layer = backround_stencil_layer

@export var use_debug_screen : bool = false:
	set(value) :
		use_debug_screen = value
		update_debugscreen()


func _ready() -> void:
	update_debugscreen()
	backround_stencil.visible = !Engine.is_editor_hint()


func _process(_delta: float) -> void:
	set_camera_transform()


func set_camera_transform() -> void:
	if Engine.is_editor_hint():
		if is_instance_valid(stencil_camera):
			stencil_camera.transform = EditorInterface.get_editor_viewport_3d(0).get_camera_3d().global_transform
	else:
		if is_instance_valid(stencil_camera):
			stencil_camera.transform = global_transform
		if is_instance_valid(screen_camera):
			screen_camera.transform = global_transform


func update_debugscreen() -> void:
	if debug_screen:
		debug_screen.visible = use_debug_screen
