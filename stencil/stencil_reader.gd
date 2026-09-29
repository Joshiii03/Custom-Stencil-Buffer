@tool
class_name StencilReader
extends MeshInstance3D


@export var stencil_camera : StencilCamera:
	set(value):
		print("Hello?")
		stencil_camera = value
		stencil_viewport_path = stencil_camera.stencil_viewport.get_path()

@export var stencil_viewport_path : String:
	set(value):
		print("set stencil_viewport_path")
		stencil_viewport_path = value
		set_screen()

@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,0,0))

@export var stencil_texture : Texture2D:
	set(value):
		stencil_texture = value
		material_override.set_shader_parameter("stencil_texture", value)


func set_screen() -> void:
	
	var stencil_viewport_texture : ViewportTexture = ViewportTexture.new()
	stencil_viewport_texture.viewport_path = stencil_viewport_path
	print("set stencil_viewport_texture")
	
	material_override.set_shader_parameter("stencil_texture", stencil_viewport_texture)
