shader_type sky;

uniform sampler2D sky_texture : filter_nearest;
uniform vec2 texture_scale = vec2(1.0, 1.0);

void sky() {
    // Uses screen-space coordinates (0.0 to 1.0 across the viewport)
    vec2 sky_uv = SCREEN_UV * texture_scale;
    
    // Output the static texture image
    COLOR = texture(sky_texture, sky_uv).rgb;
}