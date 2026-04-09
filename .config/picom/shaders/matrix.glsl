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


// Dentro do seu window_shader
float scanline = sin(texcoord.y * 1.5) * 0.04; // Linhas fixas sutis
color.rgb -= scanline;

// Uma "onda" de brilho que desce a tela a cada 5 segundos
float wave = sin(texcoord.y * 0.01 - t * 0.5);
float ripple = smoothstep(0.98, 1.0, wave);
color.rgb += ripple * vec3(0.0, 0.2, 0.0); // Brilho verde fantasmagórico


    // 3. GHOST (Inativas)
    if (opacity < 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(gray), 0.8) * 0.6;
    }

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
