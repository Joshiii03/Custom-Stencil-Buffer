@tool
class_name StencilCamera
extends Node3D

@export var stencil_viewport : Viewport
@export var screen_viewport : Viewport

@export var stencil_camera : Camera3D 
@export var screen_camera : Camera3D
@onready var backround_stencil = $BackroundStencil
@export var use_backround_stencil : bool = true
@onready var debug_screen : Control = $ScrrenSubViewport/ScreenViewport/DebugScreen

@export var backround_stencil_layer : int = 0:
	set(mew_value):
		backround_stencil_layer = mew_value
		if backround_stencil:
			print("backround_stencil: ", backround_stencil_layer)
			backround_stencil.stencil_layer = backround_stencil_layer

@export var use_debug_screen : bool = false:
	set(mew_value) :
		use_debug_screen = mew_value
		update_debugscreen()


func _ready() -> void:
	backround_stencil_layer = backround_stencil_layer
	update_debugscreen()
	if stencil_camera:
		stencil_camera.cull_mask = 67108864 # int(pow(2, 26))
	if screen_camera:
		screen_camera.cull_mask = 33554431 # int(pow(2, 26)- pow(2, 25)-1)
	
	stencil_viewport.size = screen_viewport.size
	
	if Engine.is_editor_hint():
		EditorInterface.get_editor_viewport_3d(0).get_camera_3d().cull_mask = int(pow(2, 29)- pow(2, 25)-1)
		backround_stencil.visible = use_backround_stencil
	else :
		backround_stencil.visible = use_backround_stencil

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
