shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform float blur_size : hint_range(0.0, 5.0) = 1.5;

void fragment()
{
    vec2 uv = SCREEN_UV;
    vec2 px = SCREEN_PIXEL_SIZE * blur_size;
    vec3 color = vec3(0.0);
    color += texture(screen_texture, uv).rgb;
    color += texture(screen_texture, uv + vec2( px.x,  0.0)).rgb;
    color += texture(screen_texture, uv + vec2(-px.x,  0.0)).rgb;
    color += texture(screen_texture, uv + vec2(0.0,  px.y)).rgb;
    color += texture(screen_texture, uv + vec2(0.0, -px.y)).rgb;
    color += texture(screen_texture, uv + vec2( px.x,  px.y)).rgb;
    color += texture(screen_texture, uv + vec2(-px.x,  px.y)).rgb;
    color += texture(screen_texture, uv + vec2( px.x, -px.y)).rgb;
    color += texture(screen_texture, uv + vec2(-px.x, -px.y)).rgb;
    color /= 9.0;
    COLOR = vec4(color, 1.0);
}