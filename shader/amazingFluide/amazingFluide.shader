shader_type canvas_item;


uniform float alpha : hint_range(0,1) = 1;
uniform float alphaB : hint_range(0,1) = 0.79;
uniform float shine : hint_range(0,1) = 0.07;
uniform vec4 colorA : hint_color = vec4(0.1,0.52,0.9,1);
uniform vec4 colorB : hint_color = vec4(1,1,1,1);

uniform float distordX : hint_range(0, 1) = 0.28;
uniform float distordY : hint_range(0, 1) = 0.32;
uniform float square : hint_range(0,1) = 0.889;

uniform float size : hint_range(1,2) = 1.82;
uniform float borderSize : hint_range(0,2.0) = 1.903;
uniform float speed : hint_range(0,10) = 0.4;
uniform int effectType : hint_range(0,10) = 3;
uniform float effectSize : hint_range(0,1) = 0.08;
uniform float effectVariation : hint_range(0,5) = 0.127;


float modulo(float a, float b){
	return a - floor(a / b) * b;
}

float getEffectValue(vec2 uv, float time){
	float effect = 0.0;
	if (effectType == 0)
		effect = time * 0.006 * 0.1 * sin(sin(uv.x * 10.0) + cos(uv.y * 10.0));
	else if (effectType == 1)
		effect = sin(uv.x + time * effectVariation * 0.1 ) * 100.0;
	else if (effectType == 2)
		effect = (uv.x * uv.y) * 1000000.0 * effectVariation;
	else if (effectType == 3)
		effect = uv.x * 1000.0 * effectVariation;
	else if (effectType == 4)
		effect = time * 100.0 * (1.0 + effectVariation);
	else if (effectType == 5)
		effect = 10.0 * sin(uv.y * 10.000);
	return effect;
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
		float effect = getEffectValue(uv, TIME);
		float circleSize =  900.0 + effectSize * 100.0 * sin(effect);
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
