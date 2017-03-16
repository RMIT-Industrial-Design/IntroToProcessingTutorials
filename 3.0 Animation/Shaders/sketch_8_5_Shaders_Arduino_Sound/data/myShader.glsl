#version 140
#define PROCESSING_COLOR_SHADER

uniform float iGlobalTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

out vec4 fragColor;

//-------------------------------

// User Variables 
uniform float cellResolution;
uniform float smoothingWidth;
uniform float circle_res;
uniform float warp_amount;


float ringStep(float outerRadius, float innerRadius, vec2 coord, float rotationOffset) {
    float d = length(coord);
    float ringValue = smoothstep(smoothingWidth, 0.0, d - outerRadius) * smoothstep(0.0, smoothingWidth, d - innerRadius);
    float radialMultiplier = fract(atan(coord.y, coord.x) * circle_res / 6.28 - 0.3 * iGlobalTime + rotationOffset);
    return ringValue * smoothstep(0.0, 0.1, radialMultiplier - 0.4);
}

float noiseish(vec2 coord, vec2 coordMultiplier1, vec2 coordMultiplier2, vec2 coordMultiplier3, vec3 timeMultipliers) {
    return 0.5 + 0.1667 * (sin(dot(coordMultiplier1, coord) + timeMultipliers.x * iGlobalTime) + sin(dot(coordMultiplier2, coord) + timeMultipliers.y * iGlobalTime) + sin(dot(coordMultiplier3, coord) + timeMultipliers.z * iGlobalTime));
}

void main()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    uv.x += warp_amount * cos(0.6 * uv.x + 0.7 * uv.y - 4.0*cos(0.3 * iGlobalTime) * (0.3 + 0.02*uv.y));
    vec2 localUV = fract(uv * cellResolution) - vec2(0.5);
    const float smoothingWidth = 0.04;
    
    vec2 cellCoord = floor(uv * cellResolution);
    
    float cellValue = noiseish(cellCoord, vec2(1.3, -1.0), vec2(1.7, 1.9), vec2(0.3, 0.7), vec3(-1.3, 2.3, -0.8));
    float outer1 = 0.2 + 0.3 * cellValue;
    float inner1 = 0.02 + 0.38 * pow(cellValue, 0.8);
    
    float cellValue2 = noiseish(cellCoord, vec2(-2.3, 1.1), vec2(1.4, 0.8), vec2(0.1, 0.5), vec3(2.1, 1.9, -1.7));
    
    float v = 1.0 - (ringStep(outer1, inner1, localUV, 0.0) + ringStep(0.05 + 0.25 * cellValue2, 0.05 + 0.05 * cellValue2, localUV, iGlobalTime * 1.2));
    
     //fragColor = vec4(1.0,0.0,0.0, 1.0);
   fragColor = vec4(v, v, v, 1.0);
}