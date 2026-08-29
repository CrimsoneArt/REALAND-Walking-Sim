shader_type canvas_item;
uniform float scroll_speed = 0.08;
// only works on texture rect that has stretch mode set to "tile"
void fragment()
{
    vec2 uv = UV;
    uv.y = UV.y * 1.0 + pow(abs(sin(3.14 * UV.x/1.75)),2.0);

    COLOR = texture(TEXTURE, uv + (scroll_speed * TIME));
}