@tool
class_name StencilReader
extends MeshInstance3D

@export var current_stencil_layer : int = -1:
	set(value) : 
		current_stencil_layer = value
		var currently =  current_stencil_layer == stencil_layer or (current_stencil_layer == stencil_layer_2 and use_stencil_layer_2)
		material_override.set_shader_parameter("current_stencil_infront", currently)

@export var player : Player:
	set(value):
		player = value
		if player:
			stencil_camera = player.stencil_camera

@export var stencil_camera : StencilCamera:
	set(value):
		stencil_camera = value
		set_screen()

#TODO: rename to stencil_layer_1
@export var stencil_layer : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer = value
		var red : float  = stencil_layer/25.5
		material_override.set_shader_parameter("match_color_1", Vector3(red,0,0))

@export var stencil_layer_2 : int = 0 :
	set(value):
		value = clamp(value, 0, 25)
		stencil_layer_2 = value
		var red : float  = stencil_layer_2/25.5
		material_override.set_shader_parameter("match_color_2", Vector3(red,0,0))

@export var use_stencil_layer_2 : bool = false:
	set(value):
		use_stencil_layer_2 = value
		material_override.set_shader_parameter("use_second_stencil_layer", use_stencil_layer_2)

@export var stencil_texture : Texture2D:
	set(value):
		stencil_texture = value
		material_override.set_shader_parameter("stencil_texture", value)


func _init():
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.shader = load("res://shader/stencil_shader/stencil_reader.gdshader")
	add_to_group("Stencil_Reader")


func ready():
	add_to_group("Stencil_Reader")
	set_screen()
	stencil_layer = stencil_layer
	stencil_layer_2 = stencil_layer_2


func set_screen() -> void:
	if is_instance_valid(stencil_camera) and stencil_camera.is_inside_tree():
		var stencil_viewport_texture = stencil_camera.stencil_viewport.get_texture()
		material_override.set_shader_parameter("stencil_texture", stencil_viewport_texture)
