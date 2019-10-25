shader_type canvas_item;

uniform float borderSize : hint_range(1,30) = 2.0;
uniform vec4 color : hint_color = vec4(1,1,1,1);
uniform int precision : hint_range(1,4) = 2; 
void fragment(){	
	vec4 cCur = texture(TEXTURE,UV);
	if (cCur.a < 0.2){		
		vec2 origin = UV / TEXTURE_PIXEL_SIZE;
		vec2 vec = vec2(0,0);
		vec4 colorCheck;
		bool border = false;
		float i = 0.0;
		float p = pow(2.0, 1.0 + float(precision));
		float anglePart = (2.0 * 3.14) / p;
		float a;
		while (i < p && !border){
			a = anglePart * i;
			vec.x = borderSize * cos(a);
			vec.y = borderSize * sin(a);
			i += 1.0;
			colorCheck = texture(TEXTURE, (origin + vec) * TEXTURE_PIXEL_SIZE);
			if (colorCheck.a > 0.2){
				COLOR = color;
				border = true;
			}
		}
		if (!border)
			COLOR = cCur;
	}else
		COLOR = cCur;
}
