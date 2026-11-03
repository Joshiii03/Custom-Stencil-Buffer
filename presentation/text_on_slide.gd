@tool
extends Control

@export_tool_button("") var resize = resize_all
@export var empty : bool = false :
	set(new_value):
		empty = new_value
		if is_inside_tree() and get_node("%SmallerBox"):
			%SmallerBox.visible = !empty
			

@export_multiline() var slide_header = "" :
	set(new_value):
		slide_header = new_value
		if slide_header:
			%SlideHeader.text = slide_header
		elif get_node_or_null("%SlideHeader"):
			%SlideHeader.text = ""

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
		var view_size : Vector2 = get_viewport().size
		var margin = view_size.length() * 0.03
		%SmallerBox.add_theme_constant_override("margin_left", int(margin))
		%SmallerBox.add_theme_constant_override("margin_right", int(margin))
		%SmallerBox.add_theme_constant_override("margin_top", int(margin))
		%SmallerBox.add_theme_constant_override("margin_bottom", int(margin))
		
		%SmallerBox2.add_theme_constant_override("margin_left", int(margin * 2))
		%SmallerBox2.add_theme_constant_override("margin_right", int(margin * 2))
		%SmallerBox2.add_theme_constant_override("margin_top", int(margin * 2))
		%SmallerBox2.add_theme_constant_override("margin_bottom", int(margin * 2))
		
		%TextMarginBox.add_theme_constant_override("margin_left", int(margin))
		%TextMarginBox.add_theme_constant_override("margin_right", int(margin))
		%TextMarginBox.add_theme_constant_override("margin_top", int(margin))
		%TextMarginBox.add_theme_constant_override("margin_bottom", int(margin))
		
		if %HeaderText.text:
			%HeaderText.custom_minimum_size = Vector2(0, view_size.y / 6.)
		else:
			%HeaderText.custom_minimum_size = Vector2(0,0)
		if %SlideHeader.text:
			%SlideHeader.custom_minimum_size = Vector2(0, view_size.y / 6.)
			%SlideHeader.custom_maximum_size = Vector2(99999, view_size.y / 6.)
			%SmallerBox.add_theme_constant_override("margin_top", int(margin * 2 + view_size.y / 6. ))
		else:
			%SlideHeader.custom_minimum_size =  Vector2(0,0)
		
		if empty:
			%SmallerBox.visible = false
			%SmallerBox2.visible = false


func _init():
	resize_all()


func _ready():
	resize_all()
