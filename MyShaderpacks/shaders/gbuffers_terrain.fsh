#version 150

/* Terrain Fragment Shader - OptimaPro */

in VS_OUT {
    vec4 color;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
    vec3 tangent;
    vec3 bitangent;
} fs_in;

out vec4 FragColor;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

uniform vec3 SunDirection;
uniform vec3 MoonDirection;

void main() {
    vec4 texColor = texture(Sampler0, fs_in.uv0) * fs_in.color;
    
    if (texColor.a < 0.1) discard;
    
    // Basic lighting
    float sunLight = max(0.0, dot(fs_in.normal, normalize(SunDirection))) * 0.8 + 0.2;
    
    // Apply lightmap
    vec4 lightmapTexel = texture(Sampler1, fs_in.uv1);
    vec3 lightmapColor = lightmapTexel.rgb;
    
    // Combine
    vec3 finalColor = texColor.rgb * lightmapColor * sunLight;
    
    FragColor = vec4(finalColor, texColor.a);
}
