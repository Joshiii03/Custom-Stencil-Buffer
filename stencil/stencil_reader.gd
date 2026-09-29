extends MeshInstance3D

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


#@export var screen_texture : Texture2D:
	#set(value):
		#screen_texture = value
		#material_override.set_shader_parameter("screen_texture", value)
