#include "../tonemap.hlsl"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[3];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.yw = float2(0.125,0.375);
  r1.xyzw = t0.Sample(s0_s, v1.xy).zxyw;
  o0.w = r1.w;
  float3 preCG = r1.yzx;
  if (injectedData.toneMapType != 0.f) {
    r1.w = max(r1.x, r1.y);
    r1.w = max(r1.w, r1.z);
    r1.w = 1 + r1.w;
    r1.w = renodx::math::DivideSafe(1, r1.w);
    r1.xyz = r1.xyz * r1.www;
  }
  r0.xz = r1.yz;
  r2.xyzw = t1.Sample(s1_s, r0.zw).xyzw;
  r0.xyzw = t1.Sample(s1_s, r0.xy).xyzw;
  r2.xyz = float3(0,1,0) * r2.xyz;
  r0.xyz = r0.xyz * float3(1,0,0) + r2.xyz;
  r1.y = 0.625;
  r1.xyzw = t1.Sample(s1_s, r1.xy).xyzw;
  r0.xyz = r1.xyz * float3(0,0,1) + r0.xyz;
  r0.w = dot(r0.xyz, float3(0.0396819152,0.45802179,0.00609653955));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = cb0[2].xxx * r0.xyz + r0.www;
    if (injectedData.toneMapType != 0.f) {
    r0.w = max(r0.x, r0.y);
    r0.w = max(r0.w, r0.z);
    r0.w = 1 + -r0.w;
    r0.w = renodx::math::DivideSafe(1, r0.w);
    r0.xyz = r0.xyz * r0.www;
  }
  r0.xyz = RestoreSaturationLoss(preCG, r0.xyz);
  o0.xyz = lerp(preCG, r0.xyz, injectedData.colorGradeUserLUTStrength);
  if (injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)) {
    o0.xyz = applyUserNoTonemap(o0.xyz);
  }
  if (injectedData.countOld == injectedData.countNew) {
    o0.xyz = PostToneMapScale(o0.xyz);
  }
  return;
}