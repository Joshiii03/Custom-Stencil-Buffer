class_name Presentationmanager
extends Control


const listener_Window_path = preload("uid://bpk5j7gjtd70d")
var listener_window : ListenerWindow

@export var presentation_path : String = ""
var presentation : Presentation = null

@export var test_run : bool = false

var current_slide : Node = null

var last_update = 0
func _input(event):
	if event.is_action_pressed("close"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		if listener_window:
			listener_window.mode = Window.MODE_FULLSCREEN
	if event.is_action_pressed("ui_right"):
		if last_update < Time.get_ticks_msec() - 200:
			last_update = Time.get_ticks_msec()
			next_slide()
	if event.is_action_pressed("ui_left"):
		if last_update < Time.get_ticks_msec() - 200:
			last_update = Time.get_ticks_msec()
			last_slide()



func _ready():
	get_viewport().set_embedding_subwindows(false)
	listener_window = listener_Window_path.instantiate()
	listener_window.main = self
	add_child(listener_window)
	listener_window.position = Vector2(2000, 0)
	if not test_run:
		listener_window.mode = Window.MODE_FULLSCREEN
	var viewport_texture = listener_window.get_viewport_texture()
	%OtherScreenView.material.set_shader_parameter("texture_screen", viewport_texture)
	presentation = load(presentation_path).instantiate()
	listener_window.sub_viewport.add_child(presentation)
	update_UI()


var time_since_beginn : int = 0
func _on_timer_timeout():
	time_since_beginn += 1
	update_UI()


func next_slide() -> void:
	presentation.show_next_slide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update_UI()


func last_slide() -> void:
	presentation.show_prev_slide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update_UI()


func update_UI() -> void:
	%TimerLabel.text = "%02d:%02d" % [ int(time_since_beginn / 60.), time_since_beginn % 60]
	var slide = presentation.get_slide()
	%Comments.text = ""
	%SlideName.text = "Title: " + slide.name
	if slide is Slide:
		for comment : String in slide.comments:
			%Comments.text += comment + "\n"
		if slide.slide_name != "" and slide.slide_name !=  "New Slide":
			%SlideName.text = "Title: " + slide.slide_name
	%SlideCount.text = "Slide: " + str(presentation.current_index +1) + " / " + str(presentation.slide_count)
