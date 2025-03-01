#include "./common.hlsl"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb5 : register(b5){
  float4 cb5[4];
}
cbuffer cb2 : register(b2){
  float4 cb2[36];
}

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb5[2].xyzw + v1.xyxy;
  r1.xyz = t0.Sample(s0_s, r0.xy).xyz;
  r0.xyz = t0.Sample(s0_s, r0.zw).xyz;
  r0.xyz = float3(9.99999972e-10,9.99999972e-10,9.99999972e-10) + r0.xyz;
  r0.xyz = log2(r0.xyz);
  r1.xyz = float3(9.99999972e-10,9.99999972e-10,9.99999972e-10) + r1.xyz;
  r1.xyz = log2(r1.xyz);
  r0.xyz = r1.xyz + r0.xyz;
  r1.xyzw = cb5[3].xyzw + v1.xyxy;
  r2.xyz = t0.Sample(s0_s, r1.xy).xyz;
  r1.xyz = t0.Sample(s0_s, r1.zw).xyz;
  r1.xyz = float3(9.99999972e-10,9.99999972e-10,9.99999972e-10) + r1.xyz;
  r1.xyz = log2(r1.xyz);
  r2.xyz = float3(9.99999972e-10,9.99999972e-10,9.99999972e-10) + r2.xyz;
  r2.xyz = log2(r2.xyz);
  r0.xyz = r2.xyz + r0.xyz;
  r0.xyz = r0.xyz + r1.xyz;
  r0.xyz = float3(0.25,0.25,0.25) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r0.xyz = float3(-9.99999972e-10,-9.99999972e-10,-9.99999972e-10) + r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.w = t1.SampleLevel(s1_s, float2(0,0), 0).x;
  if(cb5[1].x == -20.f && cb5[1].x == 20.f){
    r0.xyz = r0.xyz * r0.www;
  } else {
    r0.xyz = r0.xyz * lerp(1.f, r0.www, injectedData.fxAutoExposure);
  }
  r0.xyz = cb2[35].yyy * r0.xyz;
  r0.w = dot(r0.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r0.w = -cb5[1].x + r0.w;
  r1.x = cb5[1].y + -cb5[1].x;
  r1.x = 1 / r1.x;
  r0.w = saturate(r1.x * r0.w);
  r1.x = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r1.x * r0.w;
  r1.w = cb5[0].y * r0.w;
  r1.xyz = r1.www * r0.xyz;
  r0.xyzw = min(float4(65504,65504,65504,65504), r1.xyzw);
  r1.xy = v1.xy * float2(2,2) + float2(-1,-1);
  r1.xy = float2(1,1) + -abs(r1.xy);
  r1.xy = cb5[0].zw * r1.xy;
  r1.x = saturate(min(r1.x, r1.y));
  r1.x = sqrt(r1.x);
  o0.xyzw = r1.xxxx * r0.xyzw;
  return;
}