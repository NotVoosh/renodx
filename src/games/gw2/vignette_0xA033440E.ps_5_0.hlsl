#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Mon Aug 26 17:33:19 2024
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float2 v1 : TEXCOORD1,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t2.Sample(s2_s, v0.zw).x;
  r0.x = r0.x * 0.800000012 + cb0[2].x;
  r0.x = -0.800000012 + r0.x;
  r0.x = saturate(5.00000048 * r0.x);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.y * r0.x;
  r0.y = t1.Sample(s1_s, v1.xy).x * 1;
  r0.x = r0.x * r0.y;
  r0.x = cb0[0].w * r0.x;
  r1.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.yzw = cb0[0].xyz * r1.xyz;
  r1.xyz = r0.yzw + r0.yzw;
  r1.xyzw = float4(-1,-1,-1,-1) + r1.xyzw;
  o0.xyzw = r0.xxxx * r1.xyzw * injectedData.fxVignette + float4(1,1,1,1);  // Vignette
  return;
}