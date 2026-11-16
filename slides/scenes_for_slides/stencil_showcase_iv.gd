extends Node3D

@onready var animator_1 : Animator = $Cube/Animator
@onready var animator_2 = $Cube/Animator2



func _input(event):
	if event.is_action_pressed("1"):
		animator_1.start()
	if event.is_action_pressed("2"):
		animator_2.start()
