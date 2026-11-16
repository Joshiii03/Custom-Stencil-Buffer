shader_type spatial;

render_mode unshaded;

uniform sampler2D stencil_texture : source_color;
uniform vec4 outline_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float outline_width : hint_range(1.0, 10.0) = 1.0;

// Number of neighboring pixels to check
uniform float stencil_threshold : hint_range(0.0, 1.0) = 0.01;

void fragment() {
	vec2 uv = UV;
	// Current stencil value
	float center = texture(stencil_texture, uv).r;
	bool edge = false;
	// Check surrounding 8 pixels
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
			if (x == 0 && y == 0) {
				continue;
			}
			vec2 offset = vec2(float(x), float(y)) ;
			float neighbor = texture(stencil_texture, uv + offset).r;
			if (abs(center - neighbor) > stencil_threshold) {
				edge = true;
			}
		}
	}

	if (edge) {
		ALBEDO = outline_color.rgb;
	} else {
		ALBEDO = texture(stencil_texture, UV).rgb; //ALBEDO = vec3(0.1);
	}
}
