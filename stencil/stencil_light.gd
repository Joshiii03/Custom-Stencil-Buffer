@tool
class_name StencilLight
extends Light3D


## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer = mew_value

func _ready():
	light_cull_mask = int(pow(2, stencil_layer))
	#layers = int(pow(2, stencil_layer))
