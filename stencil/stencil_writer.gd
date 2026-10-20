@tool
class_name StencilWriter
extends MeshInstance3D

@export var debug : bool = false

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		if debug:
			print("Change Stecil from:", str(stencil_layer), " to: ", str(mew_value))
		stencil_layer = mew_value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,1,0))


func _init():
	if true and not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.render_priority = -1
		material_override.shader = load("res://shader/stencil_shader/stencil_writer.gdshader")


func _ready():
	layers = 67108864 # int(pow(2, 26))
