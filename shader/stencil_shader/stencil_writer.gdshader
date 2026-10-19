shader_type spatial;
render_mode unshaded, depth_draw_always;

uniform vec3 match_color1 : source_color ;

void vertex() {
}

void fragment() {
	//Depth Write
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	vec3 show_color = match_color1;
	show_color.b = fragment_depth - mod(fragment_depth, 0.01);
	show_color.g = mod(fragment_depth, .01) * 100.;
	ALBEDO = show_color;
	ALPHA = 1.;
}

//void light() {
//}
