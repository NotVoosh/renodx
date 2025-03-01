#include "./common.hlsl"

Texture2D<float4> t7 : register(t7);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s10_s : register(s10);
cbuffer cb5 : register(b5){
  float4 cb5[12];
}
cbuffer cb2 : register(b2){
  float4 cb2[39];
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

  r0.xy = (uint2)v0.xy;
  r0.zw = float2(0,0);
  r1.xyz = t0.Load(r0.xyw).xyz;
  r0.xyz = t2.Load(r0.xyz).xyz;
  r0.w = (int)r1.x & 0x7f800000;
  r0.w = cmp((int)r0.w == 0x7f800000);
  r1.xyz = r0.www ? float3(65000,65000,65000) : r1.xyz;
  r0.w = t1.Sample(s10_s, float2(0,0)).x;
  r1.xyz = r1.xyz * lerp(1.f, r0.www, injectedData.fxAutoExposure);
  r0.xyz = r1.xyz * cb2[38].yyy + r0.xyz * injectedData.fxBloom;
  r1.xy = float2(-0.5,-0.5) + v1.xy;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = log2(r0.w);
  r0.w = cb5[1].x * r0.w * injectedData.fxVignette;
  r0.w = exp2(r0.w);
  r0.xyz = r0.xyz * r0.www;
  float3 untonemapped = r0.rgb;
  if(injectedData.toneMapType == 0.f){
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.xyz = float3(-0.00400000019,-0.00400000019,-0.00400000019) + r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r1.xyz = r0.xyz * float3(3.20000005,3.20000005,3.20000005) + float3(0.5,0.5,0.5);
  r2.xyz = r1.xyz * r0.xyz;
  r0.xyz = r0.xyz * r1.xyz + float3(1.05999994,1.05999994,1.05999994);
  r0.xyz = r2.xyz / r0.xyz;
  r0.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r0.xyz);
  r0.xyz = log2(r0.xyz);
  r0.w = 1 / cb5[11].w; // 2.2
  r0.xyz = r0.www * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  //r0.xyz = cb5[11].yyy + r0.xyz;  // brightness setting
  r0.rgb = -0.08571427f + r0.rgb;
  r0.xyz = float3(-0.5,-0.5,-0.5) + r0.xyz;
  //o0.xyz = saturate(r0.xyz * cb5[11].zzz + float3(0.5,0.5,0.5));  // contrast setting
  o0.rgb = saturate(r0.rgb * 0.88f + float3(0.5,0.5,0.5));
  } else {
  o0.rgb = renodx::color::gamma::EncodeSafe(untonemapped, 2.2f);
  }
  r0.x = t7.Sample(s10_s, v1.xy).x;
  o0.w = r0.x;
  return;
}