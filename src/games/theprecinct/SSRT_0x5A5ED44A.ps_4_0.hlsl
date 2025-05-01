#include "./common.hlsl"

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
  float4 cb0[28];
}

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t1.Sample(s1_s, v1.xy).xyzw;
  r0.x = cb1[7].z * r0.x + cb1[7].w;
  r0.x = 1 / r0.x;
  r0.yz = v1.xy * float2(2,2) + float2(-1,-1);
  r1.xyzw = cb0[21].xyzw * r0.zzzz;
  r1.xyzw = cb0[20].xyzw * r0.yyyy + r1.xyzw;
  r0.xyzw = cb0[22].xyzw * r0.xxxx + r1.xyzw;
  r0.xyzw = cb0[23].xyzw + r0.xyzw;
  r0.xyz = r0.xyz / r0.www;
  r1.xyzw = t2.SampleLevel(s0_s, v1.xy, 0).xyzw;
  r1.xy = v1.xy + -r1.xy;
  r2.xyzw = t3.SampleLevel(s4_s, r1.xy, 0).xyzw;
  r0.w = cb1[7].z * r2.x + cb1[7].w;
  r0.w = 1 / r0.w;
  r0.w = r0.w * 2 + -1;
  r1.zw = r1.xy * float2(2,2) + float2(-1,-1);
  r2.xyzw = t4.SampleLevel(s3_s, r1.xy, 0).xyzw;
  r3.xyzw = cb0[25].xyzw * r1.wwww;
  r1.xyzw = cb0[24].xyzw * r1.zzzz + r3.xyzw;
  r1.xyzw = cb0[26].xyzw * r0.wwww + r1.xyzw;
  r1.xyzw = cb0[27].xyzw + r1.xyzw;
  r1.xyz = r1.xyz / r1.www;
  r0.xyz = r1.xyz + -r0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.x = 1 + -r0.x;
  r0.x = max(0, r0.x);
  r0.y = -1 + cb0[6].y;
  r0.x = r0.x * r0.y + 1;
  r1.xyzw = float4(1,1,1,1) / cb1[6].xyxy;
  r3.xyzw = r1.zwzw * float4(0.5,0.5,0.5,-0.5) + v1.xyxy;
  r1.xyzw = r1.xyzw * float4(-0.5,0.5,-0.5,-0.5) + v1.xyxy;
  r4.xyzw = t0.SampleLevel(s2_s, r3.xy, 0).xyzw;
  r3.xyzw = t0.SampleLevel(s2_s, r3.zw, 0).xyzw;
  r5.xyzw = min(r4.xyzw, r3.xyzw);
  r3.xyzw = max(r4.xyzw, r3.xyzw);
  r4.xyzw = t0.SampleLevel(s2_s, r1.xy, 0).xyzw;
  r1.xyzw = t0.SampleLevel(s2_s, r1.zw, 0).xyzw;
  r5.xyzw = min(r5.xyzw, r4.xyzw);
  r3.xyzw = max(r4.xyzw, r3.xyzw);
  r3.xyzw = max(r3.xyzw, r1.xyzw);
  r1.xyzw = min(r5.xyzw, r1.xyzw);
  r1.xyzw = max(r2.xyzw, r1.xyzw);
  r1.xyzw = min(r1.xyzw, r3.xyzw);
  r1.xyzw = r1.xyzw + -r2.xyzw;
  r1.xyzw = r1.xyzw * float4(0.25,0.25,0.25,0.25) + r2.xyzw;
  r2.xyzw = t0.Sample(s2_s, v1.xy).xyzw;
  r2.xyzw = r2.xyzw + -r1.xyzw;
  o0.xyzw = r0.xxxx * r2.xyzw + r1.xyzw;
  // dirty fix for artifacts
  // possibly unsafe maths in previous SSRT pass
  // complicated shader, broken decompilation, so fixing here instead
  o0.rgb = renodx::color::bt709::clamp::BT2020(o0.rgb);
  o0.w = max(0, o0.w);
  return;
}