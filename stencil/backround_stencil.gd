@tool
extends MeshInstance3D


@export var stencil_layer : int = 0 :
	set(new_value):
		new_value = clamp(new_value, 0, 25)
		stencil_layer = new_value
		update_stencil()


func _init():
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.render_priority = 1
		material_override.shader = load("uid://whmbn0jacgnb")
		update_stencil()


func _ready():
	layers = 67108864 # int(pow(2, 26))
	update_stencil()


func update_stencil() -> void:
	var red : float  = stencil_layer/25.5
	material_override.set_shader_parameter("match_color1", Vector3(red,0,1))
