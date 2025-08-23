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
  float2 w0 : TEXCOORD3,
  float4 v1 : SV_POSITION0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0,-0.5) + v0.xy;
  r1.xw = float2(24,19);
  r1.yz = cb0[13].ww;
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
  r0.z = cb0[13].z * r0.z;
  r2.xw = float2(38,14);
  r2.yz = cb0[13].ww;
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
  r1.xyz = cb2[0].xxx + cb1[0].xyw;
  r2.xyz = cb0[8].xyw * r1.xxx;
  r3.xy = cmp(r2.xy >= -r2.xy);
  r3.xy = r3.xy ? float2(1,1) : float2(-1,-1);
  r2.xy = r3.xy * r2.xy;
  r1.w = 10 * r2.z;
  r2.xy = frac(r2.xy);
  r2.xy = r3.xy * r2.xy + w0.xy;
  r2.xyzw = t0.Sample(s1_s, r2.xy).xyzw;
  r2.x = -0.5 + r2.x;
  r2.x = 0.200000003 * r2.x;
  r2.xy = r2.xx * cb0[8].zz + v0.xy;
  r2.zw = cb0[6].xy * cb0[2].xy + -r2.xy;
  r3.xy = cmp(r2.zw >= -r2.zw);
  r3.xy = r3.xy ? float2(1,1) : float2(-1,-1);
  r2.zw = r3.xy * r2.zw;
  r2.zw = frac(r2.zw);
  r3.yz = r3.xy * r2.zw;
  r2.z = cb1[6].x / cb1[6].y;
  r3.x = r3.y * r2.z;
  r2.z = dot(r3.xz, r3.xz);
  r2.z = sqrt(r2.z);
  r1.y = cb0[5].z * r1.y;
  r1.y = r2.z * cb0[5].y + -r1.y;
  r1.yw = sin(r1.yw);
  r2.zw = r3.xz * r1.yy;
  r1.y = 0.00100000005 * cb0[5].w;
  r2.yz = r2.zw * r1.yy + r2.xy;
  r1.y = cb0[9].x * r1.w;
  r1.y = 0.00999999978 * r1.y;
  r1.y = v0.y * r1.y + r2.y;
  r2.y = cmp(abs(r1.y) >= -abs(r1.y));
  r1.y = frac(abs(r1.y));
  r2.x = r2.y ? r1.y : -r1.y;
  r3.xy = float2(-0.5,-0.100000001) + r2.xz;
  r1.y = dot(r3.xy, r3.xy);
  r1.y = r1.y * r1.w;
  r3.z = -r3.x;
  r1.yw = r3.yz * r1.yy;
  r1.yw = r1.yw * cb0[9].zz + r2.xz;
  r0.yw = float2(0,0);
  r0.xy = r1.yw + r0.xy;
  r2.xyzw = t1.Sample(s0_s, r0.xy).xyzw;
  r2.yw = v2.yw * r2.yw;
  r0.z = 0.100000001 * cb0[13].x;
  r0.xy = r1.yw + r0.zw;
  r0.xyzw = t1.Sample(s0_s, r0.xy).xyzw;
  r0.xy = v2.xw * r0.xw;
  r3.x = -0.100000001 * cb0[13].x;
  r3.y = 0;
  r0.zw = r3.xy + r1.yw;
  r3.xyzw = t1.Sample(s0_s, r0.zw).xyzw;
  r0.zw = v2.zw * r3.zw;
  r1.y = max(r0.y, r0.w);
  r2.xz = r0.xz * r0.yw;
  r0.x = cb0[13].y * r1.y;
  r2.w = max(r0.x, r2.w);
  r0.x = cmp(r1.x >= -r1.x);
  r0.x = r0.x ? 1 : -1;
  r0.y = r1.x * r0.x;
  r0.z = r1.z * cb0[14].x + 0.0500000007;
  r0.yz = frac(r0.yz);
  r0.x = r0.x * r0.y;
  r0.x = r0.x * cb0[10].z + v0.y;
  r0.y = cb0[10].y + cb0[9].w;
  r0.w = r0.x * r0.y;
  r0.w = cmp(r0.w >= -r0.w);
  r0.w = r0.w ? r0.y : -r0.y;
  r1.x = 1 / r0.w;
  r0.x = r1.x * r0.x;
  r0.x = frac(r0.x);
  r0.x = r0.w * r0.x;
  r0.x = r0.x / r0.y;
  r0.y = cb0[10].y / r0.y;
  r0.w = r0.y + -abs(r0.x);
  r0.x = abs(r0.x) + -r0.y;
  r0.y = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.y = (int)-r0.y + (int)r0.w;
  r0.y = (int)r0.y;
  r0.y = max(0, r0.y);
  r0.w = cmp(r0.y >= 0.00999999978);
  r1.xyz = r0.www ? float3(0,0,0) : cb0[12].xyz;
  r1.xyz = r1.xyz * r2.www;
  r0.w = cmp(0 < r0.x);
  r1.w = cmp(r0.x < 0);
  r0.x = saturate(r0.x);
  r0.w = (int)-r0.w + (int)r1.w;
  r0.w = (int)r0.w;
  r0.w = max(0, r0.w);
  r0.w = cb0[10].w * r0.w;
  r0.w = max(1, r0.w);
  r1.xyz = r2.xyz * r0.www + r1.xyz;
  r0.w = saturate(cb0[10].w);
  r0.w = -cb0[10].x + r0.w;
  r0.x = r0.x * r0.w + cb0[10].x;
  r0.w = 1 + -r0.x;
  r0.x = r0.y * r0.w + r0.x;
  r1.w = r2.w * r0.x;
  r1.xyzw = r1.xyzw + -r2.xyzw;
  r1.xyzw = cb0[11].xxxx * r1.xyzw + r2.xyzw;
  r0.x = 1 + -cb0[14].y;
  r0.x = cmp(r0.x >= r0.z);
  r0.x = r0.x ? 1.000000 : 0;
  r0.x = saturate(r1.w * r0.x + cb0[14].z);
  r0.x = r1.w * r0.x;
  r1.w = cb0[5].x * r0.x;
  o0.xyzw = cb0[4].xyzw * r1.xyzw;
    o0 = saturate(o0);
  return;
}