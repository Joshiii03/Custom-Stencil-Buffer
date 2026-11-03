
class_name Presentation
extends Node

var current_index: int = 0
@onready var slides = $Slides
@onready var backround = $Backround

var slide_count : int = 0:
	get():
		print(slides.get_children())
		return slides.get_child_count()


func _ready() -> void:
	for child in slides.get_children():
		if child is Slide:
			child.deactivate()
		else:
			child.visible = false

	show_slide(0)


func get_slide() -> Slide:
	var slide = slides.get_children()[current_index]
	if slide is Slide:
		return slide
	else:
		return null


func show_slide(index: int) -> void:
	if index < 0 or index >= slide_count:
		return
	
	# Deactivate previous slide
	if current_index < slide_count:
		var previous = slides.get_child(current_index)
		
		if previous is Slide:
			previous.deactivate()
		else:
			previous.visible = false
	
	current_index = index
	
	# Activate current slide
	var current = slides.get_child(current_index)
	if current is Slide:
		current.activate()
		backround.visible = not current.is_spawning_scene
	else:
		current.visible = true
		backround.visible = true
	
	# Prepare upcoming slides
	for offset in range(1, 4):
		var next_index = current_index + offset
		if next_index < slide_count:
			var next = slides.get_child(next_index)
			if next is Slide:
				next.prepare()


func show_next_slide() -> void:
	show_slide((current_index + 1) % slides.get_child_count())


func show_prev_slide() -> void:
	show_slide((current_index - 1 + slides.get_child_count()) % slides.get_child_count())
