#include "./common.hlsl"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t1.Sample(s1_s, v1.xy).xyzw;
  r0.xy = float2(0.390625,1.984375) * r0.ww;
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r0.x = r1.w * 1.15625 + -r0.x;
  r0.y = r1.w * 1.15625 + r0.y;
  r1.z = -1.06861997 + r0.y;
  r2.xyzw = t2.Sample(s2_s, v1.xy).xyzw;
  r0.x = -r2.w * 0.8125 + r0.x;
  r0.y = 1.59375 * r2.w;
  r0.y = r1.w * 1.15625 + r0.y;
  r1.xy = float2(-0.872539997,0.531369984) + r0.yx;
  o0.xyz = renodx::color::srgb::DecodeSafe(r1.xyz);
  o0.w = 1;
  if(injectedData.toneMapType == 0.f){
    o0.xyz = saturate(o0.xyz);
  } else {
    o0.xyz = max(0.f, o0.xyz);
  }
  return;
}