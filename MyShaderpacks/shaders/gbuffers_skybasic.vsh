#version 150

in vec3 Position;
in vec4 Color;

out vec4 vertexColor;

uniform mat4 ModelViewMat;
uniform mat4 ProjectionMat;

void main() {
    gl_Position = ProjectionMat * (ModelViewMat * vec4(Position, 1.0));
    vertexColor = Color;
}
