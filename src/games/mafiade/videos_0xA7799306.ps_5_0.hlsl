#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 17 17:55:50 2024
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : VDATA0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t1.Sample(s0_s, v1.zw).x;
  r0.xyz = float3(1.59579468,-0.813476563,0) * r0.xxx;
  r0.w = t0.Sample(s0_s, v1.xy).x;
  r0.xyz = r0.www * float3(1.16412354,1.16412354,1.16412354) + r0.xyz;
  r0.w = t2.Sample(s0_s, v1.zw).x;
  r0.xyz = r0.www * float3(0,-0.391448975,2.01782227) + r0.xyz;
  r0.xyz = float3(-0.87065506,0.529705048,-1.08166885) + r0.xyz;
  r0.xyz = r0.xyz * float3(0.858823538,0.858823538,0.858823538) + float3(0.0627451017,0.0627451017,0.0627451017);
  r0.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r0.w = 9.99999975e-06 + r0.w;
  r0.w = log2(r0.w);
  r1.x = cmp(0 != cb0[0].x);
  r1.y = r1.x ? 1.000000 : 0;
  r0.w = r1.y * r0.w;
  r0.w = exp2(r0.w);
  o0.xyz = r1.xxx ? r0.www : r0.xyz;
  
    o0.rgba = saturate(o0.rgba);
        float videoPeak = injectedData.toneMapPeakNits / (injectedData.toneMapGameNits / 203.f);
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(o0.rgb)
                                                 : renodx::color::srgb::Decode(o0.rgb);
    o0.rgb = renodx::tonemap::inverse::bt2446a::BT709(o0.rgb, 100.f, videoPeak);
    o0.rgb *= injectedData.toneMapPeakNits / videoPeak;
    o0.rgb /= injectedData.toneMapUINits;
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(o0.rgb)
                                                 : renodx::color::srgb::EncodeSafe(o0.rgb);
  
  r0.x = t3.Sample(s0_s, v1.xy).x;
  o0.w = r0.x;
  return;
}