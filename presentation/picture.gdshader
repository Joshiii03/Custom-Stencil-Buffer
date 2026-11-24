shader_type canvas_item;

uniform sampler2D pic ;

void fragment() {
	COLOR = texture(pic, UV);
}
