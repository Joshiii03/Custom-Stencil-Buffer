shader_type spatial;
render_mode depth_draw_always;
//render_mode unshaded;

uniform sampler2D stencil_texture : source_color;
//uniform sampler2D screen_texture : hint_screen_texture;
uniform bool alpha_from_G = false;

uniform sampler2D my_texture;
uniform bool use_texture = false;

// inverts the depth test
uniform bool current_stencil_infront = false;
uniform bool use_second_stencil_layer = false;
uniform vec3 match_color_1 : source_color ;
uniform vec3 match_color_2 : source_color ;
uniform vec3 show_color : source_color;
const float tolerance = .001 ;


void fragment() {
	vec4 stencil_map = texture(stencil_texture, SCREEN_UV);
	
	//Stencil test
	bool stencil_test_1 = abs(stencil_map.r - match_color_1.r) < tolerance;
	bool stencil_test_2 = abs(stencil_map.r - match_color_2.r) < tolerance;
	
	//depth test , when infornt 
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	bool depth_test = fragment_depth  < stencil_map.b;
	
	if (use_second_stencil_layer)
	{
		if (!current_stencil_infront && !stencil_test_1 && !stencil_test_2 /* && depth_test*/)
		{discard;}
		if (current_stencil_infront  && !stencil_test_1 && !stencil_test_2    && depth_test)
		{discard;}
		if (!current_stencil_infront && stencil_test_1  && stencil_test_2     && !depth_test)
		{discard;}
	}
	else
	{
		if (!current_stencil_infront && !stencil_test_1 /* && depth_test*/)
		{discard;}
		if (current_stencil_infront && !stencil_test_1 && depth_test)
		{discard;}
		if (!current_stencil_infront && stencil_test_1 && !depth_test)
		{discard;}
	}
	
	//Rendering Color || Texture
	if (use_texture){
	    ALBEDO = texture(my_texture, UV).rgb;
		}
	else{
	    ALBEDO = show_color;}
	if (alpha_from_G){ALPHA = stencil_map.g;
	}
}