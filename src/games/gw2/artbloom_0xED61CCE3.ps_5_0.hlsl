// Artifacts. Bloom negative colors?
// To investigate later, maybe

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:14:22 2024
Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[13];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[3].xy * v0.xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.y = cb0[1].z * r0.y;
  r0.xy = float2(1,-1) * r0.xy;
  r1.xy = cb0[1].xx + v0.xy;
  r1.xy = cb0[3].xy * r1.xy;
  r0.z = t1.Sample(s1_s, r1.xy).x;
  r0.w = 1;
  r2.x = dot(r0.xyzw, cb0[4].xyzw);
  r2.y = dot(r0.xyzw, cb0[5].xyzw);
  r2.z = dot(r0.xyzw, cb0[6].xyzw);
  r0.x = dot(r0.xyzw, cb0[7].xyzw);
  r0.xyz = r2.xyz / r0.xxx;
  r0.xyz = -cb0[9].xyz + r0.xyz;
  r0.xyz = r0.xyz / cb0[10].www;
  r1.zw = frac(r0.xy);
  r0.w = -0.75 + r0.z;
  r2.xyz = floor(r0.xyw);
  r0.w = frac(r0.w);
  r2.xyz = (int3)r2.xyz;
  r2.w = trunc(cb0[12].z);
  r3.x = cb0[12].x / r2.w;
  r3.yzw = r2.www * cb0[10].xyz + float3(-2,-2,-2);
  r3.yzw = -r3.yzw + r0.xyz;
  r3.yzw = saturate(-r3.yzw * float3(0.5,0.5,0.5) + float3(1,1,1));
  r2.w = (int)r3.x;
  r3.x = (int)r2.w ^ (int)r2.z;
  r3.x = (int)r3.x & 0x80000000;
  r4.xy = max((int2)-r2.wz, (int2)r2.wz);
  uiDest.x = (uint)r4.y / (uint)r4.x;
  r6.x = (uint)r4.y % (uint)r4.x;
  r5.x = uiDest.x;
  r4.y = -(int)r5.x;
  r3.x = r3.x ? r4.y : r5.x;
  r4.y = (int)cb0[12].z;
  r3.x = mad((int)r3.x, (int)r4.y, (int)r2.y);
  r5.y = (int)r3.x;
  r3.x = (int)r2.z & 0x80000000;
  r4.z = -(int)r6.x;
  r3.x = r3.x ? r4.z : r6.x;
  r3.x = mad((int)r3.x, (int)r4.y, (int)r2.x);
  r5.x = (int)r3.x;
  r4.zw = r5.xy + r1.zw;
  r4.zw = float2(0.5,0.5) + r4.zw;
  r4.zw = float2(0.142857149,0.142857149) * r4.zw;
  r5.xy = floor(r4.zw);
  r5.xy = float2(0.5,0.5) + r5.xy;
  r3.x = 6 + cb0[12].x;
  r3.x = 0.142857149 * r3.x;
  r6.x = trunc(r3.x);
  r6.y = trunc(cb0[11].z);
  r5.xy = r5.xy / r6.xy;
  r3.x = t5.Sample(s5_s, r5.xy).x;
  r3.x = cmp(0.5 >= r3.x);
  r2.z = (int)r2.z + 1;
  r2.w = (int)r2.w ^ (int)r2.z;
  r5.x = max((int)-r2.z, (int)r2.z);
  r2.zw = (int2)r2.zw & int2(0x80000000,0x80000000);
  uiDest.x = (uint)r5.x / (uint)r4.x;
  r5.x = (uint)r5.x % (uint)r4.x;
  r4.x = uiDest.x;
  r5.y = -(int)r4.x;
  r2.w = r2.w ? r5.y : r4.x;
  r2.y = mad((int)r2.w, (int)r4.y, (int)r2.y);
  r7.y = (int)r2.y;
  r2.y = -(int)r5.x;
  r2.y = r2.z ? r2.y : r5.x;
  r2.x = mad((int)r2.y, (int)r4.y, (int)r2.x);
  r7.x = (int)r2.x;
  r1.zw = r7.xy + r1.zw;
  r1.zw = float2(0.5,0.5) + r1.zw;
  r1.zw = float2(0.142857149,0.142857149) * r1.zw;
  r2.xy = floor(r1.zw);
  r2.xy = float2(0.5,0.5) + r2.xy;
  r2.xy = r2.xy / r6.xy;
  r2.x = t5.Sample(s5_s, r2.xy).x;
  r2.x = cmp(0.5 >= r2.x);
  r2.x = (int)r2.x | (int)r3.x;
  if (r2.x != 0) discard;
  r2.xy = r1.zw / cb0[11].yy;
  r2.xy = t4.Sample(s4_s, r2.xy).xy;
  r1.zw = r2.xy * float2(255,255) + r1.zw;
  r2.xy = frac(r1.zw);
  r1.zw = floor(r1.zw);
  r2.xy = float2(7,7) * r2.xy;
  r1.zw = r1.zw * float2(8,8) + r2.xy;
  r1.zw = float2(0.5,0.5) + r1.zw;
  r1.zw = r1.zw / cb0[11].xx;
  r2.xyzw = t3.Sample(s3_s, r1.zw).xyzw;
  r5.xyzw = t2.Sample(s2_s, r1.zw).xyzw;
  r1.zw = r4.zw / cb0[11].yy;
  r1.zw = t4.Sample(s4_s, r1.zw).xy;
  r1.zw = r1.zw * float2(255,255) + r4.zw;
  r4.xy = frac(r1.zw);
  r1.zw = floor(r1.zw);
  r4.xy = float2(7,7) * r4.xy;
  r1.zw = r1.zw * float2(8,8) + r4.xy;
  r1.zw = float2(0.5,0.5) + r1.zw;
  r1.zw = r1.zw / cb0[11].xx;
  r4.xyzw = t3.Sample(s3_s, r1.zw).xyzw;
  r6.xyzw = t2.Sample(s2_s, r1.zw).xyzw;
  r2.xyzw = -r4.xyzw + r2.xyzw;
  r2.xyzw = r0.wwww * r2.xyzw + r4.xyzw;
  r2.xyzw = r2.xyzw * float4(2,2,2,1) + float4(-1,-1,-1,0);
  r4.xyz = t0.Sample(s0_s, r1.xy).xyz;
  r1.x = t6.Sample(s6_s, r1.xy).x;
  r1.x = -1 + r1.x;
  r1.x = r1.x * cb0[8].x + 1;
  r1.yzw = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.x = dot(r1.yzw, r1.yzw);
  r3.x = rsqrt(r3.x);
  r4.xyz = r3.xxx * r1.yzw;
  r4.w = 1;
  r1.y = dot(r2.xyzw, r4.xyzw);
  r1.y = max(0, r1.y);
  r2.xyzw = -r6.xyzw + r5.xyzw;
  r2.xyzw = r0.wwww * r2.xyzw + r6.xyzw;
  r0.w = 4 * r2.w;
  r2.xyz = r2.xyz * r0.www;
  r1.yzw = r2.xyz * r1.yyy;
  r1.yzw = cb0[11].www * r1.yzw;
  r1.xyz = r1.xxx * r1.yzw;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r1.xyz = cb0[0].xxx * r1.xyz;
  r0.y = min(r0.y, r0.z);
  r0.x = min(r0.x, r0.y);
  r0.x = 0.5 * r0.x;
  r0.x = min(1, r0.x);
  r0.x = min(r0.x, r3.y);
  r0.y = min(r3.z, r3.w);
  r0.x = min(r0.x, r0.y);
  r1.w = 0;
  o0.xyzw = r1.xyzw * r0.xxxx;
	o0.rgb = max(0, o0.rgb);							// remove negative colors, seems to work
  return;
}