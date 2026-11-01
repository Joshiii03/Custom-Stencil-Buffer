@tool
class_name MultiSlide
extends Slide

const text_path = preload("uid://bfcmqnc25xxqs")
@export var sub_slide : int = -1

signal  finished

@export_tool_button("new slide") var new_slide = add_new_slide
@export_tool_button("next slide") var show_next_slide = next_sub_slide

func add_new_slide() -> void:
	print("creating new")
	
	var new = text_path.instantiate()
	add_child(new)
	new.owner = self


func _ready():
	if not Engine.is_editor_hint():
		sub_slide = -1
		next_sub_slide()


func next_sub_slide() -> void:
	sub_slide += 1
	if sub_slide >= get_child_count() :
		
		finished.emit()
		sub_slide = 0
	
	print(sub_slide)
	for slide in get_children():
		slide.visible = false
	get_children()[sub_slide].visible = true
	
