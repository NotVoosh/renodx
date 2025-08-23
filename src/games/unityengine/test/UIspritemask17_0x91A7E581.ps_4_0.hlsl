Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[10];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0,-0.5) + v0.xy;
  r1.xw = float2(24,19);
  r1.yz = cb0[8].ww;
  r0.zw = r1.xy * r0.xy;
  r0.zw = r0.zw * r1.zw;
  r0.zw = floor(r0.zw);
  r0.zw = float2(4,4) * r0.zw;
  r1.xy = cmp(cb1[0].xy >= -cb1[0].xy);
  r1.xy = r1.xy ? float2(1,1) : float2(-1,-1);
  r1.zw = cb1[0].xy * r1.xy;
  r1.zw = frac(r1.zw);
  r1.xy = r1.xy * r1.zw;
  r1.xy = r1.xy * float2(12,12) + float2(50,50);
  r1.xy = floor(r1.xy);
  r0.zw = r1.xy * r0.zw;
  r0.z = dot(r0.zw, float2(127.099998,311.700012));
  r0.z = sin(r0.z);
  r0.z = 43758.5469 * r0.z;
  r0.z = frac(r0.z);
  r0.z = cb2[0].x + r0.z;
  r0.w = cmp(r0.z >= -r0.z);
  r0.w = r0.w ? 1 : -1;
  r0.z = r0.z * r0.w;
  r0.z = frac(r0.z);
  r0.z = r0.w * r0.z;
  r0.w = r0.z * r0.z;
  r0.z = r0.z * r0.w;
  r0.z = cb0[8].z * r0.z;
  r2.xw = float2(38,14);
  r2.yz = cb0[8].ww;
  r0.xy = r2.xy * r0.xy;
  r0.xy = r0.xy * r2.zw;
  r0.xy = floor(r0.xy);
  r0.xy = float2(4,4) * r0.xy;
  r0.xy = r0.xy * r1.xy;
  r1.xy = float2(2,1) * r1.xy;
  r0.w = dot(r1.xy, float2(127.099998,311.700012));
  r0.w = sin(r0.w);
  r0.w = 43758.5469 * r0.w;
  r0.w = frac(r0.w);
  r0.x = dot(r0.xy, float2(127.099998,311.700012));
  r0.x = sin(r0.x);
  r0.x = 43758.5469 * r0.x;
  r0.x = frac(r0.x);
  r0.xw = cb2[0].xx + r0.xw;
  r0.y = cmp(r0.x >= -r0.x);
  r0.y = r0.y ? 1 : -1;
  r0.x = r0.x * r0.y;
  r0.x = frac(r0.x);
  r0.x = r0.y * r0.x;
  r0.y = r0.x * r0.x;
  r0.x = r0.x * r0.y;
  r0.x = r0.z * r0.x;
  r0.x = 0.0199999996 * r0.x;
  r0.y = cmp(r0.w >= -r0.w);
  r0.y = r0.y ? 1 : -1;
  r0.z = r0.w * r0.y;
  r0.z = frac(r0.z);
  r0.y = r0.y * r0.z;
  r0.x = r0.x * r0.y;
  r1.xy = cb0[5].yy * v0.xy;
  r1.xy = floor(r1.xy);
  r1.xy = r1.xy / cb0[5].yy;
  r0.yw = float2(0,0);
  r0.xy = r1.xy + r0.xy;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r2.yw = v2.yw * r2.yw;
  r0.z = 0.100000001 * cb0[8].x;
  r0.xy = r1.xy + r0.zw;
  r0.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xy = v2.xw * r0.xw;
  r3.x = -0.100000001 * cb0[8].x;
  r3.y = 0;
  r0.zw = r3.xy + r1.xy;
  r1.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  r0.zw = v2.zw * r1.zw;
  r1.x = max(r0.y, r0.w);
  r2.xz = r0.xz * r0.yw;
  r0.x = cb0[8].y * r1.x;
  r2.w = max(r0.x, r2.w);
  r0.xy = cb2[0].xx + cb1[0].xw;
  r0.z = cmp(r0.x >= -r0.x);
  r0.z = r0.z ? 1 : -1;
  r0.x = r0.x * r0.z;
  r0.y = r0.y * cb0[9].x + 0.0500000007;
  r0.xy = frac(r0.xy);
  r0.x = r0.z * r0.x;
  r0.x = r0.x * cb0[6].y + v0.y;
  r0.z = cb0[6].x + cb0[5].z;
  r0.w = r0.x * r0.z;
  r0.w = cmp(r0.w >= -r0.w);
  r0.w = r0.w ? r0.z : -r0.z;
  r1.x = 1 / r0.w;
  r0.x = r1.x * r0.x;
  r0.x = frac(r0.x);
  r0.x = r0.w * r0.x;
  r0.x = r0.x / r0.z;
  r0.z = cb0[6].x / r0.z;
  r0.w = r0.z + -abs(r0.x);
  r0.x = abs(r0.x) + -r0.z;
  r0.z = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.z = (int)-r0.z + (int)r0.w;
  r0.z = (int)r0.z;
  r0.z = max(0, r0.z);
  r0.w = cmp(r0.z >= 0.00999999978);
  r1.xyz = r0.www ? float3(0,0,0) : cb0[7].xyz;
  r1.xyz = r1.xyz * r2.www;
  r0.w = cmp(0 < r0.x);
  r1.w = cmp(r0.x < 0);
  r0.x = saturate(r0.x);
  r0.w = (int)-r0.w + (int)r1.w;
  r0.w = (int)r0.w;
  r0.w = max(0, r0.w);
  r0.w = cb0[6].z * r0.w;
  r0.w = max(1, r0.w);
  r1.xyz = r2.xyz * r0.www + r1.xyz;
  r0.w = saturate(cb0[6].z);
  r0.w = -cb0[5].w + r0.w;
  r0.x = r0.x * r0.w + cb0[5].w;
  r0.w = 1 + -r0.x;
  r0.x = r0.z * r0.w + r0.x;
  r1.w = r2.w * r0.x;
  r1.xyzw = r1.xyzw + -r2.xyzw;
  r1.xyzw = cb0[6].wwww * r1.xyzw + r2.xyzw;
  r0.x = 1 + -cb0[9].y;
  r0.x = cmp(r0.x >= r0.y);
  r0.x = r0.x ? 1.000000 : 0;
  r0.x = saturate(r1.w * r0.x + cb0[9].z);
  r0.x = r1.w * r0.x;
  r1.w = cb0[5].x * r0.x;
  o0.xyzw = cb0[4].xyzw * r1.xyzw;
      o0 = saturate(o0);
  return;
}