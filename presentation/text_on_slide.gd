@tool
extends Control

@export_tool_button("") var resize = resize_all

@export_multiline() var header = "" :
	set(new_value):
		header = new_value
		%HeaderText.text = text

@export_multiline() var text = "" :
	set(new_value):
		text = new_value
		%MainText.text = text


func resize_all() -> void:
	print("resize")
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


func _init():
	resize_all()


func _ready():
	resize_all()
