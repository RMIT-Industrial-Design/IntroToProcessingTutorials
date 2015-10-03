uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;


vec4 pixelate(vec2 uv){
    
    float pixelateResolution = 0.5+(sin(iGlobalTime*0.3)*100.);

    vec2 vUv = vec2(floor(uv.x * pixelateResolution) / pixelateResolution,
                    floor(uv.y * pixelateResolution) / pixelateResolution);
    
    vec4 wet = texture2D(tex, vUv);
    
    
    return wet;
}

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
   
    vec4 color = pixelate(uv);
   // vec4 color = texture2D(tex, uv);

	gl_FragColor = color;
}