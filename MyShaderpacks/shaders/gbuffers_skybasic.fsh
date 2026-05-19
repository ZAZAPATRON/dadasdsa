#version 150

/* Sky Fragment Shader - OptimaPro */

in VS_OUT {
    vec4 color;
    vec3 position;
} fs_in;

out vec4 FragColor;

uniform float GameTime;
uniform vec3 SunDirection;
uniform sampler2D Sampler0;

// Cloud noise function
float cloudNoise(vec3 pos, float time) {
    vec2 uv = pos.xz * 0.1 + time * 0.01;
    
    // Simple noise simulation
    return fract(sin(uv.x * 12.9898 + uv.y * 78.233 + time * 0.1) * 43758.5453);
}

void main() {
    // Base sky color
    vec3 skyColor = mix(
        vec3(0.529, 0.808, 0.922),  // Day blue
        vec3(0.2, 0.1, 0.3),         // Night purple
        fs_in.color.r
    );
    
    // Sun glow
    float sunGlow = max(0.0, dot(normalize(fs_in.position), normalize(SunDirection)));
    vec3 sunColor = vec3(1.0, 0.85, 0.5) * pow(sunGlow, 128.0) * 0.5;
    
    // Cloud calculation
    float cloud = cloudNoise(fs_in.position, GameTime);
    cloud = smoothstep(0.3, 0.7, cloud);
    vec3 cloudColor = mix(skyColor, vec3(1.0), cloud * 0.4);
    
    // Final color
    vec3 finalColor = cloudColor + sunColor;
    finalColor *= fs_in.color.rgb;
    
    FragColor = vec4(finalColor, 1.0);
}
