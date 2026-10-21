shader_type spatial;
render_mode unshaded, depth_draw_always;

uniform vec3 match_color1 : source_color ;

uniform sampler2D portal_noise_texture: repeat_enable;
uniform float speed = 0.3;
uniform float twist_strength: hint_range(-10.0, 10.0, 0.1) = 3.0;

uniform float inner_circle_min = 0.1;
uniform float inner_circle_max = 0.35;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 centered_uv = UV - 0.5;
	float distance_from_centered_uv = length(centered_uv);
	float angle_around_center = atan(centered_uv.y, centered_uv.x);
	float angle_remap = angle_around_center / PI * 0.5 + 0.5;
	vec2 polar_uv = vec2(angle_remap + distance_from_centered_uv * twist_strength, distance_from_centered_uv);
	float noise_value = texture(portal_noise_texture, vec2(polar_uv.x + TIME * speed, polar_uv.y + TIME * speed)).r;
	float mask_circle = smoothstep(0.5, 0.65, 1.0 - distance_from_centered_uv);
	float rim_falling = smoothstep(inner_circle_max, inner_circle_min, distance_from_centered_uv);
	
	
	if (min(1. * max(mask_circle * noise_value, rim_falling) , .1) < .1)
	{
		discard;
	}
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	vec3 show_color = match_color1;
	ALBEDO.b = fragment_depth - mod(fragment_depth, 0.01);
	ALBEDO.g = mod(fragment_depth, .01) * 100.;
	//vec3 show_color = match_color1;
	//ALBEDO.b = fragment_depth - mod(fragment_depth, 0.01);
	//ALBEDO.g = mod(fragment_depth, .01) * 100.;
	ALBEDO.r = match_color1.r;
	//ALBEDO = vec3(match_color.r,max(mask_circle * noise_value, rim_falling) ,fragment_depth);
	ALPHA = 1.;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
