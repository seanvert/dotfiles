#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / texsize, 0);
    float lum = dot(c.rgb, vec3(0.299, 0.587, 0.114));
    c.rgb = vec3(lum * 0.9, lum * 0.15, lum * 0.05);
    c.a *= opacity;
    return default_post_processing(c);
}
