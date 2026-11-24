shader_type spatial;

uniform sampler2D depth_texture : hint_depth_texture;
render_mode depth_draw_always;

void fragment() {
	DEPTH = 0.;
	
	ALPHA = 1.;
	ALBEDO = vec3(0.5);
	
}
