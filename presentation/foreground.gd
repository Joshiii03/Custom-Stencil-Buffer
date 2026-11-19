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
		%Logo.visible = current_slide.use_cf_logo
		
		if current_slide.use_cf_top_left:
			%TopLeft.text = current_slide.cf_top_left
			%TopLeft.visible = true
		else:
			%TopLeft.text = current_slide.slide_name
			%TopLeft.visible = not current_slide.is_empty
		
		if current_slide.use_cf_top_right:
			%TopRight.text = current_slide.cf_top_right
		else:
			%TopRight.text = ""
		
		if current_slide.use_cf_buttom_left:
			%BottomLeft.text = current_slide.cf_buttom_left
		else:
			%BottomLeft.text = ""
		
		if current_slide.use_cf_buttom_right:
			%BottomRight.text = current_slide.cf_buttom_right
			%BottomRight.visible = true
		else:
			%BottomRight.text = str(presentation.current_index +1) + " / " + str(presentation.slide_count)
			%BottomRight.visible = not current_slide.is_empty
	else:
		%Logo.visible = true
		%TopLeft.text = current_slide.name
		%TopLeft.visible = true
		%BottomRight.visible = true
		%BottomRight.text = str(presentation.current_index +1) + " / " + str(presentation.slide_count)
	
	
	
	if get_viewport() :
		var view_size : Vector2 = get_viewport().size
		var margin = view_size.length() * 0.02
		%TopLeft.custom_minimum_size = Vector2(0,margin)
		%TopRight.custom_minimum_size = Vector2(0,margin)
		%BottomLeft.custom_minimum_size = Vector2(0,margin)
		%BottomRight.custom_minimum_size = Vector2(0,margin)



func _on_visibility_changed():
	pass
	#_ready()
