Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb5 : register(b5){
  float4 cb5[1];
}

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.xy * float2(1,-1) + float2(0,1);
  r0.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  o0.xyzw = cb5[0].xxxx * r0.xyzw;
  o0 = saturate(o0);
  return;
}