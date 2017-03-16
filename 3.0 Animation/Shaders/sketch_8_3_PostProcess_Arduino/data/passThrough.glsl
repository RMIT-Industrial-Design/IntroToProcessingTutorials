uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float dryWet;

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    uv.y *= -1.;
    uv.y += 1.0;
    vec4 color = texture2D(tex, uv);
    //color.r += 0.5+sin(1000.0*iGlobalTime)*0.5;
    color.g *= 0.5+sin(uv.y*iGlobalTime*0.3)*0.5;
    color.b *= 0.5+cos(uv.x*iGlobalTime*0.5)*0.5;
    
    vec4 dry = texture2D(tex,uv);
    vec4 final = mix(dry, color, dryWet);
	gl_FragColor = final;
}