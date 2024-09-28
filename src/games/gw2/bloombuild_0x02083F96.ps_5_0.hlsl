#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:12:16 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float2 w0 : TEXCOORD1,
  float2 v1 : TEXCOORD2,
  float2 w1 : TEXCOORD3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w0.xy).xyzw;		
  r0.xyzw = float4(0.25,0.25,0.25,0.25) * r0.xyzw;
  r1.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.xyzw = r1.xyzw * float4(0.25,0.25,0.25,0.25) + r0.xyzw;
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r0.xyzw = r1.xyzw * float4(0.25,0.25,0.25,0.25) + r0.xyzw;
  r1.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  r0.xyzw = r1.xyzw * float4(0.25,0.25,0.25,0.25) + r0.xyzw;
  r1.x = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  //o0.xyz = saturate(r0.xyz * r1.xxx + -cb0[0].xyz);
	o0.xyz = r0.xyz * max(0, r1.xxx) + -cb0[0].xyz;
  //o0.w = saturate(r0.w);
	o0.w = r0.w;
  return;
}