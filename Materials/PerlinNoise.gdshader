shader_type spatial;
render_mode unshaded;

uniform sampler2D base_texture : source_color, hint_default_white, repeat_enable, filter_nearest;
uniform sampler2D noise_texture : source_color, hint_default_white, repeat_enable, filter_nearest;

uniform float noise_speed = 0.2;
uniform float noise_scale = 2.0;
uniform float texture_scale = 1.0;

// Slider to control the opacity of the base texture (0.0 = invisible, 1.0 = fully opaque)
uniform float texture_opacity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // Read the repeating pixelated base texture
    vec2 repeated_texture_uv = UV * texture_scale;
    vec4 base_color = texture(base_texture, repeated_texture_uv);
    
    // Animate the pixelated noise lookup over time
    vec2 animated_noise_uv = (UV * noise_scale) + (TIME * noise_speed);
    vec4 noise_color = texture(noise_texture, animated_noise_uv);
    
    // Blend the base texture using the opacity slider
    // mix(A, B, t) smoothly transitions from A to B based on the value of t
    vec3 blended_texture = mix(vec3(1.0), base_color.rgb, texture_opacity);
    
    // Multiply the blended result by the noise color
    ALBEDO = blended_texture * noise_color.rgb;
}
