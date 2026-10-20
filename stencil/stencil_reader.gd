@tool
class_name StencilReader
extends GeometryInstance3D

## The Reference of The Player.
@export var player : Player:
	set(mew_value):
		player = mew_value
		if player:
			stencil_camera = player.stencil_camera

## The Reference of the Stencil Camera. Is needed for finding the Stencil Viewport.
@export var stencil_camera : StencilCamera:
	set(mew_value):
		stencil_camera = mew_value
		set_screen()

@export var stencil_layer_1 : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer_1 = mew_value
		update_stencil()

@export var stencil_layer_2 : int = 0 :
	set(mew_value):
		mew_value = clamp(mew_value, 0, 25)
		stencil_layer_2 = mew_value
		update_stencil()

## If the stencil_layer_2 should be used or be ignored.
@export var use_stencil_layer_2 : bool = false:
	set(mew_value):
		use_stencil_layer_2 = mew_value
		material_override.set_shader_parameter("use_second_stencil_layer", use_stencil_layer_2)
		update_stencil()

## The Stencil layer of the Player
@export var current_stencil_layer : int = -1:
	set(mew_value) : 
		current_stencil_layer = mew_value
		var currently =  current_stencil_layer == stencil_layer_1 or (current_stencil_layer == stencil_layer_2 and use_stencil_layer_2)
		material_override.set_shader_parameter("current_stencil_infront", currently)

## Texture for replacing plain color.
@export var stencil_texture : Texture2D:
	set(mew_value):
		stencil_texture = mew_value
		material_override.set_shader_parameter("stencil_texture", mew_value)

@export var color : Color :
	set(new_value):
		color = new_value
		material_override.set_shader_parameter("show_color", color)


func _init():
	if not material_override:
		material_override = ShaderMaterial.new()
		material_override.resource_local_to_scene = true
		material_override.shader = load("res://shader/stencil_shader/stencil_reader.gdshader")
	add_to_group("Stencil_Reader")


func _ready():
	add_to_group("Stencil_Reader")
	set_screen()
	update_stencil()


## Sets the matchcolor in the shader material
func update_stencil() -> void:
	var red_1 : float  = stencil_layer_1/25.5
	material_override.set_shader_parameter("match_color_1", Vector3(red_1,0,0))
	var red_2 : float  = stencil_layer_2/25.5
	material_override.set_shader_parameter("match_color_2", Vector3(red_2,0,0))
	
	if use_stencil_layer_2:
		
		layers = int(pow(2, stencil_layer_1)) |  int(pow(2, stencil_layer_2))
	else:
		layers = int(pow(2, stencil_layer_1))


## Gets the Stencil_Texture reference from the Stencil Viewport.
func set_screen() -> void:
	if is_instance_valid(stencil_camera) and stencil_camera.is_inside_tree():
		var stencil_viewport_texture = stencil_camera.stencil_viewport.get_texture()
		material_override.set_shader_parameter("stencil_texture", stencil_viewport_texture)
