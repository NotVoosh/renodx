#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Fri Sep 20 00:25:05 2024

SamplerState BlitSampler_s : register(s0);
Texture2D<float4> BlitTexture : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  out float4 o0 : SV_Target0)
{
  o0.xyzw = BlitTexture.Sample(BlitSampler_s, v0.xy).xyzw;
    o0.rgb = renodx::color::bt709::from::AP1(o0.rgb);
    		if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		}
    o0.rgb *= injectedData.toneMapUINits / 80.f;
  return;
}