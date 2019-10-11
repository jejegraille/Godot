shader_type canvas_item;

uniform float pixelSize : hint_range(1, 50) = 2;

vec2 roundVec(vec2 v){
	return vec2(floor(v.x + 0.5), floor(v.y + 0.5));
}

void fragment(){
	vec2 uv = UV / TEXTURE_PIXEL_SIZE;
	uv = roundVec(uv / pixelSize) * pixelSize;
	COLOR = texture(TEXTURE, uv * TEXTURE_PIXEL_SIZE);
//BETTER EFFECT WITH ALPHA TO 1 
	if (COLOR.a > 0.5) 
		COLOR.a = 1.0;
}
