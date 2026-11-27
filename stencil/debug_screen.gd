extends VBoxContainer

@onready var debug_screen_2d_4 : ColorRect = $DebugScreen2D4
@onready var debug_screen_2d_3 : ColorRect = $DebugScreen2D3
@onready var debug_screen_2d_2 : ColorRect = $DebugScreen2D2
@onready var debug_screen_2d   : ColorRect = $DebugScreen2D

func _input(event):
	if event.is_action_pressed("1"):
		visible = !visible
	if event.is_action_pressed("2"):
		visible = true
		debug_screen_2d_4.visible = true
		debug_screen_2d_3.visible = false
		debug_screen_2d_2.visible = false
		debug_screen_2d.visible = false
	if event.is_action_pressed("3"):
		visible = true
		debug_screen_2d_4.visible = false
		debug_screen_2d_3.visible = true
		debug_screen_2d_2.visible = false
		debug_screen_2d.visible = false
	if event.is_action_pressed("4"):
		visible = true
		debug_screen_2d_4.visible = false
		debug_screen_2d_3.visible = false
		debug_screen_2d_2.visible = true
		debug_screen_2d.visible = false
	if event.is_action_pressed("5"):
		visible = true
		debug_screen_2d_4.visible = false
		debug_screen_2d_3.visible = false
		debug_screen_2d_2.visible = false
		debug_screen_2d.visible = true
