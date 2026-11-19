
shader_type canvas_item;

uniform sampler2D stencil_texture : filter_nearest;
uniform vec4 outline_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float outline_width : hint_range(1.0, 30.0) = 2.0;
uniform float stencil_threshold : hint_range(0.0, 1.0) = 0.01;

const int DIRECTIONS = 32;

void fragment() {
	vec2 uv = UV;

	// Use the stencil texture's actual pixel dimensions
	vec2 pixel_size = 1.0 / vec2(textureSize(stencil_texture, 0));
	pixel_size *= outline_width;

	float center = texture(stencil_texture, uv).r;
	float max_neighbor = 0.0;

	for (int i = 0; i < DIRECTIONS; i++) {
		float angle = float(i) * 6.28318530718 / float(DIRECTIONS);

		vec2 direction = vec2(cos(angle), sin(angle));

		float neighbor = texture(
			stencil_texture,
			uv + direction * pixel_size
		).r;

		max_neighbor = max(max_neighbor, neighbor);
	}

	if (center < 0.01 && max_neighbor > stencil_threshold) {
		COLOR = outline_color;
	} else {
		COLOR = vec4(0.0);
	}
}
