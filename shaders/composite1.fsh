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

    vec2 lowRes = vec2(320.0, 180.0);

    vec2 coord = textureCoord;
    vec2 pixelUV = floor(coord * lowRes) / lowRes;
    vec3 color = texture(colortex0, coord).rgb;
    vec3 final = color;

    final *= mix(0.5, 1.0, smoothstep(0.0, 0.38, luma(final)));
    final = mix(vec3(luma(final)), final, SATURATION_STRENGT);

    float c = mod(fragCoord.x, 4.0);
    vec3 mask = mask(c);
    mask = mask * 0.8 + 0.1;
    
    float scanWave = 0.5 + 0.5 * cos(fragCoord.y * HALF_PI);
    float scanStrength = mix(0.22, 0.10, luma(final));
    float scan = 1.0 - scanStrength * (1.0 - scanWave);

    final *= scan;
    final = final * mask;
    final = clamp(final, 0.0, 1.0);

    color0 = vec4(final, 1.0);
}