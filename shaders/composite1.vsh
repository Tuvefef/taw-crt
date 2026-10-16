#version 330 compatibility

out vec2 textureCoord;

void main(void)
{
    gl_Position = ftransform();
    textureCoord = vec2(gl_TextureMatrix[0] * gl_MultiTexCoord0);
}