#version 150
#extension GL_ARB_explicit_attrib_location : enable

/* Terrain Vertex Shader - OptimaPro */

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in vec2 UV1;
layout(location = 4) in vec3 Normal;
layout(location = 5) in vec3 Tangent;

out VS_OUT {
    vec4 color;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
    vec3 tangent;
    vec3 bitangent;
} vs_out;

uniform mat4 ModelViewMat;
uniform mat4 ProjectionMat;

void main() {
    gl_Position = ProjectionMat * (ModelViewMat * vec4(Position, 1.0));
    
    vs_out.color = Color;
    vs_out.uv0 = UV0;
    vs_out.uv1 = UV1;
    
    mat3 normalMatrix = transpose(inverse(mat3(ModelViewMat)));
    vs_out.normal = normalize(normalMatrix * Normal);
    vs_out.tangent = normalize(normalMatrix * Tangent);
    vs_out.bitangent = cross(vs_out.normal, vs_out.tangent);
}
