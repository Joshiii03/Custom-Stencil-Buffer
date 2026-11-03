class_name ListenerWindow
extends Window


@onready var sub_viewport = $SubViewportContainer/SubViewport

var main : Presentationmanager


func _on_window_input(event):
	if main:
		main._input(event)


func get_viewport_texture() -> ViewportTexture:
	return sub_viewport.get_texture()


func get_subviewport() -> Viewport:
	return sub_viewport


var slide : Node
