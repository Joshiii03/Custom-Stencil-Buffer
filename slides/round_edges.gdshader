
shader_type canvas_item;

const float corner_radius = 70.0;
uniform vec2 rect_size = vec2(200.0, 100.0);

void fragment() {
	// Get the actual ColorRect dimensions in pixels
	vec2 size = rect_size;
	
	// Convert UV coordinates into pixel coordinates
	vec2 pixel_size = vec2(size.x, size.y);
	vec2 half_size = pixel_size * 0.5;
	vec2 pixel_pos = UV * pixel_size;

	// Rounded rectangle SDF
	vec2 q = abs(pixel_pos - half_size)
		   - (half_size - vec2(corner_radius));

	float d = length(max(q, vec2(0.0)))
			+ min(max(q.x, q.y), 0.0)
			- corner_radius;

	// Anti-aliasing
	float aa = fwidth(d);
	float alpha = 1.0 - smoothstep(-aa, aa, d);

	COLOR = vec4(COLOR.rgb, COLOR.a * alpha);
}
