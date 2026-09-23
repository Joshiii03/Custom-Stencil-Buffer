shader_type spatial;
render_mode unshaded;
uniform vec3 match_color : source_color ;
uniform sampler2D depth_texture : hint_depth_texture;

void vertex() {
}

void fragment() {
	float fragment_depth = (PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z;
	fragment_depth -= .5;
	vec3 show_color = match_color;
	show_color.b = fragment_depth;
	ALBEDO = show_color;
}

void light() {
}
