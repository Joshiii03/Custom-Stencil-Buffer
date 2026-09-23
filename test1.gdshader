shader_type canvas_item;

uniform int layer = 0;
uniform vec4 layer_color = vec4(1,1,1,1);


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.x = 0.3;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
