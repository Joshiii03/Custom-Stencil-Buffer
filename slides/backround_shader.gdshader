
shader_type canvas_item;

uniform sampler2D godot_icon : source_color, repeat_enable, filter_linear;

// Pattern settings
uniform float icon_scale = 0.18;
uniform float rotation = -0.35; // Radians
uniform float spacing = 1.5;

// Animation
uniform vec2 scroll_speed = vec2(0.015, 0.025);

// Colors
uniform vec4 background_color : source_color = vec4(0.015, 0.035, 0.12, 1.0);
uniform vec4 icon_tint : source_color = vec4(0.2, 0.55, 1.0, 1.0);
uniform float icon_opacity = 0.18;

void fragment() {
    vec2 uv = UV;

    // Repeating grid
    vec2 pattern_uv = uv / icon_scale;
    pattern_uv /= spacing;
    pattern_uv -= TIME * scroll_speed;

    // Keep cell coordinates
    vec2 cell = fract(pattern_uv) - 0.5;

    // Rotate icons
    float c = cos(rotation);
    float s = sin(rotation);

    mat2 rot = mat2(vec2(c, -s), vec2(s, c));
    vec2 icon_uv = rot * cell + 0.5;

    // Sample icon
    vec4 icon = texture(godot_icon, icon_uv);

    // Background
    vec3 col = background_color.rgb;

    // Add icons
    col = mix(col, icon_tint.rgb, icon.a * icon_opacity);
	col = mix(col, background_color.rgb, 1.- (UV.y* .3));
	

    COLOR = vec4(col, 1.0);
}
