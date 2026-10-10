shader_type spatial;
render_mode depth_draw_never, depth_test_disabled, unshaded;

uniform vec3 match_color1 : source_color ;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	ALBEDO = match_color1;
	ALPHA = 1.;
}
