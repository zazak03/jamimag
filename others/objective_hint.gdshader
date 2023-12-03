shader_type canvas_item;

uniform float fade_out = 1;


void fragment() {
	COLOR.a = fade_out;
}
