shader_type canvas_item;

uniform vec2 position = vec2(0,0); 

uniform vec4 dropColor : hint_color = vec4(1,0.2,0.2,1);
uniform vec4 dropTrailColor : hint_color = vec4(1,0.2,0.2,1);
uniform float alpha : hint_range(0,1) = 0.8;

uniform float direction : hint_range(-1, 1) = -1;
uniform float agitation : hint_range(0, 1) = 0;
uniform float fallSpeed : hint_range(0.1, 2) = 1;
uniform float dropHeigth : hint_range(0.1, 5) = 2;
uniform float dropWidth : hint_range(2, 30) = 5;
uniform float intensity : hint_range(1,20)= 10;


float modulo(float a, float b){
	return a - floor(a / b) * b;
}

void fragment(){
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec2 pos = SCREEN_UV / SCREEN_PIXEL_SIZE;
	
	float x = pos.x + position.x;
	float y = pos.y - position.y;
	float iy;
	bool visible;
	float idx;
	float res1 = 0.0;
	float res2 = 0.0;
	float i = 0.0;
	while (i < 1.0 + intensity){
		x += 30.0 * i;
		y += 100.0;
		iy = (10.0 * sin(0.0025 * (y* 0.2 + x * 0.5)) + y * 0.03 + TIME * 30.0  * fallSpeed );
		res1 = modulo(iy, 10.0);
		visible = res1 < dropHeigth;
		idx = (x * 1.2  + y * (direction * 0.7 + agitation * (sin(TIME * 1.0 ) + cos(TIME *0.5))) * 0.5) * 2.0;
		res2 = modulo(idx, 500);
		if (visible &&  res2 < dropWidth){
			COLOR = mix(dropColor, dropTrailColor, (res1/ dropHeigth));
			COLOR.a = alpha * min(1.0, 2.0 * (res2 / dropWidth)) * (1.0 - (res1/ dropHeigth)) * dropColor.a;
		}
		i += 1.0;
	}
}
