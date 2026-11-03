@tool
extends Control

@export_tool_button("") var resize = resize_all
@export var empty : bool = false :
	set(new_value):
		empty = new_value
		if is_inside_tree() and get_node("%SmallerBox"):
			%SmallerBox.visible = !empty

@export_multiline() var header = "" :
	set(new_value):
		header = new_value
		if header:
			%HeaderText.text = header

@export_multiline() var text = "" :
	set(new_value):
		text = new_value
		if text:
			%MainText.text = text


func resize_all() -> void:
	if get_viewport():
		var view_size = get_viewport().size
		var text_scale : float = 0.9
		%SmallerBox.scale = Vector2(text_scale, text_scale)
		%SmallerBox.position = view_size / 2. * (1 - text_scale)
		%TextContainer.scale = Vector2(text_scale, text_scale)
		%TextContainer.position = view_size / 2. * (1 - text_scale)
		if %HeaderText.text:
			%HeaderText.custom_minimum_size = Vector2(0, view_size.y / 6.)
		else:
			%HeaderText.custom_minimum_size = Vector2(0,0)
	if empty:
		%SmallerBox.visible = false

func _init():
	resize_all()


func _ready():
	resize_all()
