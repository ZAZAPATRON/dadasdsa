#version 150

/* Sky Fragment - Mellow Style */

in DATA {
    vec4 col;
    vec3 pos;
} data;

out vec4 FragColor;

uniform vec3 SunDir;
uniform vec3 SunColor;
uniform vec3 MoonDir;
uniform sampler2D Sampler0;

// Simple cloud noise
float cloud(vec3 pos) {
    float x = sin(pos.x * 0.5) * cos(pos.z * 0.3);
    float y = sin(pos.z * 0.7) * cos(pos.x * 0.4);
    float z = sin((pos.x + pos.z) * 0.2);
    
    return (x + y + z) * 0.33 + 0.5;
}

void main() {
    vec3 normal = normalize(data.pos);
    
    // Sky gradient
    vec3 skyCol = mix(
        vec3(0.529, 0.808, 0.922),  // Blue
        vec3(1.0),                   // White top
        max(0.0, normal.y)
    );
    
    // Sun glow
    float sunGlow = dot(normal, SunDir);
    vec3 sunGlowCol = SunColor * max(0.0, pow(sunGlow, 256.0)) * 2.0;
    
    // Clouds
    float cloudVal = cloud(normal * 10.0);
    cloudVal = smoothstep(0.4, 0.7, cloudVal);
    vec3 cloudCol = mix(skyCol, vec3(1.0), cloudVal * 0.6);
    
    // Combine
    vec3 finalCol = cloudCol + sunGlowCol;
    finalCol = finalCol * data.col.rgb;
    
    FragColor = vec4(finalCol, 1.0);
}
