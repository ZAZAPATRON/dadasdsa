#version 150

in vec2 texCoord;

uniform sampler2D colortex0;

out vec4 FragColor;

void main() {
    FragColor = texture(colortex0, texCoord);
}
