// ---- Created with 3Dmigoto v1.3.16 on Fri Sep 20 04:25:58 2024
Texture2DArray<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[49];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[46].zw * v0.xy;
  r0.xy = cb1[48].xy * r0.xy;
  r0.z = 0;
  r0.xyzw = t0.SampleLevel(s0_s, r0.xyz, 0).xyzw;
  //r0.xyzw = log2(r0.xyzw);
  r1.x = 1 / cb0[0].w;							    	// cb0 from 0.75 to 1.25
  //r0.xyzw = r1.xxxx * r0.xyzw;						// game brightness
  //o0.xyzw = exp2(r0.xyzw);
    o0.xyzw = r0.xyzw;
  return;
}