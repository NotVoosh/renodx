#include "../common.hlsl"

Texture2DArray<float4> t4 : register(t4);
Texture2DArray<float4> t3 : register(t3);
Texture2DArray<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[53];
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

  r0.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r0.zw = r0.xy * cb0[1].xy + cb0[1].zw;
  r0.z = t1.Sample(s1_s, r0.zw).w;
  r0.z = -0.5 + r0.z;
  r0.z = r0.z + r0.z;
  r1.xy = cb0[4].xy * r0.xy;
  r1.xy = (uint2)r1.xy;
  r1.zw = float2(0,0);
  r1.xyz = t0.Load(r1.xyzw).xyz;
  if(injectedData.fxFilmGrainType == 0.f){
  r2.xyz = r1.xyz * r0.zzz;
  r2.xyz = cb0[0].xxx * r2.xyz * injectedData.fxFilmGrain;
  r0.z = renodx::color::y::from::BT709(saturate(r1.xyz));
  r0.z = sqrt(r0.z);
  r0.z = cb0[0].y * -r0.z + 1;
  r1.xyz = r2.xyz * r0.zzz + r1.xyz;
  } else {
    r1.xyz = applyFilmGrain(r1.xyz, v1);
  }
  r1.xyz = renodx::color::srgb::EncodeSafe(r1.xyz);
  r2.xy = cb0[2].xy * r0.xy;
  r0.xy = cb1[52].xy * r0.xy;
  r2.z = cb0[2].z;
  r0.w = t3.Sample(s1_s, r2.xyz).w;
  r0.w = r0.w * 2 + -1;
  r1.w = 1 + -abs(r0.w);
  r0.w = r0.w >= 0 ? 1 : -1;
  r1.w = sqrt(r1.w);
  r1.w = 1 + -r1.w;
  r0.w = r1.w * r0.w;
  r1.xyz = r0.www * (1.0 / 255.0) * injectedData.fxNoise + r1.xyz;
  r1.xyz = renodx::color::srgb::DecodeSafe(r1.xyz);
  r0.z = 0;
  r0.xyzw = t2.SampleLevel(s0_s, r0.xyz, 0).xyzw;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
  o0.xyz = PostToneMapScale(o0.xyz);
  r0.xy = cb1[50].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(-1,-1) + cb1[50].xy;
  r0.zw = cb0[3].zw * r0.zw;
  r0.xy = r0.xy * cb0[3].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(0,0);
  r0.x = t4.Load(r0.xyzw).x;
  o0.w = cb0[5].x == 1.0 ? r0.x : 1;
  return;
}