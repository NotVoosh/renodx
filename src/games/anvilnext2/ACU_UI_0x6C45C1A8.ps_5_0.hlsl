Texture2D<float4> t32 : register(t32);
Texture2D<float4> t17 : register(t17);
SamplerState s12_s : register(s12);
cbuffer cb3 : register(b3){
  float4 cb3[4];
}
cbuffer cb2 : register(b2){
  float4 cb2[36];
}

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  uint v6 : InstanceID0,
  uint v7 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t32.Sample(s12_s, v1.xy).xyzw;
  r1.x = r0.w * cb3[1].x + -cb3[0].z;
  r1.x = cmp(r1.x < 0);
  if (r1.x != 0) discard;
  r0.xyz = cb3[2].xxx * r0.xyz;
  r0.w = cb3[1].x * r0.w;
  o0.w = r0.w;
  r0.xyz = cb3[3].xyz * r0.xyz;
  r0.w = t17.Load(int3(0,0,0)).x;
  r0.xyz = r0.xyz / r0.www;
  o0.xyz = cb2[35].xxx * r0.xyz;
  return;
}