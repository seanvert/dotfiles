#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
// O Picom passa o foco através da opacidade ou via variável de controle
// Mas a forma mais garantida em regras é aplicar este shader apenas para :!focused
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / texsize);

    // 1. Converter para Tons de Cinza (Luminância)
    // Usamos os pesos padrão para percepção humana
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // 2. Criar a "Tintura Ghost"
    // Um tom azulado/cinza bem frio e profundo
    vec3 ghostTint = vec3(0.4, 0.5, 0.6); 

    // 3. Misturar o cinza com a tintura e reduzir o brilho
    // Multiplicar por 0.6 faz com que a janela inativa não "brilhe"
    vec3 finalRGB = mix(vec3(gray), ghostTint * gray, 0.5) * 0.6;

    // 4. Retornar com a opacidade padrão do Picom
    color = vec4(finalRGB * opacity, color.a * opacity);
    
    return default_post_processing(color);
}
