
shader_type canvas_item;

uniform float corner_radius : hint_range(0.0, 200.0) = 20.0;

void fragment() {
	vec2 size = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 pixel_pos = UV * size;
	vec2 half_size = size * 0.5;

	vec2 q = abs(pixel_pos - half_size)
		   - (half_size - vec2(corner_radius));

	float d = length(max(q, vec2(0.0)))
			+ min(max(q.x, q.y), 0.0)
			- corner_radius;

	float aa = fwidth(d);
	float alpha = 1.0 - smoothstep(-aa, aa, d);

	COLOR = vec4(COLOR.rgb, COLOR.a * alpha);
}
