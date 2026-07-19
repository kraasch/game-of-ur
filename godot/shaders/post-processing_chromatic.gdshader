shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform float gloom : hint_range(0.0, 1.0) = 0.45;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.55;
uniform float desaturation : hint_range(0.0, 1.0) = 0.30;
uniform float blue_tint : hint_range(0.0, 1.0) = 0.20;
uniform float contrast : hint_range(0.5, 2.0) = 1.10;

void fragment()
{
    vec2 uv = SCREEN_UV;
    vec3 color = texture(screen_texture, uv).rgb;

    // Desaturate
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(color, vec3(luma), desaturation);

    // Cool tint
    color.r *= 1.0 - blue_tint * 0.08;
    color.g *= 1.0 - blue_tint * 0.03;
    color.b *= 1.0 + blue_tint * 0.12;

    // Slightly darker midtones
    color = pow(color, vec3(1.0 + gloom * 0.4));

    // Mild contrast
    color = (color - 0.5) * contrast + 0.5;

    // Soft vignette
    vec2 pos = uv - 0.5;
    float vignette = 1.0 - smoothstep(0.2, 0.8, length(pos));
    color *= mix(1.0, vignette, vignette_strength);

    COLOR = vec4(clamp(color, 0.0, 1.0), 1.0);
}