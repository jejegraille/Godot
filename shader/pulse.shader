shader_type canvas_item;

uniform float freqX : hint_range(1,100) = 18.0;
uniform float intensityX : hint_range(0,10) = 1.5;
uniform float speedX : hint_range(0,50) = 5.8;
uniform float freqY : hint_range(1,100) = 4.0;
uniform float intensityY : hint_range(0,10) = 2.5;
uniform float speedY : hint_range(0,50) = 2.0;

void fragment(){
	float x = cos(UV.x * freqX + TIME * speedX) * intensityX * 0.01;
	float y = sin(UV.y * freqY + TIME * speedY) * intensityY * 0.01;
	vec2 delta = vec2(x,y);
	COLOR = texture(TEXTURE, UV + delta);
