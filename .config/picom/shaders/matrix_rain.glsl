#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float time;
vec4 default_post_processing(vec4 c);

float hash(float n) { 
    return fract(sin(n) * 758.5453123); 
}

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture(tex, texcoord / texsize);
    float t = time * 0.001;

    // --- 1. SCANLINES (Seu efeito original) ---
    float scanline = sin(texcoord.y * 1.5) * 0.04;
    color.rgb -= scanline;

    // --- 2. DIGITAL RAIN (A "Chuva" que não caía) ---
    // Largura de cada coluna da chuva
    float col_width = 10.0;
    float x_col = floor(texcoord.x / col_width);
    
    // Velocidade e atraso aleatórios por coluna
    // float speed = hash(x_col) * 3.0 + 2.0;
    float speed = hash(x_col * 0.8) * 8.0 + 0.5;
    // float delay = hash(x_col * 15.0) * 5.0;
    float delay = hash(x_col * 123.4) * 50.0;
    
    // Criamos a repetição vertical (o rastro da gota)
    // Multiplicamos texcoord.y por um valor maior para as gotas ficarem menores
    float y_inv = texsize.y - texcoord.y;
    // float rain_pos = (y_inv * 0.05) + (t + delay) * speed;
    float rain_pos = (y_inv * 0.02) + (t + delay) * speed;
    float rain_trail = floor(rain_pos) - rain_pos;


    // --- 3. ESPAÇAMENTO (O "Pulo do Gato") ---
    // Aumentamos o valor do step para 0.95: 
    // Significa que apenas 5% das sementes de hash resultarão em chuva.
    // Adicionamos t no hash para que as colunas "morram" e "nasçam" em lugares diferentes com o tempo.
    // float random_occurrence = hash(x_col + floor(rain_pos * 0.1));
    // float rain_mask = step(0.95, random_occurrence);
    // Máscara para não chover em todas as colunas ao mesmo tempo
    float rain_mask = step(0.75, hash(x_col + floor(rain_pos)));
    // Cor com brilho aleatório para cada gota
    float brightness_vary = hash(x_col) * 0.5 + 0.5;
    vec3 rain_color = vec3(0.1, 1.0, 0.4) * pow(rain_trail, 5.0) * rain_mask * brightness_vary;


    // Cor da gota (Verde Matrix clássico, usando a cauda do fract)
    // vec3 rain_color = vec3(0.0, 1.0, 0.2) * pow(rain_trail, 3.0) * rain_mask;

    // Aplicar a chuva apenas nas bordas (glow) ou na janela toda?
    // Vou aplicar um brilho maior nas bordas como você tinha planejado:
    float thickness = 25.0;
    vec2 d = min(texcoord, texsize - texcoord);
    float minDist = min(d.x, d.y);
    
    if (minDist < thickness) {
        float edge_factor = pow(1.0 - (minDist / thickness), 2.0);
        color.rgb += rain_color * edge_factor * 4.0;
    } else {
        // Na parte de dentro, a chuva é mais sutil
        color.rgb += rain_color * 4.0;
    }

    // if (minDist < thickness) {
    //     float edge_factor = pow(1.0 - (minDist / thickness), 2.0);
    //     color.rgb += rain_color * edge_factor * 4.0;
    // }

    // --- 3. GHOST (Janelas Inativas) ---
    // if (opacity < 1.0) {
    //     float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    //     color.rgb = mix(color.rgb, vec3(gray), 0.8) * 0.6;
    // }

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
