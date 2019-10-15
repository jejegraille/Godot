shader_type canvas_item;


uniform float progress : hint_range(0,1);
uniform float trickleHeigth = 64;
uniform float traceAlpha : hint_range(0,1) = 0.28;

uniform vec4 traceColor : hint_color = vec4(1,0,0,1);
uniform bool useTextureForTrace = false;

uniform float freqX1 : hint_range(0, 10) = 6.2;
uniform float power1 : hint_range(0, 1) = 0.07;
uniform float freqX2 : hint_range(0, 10) = 1;
uniform float power2 : hint_range(0, 1) = 0.4;




vec4 findColor(float d, sampler2D texture_, vec2 pos, float pixelSize){
	float i = 0.0;
	vec2 delta = vec2(0, 0);
	float maxI = 0.0;
	while (i < 200.0 && i < d){
		delta.y = -i;
		vec4 color = texture(texture_, (pos + delta) * pixelSize);
		if (color.a > 0.8){
			maxI = i;
		}
		i += 1.0;
	}
	if (maxI > 0.0){
		delta.y = - maxI;
		vec4 color = texture(texture_, (pos + delta) * pixelSize);	
		color.a = traceAlpha * 0.2 + traceAlpha * 0.8 * (maxI / d);
		return color;
	}
	return vec4(-1,0,0,0);
}
	

void fragment(){
	vec2 pos = UV / TEXTURE_PIXEL_SIZE;
	
	float d = trickleHeigth + 30.0 * power1 * sin(pos.x * freqX1 * 0.1) + 30.0 * power2 * sin(pos.x * freqX2 * 0.1);
	float df = - progress * d;
	vec2 newUV = vec2(pos.x, pos.y + df) * TEXTURE_PIXEL_SIZE;
	vec4 color = texture(TEXTURE, UV);
	color.a = 1.0;
	vec4 trickleColor = texture(TEXTURE, newUV);
	if (trickleColor.a <= 0.7){
		vec4 topColor = findColor(-df, TEXTURE, pos, TEXTURE_PIXEL_SIZE.y);
		if (useTextureForTrace)
			COLOR = topColor;
		else{
			COLOR = traceColor;
			COLOR.a = topColor.a;
		}
	}else{
		if (color.a > trickleColor.a){
			COLOR = trickleColor;
		}
		else
			COLOR = color;
		
	}

}
