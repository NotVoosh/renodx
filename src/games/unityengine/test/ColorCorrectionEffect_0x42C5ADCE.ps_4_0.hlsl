#include "../common.hlsl"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
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

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  float3 preCG = r0.xyz;
  if (injectedData.toneMapType != 0.f) {
    r1.w = max(r0.x, r0.y);
    r1.w = max(r1.w, r0.z);
    r1.w = 1 + r1.w;
    r1.w = renodx::math::DivideSafe(1, r1.w);
    r0.xyz = r0.xyz * r1.www;
  }
  r1.xyzw = t2.Sample(s2_s, r0.xx).xyzw;
  r1.x = 9.99999975e-06 + r1.x;
  r2.xyzw = t2.Sample(s2_s, r0.yy).xyzw;
  r1.y = 1.99999995e-05 + r2.y;
  r2.xyzw = t2.Sample(s2_s, r0.zz).xyzw;
  r1.z = 2.99999992e-05 + r2.z;
  r2.xyzw = t1.Sample(s1_s, r0.xx).xyzw;
  r0.x = 9.99999975e-06 + r2.x;
  r2.xyzw = t1.Sample(s1_s, r0.yy).xyzw;
  r0.y = 1.99999995e-05 + r2.y;
  r2.xyzw = t1.Sample(s1_s, r0.zz).xyzw;
  r0.z = 2.99999992e-05 + r2.z;
  r1.w = r0.w;
  r1.xyzw = r1.xyzw + -r0.xyzw;
  o0.xyzw = cb0[2].xxxx * r1.xyzw + r0.xyzw;
    if (injectedData.toneMapType != 0.f) {
    r0.w = max(o0.x, o0.y);
    r0.w = max(r0.w, o0.z);
    r0.w = 1 + -r0.w;
    r0.w = renodx::math::DivideSafe(1, r0.w);
    o0.xyz = o0.xyz * r0.www;
  }
  if (injectedData.colorGradeUserLUTScaling > 0.f) {
    r0.xyz = float3(0, 0, 0);
  r1.xyzw = t2.Sample(s2_s, r0.xx).xyzw;
  r1.x = 9.99999975e-06 + r1.x;
  r2.xyzw = t2.Sample(s2_s, r0.yy).xyzw;
  r1.y = 1.99999995e-05 + r2.y;
  r2.xyzw = t2.Sample(s2_s, r0.zz).xyzw;
  r1.z = 2.99999992e-05 + r2.z;
  r2.xyzw = t1.Sample(s1_s, r0.xx).xyzw;
  r0.x = 9.99999975e-06 + r2.x;
  r2.xyzw = t1.Sample(s1_s, r0.yy).xyzw;
  r0.y = 1.99999995e-05 + r2.y;
  r2.xyzw = t1.Sample(s1_s, r0.zz).xyzw;
  r0.z = 2.99999992e-05 + r2.z;
  r1.xyz = r1.xyz + -r0.xyz;
  float3 minBlack = cb0[2].xxx * r1.xyz + r0.xyz;
    float lutMinY = renodx::color::y::from::BT709(abs(minBlack));
    if (lutMinY > 0) {
      float3 correctedBlack = renodx::lut::CorrectBlack(preCG, o0.rgb, lutMinY, 0.f);
      o0.rgb = lerp(o0.rgb, correctedBlack, injectedData.colorGradeUserLUTScaling);
    }
  }
  o0.xyz = lerp(preCG, o0.xyz, injectedData.colorGradeUserLUTStrength);
  return;
}