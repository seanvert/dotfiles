#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture2D(tex, texcoord / texsize, 0);
    float gray = dot(color.rgb, vec3(0.3, 0.8, 0.1));
    color = vec4(vec3(gray) * opacity, color.a * opacity);
    return default_post_processing(color);
}
