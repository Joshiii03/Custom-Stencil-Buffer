
shader_type canvas_item;

uniform sampler2D stencil_texture : filter_nearest;
uniform vec4 outline_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float outline_width : hint_range(1.0, 10.0) = 1.0;

// Number of neighboring pixels to check
uniform float stencil_threshold : hint_range(0.0, 1.0) = 0.01;

void fragment() {
	vec2 uv = UV;
	vec2 pixel_size = TEXTURE_PIXEL_SIZE * outline_width;

	// Current stencil value
	float center = texture(stencil_texture, uv).r;

	bool edge = false;

	// Check surrounding 8 pixels
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {

			if (x == 0 && y == 0) {
				continue;
			}

			vec2 offset = vec2(float(x), float(y)) * pixel_size;

			float neighbor = texture(stencil_texture, (uv + offset*0.01)).r;

			if (abs(center - neighbor) > stencil_threshold) {
				edge = true;
			}
		}
	}

	if (edge && center < 0.01) {
		COLOR = outline_color;
	} else {
		COLOR = vec4(0.0);
	}
}
