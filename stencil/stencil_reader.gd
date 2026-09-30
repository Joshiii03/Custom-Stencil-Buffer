@tool
class_name StencilReader
extends MeshInstance3D


@export var player : Player:
	set(value):
		player = value
		stencil_camera = player.stencil_camera

@export var stencil_camera : StencilCamera:
	set(value):
		stencil_camera = value
		set_screen()

@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color", Vector3(red,0,0))

@export var stencil_texture : Texture2D:
	set(value):
		stencil_texture = value
		material_override.set_shader_parameter("stencil_texture", value)


func _init():
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.shader = load("res://shader/stencil_shader/stencil_reader.gdshader")


func ready():
	set_screen()


func set_screen() -> void:
	if is_instance_valid(stencil_camera) and stencil_camera.is_inside_tree():
		var stencil_viewport_texture = stencil_camera.stencil_viewport.get_texture()
		material_override.set_shader_parameter("stencil_texture", stencil_viewport_texture)
	else:
		push_warning("StencilCamera not found")
