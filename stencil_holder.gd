extends Node3D


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


func _process(_delta: float) -> void:
	pass


func update_stencil() -> void:
	for child in get_children():
		if child is StencilReader:
			child.stencil_layer_1 = stencil_layer_1
			child.stencil_layer_2 = stencil_layer_2
		if child is Portal:
			child.stencil_layer_1 = stencil_layer_1
			child.stencil_layer_2 = stencil_layer_2
