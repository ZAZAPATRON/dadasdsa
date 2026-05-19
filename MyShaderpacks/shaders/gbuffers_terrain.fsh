#version 150

/* Terrain Fragment - Mellow Style */

in DATA {
    vec4 col;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
    vec3 viewPos;
} data;

out vec4 FragColor;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform vec3 SunDir;
uniform vec3 SunColor;
uniform vec3 MoonDir;
uniform vec3 MoonColor;

uniform float DayTime;

void main() {
    // Texture
    vec4 texCol = texture(Sampler0, data.uv0) * data.col;
    
    if (texCol.a < 0.5) discard;
    
    // Lightmap
    vec3 lightMap = texture(Sampler1, data.uv1).rgb;
    
    // Sun/Moon lighting
    float sunDot = max(0.0, dot(data.normal, SunDir));
    float moonDot = max(0.0, dot(data.normal, MoonDir));
    
    // Soft shadows
    float sunLight = mix(sunDot * 0.7 + 0.3, 1.0, DayTime);
    float moonLight = mix(moonDot * 0.5 + 0.5, 0.0, DayTime);
    
    // Dynamic lighting
    vec3 dynLight = mix(SunColor * sunLight, MoonColor * moonLight, 1.0 - DayTime);
    
    // Final color
    vec3 finalCol = texCol.rgb * (lightMap * 0.8 + dynLight * 0.2);
    
    FragColor = vec4(finalCol, texCol.a);
}
