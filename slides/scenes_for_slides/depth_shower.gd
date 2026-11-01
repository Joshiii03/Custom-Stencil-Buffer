extends MeshInstance3D

func _input(event):
	if event.is_action_pressed("1"):
		material_override.set_shader_parameter("show_log_scale", not material_override.get_shader_parameter("show_log_scale"))
