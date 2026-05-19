#version 150
#extension GL_ARB_explicit_attrib_location : enable

/* Terrain Vertex - Mellow Style */

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in vec2 UV1;
layout(location = 4) in vec3 Normal;

out DATA {
    vec4 col;
    vec2 uv0;
    vec2 uv1;
    vec3 normal;
    vec3 viewPos;
} data;

uniform mat4 ModelViewMat;
uniform mat4 ProjectionMat;
uniform mat3 NormalMat;

void main() {
    data.col = Color;
    data.uv0 = UV0;
    data.uv1 = UV1;
    data.normal = normalize(NormalMat * Normal);
    data.viewPos = vec3(ModelViewMat * vec4(Position, 1.0));
    
    gl_Position = ProjectionMat * (ModelViewMat * vec4(Position, 1.0));
}
