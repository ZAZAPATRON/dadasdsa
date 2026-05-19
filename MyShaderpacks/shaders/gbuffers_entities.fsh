#version 150

/* Entity Fragment Shader - OptimaPro */

in VS_OUT {
    vec4 color;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
} fs_in;

out vec4 FragColor;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform vec3 SunDirection;

void main() {
    vec4 texColor = texture(Sampler0, fs_in.uv0) * fs_in.color;
    
    if (texColor.a < 0.1) discard;
    
    // Lighting
    float sunLight = max(0.2, dot(fs_in.normal, normalize(SunDirection))) * 0.8;
    
    // Lightmap
    vec3 lightmapColor = texture(Sampler1, fs_in.uv1).rgb;
    
    // Final
    vec3 finalColor = texColor.rgb * lightmapColor * sunLight;
    
    FragColor = vec4(finalColor, texColor.a);
}
