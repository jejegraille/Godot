shader_type canvas_item;


uniform float alpha : hint_range(0,1) = 1;
uniform float alphaB : hint_range(0,1) = 0.79;
uniform float shine : hint_range(0,1) = 0.12;
uniform vec4 colorA : hint_color = vec4(0.1,0.52,0.9,1);
uniform vec4 colorB : hint_color = vec4(1,1,1,1);

uniform float distordX : hint_range(0, 1) = 0.28;
uniform float distordY : hint_range(0, 1) = 0.32;
uniform float square : hint_range(0,1) = 0.8;

uniform float size : hint_range(1,2) = 1.82;
uniform float borderSize : hint_range(0,2.0) = 1.33;
uniform float speed : hint_range(0,10) = 0.4;


float modulo(float a, float b){
	return a - floor(a / b) * b;
}

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a != 0.0){
		vec4 color = colorA;
		vec2 uv = 0.001 *UV / TEXTURE_PIXEL_SIZE;
		float v = (1.0 - square) * 0.0067;
		float x = uv.x * distordX + 0.04622 * sin(TIME * v * uv.y);
		float y = uv.y * distordY + 0.0271 * sin(TIME * v * uv.x);
		float r = 0.01 + 0.2 * (2.0 - size);
		x = x * r;
		y = y * r;
		float circleSize =  900.0 + sin(TIME * 0.2) * (200.0 + 10.0 * uv.x * uv.y);
		float ix = x * circleSize + sin(TIME * 0.1) * 2.0;
		float iy = y * circleSize + cos(TIME * 0.12);
		float idx = 2.0 * sin(uv.x * 10.5 * sin(speed* TIME * 0.1)) + (cos(ix + TIME * 1.3 * speed) + sin(iy)) * (8.0 + 4.0 * sin(TIME* speed));
		float b = borderSize * 0.7 + (0.3 * abs(sin(TIME * 1.2 + size * (20.0 * uv.x + 2.0 * sin(TIME* 1.2 + uv.y * 10.0)))));
		float m = pow(sin(idx *0.1), b);
		float m2 = pow(sin(idx *0.1), borderSize);
		if (m < 0.1)
			color = mix(colorA, colorB, alphaB);
		else{
			color = mix(colorA, colorB, min(alphaB, alphaB * (0.22 * shine/ m2)));
		}
		COLOR = mix(COLOR, color, alpha);
	}
}
