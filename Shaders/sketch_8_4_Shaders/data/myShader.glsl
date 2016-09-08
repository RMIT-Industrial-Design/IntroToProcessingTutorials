#version 140
#define PROCESSING_COLOR_SHADER

uniform float iGlobalTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

out vec4 fragColor;

float noiseish(vec2 coord, vec2 coordMultiplier1, vec2 coordMultiplier2, vec2 coordMultiplier3, vec3 timeMultipliers) {
    return 0.333 * (sin(dot(coordMultiplier1, coord) + timeMultipliers.x * iGlobalTime) + sin(dot(coordMultiplier2, coord) + timeMultipliers.y * iGlobalTime) + sin(dot(coordMultiplier3, coord) + timeMultipliers.z * iGlobalTime));
}

void main()
{
    vec2 uv = gl_FragCoord.xy / iResolution.y;
    vec2 uvOffset;
    uvOffset.x = .2 * sin(iGlobalTime * 0.41 + 0.7) *pow(abs(uv.y - 0.5), 3.1) - sin(iGlobalTime * 0.07 + 0.1);
    uvOffset.y = -iGlobalTime * 0.03 + .05 * sin(iGlobalTime * 0.3) * pow(abs(uv.x - 0.5), 1.8);
    uv += uvOffset;
    const float cellResolution = 7.0;
    const float lineSmoothingWidth = 0.05;
    vec2 localUV = fract(uv * cellResolution);
    vec2 cellCoord = floor(uv * cellResolution);
    
    vec2 angle = 4.9 * normalize(vec2(noiseish(cellCoord, vec2(1.7, 0.9), vec2(2.6, 1.1), vec2(0.0), vec3(0.55, 0.93, 0.0)), noiseish(cellCoord, vec2(0.6, 1.9), vec2(1.3, 0.3), vec2(0.0), vec3(1.25, 0.83, 0.0))));
    
    float v = smoothstep(-lineSmoothingWidth, lineSmoothingWidth, abs(fract(dot(localUV, angle) + 3.6*iGlobalTime)-0.5) - 0.25);
    
    const float borderSmoothingWidth = 0.02;
    // apply borders
    vec2 centeredLocalUV = localUV - vec2(0.5);
    const float borderDistance = 0.45; // 0.5 = all the way to the edge of the cell
    v = max(v, max(smoothstep(-borderSmoothingWidth, borderSmoothingWidth, abs(centeredLocalUV.x) - borderDistance), smoothstep(-borderSmoothingWidth, borderSmoothingWidth, abs(centeredLocalUV.y) - borderDistance)));
    
    fragColor = vec4(v, v, v, 1.0);
}

