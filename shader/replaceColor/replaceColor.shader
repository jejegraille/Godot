shader_type canvas_item;

uniform vec4 c1From : hint_color = vec4(0,0,0,1);
uniform vec4 c1To : hint_color = vec4(0,0,0,1);
uniform float c1Tolerance : hint_range(-1,200) = 1.0;

uniform vec4 c2From : hint_color = vec4(0,0,0,1);
uniform vec4 c2To : hint_color = vec4(0,0,0,1);
uniform float c2Tolerance : hint_range(-1,200) = -1.0;

uniform vec4 c3From : hint_color = vec4(0,0,0,1);
uniform vec4 c3To : hint_color = vec4(0,0,0,1);
uniform float c3Tolerance : hint_range(-1,200) = -1.0;

uniform vec4 c4From : hint_color = vec4(0,0,0,1);
uniform vec4 c4To : hint_color = vec4(0,0,0,1);
uniform float c4Tolerance : hint_range(-1,200) = -1.0;

uniform vec4 c5From : hint_color = vec4(0,0,0,1);
uniform vec4 c5To : hint_color = vec4(0,0,0,1);
uniform float c5Tolerance : hint_range(-1,200) = -1.0;


vec4 getColor(vec4 color){
	float diffR;
	float diffG;
	float diffB;
	float diff;
	if (c1Tolerance >= 0.0){
		diffR = color.r * 255.0 - c1From.r * 255.0;
		diffG = color.g * 255.0 - c1From.g * 255.0;
		diffB = color.b * 255.0 - c1From.b * 255.0;
		diff = 100.0 * ((abs(diffB) + abs(diffG) + abs(diffR)) / 255.0);
		if (diff <= c1Tolerance)
			return vec4(c1To.r + (diffR) / 255.0, c1To.g + diffG / 255.0, c1To.b + diffB / 255.0, color.a);
	}
	if (c2Tolerance >= 0.0){
		diffR = color.r * 255.0 - c2From.r * 255.0;
		diffG = color.g * 255.0 - c2From.g * 255.0;
		diffB = color.b * 255.0 - c2From.b * 255.0;
		diff = 100.0 * ((abs(diffB) + abs(diffG) + abs(diffR)) / 255.0);
		if (diff <= c2Tolerance)
			return vec4(c2To.r + (diffR) / 255.0, c2To.g + diffG / 255.0, c2To.b + diffB / 255.0, color.a);
	}
	if (c3Tolerance >= 0.0){
		diffR = color.r * 255.0 - c3From.r * 255.0;
		diffG = color.g * 255.0 - c3From.g * 255.0;
		diffB = color.b * 255.0 - c3From.b * 255.0;
		diff = 100.0 * ((abs(diffB) + abs(diffG) + abs(diffR)) / 255.0);
		if (diff <= c3Tolerance)
			return vec4(c3To.r + (diffR) / 255.0, c3To.g + diffG / 255.0, c3To.b + diffB / 255.0, color.a);
	}
	if (c4Tolerance >= 0.0){
		diffR = color.r * 255.0 - c4From.r * 255.0;
		diffG = color.g * 255.0 - c4From.g * 255.0;
		diffB = color.b * 255.0 - c4From.b * 255.0;
		diff = 100.0 * ((abs(diffB) + abs(diffG) + abs(diffR)) / 255.0);
		if (diff <= c4Tolerance)
			return vec4(c4To.r + (diffR) / 255.0, c4To.g + diffG / 255.0, c4To.b + diffB / 255.0, color.a);
	}
	if (c5Tolerance >= 0.0){
		diffR = color.r * 255.0 - c5From.r * 255.0;
		diffG = color.g * 255.0 - c5From.g * 255.0;
		diffB = color.b * 255.0 - c5From.b * 255.0;
		diff = 100.0 * ((abs(diffB) + abs(diffG) + abs(diffR)) / 255.0);
		if (diff <= c5Tolerance)
			return vec4(c5To.r + (diffR) / 255.0, c5To.g + diffG / 255.0, c5To.b + diffB / 255.0, color.a);
	} 

	return color;
	
}

void fragment(){
	vec4 currentColor = texture(TEXTURE, UV);
	if (currentColor.a > 0.1){
		COLOR = getColor(currentColor);
	}
	else
		COLOR = currentColor;
}
