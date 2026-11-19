@tool
extends Control

@export_tool_button("") var resize = resize_all
@export var empty : bool = false :
	set(new_value):
		empty = new_value
		if is_inside_tree() and get_node_or_null("upper_header_box"):
			upper_header_box.visible = !empty


@export_multiline() var slide_header = "" :
	set(new_value):
		slide_header = new_value
		if slider_header_label:
			slider_header_label.text = slide_header

@export_multiline() var header = "" :
	set(new_value):
		header = new_value
		if lower_header_label:
			lower_header_label.text = header


@export_multiline() var text = "" :
	set(new_value):
		text = new_value
		if main_label:
			main_label.text = text


@export_multiline() var bottom_text = "":
	set(new_value):
		bottom_text = new_value
		if bottom_label:
			bottom_label.text = bottom_text

@export_category("Node References")
@export var upper_header_box : MarginContainer
@export var main_box : MarginContainer
@export var main_text_box : MarginContainer

@export var slider_header_label : Label
@export var lower_header_label : Label
@export var main_label : Label
@export var bottom_label : Label

@export var white_backround : ColorRect

func resize_all() -> void:
	if get_viewport():
		var view_size : Vector2 = get_viewport().size
		var margin = view_size.length() * 0.03
		upper_header_box.add_theme_constant_override("margin_left", int(margin))
		upper_header_box.add_theme_constant_override("margin_right", int(margin))
		upper_header_box.add_theme_constant_override("margin_top", int(margin))
		upper_header_box.add_theme_constant_override("margin_bottom", int(margin))
		
		main_box.add_theme_constant_override("margin_left", int(margin * 2))
		main_box.add_theme_constant_override("margin_right", int(margin * 2))
		main_box.add_theme_constant_override("margin_top", int(margin * 2))
		main_box.add_theme_constant_override("margin_bottom", int(margin * 2))
		
		main_text_box.add_theme_constant_override("margin_left", int(margin))
		main_text_box.add_theme_constant_override("margin_right", int(margin))
		main_text_box.add_theme_constant_override("margin_top", int(margin))
		main_text_box.add_theme_constant_override("margin_bottom", int(margin))
		
		if lower_header_label.text:
			lower_header_label.custom_minimum_size = Vector2(0, view_size.y / 6.)
		else:
			lower_header_label.custom_minimum_size = Vector2(0,0)
		
		if slider_header_label.text:
			slider_header_label.custom_minimum_size = Vector2(0, view_size.y / 6.)
			slider_header_label.custom_maximum_size = Vector2(99999, view_size.y / 6.)
			main_box.add_theme_constant_override("margin_top", int(margin * 2 + view_size.y / 6. ))
		else:
			slider_header_label.custom_minimum_size =  Vector2(0,0)
		if bottom_label.text == "":
			bottom_label.size_flags_vertical = 0
		
		
		if empty:
			upper_header_box.visible = false
			main_box.visible = false
		
		await get_tree().process_frame
		if white_backround.size != Vector2.ZERO:
			white_backround.material.set_shader_parameter("rect_size", white_backround.size)


func _init():
	resize_all()


func _ready():
	resize_all()


func _on_white_backround_visibility_changed():
	resize_all()
