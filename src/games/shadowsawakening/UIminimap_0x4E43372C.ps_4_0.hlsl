#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Tue Oct 15 12:35:47 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r1.x = r0.w * v1.w + -0.00999999978;
  r0.xyzw = v1.xyzw * r0.xyzw;
  r1.x = cmp(r1.x < 0);
  if (r1.x != 0) discard;
  r1.xyzw = t1.Sample(s1_s, v2.xy).xyzw;
  r1.x = 1 + -r1.w;
  o0.xyzw = r1.xxxx * r0.xyzw;
      if(injectedData.toneMapGammaCorrection == 1){
      o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
      o0.rgb *= injectedData.toneMapUINits / 80.f;
      } else {
      o0.rgb *= injectedData.toneMapUINits / 80.f;
      }
  return;
}