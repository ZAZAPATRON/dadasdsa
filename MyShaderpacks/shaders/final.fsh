#version 150

/* Final Fragment */

in vec2 uv;
out vec4 FragColor;

uniform sampler2D colortex0;

void main() {
    FragColor = texture(colortex0, uv);
}
