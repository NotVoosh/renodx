Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[7];
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
  r1.xy = cb0[6].xy * cb0[2].xy + -v0.xy;
  r1.zw = cmp(r1.xy >= -r1.xy);
  r1.zw = r1.zw ? float2(1,1) : float2(-1,-1);
  r1.xy = r1.xy * r1.zw;
  r1.xy = frac(r1.xy);
  r1.yz = r1.zw * r1.xy;
  r1.w = cb1[6].x / cb1[6].y;
  r1.x = r1.y * r1.w;
  r1.y = dot(r1.xz, r1.xz);
  r1.y = sqrt(r1.y);
  r2.xy = cb2[0].xx + cb1[0].yw;
  r1.w = cb0[5].z * r2.x;
  r2.x = r2.y * cb0[12].x + 0.0500000007;
  r2.x = frac(r2.x);
  r1.y = r1.y * cb0[5].y + -r1.w;
  r1.y = sin(r1.y);
  r1.xy = r1.xz * r1.yy;
  r1.z = 0.00100000005 * cb0[5].w;
  r1.xy = r1.xy * r1.zz + v0.xy;
  r0.yw = float2(0,0);
  r0.xy = r1.xy + r0.xy;
  r3.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xy = v2.yw * r3.yw;
  r3.y = log2(r0.x);
  r4.x = -0.100000001 * cb0[11].x;
  r4.y = 0;
  r1.zw = r4.xy + r1.xy;
  r4.xyzw = t0.Sample(s0_s, r1.zw).xyzw;
  r1.zw = v2.zw * r4.zw;
  r0.x = r1.z * r1.w;
  r3.z = log2(r0.x);
  r0.z = 0.100000001 * cb0[11].x;
  r0.xz = r1.xy + r0.zw;
  r4.xyzw = t0.Sample(s0_s, r0.xz).xyzw;
  r0.xz = v2.xw * r4.xw;
  r0.x = r0.x * r0.z;
  r0.z = max(r0.z, r1.w);
  r0.z = cb0[11].y * r0.z;
  r0.y = max(r0.z, r0.y);
  r3.x = log2(r0.x);
  r0.xzw = cb0[8].www * r3.xyz;
  r0.xzw = exp2(r0.xzw);
  r0.xzw = cb0[8].zzz * r0.xzw;
  r0.xzw = floor(r0.xzw);
  r0.xzw = r0.xzw / cb0[8].zzz;
  r0.xzw = log2(r0.xzw);
  r1.z = 1 / cb0[8].w;
  r0.xzw = r1.zzz * r0.xzw;
  r0.xzw = exp2(r0.xzw);
  r3.x = cb0[12].w + r1.x;
  r3.y = cb0[13].x + r1.y;
  r1.xyzw = t0.Sample(s0_s, r3.xy).xyzw;
  r1.x = r1.w + -r0.y;
  r1.y = 1 + -r0.y;
  r1.x = -r1.x * r1.y + 1;
  r2.yzw = cb0[14].xyz * r1.www;
  r1.z = cb0[13].y * r1.w;
  r1.z = v2.w * r1.z;
  r0.y = max(r1.z, r0.y);
  r1.yzw = r2.yzw * r1.yyy;
  r0.xzw = r0.xzw * r1.xxx + r1.yzw;
  r1.x = r0.y * r0.y;
  r1.x = cb0[8].x * r1.x;
  r1.xyz = cb0[7].xyz * r1.xxx;
  r1.xyz = r1.xyz * r0.xzw;
  r0.xzw = r0.xzw * cb0[8].yyy + r1.xyz;
  r1.xyz = cb0[10].xyz * cb0[9].xxx + -r0.xzw;
  r1.w = 1 + -cb0[12].y;
  r1.w = cmp(r1.w >= r2.x);
  r1.w = r1.w ? 1.000000 : 0;
  r1.w = saturate(r0.y * r1.w + cb0[12].z);
  r0.y = r1.w * r0.y;
  r1.w = -r0.y * cb0[5].x + 1;
  r0.y = cb0[5].x * r0.y;
  r2.x = log2(r1.w);
  r2.y = max(9.99999975e-05, cb0[9].y);
  r2.x = r2.y * r2.x;
  r2.x = exp2(r2.x);
  r2.y = cmp(r0.y >= cb0[9].z);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r2.x = cb0[9].w * r2.x;
  r3.xyz = r2.xxx * r1.xyz + r0.xzw;
  r0.x = cmp(1 < r2.x);
  r0.x = r0.x ? 1.000000 : 0;
  r3.w = r0.x * r1.w + r0.y;
  o0.xyzw = cb0[4].xyzw * r3.xyzw;
    o0 = saturate(o0);
  return;
}