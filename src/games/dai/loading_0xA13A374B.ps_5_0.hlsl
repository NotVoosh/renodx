// loading screens

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:00:29 2024

SamplerState mainTextureSampler_s : register(s0);
Texture2D<float4> mainTexture : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = mainTexture.Sample(mainTextureSampler_s, v1.xy).xyzw;
    	
    r0.rgb = renodx::color::bt709::from::SRGB(r0.rgb);
    r0.rgb *= injectedData.toneMapUINits / 80.f ;                                               // UI brightness
    
  o0.xyzw = v2.xyzw * r0.xyzw;
  return;
}