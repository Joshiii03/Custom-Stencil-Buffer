shader_type spatial;

uniform sampler2D depth_texture : hint_depth_texture;
render_mode depth_draw_always;

void vertex() {
	// Called for every vertex the material is visible on.
}


void fragment() {
	ALPHA = 1.;
	ALBEDO = vec3(0.5);
	//depth_texture;
	//texture(depth_texture, SCREEN_UV).r;
	DEPTH = 0.;
	//float depth = texture(depth_texture, SCREEN_UV).r;
	//vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	//float fragment_depth = clip_pos.z / clip_pos.w;
	//DEPTH = fragment_depth;
}


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
