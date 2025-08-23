#include "../common.hlsl"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[32];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  r1.xyzw = r0.xyzw * float4(-2,-2,-2,-2) + float4(1,1,1,1);
  r0.xyzw = cb0[31].xxxx * r1.xyzw + r0.xyzw;
  //r1.xyz = saturate(r0.zxy);
  //r1.xyz = renodx::color::srgb::EncodeSafe(r1.xyz);
  /*r1.yzw = cb0[29].zzz * r1.xyz;
  r2.xy = float2(0.5,0.5) * cb0[29].xy;
  r2.yz = r1.zw * cb0[29].xy + r2.xy;
  r1.y = floor(r1.y);
  r2.x = r1.y * cb0[29].y + r2.y;
  r1.x = r1.x * cb0[29].z + -r1.y;
  r3.x = cb0[29].y;
  r3.y = 0;
  r1.yz = r3.xy + r2.xz;
  r2.xyzw = t1.Sample(s1_s, r2.xz).xyzw;
  r3.xyzw = t1.Sample(s1_s, r1.yz).xyzw;
  r1.yzw = r3.xyz + -r2.xyz;
  r1.xyz = r1.xxx * r1.yzw + r2.xyz;*/
  r1.xyz = handleUserLUT(r0.xyz, t1, s1_s, cb0[29].xyz);
  r1.xyz = renodx::color::srgb::DecodeSafe(r1.xyz);
  r1.xyz = r1.xyz + -r0.xyz;
  o0.xyz = cb0[29].www * r1.xyz + r0.xyz;
  o0.w = r0.w;
  return;
}