extends Sprite2D

var timer :Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.timeout.connect(next)
	timer.start()

@export var max_frames = 32
var current_frame = 0

func next() -> void:
	frame = current_frame
	current_frame += 1
	current_frame = current_frame % max_frames
