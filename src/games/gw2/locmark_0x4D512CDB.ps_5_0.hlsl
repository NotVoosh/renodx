#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:12:52 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

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
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v2.xyz, v1.xyz);
  r0.x = abs(r0.x);
  r0.x = t1.Sample(s1_s, r0.xx).x;
  r1.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = r1.w * r0.x;
  r0.y = r0.x * cb0[2].x + -cb0[0].x;
  r0.x = cb0[2].x * r0.x;
  //o0.w = r0.x;
	o0.a = saturate(r0.r);
  r0.x = cmp(r0.y < 0);
  if (r0.x != 0) discard;
  r0.x = 1 + -v3.w;
  o0.xyz = r1.xyz * r0.xxx + v3.xyz;
	o0.rgb = renodx::color::bt709::from::SRGB(o0.rgb);
	o0.rgb *= (injectedData.toneMapUINits + injectedData.toneMapGameNits) / (injectedData.toneMapGameNits * 2);
	o0.rgb = renodx::color::srgb::from::BT709(o0.rgb);
  return;
}