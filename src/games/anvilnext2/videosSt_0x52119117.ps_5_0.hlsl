#include "./common.hlsl"

Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s6_s : register(s6);
cbuffer cb5 : register(b5){
  float4 cb5[1];
}

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.y = t1.SampleLevel(s6_s, v1.xy, 0).x;
  r0.z = t2.SampleLevel(s6_s, v1.xy, 0).x;
  r0.x = t0.SampleLevel(s6_s, v1.xy, 0).x;
  r0.w = 1;
  r1.y = dot(float4(1.16412354,-0.813476562,-0.391448975,0.529705048), r0.xyzw);
  r1.x = dot(float3(1.16412354,1.59579468,-0.87065506), r0.xyw);
  r1.z = dot(float3(1.16412354,2.01782227,-1.08166885), r0.xzw);
  r1.rgb = saturate(r1.rgb);
  r1.rgb = InverseToneMap(r1.rgb);
  r1.rgb = PostToneMapScale(r1.rgb);
  r0.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r1.xyz);
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(2.20000005,2.20000005,2.20000005) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r2.x = dot(float3(0.627403975,0.329281986,0.0433136001), r0.xyz);
  r2.y = dot(float3(0.0690969974,0.919539988,0.0113612004), r0.xyz);
  r2.z = dot(float3(0.0163915996,0.088013202,0.895595014), r0.xyz);
  r0.xyz = float3(0.100000001,0.100000001,0.100000001) * r2.xyz;
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(0.159301758,0.159301758,0.159301758) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r2.xyz = r0.xyz * float3(18.8515625,18.8515625,18.8515625) + float3(0.8359375,0.8359375,0.8359375);
  r0.xyz = r0.xyz * float3(18.6875,18.6875,18.6875) + float3(1,1,1);
  r0.xyz = r2.xyz / r0.xyz;
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(78.84375,78.84375,78.84375) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r0.xyz = cb5[0].yyy ? r0.xyz : r1.xyz;
  r1.x = t3.SampleLevel(s6_s, v1.xy, 0).x;
  r0.w = cb5[0].x * r1.x;
  r0.xyzw = float4(-0,-0,-0,-1) + r0.xyzw;
  r1.xyzw = cmp(float4(0,1,0,1) >= v1.xxyy);
  r1.xyzw = r1.xyzw ? float4(1,1,1,1) : 0;
  r1.xy = cmp(r1.yw != r1.xz);
  r1.x = r1.y ? r1.x : 0;
  r1.x = r1.x ? 1.000000 : 0;
  o0.xyzw = r1.xxxx * r0.xyzw + float4(0,0,0,1);
  return;
}