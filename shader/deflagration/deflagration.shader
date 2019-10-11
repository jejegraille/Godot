shader_type canvas_item;

uniform float deflagration : hint_range(0,1) = 0;
uniform float blockSize : hint_range(1, 64) = 8.0;
uniform float dist  = 64.0;
uniform vec2 origine = vec2(0.5, 0.5);
uniform bool implose = false;

float atan2(float y, float x){
	float PI = 3.1415926;
	
	float c1 = PI / 4.0;
	float c2 = 3.0 * c1;
	float abY = abs(y) + 0.00000001;
	float r;
	float angle;
	
	if (x >= 0.0){
		r = (x - abY) / (x + abY);
		angle = c1 - c1 * r;
	}else {
		r = (x + abY) / (abY - x);
		angle = c2 - c1 * r;
	}
	if (y < 0.0)
		return - angle;
	else
		return angle;
}

float getAngle(float aX, float aY, float bX, float bY){
	return atan2(bY - aY, bX - aX);
}

float randomise(float value){
	int v = int(value * 10000.0);
	return float(((v * 31563) % 6562) * ((v * 7763) % 343) % 1000)/1000.0;
}

vec2 getRound(vec2 v){
	return vec2(floor(v.x + 0.5),floor(v.y + 0.5));
}

void fragment(){
	float PI = 3.1415926;	
	vec2 uv  = UV;
	uv = getRound((uv / TEXTURE_PIXEL_SIZE)/ blockSize) * blockSize * TEXTURE_PIXEL_SIZE;
	float angle = getAngle(uv.x, uv.y, origine.x, origine.y);
	if (implose)
		angle += PI;
	vec2 d = (dist * TEXTURE_PIXEL_SIZE) * (0.4 + 0.6 * randomise(uv.x * randomise(uv.y * randomise(uv.x + uv.y)))) * (deflagration * 5.0);
	float dD = distance(vec2(0.0,0.0), d);
	float dDist = distance(uv, origine);
	if (dD < dDist || implose){
		vec2 delta = vec2(d.x * cos(angle), d.y * sin(angle));
		vec2 newUV = UV + delta;
		COLOR = texture(TEXTURE, newUV);
		COLOR.a = min(COLOR.a, 1.0  - max(deflagration/ 5.0, pow(distance(uv, newUV)/distance(vec2(0,0), dist * TEXTURE_PIXEL_SIZE), 2)));
	}else{
		COLOR.a = 0.0;
	}
}
