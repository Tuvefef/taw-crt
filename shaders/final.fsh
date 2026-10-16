#version 330 compatibility

uniform sampler2D colortex0;

uniform float viewWidth;
uniform float viewHeight;
uniform int worldTime;

in vec2 textureCoord;

layout (location = 0) out vec4 color0;

#include "common/common.glsl"
#include "config/config.h"

vec3 bloom(void)
{
    float bloomBase;
    vec2 uv = textureCoord;
    vec2 texel = 1.0 / vec2(viewWidth, viewHeight);

    vec3 center = texture(colortex0, uv).rgb;
    vec3 sum = vec3(0.0);
    float weightSum = 0.0;

    vec2 dir = vec2(1.0, 0.0);

    for (int i = 0; i < 8; ++i)
    {
        vec2 offset = dir * texel * 2.0;
        sum += texture(colortex0, uv + offset).rgb * 0.65;
        sum += texture(colortex0, uv - offset).rgb * 0.65;
        weightSum += 1.30;

        offset = dir * texel * 5.0;
        sum += texture(colortex0, uv + offset).rgb * 0.35;
        sum += texture(colortex0, uv - offset).rgb * 0.35;
        weightSum += 0.70;

        dir = ROT45 * dir;
    }

    vec3 glow = sum / weightSum;

    if (nightFactor(worldTime) == 0.0)
    {
        bloomBase = DAY_BLOOM;
    }
    else
    {
        bloomBase = NIGHT_BLOOM;
    }

    return glow + center * bloomBase;
}

void main(void)
{
    vec3 final = bloom();

    color0 = vec4(final, 1.0);
}