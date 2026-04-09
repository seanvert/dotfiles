#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;

uniform float time;
uniform float iTime;
uniform float u_time; // O fork Pijulius Next usa u_time
vec4 default_post_processing(vec4 c);

float noise(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / texsize);

    // 1. NEVOA COLORIDA (GLOW)
    float thickness = 20.0;
    vec2 d = min(texcoord, texsize - texcoord);
    float minDist = min(d.x, d.y);

    if (minDist < thickness) {
        // Cor arco-íris animada
        float hue = u_time * 2.0 + (texcoord.x + texcoord.y) * 0.01;
        vec3 neon = 0.5 + 0.5 * cos(hue + vec3(0, 2, 4));
        
        float glow = pow(1.0 - (minDist / thickness), 2.0);
        color.rgb += neon * glow * 1.5;
        color.a = max(color.a, glow);
    }

    // 2. GRANULADO ANIMADO
    float grain = (noise(texcoord + u_time) - 0.5) * 0.08;
    color.rgb += grain;

    // 3. GHOST (Inativas)
    if (opacity < 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(gray), 0.8) * 0.6;
    }

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
