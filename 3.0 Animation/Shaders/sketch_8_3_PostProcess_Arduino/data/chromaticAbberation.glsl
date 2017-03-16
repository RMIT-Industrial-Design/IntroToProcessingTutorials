uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float offset;

void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec4 color = texture2D(tex, uv);

    vec2 offset = vec2(offset*0.025,0.0);
    color.r = texture2D(tex, uv+offset.xy).r;
    color.g = texture2D(tex, uv          ).g;
    color.b = texture2D(tex, uv+offset.yx).b;

    gl_FragColor = color;
}

