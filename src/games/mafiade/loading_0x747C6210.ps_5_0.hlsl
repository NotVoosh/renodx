#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 17 17:55:43 2024
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
  float4 v2 : VDATA1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = v1.xyzw * r0.xyzw;

        float videoPeak = injectedData.toneMapPeakNits / (injectedData.toneMapGameNits / 203.f);
    r0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::DecodeSafe(r0.rgb)
                                                 : renodx::color::srgb::DecodeSafe(r0.rgb);
    r0.rgb /= injectedData.toneMapPeakNits / videoPeak;
    r0.rgb *= injectedData.toneMapUINits;
    r0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(r0.rgb)
                                                 : renodx::color::srgb::EncodeSafe(r0.rgb);

// sensor noise
  r1.x = cmp(0 < cb0[0].z);
  if (r1.x != 0) {
    r1.xy = cb0[0].xy + v0.xy;
    r1.xy = (int2)r1.xy;
    r1.xy = (int2)r1.xy & int2(63,63);
    r1.zw = float2(0,0);
    r1.xyz = t1.Load(r1.xyz).xyz;
    r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
    //r2.xyz = max(float3(0,0,0), r0.xyz);
    //r2.xyz = sqrt(r2.xyz);
      r2.rgb = sign(r0.rgb) * sqrt(abs(r0.rgb));
    r3.xyz = cb0[0].www + r2.xyz;
    r3.xyz = min(cb0[0].zzz, r3.xyz);
    r1.xyz = r1.xyz * r3.xyz * injectedData.fxNoise + r2.xyz;     // noise
    //r0.xyz = r1.xyz * r1.xyz;
      r0.rgb = sign(r1.rgb) * pow(abs(r1.rgb), 2.f);
  }
  o0.xyzw = r0.xyzw;

    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::DecodeSafe(o0.rgb)
                                                 : renodx::color::srgb::DecodeSafe(o0.rgb);
    o0.rgb *= injectedData.toneMapPeakNits / videoPeak;
    o0.rgb /= injectedData.toneMapUINits;
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(o0.rgb)
                                                 : renodx::color::srgb::EncodeSafe(o0.rgb);
    
  return;
}