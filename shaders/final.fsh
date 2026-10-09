#version 330 compatibility

uniform sampler2D colortex0;

uniform float viewWidth;
uniform float viewHeight;

in vec2 textureCoord;

layout (location = 0) out vec4 color0;

#include "common/common.glsl"

vec3 bloom(void)
{
    vec2 uv = textureCoord;
    vec2 texel = vec2(1.0) / vec2(viewWidth, viewHeight);

    vec3 bloom = vec3(0.0);

    const float samples = 32.0;
    vec2 point = vec2(16.0, 0.0) * inversesqrt(samples);

    for (int i = 0; i < int(samples); i++)
    {
        point *= MAT2_ROT;
        vec2 coord = uv + point * sqrt(float(i)) * texel;
        bloom += texture(colortex0, coord).rgb * (1.0 - float(i) / samples);
    }

    bloom *= 3.0 / samples;
    bloom += texture(colortex0, uv).rgb * 0.97;

    return bloom;
}

void main(void)
{
    vec3 final = bloom();

    color0 = vec4(final, 1.0);
}