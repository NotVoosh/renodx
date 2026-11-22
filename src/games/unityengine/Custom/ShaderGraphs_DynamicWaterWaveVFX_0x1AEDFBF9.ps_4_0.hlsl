#include "../shared.h"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[7];
}
cbuffer cb0 : register(b0){
  float4 cb0[132];
}

float HashValue(int2 cell)
{
  uint2 cellBits = asuint(cell);
  uint hash = cellBits.y ^ 0x41c64e6du;
  hash *= hash + cellBits.x;
  hash ^= hash >> 5;
  hash *= 0x27d4eb2du;
  return (float)hash;
}

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = float3(0.992999971,1.83000004,0.99000001) + -v1.yyy;
  r0.xy = float2(1,1) / r0.xy;
  r0.x = saturate(-v1.y * r0.x);
  r0.w = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.w * r0.x;
  r0.y = saturate(r0.z * r0.y);
  r0.z = r0.y * -2 + 3;
  r0.y = r0.y * r0.y;
  r0.y = dot(r0.zz, r0.yy);
  r1.xyz = -cb1[4].xyz + v2.xyz;
  r1.xyz = r0.yyy * r1.xyz + cb1[4].xyz;
  r0.zw = floor(v4.xy);
  r2.xy = frac(v4.xy);
  r1.w = HashValue((int2)r0.zw);
  r3.yz = r1.ww * float2(2.32830644e-010,2.32830644e-010) + float2(0.5,-0.5);
  r2.z = floor(r3.y);
  r3.x = r1.w * 2.32830644e-010 + -r2.z;
  r1.w = dot(r3.xz, r3.xz);
  r1.w = rsqrt(r1.w);
  r2.zw = r3.xz * r1.ww;
  r1.w = dot(r2.zw, r2.xy);
  r3.xyzw = float4(0,1,1,0) + r0.zwzw;
  r2.zw = float2(HashValue((int2)r3.xy), HashValue((int2)r3.zw));
  r3.xyzw = r2.zwzw * float4(2.32830644e-010,2.32830644e-010,2.32830644e-010,2.32830644e-010) + float4(0.5,0.5,-0.5,-0.5);
  r4.xy = floor(r3.xy);
  r3.xy = r2.zw * float2(2.32830644e-010,2.32830644e-010) + -r4.xy;
  r2.z = dot(r3.xz, r3.xz);
  r2.z = rsqrt(r2.z);
  r2.zw = r3.xz * r2.zz;
  r4.xyzw = float4(-0,-1,-1,-0) + r2.xyxy;
  r2.z = dot(r2.zw, r4.xy);
  r2.w = dot(r3.yw, r3.yw);
  r2.w = rsqrt(r2.w);
  r3.xy = r3.yw * r2.ww;
  r2.w = dot(r3.xy, r4.zw);
  r0.zw = float2(1,1) + r0.zw;
  r0.z = HashValue((int2)r0.zw);
  r3.yz = r0.zz * float2(2.32830644e-010,2.32830644e-010) + float2(0.5,-0.5);
  r0.w = floor(r3.y);
  r3.x = r0.z * 2.32830644e-010 + -r0.w;
  r0.z = dot(r3.xz, r3.xz);
  r0.z = rsqrt(r0.z);
  r0.zw = r3.xz * r0.zz;
  r3.xy = float2(-1,-1) + r2.xy;
  r0.z = dot(r0.zw, r3.xy);
  r3.xy = r2.xy * r2.xy;
  r3.xy = r3.xy * r2.xy;
  r3.zw = r2.xy * float2(6,6) + float2(-15,-15);
  r2.xy = r2.xy * r3.zw + float2(10,10);
  r2.xy = r3.xy * r2.xy;
  r0.w = r2.z + -r1.w;
  r0.w = r2.y * r0.w + r1.w;
  r0.z = r0.z + -r2.w;
  r0.z = r2.y * r0.z + r2.w;
  r0.z = r0.z + -r0.w;
  r0.z = r2.x * r0.z + r0.w;
  r0.z = v4.x + r0.z;
  r2.x = 0.5 + r0.z;
  r0.zw = float2(0.5,0.5) * v4.xy;
  r2.zw = floor(r0.zw);
  r0.zw = frac(r0.zw);
  r1.w = HashValue((int2)r2.zw);
  r3.yz = r1.ww * float2(2.32830644e-010,2.32830644e-010) + float2(0.5,-0.5);
  r3.y = floor(r3.y);
  r3.x = r1.w * 2.32830644e-010 + -r3.y;
  r1.w = dot(r3.xz, r3.xz);
  r1.w = rsqrt(r1.w);
  r3.xy = r3.xz * r1.ww;
  r1.w = dot(r3.xy, r0.zw);
  r3.xyzw = float4(0,1,1,0) + r2.zwzw;
  r3.xy = float2(HashValue((int2)r3.xy), HashValue((int2)r3.zw));
  r4.xyzw = r3.xyxy * float4(2.32830644e-010,2.32830644e-010,2.32830644e-010,2.32830644e-010) + float4(0.5,0.5,-0.5,-0.5);
  r3.zw = floor(r4.xy);
  r4.xy = r3.xy * float2(2.32830644e-010,2.32830644e-010) + -r3.zw;
  r3.x = dot(r4.xz, r4.xz);
  r3.x = rsqrt(r3.x);
  r3.xy = r4.xz * r3.xx;
  r5.xyzw = float4(-0,-1,-1,-0) + r0.zwzw;
  r3.x = dot(r3.xy, r5.xy);
  r3.y = dot(r4.yw, r4.yw);
  r3.y = rsqrt(r3.y);
  r3.yz = r4.yw * r3.yy;
  r3.y = dot(r3.yz, r5.zw);
  r2.zw = float2(1,1) + r2.zw;
  r2.z = HashValue((int2)r2.zw);
  r4.yz = r2.zz * float2(2.32830644e-010,2.32830644e-010) + float2(0.5,-0.5);
  r2.w = floor(r4.y);
  r4.x = r2.z * 2.32830644e-010 + -r2.w;
  r2.z = dot(r4.xz, r4.xz);
  r2.z = rsqrt(r2.z);
  r2.zw = r4.xz * r2.zz;
  r3.zw = float2(-1,-1) + r0.zw;
  r2.z = dot(r2.zw, r3.zw);
  r3.zw = r0.zw * r0.zw;
  r3.zw = r3.zw * r0.zw;
  r4.xy = r0.zw * float2(6,6) + float2(-15,-15);
  r0.zw = r0.zw * r4.xy + float2(10,10);
  r0.zw = r3.zw * r0.zw;
  r2.w = r3.x + -r1.w;
  r1.w = r0.w * r2.w + r1.w;
  r2.z = r2.z + -r3.y;
  r0.w = r0.w * r2.z + r3.y;
  r0.w = r0.w + -r1.w;
  r0.z = r0.z * r0.w + r1.w;
  r0.z = v4.y + r0.z;
  r2.y = 0.5 + r0.z;
  r3.x = cb1[6].x * cb0[19].x;
  r3.y = 0;
  r0.zw = r2.xy * float2(0.150000006,0.25) + r3.xy;
  r2.xyzw = t0.SampleBias(s0_s, r0.zw, cb0[5].x).xyzw;
  r2.xyz = float3(0.99999994,0.99999994,0.99999994) * r2.xyz;
  r0.z = 0.639999986 + -r0.y;
  r0.z = saturate(1.63934422 * r0.z);
  r0.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r0.w * r0.z;
  r0.xz = float2(27.2299995,0.300000012) * r0.xz;
  r2.xyz = r2.xyz * r0.zzz + r1.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r1.xyz = r0.xxx * cb1[5].xyz + r1.xyz;
  r0.x = cb1[4].w + -v2.w;
  r1.w = r0.y * r0.x + v2.w;
  r0.xyzw = v2.xyzw * r1.xyzw;
  if (r0.w == 0.0) discard;
  r2.xy = v3.xy / v3.ww;
  r2.xyzw = t1.SampleBias(s1_s, r2.xy, cb0[5].x).xyzw;
  r1.w = dot(cb0[129].xyzw, cb0[129].xyzw);
  r3.xyzw = float4(1,1,1,1) + -cb0[130].xyzw;
  r2.w = dot(r3.xyzw, cb0[129].xyzw);
  r3.xyz = r2.xyz * r2.www;
  r2.xyz = r1.w != 0.0 ? r3.xyz : r2.xyz;
  r3.xyz = cb0[128].xxx * r2.xyz;
  r2.xyz = cb0[128].yyy * r2.xyz;
  r4.xyz = cb0[131].xxx * r0.xyz;
  r2.xyz = r4.xyz * r3.xyz + r2.xyz;
  r1.xyz = -r1.xyz * v2.xyz + r2.xyz;
  r1.w = 0;
  r0.xyzw = cb0[131].yyyy * r1.xyzw + r0.xyzw;
  o0.xyzw = max(float4(0,0,0,0), r0.xyzw);
  if(CUSTOM_IS_CLAMPED > 1.f){
    o0 = saturate(o0);
  }
  return;
}