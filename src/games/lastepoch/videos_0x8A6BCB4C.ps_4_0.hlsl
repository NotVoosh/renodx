#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sat Sep 28 02:39:24 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
    float videoPeak = injectedData.toneMapPeakNits / (injectedData.toneMapGameNits / 203.f);
    r0.rgb = saturate(r0.rgb);
    r0.rgb = renodx::tonemap::inverse::bt2446a::BT2020(r0.rgb, 100.f, videoPeak);
    r0.rgb *= injectedData.toneMapPeakNits / videoPeak;
    r0.rgb /= injectedData.toneMapUINits;
  o0.w = cb0[2].x * r0.w;
  o0.xyz = r0.xyz;
  return;
}