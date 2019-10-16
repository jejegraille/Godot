shader_type canvas_item;


uniform float progress : hint_range(0,1);
uniform float trickleHeigth = 100;

uniform vec4 traceColor : hint_color = vec4(1,0,0,1);
uniform bool useTextureForTrace = false;

uniform float microFreqX : hint_range(0, 1) = 0.39;
uniform float freqX : hint_range(0, 1) = 0.352;
uniform float macroFreqX : hint_range(0, 1) = 1;




vec4 findColor(float d, sampler2D texture_, vec2 pos, vec2 pixelSize){
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
		return color;
	}
	return vec4(-1,0,0,0);
}
	

void fragment(){
	vec2 pos = UV / TEXTURE_PIXEL_SIZE;
	
	float d = trickleHeigth;
	float r = max(0, sin(pos.x * microFreqX * 2.0) - 0.8) / 0.2;
	r += max(0, sin(pos.x * freqX * 0.8) - 0.3) / 0.7;
	r += sin(pos.x * macroFreqX * 0.08);
	r = max(0, r);
	r /= 3.0;
	d += 50.0 * pow(sin(pos.x * macroFreqX * 0.1),2);
	d = trickleHeigth * r;
	float df = - progress * d;
	vec2 newUV = vec2(pos.x, pos.y + df) * TEXTURE_PIXEL_SIZE;
	vec4 color = texture(TEXTURE, UV);
	color.a = 1.0;
	vec4 trickleColor = texture(TEXTURE, newUV);
	if (trickleColor.a <= 0.7){
		vec4 topColor = findColor(-df, TEXTURE, pos, TEXTURE_PIXEL_SIZE);
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
