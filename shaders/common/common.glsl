#ifndef COMMON_GLSL
#define COMMON_GLSL 0

const float PI = 3.14159265;
const float HALF_PI = PI * 0.5;
const mat2 MAT2_ROT = -mat2(0.7374, 0.6755, -0.6755, 0.7374);

float luma(vec3 color)
{
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

vec3 mask(float c)
{
    return vec3(
        exp(-pow(c - 1.5, 2.0) * 4.0),
        exp(-pow(c - 2.5, 2.0) * 4.0),
        exp(-pow(c - 3.5, 2.0) * 4.0)
    );
}

#endif