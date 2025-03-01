// ---- Created with 3Dmigoto v1.4.1 on Fri Feb 28 11:40:07 2025
Texture2D<float4> t17 : register(t17);

cbuffer cb3 : register(b3)
{
  float4 cb3[11];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[36];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  uint v5 : InstanceID0,
  uint v6 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 1 + -cb3[0].z;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  r0.x = t17.Load(float4(0,0,0,0)).x;
  r0.x = 1 / r0.x;
  r0.yzw = cb3[10].xyz * cb3[9].xxx;
  r0.xyz = r0.yzw * r0.xxx;
  o0.xyz = cb2[35].xxx * r0.xyz;
  o0.w = 1;
  o0.rgb = saturate(o0.rgb);
  return;
}