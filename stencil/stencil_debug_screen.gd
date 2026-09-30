@tool
extends Node3D

@export var stencil_camera : StencilCamera:
	set(value):
		stencil_camera = value
		update_stencil_camera()

@export var stencil_viewport_path : String:
	set(value):
		stencil_viewport_path = value
		set_screens()

@export var screen_viewport_path : String:
	set(value):
		screen_viewport_path = value
		set_screens()

@export var normal_screen: MeshInstance3D
@export var stencil_screen: MeshInstance3D

@export var test_screen_blue: MeshInstance3D 
@export var test_screen_red: MeshInstance3D
@export var test_screen_green: MeshInstance3D


func _ready() -> void:
	update_stencil_camera()


func set_screens() -> void:
	var stencil_viewport_texture : ViewportTexture = ViewportTexture.new()
	stencil_viewport_texture.viewport_path = stencil_viewport_path
	var screen_viewport_texture : ViewportTexture = ViewportTexture.new()
	screen_viewport_texture.viewport_path = screen_viewport_path
	
	normal_screen.material_override.set_shader_parameter("texture_screen", screen_viewport_texture)
	stencil_screen.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
	
	test_screen_blue.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
	test_screen_red.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)
	test_screen_green.material_override.set_shader_parameter("texture_screen", stencil_viewport_texture)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		update_stencil_camera()


func update_stencil_camera() -> void:
	await RenderingServer.frame_post_draw
	if stencil_camera.is_inside_tree():
		stencil_viewport_path = stencil_camera.stencil_viewport.get_path()
		screen_viewport_path = stencil_camera.screen_viewport.get_path()
