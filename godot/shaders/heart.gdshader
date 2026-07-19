shader_type spatial;

const vec2 A = vec2(0.4, 0.7);
const vec2 B = vec2(0.6, 0.7);
const vec2 C = vec2(0.5, 0.9);

const vec3 HEART_COLOR = vec3(1.0, 0.0, 0.0);
const vec3 BG_COLOR = vec3(0.3, 0.0, 0.0);

void fragment() {
    // triangle center.
    vec2 center = (A + B + C) / 3.0;
    // width and height from the triangle.
    float width = distance(A, B);
    float height = C.y - A.y;
    // normalize UV into heart space.
    vec2 p = UV - center;
    p.x /= width * 0.5;
    p.y /= height * 0.7;
    // move the heart up slightly.
    p.y += 0.2;
    // heart equation.
    float h = pow(p.x * p.x + p.y * p.y - 1.0, 3.0)
            - p.x * p.x * p.y * p.y * p.y;
    if (h <= 0.0)
        ALBEDO = HEART_COLOR;
    else
        ALBEDO = BG_COLOR;
}