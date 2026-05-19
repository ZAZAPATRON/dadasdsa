#version 150
#extension GL_ARB_explicit_attrib_location : enable

/* Sky Vertex - Mellow Style */

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;

out DATA {
    vec4 col;
    vec3 pos;
} data;

uniform mat4 ModelViewMat;
uniform mat4 ProjectionMat;

void main() {
    data.col = Color;
    data.pos = Position;
    
    gl_Position = ProjectionMat * (ModelViewMat * vec4(Position, 1.0));
}
