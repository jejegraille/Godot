shader_type canvas_item;

uniform float alpha : hint_range(0,1) = 1;
uniform float size : hint_range(1,2) = 1;
uniform float speed : hint_range(0,20) = 12;
uniform float detail : hint_range(0,10) = 7;
uniform vec4 color : hint_color = vec4(1,1,0.3,1);

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.3){
		vec2 uv = UV;
		uv.x = uv.x * TEXTURE_PIXEL_SIZE.y;
		uv.y = uv.y * TEXTURE_PIXEL_SIZE.x;
		float circleSize = 100000.0 - 100000.0 * (size - 1.0);
		vec2 iV = uv * circleSize;
		int i = int((cos(iV.x) + cos(iV.y)) * (8.0 + 4.0 * sin(TIME * speed)));
		if (i % max(2, 30 - (6 + int(detail) * 2))  == 0)
			COLOR = mix(COLOR, color, alpha);
	}
}
