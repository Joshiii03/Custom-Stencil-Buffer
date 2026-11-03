
class_name Presentation
extends Node

var current_index: int = 0


func _ready() -> void:
	for child in get_children():
		if not child is Slide:
			child.visible = false

	show_slide(0)


func show_slide(index: int) -> void:
	if index < 0 or index >= get_child_count():
		return
	
	# Deactivate previous slide
	if current_index < get_child_count():
		var previous = get_child(current_index)
		
		if previous is Slide:
			previous.deactivate()
		else:
			previous.visible = false
	
	current_index = index
	
	# Activate current slide
	var current = get_child(current_index)
	
	if current is Slide:
		current.activate()
	else:
		current.visible = true
	
	# Prepare upcoming slides
	for offset in range(1, 4):
		var next_index = current_index + offset
		
		if next_index < get_child_count():
			var next = get_child(next_index)
			
			if next is Slide:
				next.prepare()


func show_next_slide() -> void:
	show_slide((current_index + 1) % get_child_count())


func show_prev_slide() -> void:
	show_slide((current_index - 1 + get_child_count()) % get_child_count())
