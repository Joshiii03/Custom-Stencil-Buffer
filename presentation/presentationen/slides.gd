@tool
extends Node

@export_tool_button("shut down all slides") var test  = all_invisible

func all_invisible() -> void:
	for child in get_children():
		if child is Slide:
			for sub_child in child.get_children():
				sub_child.visible = false
		else:
			child.visible = false
