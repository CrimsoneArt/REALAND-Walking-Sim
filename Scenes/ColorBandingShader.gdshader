shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform float step_size : hint_range(0.0, 1.0, 0.001) = 0.01;

void fragment() {
    // Get the base color
    vec3 color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
    
    color.r = round(color.r/step_size)*step_size;
	color.g = round(color.g/step_size)*step_size;
	color.b = round(color.b/step_size)*step_size;
	
    COLOR = vec4(color, 1.0);
}