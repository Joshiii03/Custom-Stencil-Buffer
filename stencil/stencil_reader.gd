extends MeshInstance3D

@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value

@export var stencil_texture : Texture2D:
	set(value):
		stencil_texture = value
		material_override.set_shader_parameter("stencil_texture", value)
