#include "../common.hlsl"

Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[8];
}
cbuffer cb0 : register(b0){
  float4 cb0[5];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xzyw;
  r0 = max(0.f, r0);
  o0.w = r0.w;
  float3 preCG = r0.xzy;
  if (injectedData.toneMapType != 0.f) {
    r0.w = max(r0.x, r0.y);
    r0.w = max(r0.w, r0.z);
    r0.w = 1 + r0.w;
    r0.w = renodx::math::DivideSafe(1, r0.w);
    r0.xyz = r0.xyz * r0.www;
  }
  r1.x = r0.y;
  r1.yw = float2(0.625,0.5);
  r2.xyzw = t4.Sample(s4_s, r1.xy).xyzw;
  r3.xyzw = t1.Sample(s2_s, r1.xy).xyzw;
  r2.xyz = float3(0,0,1) * r2.xyz;
  r0.yw = float2(0.125,0.375);
  r4.xyzw = t4.Sample(s4_s, r0.xy).xyzw;
  r2.xyz = r4.xyz * float3(1,0,0) + r2.xyz;
  r4.xyzw = t4.Sample(s4_s, r0.zw).xyzw;
  r2.xyz = r4.xyz * float3(0,1,0) + r2.xyz;
  r4.xyzw = t1.Sample(s2_s, r0.zw).xyzw;
  r0.xyzw = t1.Sample(s2_s, r0.xy).xyzw;
  r4.xyz = float3(0,1,0) * r4.xyz;
  r0.xyz = r0.xyz * float3(1,0,0) + r4.xyz;
  r0.xyz = r3.xyz * float3(0,0,1) + r0.xyz;
  r2.xyz = r2.xyz + -r0.xyz;
  r3.xyzw = t2.Sample(s1_s, w1.xy).xyzw;
  r0.w = cb1[7].x * r3.x + cb1[7].y;
  r1.z = 1 / r0.w;
  r1.xyzw = t3.Sample(s3_s, r1.zw).xyzw;
  r0.xyz = r1.xxx * r2.xyz + r0.xyz;
  r0.w = dot(r0.xyz, float3(0.0396819152,0.45802179,0.00609653955));
  r0.xyz = r0.xyz + -r0.www;
  o0.xyz = cb0[4].xxx * r0.xyz + r0.www;
    if (injectedData.toneMapType != 0.f) {
    r0.w = max(o0.x, o0.y);
    r0.w = max(r0.w, o0.z);
    r0.w = 1 + -r0.w;
    r0.w = renodx::math::DivideSafe(1, r0.w);
    o0.xyz = o0.xyz * r0.www;
  }
  if (injectedData.colorGradeUserLUTScaling > 0.f) {
    r0.xyz = float3(0, 0, 0);
  r1.x = r0.y;
  r1.yw = float2(0.625,0.5);
  r2.xyzw = t4.Sample(s4_s, r1.xy).xyzw;
  r3.xyzw = t1.Sample(s2_s, r1.xy).xyzw;
  r2.xyz = float3(0,0,1) * r2.xyz;
  r0.yw = float2(0.125,0.375);
  r4.xyzw = t4.Sample(s4_s, r0.xy).xyzw;
  r2.xyz = r4.xyz * float3(1,0,0) + r2.xyz;
  r4.xyzw = t4.Sample(s4_s, r0.zw).xyzw;
  r2.xyz = r4.xyz * float3(0,1,0) + r2.xyz;
  r4.xyzw = t1.Sample(s2_s, r0.zw).xyzw;
  r0.xyzw = t1.Sample(s2_s, r0.xy).xyzw;
  r4.xyz = float3(0,1,0) * r4.xyz;
  r0.xyz = r0.xyz * float3(1,0,0) + r4.xyz;
  r0.xyz = r3.xyz * float3(0,0,1) + r0.xyz;
  r2.xyz = r2.xyz + -r0.xyz;
  r3.xyzw = t2.Sample(s1_s, w1.xy).xyzw;
  r0.w = cb1[7].x * r3.x + cb1[7].y;
  r1.z = 1 / r0.w;
  r1.xyzw = t3.Sample(s3_s, r1.zw).xyzw;
  r0.xyz = r1.xxx * r2.xyz + r0.xyz;
  r0.w = dot(r0.xyz, float3(0.0396819152,0.45802179,0.00609653955));
  r0.xyz = r0.xyz + -r0.www;
  float3 minBlack = cb0[4].xxx * r0.xyz + r0.www;
    float lutMinY = renodx::color::y::from::BT709(abs(minBlack));
    if (lutMinY > 0) {
      float3 correctedBlack = renodx::lut::CorrectBlack(preCG, o0.rgb, lutMinY, 0.f);
      o0.rgb = lerp(o0.rgb, correctedBlack, injectedData.colorGradeUserLUTScaling);
    }
  }
  o0.xyz = lerp(preCG, o0.xyz, injectedData.colorGradeUserLUTStrength);
  return;
}