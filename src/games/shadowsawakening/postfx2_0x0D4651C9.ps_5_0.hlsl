#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Tue Oct 15 18:03:16 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.xy = r0.xy + r0.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = cb0[2].x * r0.x;
  r0.x = -r0.x * 0.100000001 + 1;
  r0.y = 1 + -r0.x;
  r0.x = cb0[2].y * r0.y + r0.x;
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r0.xyzw = r1.xyzw * r0.xxxx;
  //o0.xyzw = cb0[3].zzzz * r0.xyzw;    // game "gamma" setting
    o0.rgba = r0.rgba;
      o0.rgb = applyFilmGrain(o0.rgb, v1.xy);
      if(injectedData.toneMapGammaCorrection == 1){
      o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
      o0.rgb *= injectedData.toneMapGameNits / 80.f;
      } else {
      o0.rgb *= injectedData.toneMapGameNits / 80.f;
      }
  return;
}