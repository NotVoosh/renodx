#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sun Oct 20 13:09:11 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  //r0.xyzw = log2(r0.xyzw);
  //r0.xyzw = cb0[2].xxxx * r0.xyzw;          // in-game gamma correction
  //o0.xyzw = exp2(r0.xyzw);
    o0.rgba = r0.rgba;
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::DecodeSafe(o0.rgb)
                                                 : renodx::color::srgb::DecodeSafe(o0.rgb);
    o0.rgb *= injectedData.toneMapUINits / 80.f;
  return;
}