shader_type canvas_item;


uniform float power : hint_range(0,1) = 0.3;
uniform float vibrance : hint_range(0,1) = 1;

bool isBorder(float p, sampler2D texture_, vec2 uv, vec2 pixelSize){
	float speed = 5.0 * p;
	float intensity = (speed / 5.0) * vibrance;
	int i = 0;
	float anglePart = 3.14 / 8.0;
	while (i < 8){
		float a = float(i) * anglePart;
		vec2 delta = vec2(cos(a), sin(a));
		vec4 color = texture(texture_, uv +  delta * pixelSize * 10.0 * intensity);
		if (color.a < 0.3)
			return true;
		i += 1;
	} 
	return false;
}

void fragment(){
	float p = power * (1.0 + 0.1 * sin(TIME * 2.0));	
	float speed = 5.0 * p;
	float intensity = (speed / 5.0) * vibrance;
	vec2 newUV = UV;
	newUV.x += TEXTURE_PIXEL_SIZE.x * 2.7 * intensity * (sin(TIME * 10.0 * speed) + cos(TIME *20.0 * speed));
	newUV.y += TEXTURE_PIXEL_SIZE.y * 2.7 * intensity * (cos(TIME * 11.0 * speed) + sin(TIME * 21.0 * speed));
	vec4 colorEffect = texture(TEXTURE, newUV);
	vec2 uv = UV;
	uv.x += TEXTURE_PIXEL_SIZE.x * 5.0 * intensity * sin(TIME* 13.4 * speed);
	uv.y += TEXTURE_PIXEL_SIZE.y * 5.0 * intensity * cos(TIME* 11.2* speed);
	vec4 colorTexture = texture(TEXTURE, uv);
	if (colorTexture.a < 1.0){
		float oldA = colorEffect.a;
		colorEffect *= 10.0;
		colorEffect.a = oldA;
		COLOR = mix(colorEffect, colorTexture, 0.8);
	}
	else{
		vec2 uv2 = UV;
		uv2.x += intensity * 2.0 * TEXTURE_PIXEL_SIZE.x * (cos(TIME * 2.3 * speed) + sin(TIME * 2.0 * speed));
		uv2.y += intensity * 2.0 * TEXTURE_PIXEL_SIZE.y * (cos(TIME * 4.3 * speed) + sin(TIME * 3.0 * speed));
		if (isBorder(p, TEXTURE, uv2, TEXTURE_PIXEL_SIZE)){
			colorTexture *= 2.0;
			COLOR = colorTexture;
		}else
			COLOR = mix(texture(TEXTURE, uv2), vec4(1,1,1,colorTexture.a), speed / 5.0);
	}
	
}
