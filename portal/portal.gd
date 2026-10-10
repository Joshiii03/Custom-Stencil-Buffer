@tool
class_name Portal
extends Node3D

@onready var portal_frame = $StencilReader
@onready var stencil_writer_1 : StencilWriter = $StencilWriter
@onready var stencil_writer_2 : StencilWriter = $StencilWriter2


@export var player : Player:
	set(value):
		player = value
		if player and portal_frame:
			portal_frame.player = player


func _on_area_3d_body_entered(body):
	if body is Player:
		var new_layer : int = body.change_stencil_layer()
		if new_layer == 0:
			new_layer = 1
		else:
			new_layer = 0
		stencil_writer_1.stencil_layer = new_layer
		stencil_writer_2.stencil_layer = new_layer
