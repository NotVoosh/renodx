// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:13:33 2024
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float2 v1 : TEXCOORD1,
  out float4 o0 : SV_TARGET0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t2.Sample(s2_s, v0.zw).x;
  r0.x = r0.x * 0.800000012 + cb0[3].x;
  r0.x = -0.800000012 + r0.x;
  r0.x = saturate(5.00000048 * r0.x);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.y * r0.x;
  r0.y = t1.Sample(s1_s, v1.xy).x;
  r0.x = r0.x * r0.y;
  r0.y = cb0[0].w * r0.x + -cb0[1].x;
  r0.x = cb0[0].w * r0.x;
  o0.w = r0.x;
  r0.x = cmp(r0.y < 0);
  if (r0.x != 0) discard;
  r0.xyz = t0.Sample(s0_s, v0.xy).xyz;
  r0.xyz = cb0[0].xyz * r0.xyz;
  o0.xyz = r0.xyz + r0.xyz;
	
	o0.rgb = saturate(o0.rgb);
  return;
}