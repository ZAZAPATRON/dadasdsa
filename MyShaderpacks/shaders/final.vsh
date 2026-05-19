#version 150

/* Final Vertex */

out vec2 uv;

void main() {
    uv = vec2(gl_VertexID & 1, (gl_VertexID >> 1) & 1) * 2.0;
    gl_Position = vec4(uv * 2.0 - 1.0, 0.0, 1.0);
}
