shader_type canvas_item;
render_mode blend_add;

uniform vec4 glow_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float glow_strength = 1.0;
uniform float glow_size = 0.4; // 0.0 to 0.5 (relative to sprite size)

void fragment() {
    vec2 center = vec2(0.5);
    float dist = length(UV - center);
    float halo = smoothstep(glow_size, 0.0, dist);
    vec4 tex = texture(TEXTURE, UV);
    // Draw the original sprite
    COLOR = tex;
    // Add a glow/halo even in transparent areas
    COLOR.rgb += glow_color.rgb * halo * glow_strength;
}