#include "../common.hlsl"

Texture2DArray<float4> t3 : register(t3);
Texture2DArray<float4> t2 : register(t2);
Texture2DArray<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[80];
}
cbuffer cb0 : register(b0){
  float4 cb0[6];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.zw = float2(0,0);
  r1.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r1.zw = cb0[4].xy * r1.xy;
  r0.xy = (int2)r1.zw;
  r0.xyz = t0.Load(r0.xyzw).xyz;
  r0.xyz = renodx::color::srgb::EncodeSafe(r0.xyz);
  r2.xy = cb0[2].xy * r1.xy;
  r1.xy = cb1[48].xy * r1.xy;
  r2.z = cb0[2].z;
  r0.w = t2.SampleBias(s1_s, r2.xyz, cb1[79].y).w;
  r0.w = r0.w * 2 + -1;
  r1.w = 1 + -abs(r0.w);
  r0.w = r0.w >= 0 ? 1 : -1;
  r1.w = sqrt(r1.w);
  r1.w = 1 + -r1.w;
  r0.w = r1.w * r0.w;
  r0.xyz = r0.www * (1.0 / 255.0) * injectedData.fxNoise + r0.xyz;
  r0.xyz = renodx::color::srgb::DecodeSafe(r0.xyz);
  r1.z = 0;
  r1.xyzw = t1.SampleLevel(s0_s, r1.xyz, 0).xyzw;
  o0.xyz = r1.www * r0.xyz + r1.xyz;
  o0.xyz = PostToneMapScale(o0.xyz);
  r0.xy = cb1[46].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(-1,-1) + cb1[46].xy;
  r0.zw = cb0[3].zw * r0.zw;
  r0.xy = r0.xy * cb0[3].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(0,0);
  r0.x = t3.Load(r0.xyzw).x;
  o0.w = cb0[5].x == 1.0 ? r0.x : 1;
  return;
}