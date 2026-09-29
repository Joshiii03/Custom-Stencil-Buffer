shader_type spatial;
render_mode unshaded;

uniform vec3 match_color1 : source_color ;
uniform vec3 match_color2 : source_color ;

uniform bool checker = false;
uniform float checker_size = 5.0;
uniform bool stripes = false;
uniform float stripes_size = 2.0;
uniform float stripes_speed = 2.0;

varying vec3 v_vertex;

void vertex() {
	v_vertex = VERTEX;
}

void fragment() {
	float fragment_depth = 1./((PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z);
	vec3 show_color = match_color1;
	if (checker)
	{
		if(mod(floor(v_vertex.x * checker_size),2.) - mod(floor(v_vertex.y * checker_size),2.) == 0.0){
			show_color = match_color2;
		}
	}
	if (stripes)
	{
		if(mod((v_vertex.x + v_vertex.y + TIME * stripes_speed)* stripes_size, 1)  > 0.5)
		{
			show_color = match_color2;
		}
	}
	show_color.b = fragment_depth;
	ALBEDO = show_color;
}

void light() {
}
