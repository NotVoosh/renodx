#include "../common.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  /*r1.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  r1.xyz = float3(0.947867334,0.947867334,0.947867334) * r1.xyz;
  r1.xyz = log2(r1.xyz);
  r1.xyz = float3(2.4000001,2.4000001,2.4000001) * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r1.xyz = -r0.xyz * float3(0.0773993805,0.0773993805,0.0773993805) + r1.xyz;
  r2.xyz = cmp(r0.xyz >= float3(0.0404499993,0.0404499993,0.0404499993));
  r2.xyz = r2.xyz ? float3(1,1,1) : 0;
  r0.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  o0.xyz = r2.xyz * r1.xyz + r0.xyz;*/
  r0.xyz = renodx::color::srgb::DecodeSafe(r0.xyz);
  o0.xyz = r0.xyz;
  o0.w = saturate(r0.w);
  return;
}