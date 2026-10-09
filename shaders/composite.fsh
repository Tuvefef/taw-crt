#version 330 compatibility

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

in vec2 textureCoord;

/* RENDERTARGETS: 0 */
layout (location = 0) out vec4 color0;

#include "common/common.glsl"
#include "config/config.h"

void main(void)
{
    vec2 fragCoord = textureCoord * vec2(viewWidth, viewHeight);
    vec2 coord = textureCoord;
    vec3 color = texture(colortex0, coord).rgb;

    vec3 final = color;

    final = mix(vec3(luma(final)), final, SATURATION_STRENGT);

    float c = mod(fragCoord.x, 4.0);
    vec3 mask = mask(c);
    mask = mask * 0.8 + 0.1;
    float scan = 0.85 + 0.15 * cos(fragCoord.y * HALF_PI);

    final = final * mask * scan;
    final = clamp(final, 0.0, 1.0);

    color0 = vec4(final, 1.0);
}