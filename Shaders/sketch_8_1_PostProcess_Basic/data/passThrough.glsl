uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float dryWet;

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    uv.y *= -1.;
    uv.y += 1.0;

    uv.xy = fract(uv.xy*20.0);
    //uv.xy *= fract(uv.xy*10.0);
    vec4 color = texture2D(tex, uv);
    
    //color.r = 0.5+(sin((uv.x*0.02) * iGlobalTime*2.0)*0.5);

	gl_FragColor = color;
}