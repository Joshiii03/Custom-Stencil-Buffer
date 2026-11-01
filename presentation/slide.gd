class_name Slide
extends Node

@export var slide_name: String = "New Slide"
@export var comments : Array[String] = []

@export_file_path("*tscn") var scene  
@export var use_scene : bool = true

func _ready():
	if scene and use_scene:
		var new_scene = load(scene).instantiate()
		get_parent().add_child(new_scene)
