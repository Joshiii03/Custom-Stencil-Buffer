shader_type spatial;
render_mode depth_draw_always;

uniform sampler2D stencil_texture : source_color;
//uniform sampler2D screen_texture : hint_screen_texture;

uniform sampler2D my_texture;
uniform bool use_texture = false;

// inverts the depth test
uniform bool current_stencil_infront = false;
uniform bool use_second_stencil_layer = false;
uniform int stencil_layer = 1;
uniform vec3 show_color : source_color;


uniform bool disable_lighting = false;
const float tolerance = .001 ;


void fragment() {
	vec4 stencil_map = texture(stencil_texture, SCREEN_UV);
	//Stencil test
	bool stencil_test = false;
	
	if (stencil_layer == 1){
		stencil_test  = stencil_map.r > 0.99;
	}
	if (stencil_layer == 2){
		stencil_test  = stencil_map.g > 0.99;
	}
	if (stencil_layer == 3){
		stencil_test  = stencil_map.b > 0.99;
	}
	if (stencil_layer > 3 || stencil_layer < 1){
		discard;
	}
	if (!stencil_test)
	{
		discard;
	}
	
	//Rendering Color || Texture
	
	if (use_texture){
		ALBEDO = texture(my_texture, UV).rgb;
		}
	else{
		ALBEDO = show_color;}
	if (disable_lighting)
	{
		ALBEDO = vec3(0.0);
		if (use_texture){
			EMISSION = texture(my_texture, UV).rgb;
			}
		else{
			EMISSION = show_color;
		}
	}
}
