#version 150

in vec2 texCoord;

uniform sampler2D colortex0;

out vec4 color;

void main() {
    color = texture(colortex0, texCoord);
}
