shader_type spatial;
render_mode unshaded, depth_draw_always;

uniform vec3 match_color : source_color ;

uniform sampler2D portal_noise_texture: repeat_enable;
uniform float speed = 0.3;
uniform float power_stregth : hint_range(0.0, 5.0, 0.1) = 0.3;
uniform float twist_strength: hint_range(-10.0, 10.0, 0.1) = 3.0;

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
	float rim_falling = smoothstep(0.4, 0.2, distance_from_centered_uv);
	
	//float fragment_depth = 1./((PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z);
	vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	
	if (min(match_color.g * max(mask_circle * noise_value, rim_falling) , .1) < .1)
	{
		discard;
	}
	ALBEDO = vec3(match_color.r,max(mask_circle * noise_value, rim_falling) ,fragment_depth);
	ALPHA = 1.;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
