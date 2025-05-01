#include "./common.hlsl"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[43];
}

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t1.Sample(s1_s, v1.xy).xyzw;
  r1.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  r0.xyz = r1.xyz * r0.xxx;
  r1.rgb = applyUserTonemap(r0.rgb, t2, s2_s, cb0[36].xyz);
  r0.x = cmp(0.5 < cb0[42].x);
  if (r0.x != 0) {
    r1.w = renodx::color::y::from::BT709(r1.rgb);
  }
  o0.xyzw = r1.xyzw;
  return;
}