@tool
class_name StencilWriter
extends MeshInstance3D

@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,1,0))


func _init():
	if true and not material_override:
		material_override = ShaderMaterial.new()
		material_override.shader = load("res://shader/stencil_shader/stencil_writer.gdshader")
