extends Node2D

@export var pointer_size = 10

const RED : Color = Color(1,0,0)
const pink : Color = Color(1,0,0,0.4)
func _process(_delta):
	queue_redraw()

func _draw():
	var pos = get_viewport().get_mouse_position()
	draw_circle(pos, pointer_size, pink)
	draw_circle(pos, pointer_size - 3, RED)
