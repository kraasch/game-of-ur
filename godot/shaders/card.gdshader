shader_type spatial;

const vec2 A = vec2(0.4, 0.6);
const vec2 B = vec2(0.6, 0.6);
const vec2 C = vec2(0.5, 0.9);

const vec3 TRIANGLE_COLOR = vec3(0.2, 0.2, 0.2);
const vec3 BG_COLOR = vec3(0.3, 0.0, 0.0);

bool inside_triangle(vec2 p){
    vec2 v0 = C - A;
    vec2 v1 = B - A;
    vec2 v2 = p - A;

    float dot00 = dot(v0, v0);
    float dot01 = dot(v0, v1);
    float dot02 = dot(v0, v2);
    float dot11 = dot(v1, v1);
    float dot12 = dot(v1, v2);

    float inv = 1.0 / (dot00 * dot11 - dot01 * dot01);

    float u = (dot11 * dot02 - dot01 * dot12) * inv;
    float v = (dot00 * dot12 - dot01 * dot02) * inv;

    return u >= 0.0 && v >= 0.0 && u + v <= 1.0;
}

void fragment() {
    if (inside_triangle(UV)) {
        ALBEDO = TRIANGLE_COLOR;
    } else {
        ALBEDO = BG_COLOR;
	}
}