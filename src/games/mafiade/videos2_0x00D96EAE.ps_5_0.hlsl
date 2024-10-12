// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 17 17:55:29 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : VDATA0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v1.xy).xyz;
  r0.w = dot(r0.xyz, float3(1,1,1));
  //o0.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r0.xyz);
    o0.rgb = r0.rgb;
  r0.x = cmp(9.99999975e-06 < r0.w);
  o0.w = r0.x ? 1.000000 : 0;
  return;
}