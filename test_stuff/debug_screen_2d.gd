@tool
extends ColorRect

@export var viewport : Viewport:
	set(new_value):
		viewport = new_value
		if viewport:
			var viewport_texture = viewport.get_texture()
			material.set_shader_parameter("texture_screen", viewport_texture)

@export var filter_r : bool:
	set(new_value):
		filter_r = new_value
		material.set_shader_parameter("filter_r", filter_r)

@export var filter_g : bool:
	set(new_value):
		filter_g = new_value
		material.set_shader_parameter("filter_g", filter_g)

@export var filter_b : bool:
	set(new_value):
		filter_b = new_value
		material.set_shader_parameter("filter_b", filter_b)
