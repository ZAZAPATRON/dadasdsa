#version 150

in vec4 vertexColor;
in vec2 texCoord;

uniform sampler2D Sampler0;

out vec4 FragColor;

void main() {
    vec4 texColor = texture(Sampler0, texCoord) * vertexColor;
    FragColor = texColor;
}
