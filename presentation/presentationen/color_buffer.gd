extends ColorRect

func _ready():
	material.set_shader_parameter("texture_screen", get_viewport().get_texture())
	
