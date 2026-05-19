#version 150
#extension GL_ARB_explicit_attrib_location : enable

/* Entity Vertex Shader - OptimaPro */

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in vec2 UV1;
layout(location = 4) in vec3 Normal;

out VS_OUT {
    vec4 color;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
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
}
