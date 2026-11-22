extends Node
@onready var stencil_camera_with_text = $"../StencilCameraWithText"
@onready var buffer = $"../StencilCameraWithText/StencilViewport/MarginContainer/VBoxContainer/Buffer"
@onready var portale = $"../StencilCameraWithText/StencilViewport/MarginContainer/VBoxContainer/Portale"

func _input(event):
	if event.is_action_pressed("1"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "TEST"
		portale.text = "TEST TEST"
	if event.is_action_pressed("2"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "HIER KÖNNTE IHRE"
		portale.text = "WERBUNG STEHEN"
		#get_parent()._ready()
	if event.is_action_pressed("3"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "Godot ist besser"
		portale.text = "als Unity"
		#get_parent()._ready()
	if event.is_action_pressed("4"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "Aurum Est."
		portale.text = "Potestas"
	if event.is_action_pressed("5"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "I'll take a potato chip... "
		portale.text = "and eat it!"
	if event.is_action_pressed("6"):
		stencil_camera_with_text.use_debug_screen = true
		buffer.text = "We will be right back"
		portale.text = ""
