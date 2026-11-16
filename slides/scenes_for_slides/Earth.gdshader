
shader_type spatial;

const vec3 dark_color = vec3(0.1, 0.05, 0.01);
const vec3 bright_color = vec3(0.223, 0.089, 0.015);

varying vec3 v_vertex;

uniform sampler2D noise : repeat_enable;
uniform vec3 coords = vec3(0.0);

uniform float layer_frequency = 50.0;
uniform float noise_scale = 0.25;
uniform float noise_strength = 0.8;
uniform float grass_hight = 0.6;
uniform float timescale = 1.0;

void vertex() {
	v_vertex = VERTEX;
}

void fragment() {
	
	vec2 uv = v_vertex.yz + TIME*timescale;// * noise_scale + coords;

	float noise_value = texture(noise, uv).r;

	// Distort the horizontal dirt layers.
	float distortion = (noise_value - 0.5) * noise_strength;

	// Create irregular layers.
	float layers = sin(v_vertex.y * layer_frequency + distortion * 5.0);

	// Break up the layers using noise.
	float pattern = layers + noise_value * 0.8;

	ALBEDO = pattern > 0.0 ? dark_color : bright_color;
	if (v_vertex.y  + noise_value * 0.2> grass_hight)
	{
		ALBEDO = vec3(0,1,0);
	}
}
