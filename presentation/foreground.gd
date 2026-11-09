extends Control

@export var autoconnect : bool = false
@export var debug : bool = false

func _ready():
	if autoconnect:
		var last_parent = get_parent()
		while not last_parent is Presentation and last_parent != get_tree() and last_parent:
			last_parent = last_parent.get_parent()
		
		if last_parent is Presentation:
			last_parent.update_UI.connect(update_UI)
		else:
			visible = false




func update_UI(presentation : Presentation) -> void:
	if debug:
		print("update UI: ", self.name)
	var current_slide = presentation.get_slide()
	if current_slide is Slide:
		%TopLabel.text = current_slide.slide_name
		%TopLabel.visible = not current_slide.is_empty
		%BottomLabel.visible = not current_slide.is_empty
	else:
		%TopLabel.text = current_slide.name
		%TopLabel.visible = true
		%BottomLabel.visible = true
	%BottomLabel.text = str(presentation.current_index +1) + " / " + str(presentation.slide_count)
	
	if get_viewport() :
		var view_size : Vector2 = get_viewport().size
		var margin = view_size.length() * 0.02
		%TopLabel.custom_minimum_size = Vector2(0,margin)
		%BottomLabel.custom_minimum_size = Vector2(0,margin)


func _on_visibility_changed():
	pass
	#_ready()
