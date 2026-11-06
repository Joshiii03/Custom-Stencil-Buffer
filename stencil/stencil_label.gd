@tool
class_name StencilLabel
extends Label3D

@export var debug : bool = false

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer = mew_value
		var red : float  = stencil_layer/25.5
		modulate =  Color(red,0.,1., 1)
		
		#material_override.set_shader_parameter("match_color1", Vector3(red,1,0))


func _ready():
	layers = 67108864 # int(pow(2, 26))
	stencil_layer = stencil_layer
