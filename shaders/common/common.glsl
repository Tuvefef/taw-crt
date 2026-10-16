#ifndef COMMON_GLSL
#define COMMON_GLSL 0

#define inverse(x) (1.0 - (x))

const float PI = 3.14159265;
const float HALF_PI = PI * 0.5;
const mat2 ROT45 = mat2(0.70710678,  0.70710678, -0.70710678,  0.70710678);

float luma(vec3 color)
{
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

float nightFactor(int time)
{
    float t = float(time % 24000);
    float fi = smoothstep(12000.0, 13500.0, t);
    float fo = inverse(smoothstep(21500.0, 23000.0, t));

    return fi * fo;
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