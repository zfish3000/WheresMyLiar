//shader_type canvas_item;
//
//uniform vec3 color_one : source_color;
//uniform vec3 color_two : source_color;
//
//uniform float angle = 20.0;
//uniform float line_count = 20.0;
//uniform float speed = 10.0;
//uniform float blur : hint_range(0.0, 2.0, 0);
//
//vec2 rotate(vec2 uv, float rotation_angle) {
    //float radians_angle = radians(rotation_angle);
    //float cos_angle = cos(radians_angle);
    //float sin_angle = sin(radians_angle);
    //mat2 rotation_matrix = mat2(vec2(cos_angle, -sin_angle), vec2(sin_angle, cos_angle));
    //return uv * rotation_matrix;
//}
//
//float stripe(vec2 uv) {
    //return cos(uv.x * 0.0 - TIME*speed + uv.y * -line_count/2.0);
//}
//
//void fragment() {
    //vec2 uv = UV;
    //vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
    //float a = TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;
    //uv.x *= a;
    //uv = rotate(uv, angle);
    //float g = stripe(uv);
    //vec3 col = mix(color_one, color_two, smoothstep(0.0, blur, g));
    //COLOR = vec4(col, 1.0);
//}
shader_type canvas_item;

uniform sampler2D gradient;
uniform vec4 circle_color : source_color = vec4(1.0,1.0,1.0,1.0);
uniform float circle_multiplier = 10.0;
uniform float speed = 1.0;
uniform vec2 direction = vec2(1.0,1.0);
uniform mat2 rotation = mat2(vec2(1.0,1.0), vec2(-1.0,1.0));

void fragment() {
	vec2 direction_norm = normalize(direction);
	vec2 uv = UV;
	vec2 uv_deriv = fwidthFine(uv);
	float aspect_ratio = uv_deriv.y / uv_deriv.x;
	uv.x *= aspect_ratio;
	vec2 tiled_UV = rotation * (uv * circle_multiplier - direction_norm * TIME * speed);
	vec2 local_uv = fract(tiled_UV);
	vec2 center = vec2(0.5);
	float dist = distance(local_uv, center);
	float radius = texture(gradient, UV).r;
	float circle_alpha = 1.0 - step(radius, dist);
	COLOR = circle_color * vec4(circle_alpha);
}