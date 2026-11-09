Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[138];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1 / cb0[137].x;
  r1.xyzw = t0.SampleLevel(s0_s, v1.xy, cb0[133].x).xyzw;
  r0.yzw = cb0[136].zzz * r1.xyz;
  o0.w = r1.w;
  r0.xyz = sign(r0.yzw) * pow(abs(r0.yzw), r0.x);
  r0.xyz = float3(-0.217637643,-0.217637643,-0.217637643) + r0.xyz;
  o0.xyz = r0.xyz * cb0[136].www + float3(0.217637643,0.217637643,0.217637643);
  return;
}