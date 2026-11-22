#include "../shared.h"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[3];
}
cbuffer cb0 : register(b0){
  float4 cb0[132];
}

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.SampleBias(s0_s, v1.xy, cb0[5].x).xyzw;
  r1.xyzw = t1.SampleBias(s1_s, v1.xy, cb0[5].x).xyzw;
  r0.xyzw = r1.xxxx * cb1[2].xyzw + r0.xyzw;
  r1.xyzw = v2.xyzw * r0.xyzw;
  if (r1.w == 0.0) discard;
  r2.xy = v3.xy / v3.ww;
  r2.xyzw = t2.SampleBias(s2_s, r2.xy, cb0[5].x).xyzw;
  r0.w = dot(cb0[129].xyzw, cb0[129].xyzw);
  r3.xyzw = float4(1,1,1,1) + -cb0[130].xyzw;
  r2.w = dot(r3.xyzw, cb0[129].xyzw);
  r3.xyz = r2.xyz * r2.www;
  r2.xyz = r0.w != 0.0 ? r3.xyz : r2.xyz;
  r3.xyz = cb0[128].xxx * r2.xyz;
  r2.xyz = cb0[128].yyy * r2.xyz;
  r4.xyz = cb0[131].xxx * r1.xyz;
  r2.xyz = r4.xyz * r3.xyz + r2.xyz;
  r0.xyz = -r0.xyz * v2.xyz + r2.xyz;
  r0.w = 0;
  r0.xyzw = cb0[131].yyyy * r0.xyzw + r1.xyzw;
  o0.xyzw = max(float4(0,0,0,0), r0.xyzw);
  if(CUSTOM_IS_CLAMPED > 1.f){
    o0 = saturate(o0);
  }
  return;
}