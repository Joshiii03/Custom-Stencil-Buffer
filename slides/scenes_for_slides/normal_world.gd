@tool
extends Node3D



func correct_material() -> void:
	for child in get_children():
		child.material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		child.material_override.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
		child.material_override.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
		child.material_override.stencil_flags = 1
		child.material_override.stencil_compare = BaseMaterial3D.STENCIL_COMPARE_EQUAL
		child.material_override.stencil_reference = 0
		
		var new_material : StandardMaterial3D = StandardMaterial3D.new()
		new_material.render_priority = -1
		new_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		new_material.depth_draw_mode = BaseMaterial3D.DEPTH_DRAW_ALWAYS
		new_material.stencil_mode = BaseMaterial3D.STENCIL_MODE_CUSTOM
		new_material.stencil_flags = 2
		new_material.stencil_reference = 0
		
		child.material_override.next_pass = new_material
