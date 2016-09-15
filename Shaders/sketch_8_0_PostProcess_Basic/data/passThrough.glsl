uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float copies;


void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    uv.y *= -1.;
    uv.y += 1.0;

    uv.xy = fract(uv.xy*copies);
    
    vec4 color = texture2D(tex, uv);
    
    //color.r = 0.5+(sin((uv.x*0.102) * iGlobalTime*12.0)*0.5);

	gl_FragColor = color;
}