#include "../common.hlsl"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[29];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.xy * cb0[28].xy + cb0[28].zw;
  r0.x = t0.Sample(s0_s, r0.xy).w;
  r0.x = r0.x * 2 + -1;
  r0.y = 1 + -abs(r0.x);
  r0.x = saturate(r0.x * renodx::math::FLT_MAX + 0.5);
  r0.x = r0.x * 2 + -1;
  r0.y = sqrt(r0.y);
  r0.y = 1 + -r0.y;
  r0.x = r0.x * r0.y;
  r1.xyzw = t1.Sample(s1_s, w1.xy).xyzw;
  r0.xyz = r0.xxx * (1.0 / 255.0) * injectedData.fxNoise + r1.xyz;
  if (injectedData.countOld == injectedData.countNew) {
  r0.xyz = renodx::color::srgb::DecodeSafe(r0.xyz);
  r0.xyz = PostToneMapScale(r0.xyz, true);
  }
  o0.xyz = r0.xyz;
  o0.w = r1.w;
  return;
}