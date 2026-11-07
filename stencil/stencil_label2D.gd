@tool
extends Label
class_name StencilLabel2D

@export var debug : bool = false

## Stencil that is written on the Stencil Viewport.
@export var stencil_layer : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer = mew_value
		var red : float  = stencil_layer/25.5
		modulate =  Color(red,0.,0., 1)
		set("theme_override_colors/font_color",  Color(red,0.,0., 1))
		self_modulate = Color(red,0.,0., 1)
		#theme_override_colors/font_color
		#add_theme_constant_override("font_color", Color(red,0.,0., 1))
		#material_override.set_shader_parameter("match_color1", Vector3(red,1,0))


func _ready():
	stencil_layer = stencil_layer
