shader_type spatial;


uniform sampler2D depth_texture : hint_depth_texture;
render_mode depth_draw_never;

uniform bool show_log_scale = false;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}


void fragment() {
	ALPHA = 1.;
	float depth =  texture(depth_texture, vec2(UV.x, -UV.y)).r;
	ALBEDO = vec3(depth) * 400.;
	if (show_log_scale && mod(depth, 0.0004) < 0.0001){
		ALBEDO = vec3(0.1,0.1,0.1);
	}
	
}
