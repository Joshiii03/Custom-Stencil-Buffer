@tool
class_name StencilCamera
extends Node3D

@export var stencil_viewport : Viewport
@export var screen_viewport : Viewport

@export var stencil_camera : Camera3D 
@export var screen_camera : Camera3D


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		print("moved")
		set_camera_transform()


func set_camera_transform() -> void:
	if is_instance_valid(stencil_camera):
		stencil_camera.transform = transform
	if is_instance_valid(screen_camera):
		screen_camera.transform = transform


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	set_camera_transform()
