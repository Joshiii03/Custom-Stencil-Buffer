@tool
extends GeometryInstance3D




func _init():
	layers = get_stencil_mask()


func _ready():
	layers = get_stencil_mask()


func get_stencil_mask() -> int:
	return 1
