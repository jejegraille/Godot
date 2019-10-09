shader_type canvas_item;

uniform float alpha = 1;
uniform float size = 1;
uniform float speed = 1;
uniform int detail = 1;
uniform vec4 color : hint_color;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a != 0.0){
		float x = UV.x * TEXTURE_PIXEL_SIZE.y;
		float y = UV.y * TEXTURE_PIXEL_SIZE.x;
		float circleSize = 10000.0 + 100.0 * max(0, (400.0 - size * 10.0));
		float ix = x * circleSize;
		float iy = y * circleSize;
		int idx = int((cos(ix) + sin(iy)) * (8.0 + 4.0 * sin(TIME * speed)));
		if (idx % max(2, 30 - (6 + detail * 2))  == 0)
			COLOR = mix(COLOR, color, alpha);
	}
}
