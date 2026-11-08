shader_type spatial;
render_mode depth_draw_always, unshaded;
//render_mode unshaded;

uniform sampler2D stencil_texture : source_color;

// inverts the depth test
uniform vec3 match_color_1 : source_color ;

const float tolerance = .01 ;

void fragment() {
	vec4 stencil_map = texture(stencil_texture, SCREEN_UV);
	
	//Stencil test
	bool stencil_test_1 = abs(stencil_map.r - match_color_1.r) < tolerance;
	if(stencil_map.r >= 0.96){
		ALBEDO = vec3(1.,1.,1.);
	}
	else{
		ALBEDO = vec3(0,0,0);
	}
}
