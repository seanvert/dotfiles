#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float time; 
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / texsize);

    // --- CONFIGURAÇÃO DA NÉVOA (GLOW) ---
    float thickness = 15.0;  // Aumentei para a névoa ter espaço para espalhar
    float speed = 2.5;       // Velocidade da transição de cores
    
    float distL = texcoord.x;
    float distR = texsize.x - texcoord.x;
    float distT = texcoord.y;
    float distB = texsize.y - texcoord.y;
    float minDist = min(min(distL, distR), min(distT, distB));

    if (minDist < thickness) {
        // 1. Gerar a cor dinâmica (Rainbow)
        float hue = time * speed + (texcoord.x + texcoord.y) * 0.008;
        vec3 neonColor;
        neonColor.r = 0.5 + 0.5 * sin(hue);
        neonColor.g = 0.5 + 0.5 * sin(hue + 2.1);
        neonColor.b = 0.5 + 0.5 * sin(hue + 4.2);

        // 2. Criar o efeito de "Névoa" (Decaimento Suave)
        // Quanto mais longe da borda (minDist próximo de thickness), menor o glow.
        // Usamos uma potência (pow) para deixar a queda da luz mais natural
        float glowIntensity = pow(1.0 - (minDist / thickness), 2.0);

        // 3. Mistura Aditiva (Simula Luz)
        // Em vez de substituir a cor da janela, somamos o neon para parecer que ele brilha por cima
        color.rgb += neonColor * glowIntensity * 1.5;

        // 4. Garante que o Alpha acompanhe a intensidade da névoa para não ficar um bloco sólido
        // Mas mantemos a base da janela para não sumir com o conteúdo
        color.a = max(color.a, glowIntensity);
    }

    color.rgb *= opacity;
    color.a *= opacity;

    return default_post_processing(color);
}
