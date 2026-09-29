shader_type spatial;
render_mode unshaded;

uniform float strength = 5.0; // Stärke des Wirbels
uniform sampler2D base_texture : source_color; // Die Textur

uniform vec3 match_color : source_color ;

void fragment() {
    //UV-Koordinaten zentrieren (-0.5 bis 0.5);
    vec2 uv = UV - 0.5;
    
    // Abstand zum Zentrum berechnen
    float dist = length(uv);
    
    // Rotationswinkel abhängig vom Abstand berechnen
    float angle = (1.0 - dist) * strength;
    
    // Sinus und Kosinus für die Rotationsmatrix
    float s = sin(angle);
    float c = cos(angle);
    
    // 2x2 Rotationsmatrix anwenden
    mat2 rot = mat2(vec2(c, -s), vec2(s, c));
    vec2 swirled_uv = rot * uv;
    
    // Koordinaten zurückverschieben
    swirled_uv += 0.5;
	
    // Farbe aus der Textur auslesen
    //ALBEDO = texture(base_texture, swirled_uv).rgb;
	float fragment_depth = 1./((PROJECTION_MATRIX[2].z * VERTEX.z + PROJECTION_MATRIX[3].z) -VERTEX.z);
	
	ALBEDO = vec3(0.,mod(swirled_uv.y * sin(TIME * 0.3), .3) + 0.5,0.);
	ALBEDO.r = match_color.r;
	ALBEDO.b = fragment_depth;
}