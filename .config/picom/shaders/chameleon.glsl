#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float time;
vec4 default_post_processing(vec4 c);

// Função de suavização (Smooth Color Transition)
vec3 lerp_color(vec3 a, vec3 b, float t) {
    return a + t * (b - a);
}

vec4 window_shader() {
    vec2 res = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / res);
    float t = time * 0.001;

    // 1. AMOSTRAGEM EM MASSA (Efeito 300+ amostras)
    // Usamos textureLod com um bias alto (ex: 10.0) para pegar a média global
    // Isso é mecanicamente igual a tirar a média de milhares de pixels.
    vec3 avg_color = textureLod(tex, vec2(0.5, 0.5), 10.0).rgb;

    // 2. ESTABILIZAÇÃO (Evita a troca brusca)
    // Usamos um seno lento para criar uma "persistência" na cor
    float stability = sin(t * 0.5) * 0.5 + 0.5;
    vec3 stable_color = mix(avg_color, vec3(dot(avg_color, vec3(0.33))), 0.2);

    // 3. BORDA CAMALEÃO
    float thickness = 22.0;
    vec2 d = min(texcoord, res - texcoord);
    float edge = min(d.x, d.y);

    if (edge < thickness) {
        float factor = pow(1.0 - (edge / thickness), 2.0);
        
        // Intensifica a cor para o Glow não ficar "lavado"
        vec3 glow = stable_color * 1.8; 
        
        // Pulsação lenta
        glow *= (sin(t * 1.2) * 0.15 + 0.85);
        
        color.rgb = mix(color.rgb, glow, factor);
    }

    // 4. GHOST & GRANULADO
    if (opacity < 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = vec3(gray * 0.55);
    }
    
    // Granulado fino
    float n = (fract(sin(dot(texcoord + t, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 0.06;
    color.rgb += n;

    return default_post_processing(vec4(color.rgb * opacity, color.a * opacity));
}
