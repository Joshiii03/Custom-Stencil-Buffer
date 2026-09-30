@tool
extends Node3D

@export var stencil_camera : StencilCamera:
	set(value):
		stencil_camera = value
		set_screens()

@export var normal_screen: MeshInstance3D
@export var stencil_screen: MeshInstance3D

@export var test_screen_blue: MeshInstance3D 
@export var test_screen_red: MeshInstance3D
@export var test_screen_green: MeshInstance3D


func _ready() -> void:
	set_screens()


func set_screens() -> void:
	if (stencil_camera) && stencil_camera.is_inside_tree():
		if is_instance_valid(stencil_camera.stencil_viewport):
			var stencil_viewport_texture = stencil_camera.stencil_viewport.get_texture()
			var screen_viewport_texture = stencil_camera.screen_viewport.get_texture()
			
			normal_screen.material_override.set_shader_parameter("texture_screen", screen_viewport_texture)
			stencil_screen.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
			
			test_screen_blue.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
			test_screen_red.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
			test_screen_green.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
