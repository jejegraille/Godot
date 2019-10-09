shader_type canvas_item;

uniform float pixelSize : hint_range(1, 20) = 2;

void fragment(){
	vec2 size = pixelSize * TEXTURE_PIXEL_SIZE * 0.005;
	vec2 newUV = (floor(vec2(0.5, 0.5) + (UV * TEXTURE_PIXEL_SIZE) / size) * size) / TEXTURE_PIXEL_SIZE;
	COLOR = texture(TEXTURE, newUV);
//BETTER EFFECT WITH ALPHA TO 1 
	if (COLOR.a > 0.5) 
		COLOR.a = 1.0;
}
