// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:13:03 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

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
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float3 v3 : TEXCOORD3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t0.Sample(s0_s, v0.xy).w;
  r0.y = saturate(r0.x + r0.x);
  r0.x = -0.5 + r0.x;
  r0.x = saturate(r0.x + r0.x);
  r0.x = cb0[3].w * r0.x;
  o0.w = cb0[0].z * r0.x;
  
	o0.w = saturate(o0.w);
  r0.x = -0.5 + r0.y;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  if (r0.x != 0) discard;
  r0.xy = t1.Sample(s1_s, v0.xy).xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.w = dot(r0.xy, r0.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.z = sqrt(r0.w);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r1.xyz = v1.xyz * r0.yyy;
  r0.xyw = r0.xxx * v2.xyz + r1.xyz;
  r0.xyz = r0.zzz * v3.xyz + r0.xyw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = sqrt(r0.w);
  r1.xy = cmp(float2(9.99999991e-38,0) < r0.ww);
  r1.y = (int)-r1.y;
  r1.z = cmp(r1.y != 0.000000);
  r1.y = 9.99999991e-38 * r1.y;
  r1.y = r1.z ? r1.y : 9.99999991e-38;
  r0.w = r1.x ? r0.w : r1.y;
  r0.xyz = r0.xyz / r0.www;
  o0.xyz = r0.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  return;
}