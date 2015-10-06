uniform sampler2D tex;
uniform vec3 iResolution;
uniform float iGlobalTime;

uniform float blurAmount;

vec3 Sample(vec2 uv, vec2 offsets, float weight, float mipBias)
{
    vec2 PixelSize = (mipBias == 0.0 ? 1.0 : mipBias) / iResolution.xy;
    return texture2D(tex, uv + offsets * PixelSize, mipBias).rgb * weight;
}

vec3 GaussianBlur(in vec2 uv, in float Mip, bool line)
{
    // --- pixel offsets for a 3x3 filter kernel;
    vec2 Offsets[9];
    Offsets[0] = vec2(-1.0, -1.0); 	Offsets[1] = vec2(-1.0, 0.0); 	Offsets[2] = vec2(-1.0, 1.0);
    Offsets[3] = vec2(0.0, -1.0); 	Offsets[4] = vec2(0.0, 0.0); 	Offsets[5] = vec2(0.0, 1.0);
    Offsets[6] = vec2(1.0, -1.0); 	Offsets[7] = vec2(1.0, 0.0); 	Offsets[8] = vec2(1.0, 1.0);
    
   	// --- EX8: Implement Gaussian Blur filter
    // --- a) introduce the correct weights to obtain a gaussian blur operator
    float Weights[9];
    Weights[0] = 1.0 / 16.0; 	Weights[1] = 2.0 / 16.0; 	Weights[2] = 1.0 / 16.0;
    Weights[3] = 2.0 / 16.0; 	Weights[4] = 4.0 / 16.0; 	Weights[5] = 2.0 / 16.0;
    Weights[6] = 1.0 / 16.0; 	Weights[7] = 2.0 / 16.0; 	Weights[8] = 1.0 / 16.0;
    
   	// --- take the samples with the appropriate weights and offsets
   	vec3 FilteredColor = Sample(uv, Offsets[0], Weights[0], Mip) + Sample(uv, Offsets[1], Weights[1], Mip) + Sample(uv, Offsets[2], Weights[2], Mip) +
    Sample(uv, Offsets[3], Weights[3], Mip) + Sample(uv, Offsets[4], Weights[4], Mip) + Sample(uv, Offsets[5], Weights[5], Mip) +
    Sample(uv, Offsets[6], Weights[6], Mip) + Sample(uv, Offsets[7], Weights[7], Mip) + Sample(uv, Offsets[8], Weights[8], Mip);
    
    return FilteredColor;
}


void main(){
    vec2 uv = gl_FragCoord.xy / iResolution.xy;


    vec3 color  = GaussianBlur(uv, blurAmount*20.0, true);

	gl_FragColor = vec4(color,1.0);
}