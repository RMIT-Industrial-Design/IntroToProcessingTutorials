uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float dryWet;

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    uv.y *= -1.;
    uv.y += 1.0;
    
    vec4 color = texture2D(tex, uv);
	gl_FragColor = color;
}