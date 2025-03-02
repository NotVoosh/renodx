#include "./common.hlsl"

SamplerState s_PointClamp_s : register(s10);
Texture2D<float4> t_g_PointInput : register(t1);

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t_g_PointInput.SampleLevel(s_PointClamp_s, v1.xy, 0, int2(-1, 0)).xyz;
  r1.xyz = t_g_PointInput.SampleLevel(s_PointClamp_s, v1.xy, 0, int2(0, -1)).xyz;
  r0.xyz = r1.xyz + r0.xyz;
  r1.xyz = t_g_PointInput.SampleLevel(s_PointClamp_s, v1.xy, 0, int2(1, 0)).xyz;
  r0.xyz = r1.xyz + r0.xyz;
  r1.xyz = t_g_PointInput.SampleLevel(s_PointClamp_s, v1.xy, 0, int2(0, 1)).xyz;
  r0.xyz = r1.xyz + r0.xyz;
  r0.xyz = float3(0.25,0.25,0.25) * r0.xyz;
  //r0.xyz = sqrt(r0.xyz);
  r0.rgb = renodx::math::SignSqrt(r0.rgb);
  r1.xyzw = t_g_PointInput.SampleLevel(s_PointClamp_s, v1.xy, 0).xyzw;
  //r2.xyz = sqrt(r1.xyz);
  r2.rgb = renodx::math::SignSqrt(r1.rgb);
  o1.xyzw = r1.xyzw;
  r0.xyz = r2.xyz + -r0.xyz;
  r0.xyz = r0.xyz * float3(0.25,0.25,0.25) + r2.xyz;
  //o0.xyz = r0.xyz * r0.xyz;
  o0.rgb = renodx::math::SignPow(r0.rgb, 2.f);
  o0.w = 1;
  return;
}