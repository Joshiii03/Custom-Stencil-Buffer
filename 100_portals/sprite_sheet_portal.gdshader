
shader_type spatial;
render_mode unshaded, depth_draw_always;

uniform vec3 match_color1 : source_color ;
uniform vec3 match_color2 : source_color ;

uniform sampler2D sprite_sheet : source_color;
uniform int h_frames = 4;
uniform int v_frames = 4;
uniform float animation_speed = 10.0;

void fragment() {
	// Calculate the current animation frame
	int total_frames = h_frames * v_frames;
	int frame = int(TIME * animation_speed) % total_frames;

	// Calculate the frame's position in the grid
	int col = frame % h_frames;
	int row = frame / h_frames;

	// Map UV coordinates to the selected frame
	vec2 frame_size = vec2(
		1.0 / float(h_frames),
		1.0 / float(v_frames)
	);

	vec2 frame_uv = UV * frame_size;
	frame_uv += vec2(float(col), float(row)) * frame_size;

	vec4 pixel = texture(sprite_sheet, frame_uv);
	
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	vec3 show_color = match_color1;
	show_color.b = fragment_depth - mod(fragment_depth, 0.01);
	show_color.g = mod(fragment_depth, .01) * 100.;
	
	if (pixel.r > 0.1)
	{
		show_color = match_color2;
		//discard;
	}
	ALBEDO =show_color;
	ALPHA = 1.;
}
