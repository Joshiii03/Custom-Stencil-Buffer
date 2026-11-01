@tool
class_name Slide
extends Node

@export var slide_name: String = "New Slide"
@export var comments : Array[String] = []

@export_file_path("*tscn") var scene  
@export var use_scene : bool = true

func _ready():
	if scene and use_scene and not Engine.is_editor_hint():
		var new_scene = load(scene).instantiate()
		get_parent().add_child(new_scene)
	else:
		resize_all()


func _init():
	resize_all()


func _input(event):
	if event.is_action_pressed("jump"):
		pass
		#print("###################################")
		#print(%HeaderText.get_rendered_font_size())
		#print(%MainText.get_rendered_font_size())


func resize_all() -> void:
	pass
	#if get_viewport():
	#	var view_size = get_viewport().size
	#	var scale : float = 0.9
	#	%SmallerBox.scale = Vector2(scale, scale)
	#	%SmallerBox.position = view_size / 2. * (1 - scale)
	#	%TextContainer.scale = Vector2(scale, scale)
	#	%TextContainer.position = view_size / 2. * (1 - scale)
	#	if %HeaderText.text:
	#		%HeaderText.custom_minimum_size = Vector2(0, view_size.y / 6.)
	#	else:
	#		%HeaderText.custom_minimum_size = Vector2(0,0)
	#	#%MainText
