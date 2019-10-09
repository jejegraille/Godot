shader_type canvas_item;


uniform float power : hint_range(0,1) = 0.3;
uniform float vibrance : hint_range(0,1) = 1;
uniform vec4 powerColor: hint_color = vec4(1,1,1,1);

bool isBorder(vec2 intensity, float p, sampler2D texture_, vec2 uv, vec2 pixelSize){
	float speed = 5.0 * p;
	int i = 0;
	float anglePart = 3.14 / 8.0;
	while (i < 8){
		float a = float(i) * anglePart;
		vec2 delta = vec2(cos(a), sin(a));
		vec4 color = texture(texture_, uv +  delta * pixelSize * 2.0 * intensity);
		if (color.a < 0.3)
			return true;
		i += 1;
	} 
	return false;
}

void fragment(){
	float p = power * (1.0 + 0.1 * sin(TIME * 2.0));	
	float speed = 5.0 * p;
	vec2 intensity = 0.005 * (speed / 5.0) * vibrance / TEXTURE_PIXEL_SIZE;
	vec2 newUV = UV;
	newUV.x += TEXTURE_PIXEL_SIZE.x * 2.7 * intensity.x * (sin(TIME * 10.0 * speed) + cos(TIME *20.0 * speed));
	newUV.y += TEXTURE_PIXEL_SIZE.y * 2.7 * intensity.y * (cos(TIME * 11.0 * speed) + sin(TIME * 21.0 * speed));
	vec4 colorEffect = texture(TEXTURE, newUV);
	vec2 uv = UV;
	uv.x += TEXTURE_PIXEL_SIZE.x * 5.0 * intensity.x * sin(TIME* 13.4 * speed);
	uv.y += TEXTURE_PIXEL_SIZE.y * 5.0 * intensity.y * cos(TIME* 11.2* speed);
	vec4 colorTexture = texture(TEXTURE, uv);
	if (isBorder(intensity,p,TEXTURE,uv,TEXTURE_PIXEL_SIZE)){
		float oldA = colorEffect.a;
		colorEffect *= 10.0;
		colorEffect.a = oldA;
		COLOR = mix(colorEffect, colorTexture, 0.8);
	}
	else{
		vec2 uv2 = UV;
		uv2.x += intensity.x * 2.0 * TEXTURE_PIXEL_SIZE.x * (cos(TIME * 2.3 * speed) + sin(TIME * 2.0 * speed));
		uv2.y += intensity.y * 2.0 * TEXTURE_PIXEL_SIZE.y * (cos(TIME * 4.3 * speed) + sin(TIME * 3.0 * speed));
		COLOR = mix(texture(TEXTURE, uv2), vec4(powerColor.r, powerColor.g, powerColor.b, colorTexture.a), 0.6 * speed / 5.0);
	}
	
}
