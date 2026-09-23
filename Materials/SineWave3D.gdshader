shader_type spatial;
uniform float scroll_speed = 0.08;

uniform sampler2D image : hint_screen_texture;

void fragment()
{
    vec2 uv = UV;
    uv.y = UV.y * 1.0 + pow(abs(sin(3.14 * UV.x/1.75)),2.0);
	
	vec4 color = texture(image, uv + (scroll_speed * TIME));

    ALBEDO = vec3(color.x,color.y,color.z);
}