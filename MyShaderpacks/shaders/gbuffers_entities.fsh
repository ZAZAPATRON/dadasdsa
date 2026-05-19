#version 150

/* Entity Fragment - Mellow Style */

in DATA {
    vec4 col;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
} data;

out vec4 FragColor;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

uniform vec3 SunDir;
uniform vec3 SunColor;

void main() {
    vec4 texCol = texture(Sampler0, data.uv0) * data.col;
    
    if (texCol.a < 0.5) discard;
    
    // Lightmap
    vec3 lightMap = texture(Sampler1, data.uv1).rgb;
    
    // Lighting
    float sunLight = max(0.2, dot(data.normal, SunDir)) * 0.8 + 0.2;
    
    // Final
    vec3 finalCol = texCol.rgb * lightMap * sunLight;
    
    FragColor = vec4(finalCol, texCol.a);
}
