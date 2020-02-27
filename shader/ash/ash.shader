shader_type canvas_item;


uniform float progress = 0.0;

float getRand(vec2 pos){
	return fract(sin(dot(pos.xy , vec2(12.9898,33.233))) * 414858.5453);
}

float getRand2(vec2 pos){
	return fract(sin(dot(pos.xy , vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	vec2 pos = UV / TEXTURE_PIXEL_SIZE;
	float sizeY = 1.0 / TEXTURE_PIXEL_SIZE.y;
	float p = progress;
	p += 0.3 * getRand(pos);
	float p1 = min(1, p  / 0.4);
	float p2 = min(1, max(0, p - 0.3)  / 0.7);
	
	pos.y -= sizeY  * getRand2(pos) * p2;
	
	
	vec4 color = texture(TEXTURE, pos * TEXTURE_PIXEL_SIZE);
	
	color.r *= 1.0 - p1;
	color.g *= 1.0 - p1;
	color.b *= 1.0 - p1;
	color.a = min(color.a, (1.0 - p2));
	
	float h = sizeY - 32.0 * p2;
	float dFromCenter = (abs(0.5 - UV.x))/0.5;
	if (pos.y > h + dFromCenter * 25.0)
		color.a = 1.0;
	COLOR = color;
}
