Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

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
  float4 cb0[15];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0,-0.5) + v0.xy;
  r1.xw = float2(24,19);
  r1.yz = cb0[11].ww;
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
  r0.z = cb0[11].z * r0.z;
  r2.xw = float2(38,14);
  r2.yz = cb0[11].ww;
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
  r1.xy = cb2[0].xx + cb1[0].xw;
  r1.z = cb0[5].y * r1.x;
  r1.z = 50 * r1.z;
  sincos(r1.z, r2.x, r3.x);
  r1.z = cb0[5].z * r2.x;
  r1.w = cb0[5].w * r3.x;
  r2.xy = float2(0.0120000001,0.00999999978) * r1.zw;
  r1.zw = v0.xy + r2.xy;
  r0.yw = float2(0,0);
  r0.xy = r1.zw + r0.xy;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xy = v2.yw * r2.yw;
  r2.y = log2(r0.x);
  r3.x = -0.100000001 * cb0[11].x;
  r3.y = 0;
  r3.xy = r3.xy + r1.zw;
  r3.xyzw = t0.Sample(s0_s, r3.xy).xyzw;
  r3.xy = v2.zw * r3.zw;
  r0.x = r3.x * r3.y;
  r2.z = log2(r0.x);
  r0.z = 0.100000001 * cb0[11].x;
  r0.xz = r1.zw + r0.zw;
  r4.xyzw = t0.Sample(s0_s, r0.xz).xyzw;
  r0.xz = v2.xw * r4.xw;
  r0.x = r0.x * r0.z;
  r0.z = max(r0.z, r3.y);
  r0.z = cb0[11].y * r0.z;
  r0.y = max(r0.z, r0.y);
  r2.x = log2(r0.x);
  r0.xzw = cb0[7].www * r2.xyz;
  r0.xzw = exp2(r0.xzw);
  r0.xzw = cb0[7].zzz * r0.xzw;
  r0.xzw = floor(r0.xzw);
  r0.xzw = r0.xzw / cb0[7].zzz;
  r0.xzw = log2(r0.xzw);
  r2.x = 1 / cb0[7].w;
  r0.xzw = r2.xxx * r0.xzw;
  r0.xzw = exp2(r0.xzw);
  r2.x = cb0[12].w + r1.z;
  r2.y = cb0[13].x + r1.w;
  r3.xyzw = t1.Sample(s1_s, r1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r2.xy).xyzw;
  r1.z = r2.w + -r0.y;
  r1.w = 1 + -r0.y;
  r1.z = -r1.z * r1.w + 1;
  r2.xyz = cb0[14].xyz * r2.www;
  r2.w = cb0[13].y * r2.w;
  r2.w = v2.w * r2.w;
  r4.w = max(r2.w, r0.y);
  r2.xyz = r2.xyz * r1.www;
  r0.xyz = r0.xzw * r1.zzz + r2.xyz;
  r0.w = r4.w * r3.w;
  r0.w = cb0[7].x * r0.w;
  r2.xyz = cb0[6].xyz * r0.www;
  r2.xyz = r3.xyz * r2.xyz;
  r4.xyz = r0.xyz * cb0[7].yyy + r2.xyz;
  r0.x = cmp(r1.x >= -r1.x);
  r0.x = r0.x ? 1 : -1;
  r0.y = r1.x * r0.x;
  r0.z = r1.y * cb0[12].x + 0.0500000007;
  r0.yz = frac(r0.yz);
  r0.x = r0.x * r0.y;
  r0.x = r0.x * cb0[8].w + v0.y;
  r0.y = cb0[8].x + cb0[8].z;
  r0.w = r0.x * r0.y;
  r0.w = cmp(r0.w >= -r0.w);
  r0.w = r0.w ? r0.y : -r0.y;
  r1.x = 1 / r0.w;
  r0.x = r1.x * r0.x;
  r0.x = frac(r0.x);
  r0.x = r0.w * r0.x;
  r0.x = r0.x / r0.y;
  r0.y = cb0[8].z / r0.y;
  r0.w = r0.y + -abs(r0.x);
  r0.x = abs(r0.x) + -r0.y;
  r0.y = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.y = (int)-r0.y + (int)r0.w;
  r0.y = (int)r0.y;
  r0.y = max(0, r0.y);
  r0.w = cmp(r0.y >= 0.00999999978);
  r1.xyz = r0.www ? float3(0,0,0) : cb0[10].xyz;
  r1.xyz = r1.xyz * r4.www;
  r0.w = cmp(0 < r0.x);
  r1.w = cmp(r0.x < 0);
  r0.x = saturate(r0.x);
  r0.w = (int)-r0.w + (int)r1.w;
  r0.w = (int)r0.w;
  r0.w = max(0, r0.w);
  r0.w = cb0[9].x * r0.w;
  r0.w = max(1, r0.w);
  r1.xyz = r4.xyz * r0.www + r1.xyz;
  r0.w = saturate(cb0[9].x);
  r0.w = -cb0[8].y + r0.w;
  r0.x = r0.x * r0.w + cb0[8].y;
  r0.w = 1 + -r0.x;
  r0.x = r0.y * r0.w + r0.x;
  r1.w = r4.w * r0.x;
  r1.xyzw = r1.xyzw + -r4.xyzw;
  r1.xyzw = cb0[9].yyyy * r1.xyzw + r4.xyzw;
  r0.x = 1 + -cb0[12].y;
  r0.x = cmp(r0.x >= r0.z);
  r0.x = r0.x ? 1.000000 : 0;
  r0.x = saturate(r1.w * r0.x + cb0[12].z);
  r0.x = r1.w * r0.x;
  r1.w = cb0[5].x * r0.x;
  o0.xyzw = cb0[4].xyzw * r1.xyzw;
      o0 = saturate(o0);
  return;
}