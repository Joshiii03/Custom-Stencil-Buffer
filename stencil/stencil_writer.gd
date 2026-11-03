@tool
class_name StencilWriter
extends GeometryInstance3D

@export var debug : bool = false

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer = mew_value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,1,0))

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer_2 : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer_2 = mew_value
		var red : float  = stencil_layer_2/25.5
		material_override.set_shader_parameter("match_color2", Vector3(red,1,0))

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer_3 : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer_3 = mew_value
		var red : float  = stencil_layer_3/25.5
		material_override.set_shader_parameter("match_color3", Vector3(red,1,0))

func _init():
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.render_priority = -1
		material_override.shader = load("res://shader/stencil_shader/stencil_writer.gdshader")


func _ready():
	layers = 67108864 # int(pow(2, 26))
