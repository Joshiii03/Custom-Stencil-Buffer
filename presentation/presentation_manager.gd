class_name Presentationmanager
extends Control


const listener_Window_path = preload("uid://bpk5j7gjtd70d")
var listener_window : ListenerWindow


var current_slide : int = -1
@export var slides : Array[Array] = [
	["start Folie", "uid://h4xmx0p6mpy0", true],
	["portale" , "uid://c26wpn4puqq0f", false], 
	["end Folie" , "uid://bvr10un6jc7nc", true]
	]


func _input(event):
	if event.is_action_pressed("close"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		if listener_window:
			listener_window.mode = Window.MODE_FULLSCREEN
		print(listener_window.get_subviewport().get_camera_3d())
	if event.is_action_pressed("ui_right"):
		next_slide()


func _ready():
	get_viewport().set_embedding_subwindows(false)
	listener_window = listener_Window_path.instantiate()
	listener_window.main = self
	add_child(listener_window)
	listener_window.position = Vector2(2000, 0)
	listener_window.mode = Window.MODE_FULLSCREEN
	var viewport_texture = listener_window.get_viewport_texture()
	%OtherScreenView.material.set_shader_parameter("texture_screen", viewport_texture)
	next_slide()
	update_UI()


var time_since_beginn : int = 0
func _on_timer_timeout():
	time_since_beginn += 1
	update_UI()


func next_slide() -> void:
	current_slide += 1
	if not  slides.size() > current_slide:
		current_slide -= slides.size()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	listener_window.show_new_slide(slides[current_slide][1])
	
	
	update_UI()


func update_UI() -> void:
	%SlideCount.text = "Slide" + str(current_slide)
	%TimerLabel.text = "%02d:%02d" % [ int(time_since_beginn / 60.), time_since_beginn % 60]
	#%TimerLabel.text = "Zeit: " + str(int(time_since_beginn / 60.)) + ":" + str(int(time_since_beginn % 60))
	var slide = listener_window.slide
	%Comments.text = ""
	if slides[current_slide][0]:
		%SlideName.text = "Slide: " +  slides[current_slide][0]
	if slide is Slide:
		for comment : String in slide.comments:
			%Comments.text += comment + "\n"
		if slide.slide_name != "" and slide.slide_name !=  "New Slide":
			%SlideName.text = "Slide: " + slide.slide_name
