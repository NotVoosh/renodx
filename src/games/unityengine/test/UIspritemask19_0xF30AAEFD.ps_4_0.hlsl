Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

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
  float4 cb0[16];
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
  r1.yz = cb0[14].yy;
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
  r0.z = cb0[14].x * r0.z;
  r2.xw = float2(38,14);
  r2.yz = cb0[14].yy;
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
  r0.zw = cb0[10].xy * r1.xx;
  r2.xy = cmp(r0.zw >= -r0.zw);
  r2.xy = r2.xy ? float2(1,1) : float2(-1,-1);
  r0.zw = r2.xy * r0.zw;
  r0.zw = frac(r0.zw);
  r0.zw = r2.xy * r0.zw + w0.xy;
  r2.xyzw = t0.Sample(s2_s, r0.zw).xyzw;
  r0.z = -0.5 + r2.x;
  r0.z = 0.200000003 * r0.z;
  r0.zw = r0.zz * cb0[10].zz + v0.xy;
  r2.xy = cb0[6].xy * cb0[2].xy + -r0.zw;
  r2.zw = cmp(r2.xy >= -r2.xy);
  r2.zw = r2.zw ? float2(1,1) : float2(-1,-1);
  r2.xy = r2.xy * r2.zw;
  r2.xy = frac(r2.xy);
  r2.yz = r2.zw * r2.xy;
  r1.w = cb1[6].x / cb1[6].y;
  r2.x = r2.y * r1.w;
  r1.w = dot(r2.xz, r2.xz);
  r1.w = sqrt(r1.w);
  r1.y = cb0[5].z * r1.y;
  r1.y = r1.w * cb0[5].y + -r1.y;
  r1.y = sin(r1.y);
  r1.yw = r2.xz * r1.yy;
  r2.x = 0.00100000005 * cb0[5].w;
  r0.zw = r1.yw * r2.xx + r0.zw;
  r0.y = 0;
  r0.xy = r0.zw + r0.xy;
  r2.xyzw = t2.Sample(s1_s, r0.zw).xyzw;
  r0.xyzw = t1.Sample(s0_s, r0.xy).xyzw;
  r0.xyzw = v2.xyzw * r0.xyzw;
  r1.y = r2.w * r0.w;
  r1.y = cb0[8].x * r1.y;
  r3.xyz = cb0[7].xyz * r1.yyy;
  r2.xyz = r3.xyz * r2.xyz;
  r3.xyz = log2(r0.xyz);
  r3.xyz = cb0[11].xxx * r3.xyz;
  r3.xyz = exp2(r3.xyz);
  r3.xyz = cb0[10].www * r3.xyz;
  r3.xyz = floor(r3.xyz);
  r3.xyz = r3.xyz / cb0[10].www;
  r3.xyz = log2(r3.xyz);
  r1.y = 1 / cb0[11].x;
  r3.xyz = r1.yyy * r3.xyz;
  r3.xyz = exp2(r3.xyz);
  r0.xyz = r3.xyz * cb0[8].yyy + r2.xyz;
  r1.y = cmp(r1.x >= -r1.x);
  r1.y = r1.y ? 1 : -1;
  r1.x = r1.x * r1.y;
  r1.z = r1.z * cb0[14].z + 0.0500000007;
  r1.xz = frac(r1.xz);
  r1.x = r1.y * r1.x;
  r1.x = r1.x * cb0[12].x + v0.y;
  r1.y = cb0[11].y + cb0[11].w;
  r1.w = r1.x * r1.y;
  r1.w = cmp(r1.w >= -r1.w);
  r1.w = r1.w ? r1.y : -r1.y;
  r2.x = 1 / r1.w;
  r1.x = r2.x * r1.x;
  r1.x = frac(r1.x);
  r1.x = r1.w * r1.x;
  r1.x = r1.x / r1.y;
  r1.y = cb0[11].w / r1.y;
  r1.w = r1.y + -abs(r1.x);
  r1.x = abs(r1.x) + -r1.y;
  r1.y = cmp(0 < r1.w);
  r1.w = cmp(r1.w < 0);
  r1.y = (int)-r1.y + (int)r1.w;
  r1.y = (int)r1.y;
  r1.y = max(0, r1.y);
  r1.w = cmp(r1.y >= 0.00999999978);
  r2.xyz = r1.www ? float3(0,0,0) : cb0[13].xyz;
  r2.xyz = r2.xyz * r0.www;
  r1.w = cmp(0 < r1.x);
  r2.w = cmp(r1.x < 0);
  r1.x = saturate(r1.x);
  r1.w = (int)-r1.w + (int)r2.w;
  r1.w = (int)r1.w;
  r1.w = max(0, r1.w);
  r1.w = cb0[12].y * r1.w;
  r1.w = max(1, r1.w);
  r2.xyz = r0.xyz * r1.www + r2.xyz;
  r1.w = saturate(cb0[12].y);
  r1.w = -cb0[11].z + r1.w;
  r1.x = r1.x * r1.w + cb0[11].z;
  r1.w = 1 + -r1.x;
  r1.x = r1.y * r1.w + r1.x;
  r2.w = r1.x * r0.w;
  r2.xyzw = r2.xyzw + -r0.xyzw;
  r0.xyzw = cb0[12].zzzz * r2.xyzw + r0.xyzw;
  r1.x = 1 + -cb0[14].w;
  r1.x = cmp(r1.x >= r1.z);
  r1.x = r1.x ? 1.000000 : 0;
  r1.x = saturate(r0.w * r1.x + cb0[15].x);
  r1.x = r1.x * r0.w;
  r0.w = cb0[5].x * r1.x;
  o0.xyzw = cb0[4].xyzw * r0.xyzw;
      o0 = saturate(o0);
  return;
}