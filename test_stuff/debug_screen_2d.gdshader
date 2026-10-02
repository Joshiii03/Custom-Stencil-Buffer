shader_type canvas_item;
render_mode unshaded;

uniform bool filter_r = false;
uniform bool filter_b = false;
uniform bool filter_g = false;

uniform sampler2D texture_screen: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 color = texture(texture_screen, UV).rgb;
	if (filter_r)
	{
		color.r = 0.;
	}
	if (filter_g)
	{
		color.g = 0.;
	}
	if (filter_b)
	{
		color.b = 0.;
	}
	COLOR = vec4(color.rgb, 1);
	//COLOR = vec4(1.,0.5,1.,1.);
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
