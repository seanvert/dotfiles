#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float time;
uniform bool invert_color;
vec4 default_post_processing(vec4 c);

float noise(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / texsize);
    float t = time * 0.001;
    // 1. NEVOA COLORIDA (GLOW)
    float thickness = 20.0;
    vec2 d = min(texcoord, texsize - texcoord);
    float minDist = min(d.x, d.y);

    // if (minDist > thickness) {
        // Cor arco-íris animada
        // float hue = t * 1.0 + (texcoord.x + texcoord.y) * 0.001;
    float hue = 0.5 * sin(t);
        vec3 neon = 0.1 + 0.2 * hue + vec3(0.1, 0, 0);
        
        // float glow = pow(1.0 - (minDist / thickness), 1.0);
        // color.rgb += neon * glow * 1.5;
	color.rgb += neon;
        // color.a = max(color.a, glow);
    // }

    // // 2. GRANULADO ANIMADO
    float grain = (noise(texcoord + t * 0.001) - 0.5) * 0.08;
    color.rgb += grain;

    // 3. GHOST (Inativas)
    if (opacity < 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(gray), 0.8) * 0.6;
    }

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
