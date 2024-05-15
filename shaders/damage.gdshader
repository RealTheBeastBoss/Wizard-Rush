shader_type canvas_item;

void fragment() {
	vec4 input_colour = texture(TEXTURE, UV);
	COLOR = vec4(1.0, 1.0, 1.0, input_colour.a);
}