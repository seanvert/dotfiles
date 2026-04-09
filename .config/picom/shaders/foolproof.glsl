#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float time; 
vec4 default_post_processing(vec4 c);

float grain_noise(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec2 uv = texcoord / texsize;
    vec4 color = texture(tex, texcoord / texsize);
    float t = time * 0.001;

    // 2. NÉVOA NEON ANIMADA (Sempre colorida)
    float thickness = 20.0; // Aumentei para ficar bem visível
    vec2 d = min(texcoord, texsize - texcoord);
    float minDist = min(d.x, d.y);
    if (opacity == 1.0) {
    if (minDist < thickness) {
        // Cálculo do Arco-íris (Ciclo de cores baseado no tempo)
        float hue = t * 1.0 + (texcoord.x + texcoord.y) * 0.00001;
        vec3 neon = 0.5 + 0.5 * cos(hue + vec3(0, 2, 4));
        
        // Suaviza a borda conforme entra na janela
        float glow = pow(1.0 - (minDist / thickness), 1.5);
        
        // Adicionamos a cor neon por CIMA do conteúdo (garante que não fique P&B)
        color.rgb = mix(color.rgb, neon, glow * 0.8);
        color.rgb += neon * glow * 0.5; // Um pouco de brilho extra
	// color.rgb += neon * glow * 1.5;
        // color.a = max(color.a, glow);
    }
}
    // 2. GHOST (Escala de Cinza)
    if (opacity < 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(gray), 0.7);
    }

    // 3. GRANULADO (Calculado por pixel real para ser fino)
    // float n = grain_noise(uv + t);
    // color.rgb += (n - 0.5) * 0.08;

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
