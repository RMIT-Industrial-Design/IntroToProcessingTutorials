#version 140
#define PROCESSING_COLOR_SHADER

uniform float iGlobalTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

out vec4 fragColor;

uniform float strobeSpeed;

//-------------------------------

#define t iGlobalTime
#define PI 3.1415297
#define TWOPI 2.0*PI

void main()
{
    vec2 uv = (-1.0+2.0*(gl_FragCoord.xy / iResolution.xy))*vec2(iResolution.x/iResolution.y, 1.0);
    
    float a = atan( uv.y, uv.x);
    float r = length(uv);
    
   	vec3 pixel = vec3(0.0);
    
    float w = TWOPI * t * strobeSpeed;
    vec3 col = vec3(0.5+0.5*sin(0.2*w), 0.5+0.5*sin(0.5*w), 0.5+0.5*sin(1.0*w));
    
    pixel += col*smoothstep(0.0, 0.1,sin(10.0*(1.0/r+t))-0.9);
    pixel += col*smoothstep(0.0, 0.1,sin(10.0*(a-t))-.9);
    pixel *= smoothstep(0.1, 0.6, r);
    
    float alpha;
    fragColor = vec4(pixel, 1.0);
}