#version 150

/* Water Fragment - Mellow Style */

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
uniform float GameTime;

void main() {
    // Water texture
    vec4 waterTex = texture(Sampler0, data.uv0 + vec2(GameTime * 0.1));
    
    // Lightmap
    vec3 lightMap = texture(Sampler1, data.uv1).rgb;
    
    // Reflection
    vec3 viewNorm = normalize(data.normal);
    vec3 sunReflect = reflect(-SunDir, viewNorm);
    float sunReflection = max(0.0, dot(sunReflect, -normalize(data.viewPos))) * 0.3;
    
    // Water color with transparency
    vec3 waterCol = mix(vec3(0.2, 0.5, 0.8), vec3(1.0), sunReflection);
    
    // Final
    vec3 finalCol = waterTex.rgb * waterCol * lightMap * 0.8;
    
    FragColor = vec4(finalCol, 0.8);
}
