shader_type spatial;
render_mode unshaded, world_vertex_coords, blend_mix, depth_draw_never;

uniform sampler2D albedo_texture : source_color, hint_default_white, repeat_enable, filter_nearest;
uniform vec2 scroll_speed = vec2(0.05, 0.0);
uniform vec3 uv_scale = vec3(1.0, 1.0, 1.0);

varying vec3 uv1_triplanar_pos;
varying vec3 uv1_power;

void vertex() {
	vec3 normal = MODEL_NORMAL_MATRIX * NORMAL;
	uv1_power = pow(abs(normal), vec3(10.0));
	uv1_power /= (uv1_power.x + uv1_power.y + uv1_power.z);
	uv1_triplanar_pos = VERTEX * uv_scale;
}

void fragment() {
	vec2 uv_x = uv1_triplanar_pos.zy + (scroll_speed * TIME);
	vec2 uv_y = uv1_triplanar_pos.xz + (scroll_speed * TIME);
	vec2 uv_z = uv1_triplanar_pos.xy + (scroll_speed * TIME);
	
	vec4 tex_x = texture(albedo_texture, uv_x);
	vec4 tex_y = texture(albedo_texture, uv_y);
	vec4 tex_z = texture(albedo_texture, uv_z);
	
	vec4 final_color = tex_x * uv1_power.x + tex_y * uv1_power.y + tex_z * uv1_power.z;
	
	ALBEDO = final_color.rgb;
	ALPHA = final_color.a;
}
