#version 330 compatibility

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;

in vec2 textureCoord;

/* RENDERTARGETS: 0 */
layout (location = 0) out vec4 color0;

#include "config/config.h"

void main(void)
{
    vec4 final = texture(colortex0, textureCoord);

#ifdef CHROMATIC_ABERRATION
    vec2 center = textureCoord - vec2(0.5);
    
    final.r = texture(colortex0, textureCoord + (center * vec2(0.018))).r;
    final.g = texture(colortex0, textureCoord + (center * vec2(0.012))).g;
    final.b = texture(colortex0, textureCoord + (center * vec2(-0.012))).b;
#endif

    color0 = final;
}