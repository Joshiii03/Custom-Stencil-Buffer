shader_type spatial;
render_mode unshaded;

uniform float strength = 5.0; // Stärke des Wirbels
uniform sampler2D base_texture : source_color; // Die Textur

uniform vec3 match_color1 : source_color ;
uniform vec3 match_color2 : source_color ;

void fragment() {
    //UV-Koordinaten zentrieren (-0.5 bis 0.5);
    vec2 uv = UV - 0.5;
    
    // Abstand zum Zentrum berechnen
    float dist = length(uv);
    
    // Rotationswinkel abhängig vom Abstand berechnen
    float angle = (1.0 - dist) * strength ;
    
    // Sinus und Kosinus für die Rotationsmatrix
    float s = sin(angle * sin(TIME * 0.1));
    float c = cos(angle);
    
    // 2x2 Rotationsmatrix anwenden
    mat2 rot = mat2(vec2(c, -s), vec2(s, c));
    vec2 swirled_uv = rot * uv;
    
    // Koordinaten zurückverschieben
    swirled_uv += 0.5;
	
  vec4 clip_pos = PROJECTION_MATRIX * vec4(VERTEX, 1.0);
	float fragment_depth = clip_pos.z / clip_pos.w;
	vec3 show_color = match_color1;
	//ALBEDO = vec3(0.,mod(swirled_uv.y * sin(TIME * 0.3), .3) + 0.5,0.);
	
	ALBEDO.b = fragment_depth - mod(fragment_depth, 0.01);
	ALBEDO.g = mod(fragment_depth, .01) * 100.;
	ALBEDO.r = match_color1.r;
	if (0.1 > mod(swirled_uv.y * sin(0.3 * TIME), .2))
	{
		discard;
	}
	
	
	ALPHA;
}