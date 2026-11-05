extends Node3D

@onready var water_mesh : MeshInstance3D = $Water/WaterMesh
@onready var inside = $Boat/Hull/Inside

func _input(event):
	if event.is_action_pressed("1"):
		
		if inside.material.stencil_reference == 2:
			inside.material.stencil_reference = 1
			print("1")
		elif inside.material.stencil_reference == 1:
			inside.material.stencil_reference = 2
			print("2")
