@tool
extends Node3D

@export_tool_button("Fix Material") var material_fix = correct_material

func correct_material() -> void:
	for child in get_children():
		if is_instance_valid(child) :
			if child is VisualInstance3D:
				child.material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				child.material_override.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
				child.material_override.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
				child.material_override.stencil_flags = 1
				child.material_override.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
				child.material_override.stencil_reference = 0
				
				if child.name != "Floor" and child.name != "Wall":
					var new_material : StandardMaterial3D = StandardMaterial3D.new()
					new_material.render_priority = -1
					new_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
					new_material.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
					new_material.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
					new_material.stencil_flags = 2
					new_material.stencil_reference = 0
					
					child.material_override.next_pass = new_material
			elif child.get_children()[0] is MeshInstance3D:
				var child_mesh = child.get_children()[0].mesh
				var surface_0 = child_mesh.get("surface_0/material")
				var surface_1 = child_mesh.get("surface_1/material")
				
				surface_0.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				surface_1.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				
				surface_0.render_priority = -1
				surface_1.render_priority = -1
				
				surface_0.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
				surface_1.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
				
				surface_0.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
				surface_1.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
				
				surface_0.stencil_flags = 1
				surface_1.stencil_flags = 1
				
				surface_0.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
				surface_1.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
				
				surface_0.stencil_reference = 0
				surface_1.stencil_reference = 0
