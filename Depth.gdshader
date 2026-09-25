shader_type spatial;
render_mode unshaded;

const vec3 green = vec3(0.2,1,0);
const vec3 end_color = vec3(1,0,1);
const bool test = true;

uniform sampler2D depth_texture : hint_depth_texture;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float depth = texture(depth_texture, SCREEN_UV).r;
	float fragment_depth = (1./((PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z));
	float test_depth = 0.0;
	if (test){test_depth = depth;}else{test_depth = fragment_depth;}
	ALBEDO = vec3(test_depth);
	//test_depth = 21. ;
	if (abs(test_depth - .5) > 1.)
	{
		ALBEDO = end_color;
	}
	if (fragment_depth == depth)
	{
		ALBEDO = green;
	}
	
	
	/*
	if ( test){ALBEDO = vec3(-(depth- fragment_depth));}
	else{
		ALBEDO = vec3(fragment_depth);}
	if (fragment_depth > 1.)
	{
		ALBEDO = end_color;
	}
	if (fragment_depth == depth)
	{
		ALBEDO = green;
	}*/
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
