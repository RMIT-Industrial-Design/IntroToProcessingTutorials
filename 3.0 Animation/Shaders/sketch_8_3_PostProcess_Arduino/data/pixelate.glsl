uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float downsample;

vec4 pixelate(vec2 uv){
    float rate = 300.0-(downsample*300.0);
    vec2 vUv = vec2(floor(uv.x * rate) / rate,
                    floor(uv.y * rate) / rate);
    return texture2D(tex, vUv);
}

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec4 color = pixelate(uv);
    
	gl_FragColor = color;
}