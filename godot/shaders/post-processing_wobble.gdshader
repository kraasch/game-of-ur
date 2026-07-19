shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float posterize_strength : hint_range(0.0, 1.0) = 0.55;
uniform float saturation : hint_range(0.5, 2.0) = 1.25;
uniform float warmth : hint_range(0.0, 1.0) = 0.25;
uniform float edge_glow : hint_range(0.0, 1.0) = 0.25;
uniform float wobble : hint_range(0.0, 0.01) = 0.002;
uniform float chromatic : hint_range(0.0, 0.01) = 0.0025;

void fragment()
{
    vec2 uv = SCREEN_UV;
    // wobble effect
    uv.x += sin(uv.y * 40.0 + TIME * 2.0) * wobble;
    uv.y += cos(uv.x * 35.0 + TIME * 1.5) * wobble;
    // chromatic toy lens effect
    float r = texture(screen_texture, uv + vec2(chromatic, 0.0)).r;
    float g = texture(screen_texture, uv).g;
    float b = texture(screen_texture, uv - vec2(chromatic, 0.0)).b;
    vec3 color = vec3(r, g, b);
    // increased saturation
    float grey = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(vec3(grey), color, saturation);
    // toy-like color quantization
    float levels = mix(32.0, 6.0, posterize_strength);
    color = floor(color * levels) / levels;
    // warm plastic tint
    color.r += warmth * 0.08;
    color.g += warmth * 0.03;
    // fake soft edge highlights
    vec2 px = SCREEN_PIXEL_SIZE;
    float brightness =
        texture(screen_texture, uv + vec2(px.x, 0.0)).r +
        texture(screen_texture, uv - vec2(px.x, 0.0)).r +
        texture(screen_texture, uv + vec2(0.0, px.y)).r +
        texture(screen_texture, uv - vec2(0.0, px.y)).r;
    brightness *= 0.25;
    color += vec3(1.0, 0.9, 0.7)
        * max(0.0, brightness - dot(color, vec3(0.333)))
        * edge_glow;
    // soft vignette
    float vignette = smoothstep(0.85, 0.25, length(uv - 0.5));
    color *= mix(0.85, 1.0, vignette);
    COLOR = vec4(color, 1.0);
}