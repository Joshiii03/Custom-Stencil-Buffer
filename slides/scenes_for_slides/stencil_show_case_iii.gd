extends Node3D
@onready var csg_box_3d = $Hole/CSGBox3D
@onready var cube_scene : PackedScene = preload("uid://dhh3hkblmc45")

func _input(event):
	if event.is_action_pressed("2"):
		csg_box_3d.visible = !csg_box_3d.visible
	if event.is_action_pressed("1"):
		var new_cube = cube_scene.instantiate()
		new_cube.position = Vector3(0,5,0)
		get_parent().add_child(new_cube)
