class_name ListenerWindow
extends Window


@onready var sub_viewport = $SubViewportContainer/SubViewport

var main : Presentationmanager

# TODO: Input has to be singaled between Windows
func _on_window_input(event):
	if main:
		main._input(event)


func get_viewport_texture() -> ViewportTexture:
	return sub_viewport.get_texture()


func get_subviewport() -> Viewport:
	return sub_viewport


var slide : Node

func show_new_slide(new_slide_path : String) -> Node:
	for child in sub_viewport.get_children():
		child.queue_free.call_deferred()
	slide = load(new_slide_path).instantiate()
	sub_viewport.add_child(slide)
	return slide
