shader_type spatial;
render_mode unshaded;
uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D stencil_texture : source_color;
uniform bool alpha_from_G = false;

uniform sampler2D my_texture;
uniform bool use_texture = false;

uniform vec3 match_color : source_color ;
uniform vec3 show_color : source_color;
uniform float tolarence = 0.0003 ;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 stencil_map = texture(stencil_texture, SCREEN_UV);
	vec4 color = texture(screen_texture, SCREEN_UV);
	
	if (abs(stencil_map.r - match_color.r) > tolarence)
	{
		discard;
	}
	float fragment_depth = 1./((PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z);
	if(fragment_depth  > stencil_map.b )
	{
		discard;
	}
	
	if (use_texture)
	{
	    vec4 tex = texture(my_texture, UV);
	    ALBEDO = tex.rgb;
	}
	else
	{
	    ALBEDO = show_color;
	}
	if (alpha_from_G){ALPHA = stencil_map.g;}
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
