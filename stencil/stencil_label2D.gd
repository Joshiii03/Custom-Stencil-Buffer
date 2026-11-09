@tool
extends Control
class_name StencilLabel2D

@export var debug : bool = false

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 1, 3)
		stencil_layer = mew_value
		if stencil_layer == 1:
			material.set_shader_parameter("match_color1", Vector3(1,0,0))
		if stencil_layer == 2:
			material.set_shader_parameter("match_color1", Vector3(0,1,0))
		if stencil_layer == 3:
			material.set_shader_parameter("match_color1", Vector3(0,0,1))


func _ready():
	stencil_layer = stencil_layer
