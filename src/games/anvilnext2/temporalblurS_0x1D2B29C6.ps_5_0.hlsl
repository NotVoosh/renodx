Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb5 : register(b5){
  float4 cb5[1];
}

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t1.SampleLevel(s1_s, v1.xy, 0).xyz;
  r1.xyz = t0.SampleLevel(s0_s, v1.xy, 0).xyz;
  o0.rgb = lerp(r1.rgb, r0.rgb, cb5[0].x);
  o0.w = 1;
  return;
}