@tool
extends ColorRect

@export var viewport : Viewport:
	set(value):
		viewport = value
		var viewport_texture = viewport.get_texture()
		material.set_shader_parameter("texture_screen", viewport_texture)

@export var filter_r : bool:
	set(value):
		filter_r = value
		material.set_shader_parameter("filter_r", filter_r)

@export var filter_g : bool:
	set(value):
		filter_g = value
		material.set_shader_parameter("filter_g", filter_g)

@export var filter_b : bool:
	set(value):
		filter_b = value
		material.set_shader_parameter("filter_b", filter_b)
