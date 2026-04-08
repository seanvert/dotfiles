#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture2D(tex, texcoord / texsize, 0);
    float lum = dot(color.rgb, vec3(0.2, 0.72, 0.09));

    vec3 tint = vec3(0.9, 0.15, 0.05);
    color.rbg = vec3(lum) * tint;
    color = vec4(color.rgb, color.a * opacity);
    return default_post_processing(color);
}
