@tool
class_name MultiSlide
extends Slide

const text_path = preload("uid://bfcmqnc25xxqs")
var sub_slide : int = 0

@export_tool_button("new slide") var new_slide = add_new_slide

func add_new_slide() -> void:
	print("creating new")
	
	var new = text_path.instantiate()
	add_child(new)
	new.owner = self
	for oprh in get_orphan_node_ids():
		print(oprh)
