@tool
class_name StencilHolder
extends Node3D

@export var update : bool  = false:
	set(new_value):
		update = true
		update_player()
		update_stencil()
		update = false

@export var player : Player :
	set(new_value):
		player = new_value
		update_player()

@export var stencil_layer_1 : int = 0 :
	set(new_value) :
		stencil_layer_1 = new_value
		update_stencil()

@export var stencil_layer_2 : int = 0 :
	set(new_value) :
		stencil_layer_2 = new_value
		update_stencil()


func _ready() -> void:
	update_stencil()
	child_order_changed.connect(update_stencil)
	child_order_changed.connect(update_player)


func update_player() -> void:
	for child in get_children():
		if child.is_inside_tree():
			if child is StencilReader:
				child.player = player
			if child is Portal:
				child.player = player


func update_stencil() -> void:
	for child in get_children():
		if child is StencilReader:
			child.stencil_layer_1 = stencil_layer_1
			child.stencil_layer_2 = stencil_layer_2
		if child is Portal:
			child.stencil_layer_1 = stencil_layer_1
			child.stencil_layer_2 = stencil_layer_2
		if child is StencilLight:
			child.stencil_layer = stencil_layer_1
