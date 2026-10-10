@tool
extends MeshInstance3D


@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color1", Vector3(red,0,1))


func _init():
	if true and not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.render_priority = 1
		material_override.shader = load("uid://whmbn0jacgnb")
		stencil_layer = stencil_layer


func _ready():
	stencil_layer = stencil_layer
