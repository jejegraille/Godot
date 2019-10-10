shader_type canvas_item;

uniform float alpha : hint_range(0,1) = 1;
uniform float size : hint_range(1,50) = 1;
uniform float speed : hint_range(0,20) = 12;
uniform float detail : hint_range(0,10) = 7;
uniform vec4 color : hint_color = vec4(1,1,0.3,1);

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.3){
		float x = UV.x * TEXTURE_PIXEL_SIZE.y;
		float y = UV.y * TEXTURE_PIXEL_SIZE.x;
		float circleSize = 10000.0 + 100.0 * (400.0 - size * 10.0);
		float ix = x * circleSize;
		float iy = y * circleSize;
		int idx = int((cos(ix) + sin(iy)) * (8.0 + 4.0 * sin(TIME * speed)));
		if (idx % max(2, 30 - (6 + int(detail) * 2))  == 0)
			COLOR = mix(COLOR, color, alpha);
	}
}
