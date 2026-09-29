@tool
class_name StencilWriter
extends MeshInstance3D

@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,1,0))
