
@tool
extends Node3D

@export_tool_button("make mirror world") var make_mirror = make_mirror_world
@export var normal_world : Node3D
@export var mirror : Node3D


func make_mirror_world() -> void:
	if not is_instance_valid(normal_world) or not is_instance_valid(mirror):
		push_error("Please assign normal_world and mirror!")
		return
	
	for child in get_children():
		child.queue_free.call_deferred()
	
	for child in normal_world.get_children():
		if not child.is_inside_tree():
			continue
		
		var new_child := MeshInstance3D.new()
		if child is MeshInstance3D :
			# Copy mesh
			new_child.mesh = child.mesh
			# Duplicate material so the original isn't affected
			if child.material_override != null:
				new_child.material_override = child.material_override.duplicate()
				if new_child.material_override is BaseMaterial3D:
					new_child.material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
					new_child.material_override.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
					new_child.material_override.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
					new_child.material_override.stencil_flags = 1
					new_child.material_override.stencil_reference = 1
					new_child.material_override.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
					new_child.material_override.next_pass = null
		elif child.get_children().size() > 0:
			child = child.get_children()[0]
			if child is MeshInstance3D:
				new_child.mesh = child.mesh.duplicate()
				for index in new_child.mesh.get_surface_count():
					var surface = new_child.mesh.surface_get_material(index).duplicate()
					if surface:
						new_child.mesh.surface_set_material(index, surface)
						surface.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
						surface.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
						surface.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
						surface.stencil_flags = 1
						surface.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
						surface.stencil_reference = 1
						surface.cull_mode = 0
			else:
				continue
		else:
			continue
		
		new_child.name = child.name
		
		add_child(new_child)
		
		# Mirror position
		new_child.global_position = Vector3(
			-mirror.global_position.x + child.global_position.x,
			child.global_position.y,
			mirror.global_position.z * 2 - child.global_position.z
		)
		print("set rotation")
		new_child.global_rotation = Vector3(
			-child.global_rotation.x, 
			-child.global_rotation.y, 
			child.global_rotation.z
			)
		new_child.scale.z = -new_child.scale.z
		
		
		new_child.owner = get_tree().edited_scene_root
