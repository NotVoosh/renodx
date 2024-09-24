#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Fri Sep 20 06:07:15 2024
Texture2DArray<float4> t0 : register(t0);

SamplerState s0_s : register(s0);




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

  r0.xy = v1.xy;
  r0.z = 0;
  o0.xyzw = t0.SampleLevel(s0_s, r0.xyz, 0).xyzw;
    float3 lch = renodx::color::oklch::from::BT709(o0.rgb);
    lch[1] /= max(0.1f, injectedData.colorGradeSaturation);
    float3 color = renodx::color::bt709::from::OkLCh(lch);
    o0.rgb = color;
  return;
}