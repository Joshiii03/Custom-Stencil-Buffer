shader_type spatial;

uniform sampler2D stencil_texture : source_color; 
render_mode unshaded;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 stencil = texture(stencil_texture, SCREEN_UV);
	if (vec3(0,1,0) == vec3(stencil.rgb))
	{
		ALBEDO = vec3(0,1,0);
	}
	else //Stencil buffer delay
	{
		ALBEDO = vec3(1,0,0);
	}
}
