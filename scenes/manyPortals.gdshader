
shader_type spatial;
render_mode unshaded, depth_draw_always;

uniform vec3 match_color1 : source_color;
uniform vec3 match_color2 : source_color;
uniform vec3 match_color3 : source_color;

// Grid
uniform float size = 0.2;
uniform float line_width = 0.018;

// Chaos
uniform float chaos = 0.75;
uniform float glitch_speed = 12.0;
uniform float glitch_density = 0.12;

// Scanners
uniform float scan_speed = 0.22;
uniform float scan_width = 0.012;
uniform float scan_count = 3.0;

// Random number generator
float hash21(vec2 p) {
	p = fract(p * vec2(123.34, 456.21));
	p += dot(p, p + 45.32);
	return fract(p.x * p.y);
}

void fragment() {
	vec2 uv = UV;

	// Cell coordinates
	vec2 cell = floor(uv / size);
	vec2 local_uv = fract(uv / size);

	// Animated randomness, stable within each time slice
	float tick = floor(TIME * glitch_speed);
	float rnd = hash21(cell + vec2(tick, tick * 0.73));

	// Original checker pattern
	float pattern = mod(cell.x + cell.y, 2.0);

	// Occasional chaotic cell swaps
	if (rnd > 1.0 - glitch_density * chaos) {
		pattern = 1.0 - pattern;
	}

	vec3 final_color =
		pattern < 1.0 ? match_color2 : match_color1;

	// Jagged grid edges, still using exact match colors
	float edge = min(
		min(local_uv.x, 1.0 - local_uv.x),
		min(local_uv.y, 1.0 - local_uv.y)
	);

	float edge_noise = hash21(cell + vec2(tick * 0.2, 19.7));

	float dynamic_width =
		line_width * (0.45 + edge_noise * chaos * 1.8);

	if (edge < dynamic_width) {
		final_color = match_color3;
	}

	// Multiple moving scan bands
	float scan = fract(
		uv.y * scan_count - TIME * scan_speed
	);

	float scan_dist = min(scan, 1.0 - scan);

	float scan_random = hash21(
		vec2(floor(uv.y * 35.0), tick)
	);

	if (
		scan_dist < scan_width * (0.5 + chaos)
		&& scan_random > 0.18
	) {
		final_color = match_color3;
	}

	// Horizontal glitch slices
	float slice_id = floor(uv.y * 42.0);
	float slice_noise = hash21(
		vec2(slice_id, tick * 1.37)
	);

	if (slice_noise > 1.0 - 0.055 * chaos) {
		float block = hash21(
			vec2(slice_id + 7.1, tick)
		);

		if (uv.x > block && uv.x < block + 0.12 * chaos) {
			final_color =
				slice_noise > 0.975
				? match_color3
				: (pattern < 1.0
					? match_color1
					: match_color2);
		}
	}

	// Sudden rectangular interference blocks
	vec2 glitch_cell = floor(uv * vec2(9.0, 13.0));
	float block_noise = hash21(
		glitch_cell + vec2(tick * 0.31, tick)
	);

	if (block_noise > 1.0 - 0.035 * chaos) {
		final_color = match_color3;
	}
	
	ALBEDO = final_color;
	//Depth Write
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	vec3 show_color = match_color1;
	ALBEDO.b = fragment_depth - mod(fragment_depth, 0.01);
	ALBEDO.g = mod(fragment_depth, .01) * 100.;
	ALPHA;
}
