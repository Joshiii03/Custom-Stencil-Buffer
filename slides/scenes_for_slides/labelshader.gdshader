shader_type canvas_item;
render_mode unshaded;

uniform vec3 match_color1 : source_color = vec3(0.,0.,0.);

void fragment() {
	COLOR.rgb = match_color1;
}
