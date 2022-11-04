shader_type canvas_item;
uniform float speed;

void fragment() {
	vec2 uv = UV;
	uv.x += TIME*speed;
	uv.x -= floor(uv.x);
	COLOR = texture(TEXTURE,uv);
}
