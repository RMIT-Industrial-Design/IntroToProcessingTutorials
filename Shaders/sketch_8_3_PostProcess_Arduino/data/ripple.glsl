uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;


// MTAT.03.015 Computer Graphics
// https://courses.cs.ut.ee/2013/cg/
//
// Basic ripple effect example


// Params = (wave frequency in Hz, number of waves per unit distance)
//
vec2 params = vec2(2.5, 11.0);

uniform float frequency;
uniform float waveNum;

// Simple circular wave function
float wave(vec2 pos, float t, float freq, float numWaves, vec2 center) {
    float d = length(pos - center);
    d = log(1.0 + exp(d));
    return 1.0/(1.0+20.0*d*d) *
    sin(2.0*3.1415*(-numWaves*d + t*freq));
}

// This height map combines a couple of waves
float height(vec2 pos, float t) {
    float w;
    w =  wave(pos, t, params.x, params.y, vec2(0.5, -0.5));
    w += wave(pos, t, params.x, params.y, -vec2(0.5, -0.5));
    return w;
}

// Discrete differentiation
vec2 normal(vec2 pos, float t) {
    return 	vec2(height(pos - vec2(0.01, 0), t) - height(pos, t),
                 height(pos - vec2(0, 0.01), t) - height(pos, t));
}

// Simple ripple effect
void main() {
    params = vec2(frequency*4.0, waveNum*5.0);
    
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec2 uvn = 2.0*uv - vec2(1.0);
    uv += normal(uvn, iGlobalTime);
    gl_FragColor = texture2D(tex, vec2(1.0-uv.x, uv.y));
}