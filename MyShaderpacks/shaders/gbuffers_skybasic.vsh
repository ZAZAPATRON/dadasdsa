#version 150
#extension GL_ARB_explicit_attrib_location : enable

/* Sky Vertex Shader - OptimaPro */

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;

out VS_OUT {
    vec4 color;
    vec3 position;
} vs_out;

uniform mat4 ModelViewMat;
uniform mat4 ProjectionMat;

void main() {
    gl_Position = ProjectionMat * (ModelViewMat * vec4(Position, 1.0));
    vs_out.color = Color;
    vs_out.position = Position;
}
