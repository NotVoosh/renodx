#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:00:11 2024

cbuffer CommonConstants : register(b0)
{
  float4 g_SssScreenSize : packoffset(c0);
  float2 g_SssBlurDirection : packoffset(c1);
  float g_SssProjCx : packoffset(c1.z);
  float g_SssProjCy : packoffset(c1.w);
  int g_SssSampleCount : packoffset(c2);
  float g_SssMaxWidth : packoffset(c2.y);
  float2 g_SssPad0 : packoffset(c2.z);
}

SamplerState g_LinearSampler_s : register(s0);
Texture2D<float4> g_DiffIrradianceInput : register(t0);
Texture2D<float> g_LinearDepthTexture : register(t1);
Texture2D<float4> g_GBuffer2 : register(t4);
Buffer<float4> g_MaterialBuffer : register(t5);
Texture2D<float4> g_SpecIrradianceInput : register(t6);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (int2)v0.xy;
  r0.zw = float2(0,0);
  r1.x = g_LinearDepthTexture.Load(r0.xyw).x;
  r1.yz = trunc(v0.xy);
  r2.xyzw = g_SssScreenSize.zwzw * r1.yzyz;
  r1.w = dot(r2.xzyw, g_SssBlurDirection.xxyy);
  r1.yzw = float3(0.5,0.5,-1) + r1.yzw;
  r1.w = r1.w * r1.x;
  r2.x = dot(g_SssProjCx, g_SssBlurDirection.xy);
  r1.w = r1.w / r2.x;
  r2.xy = ddx_coarse(r1.wx);
  r3.xy = ddy_coarse(r1.wx);
  r2.zw = g_SssBlurDirection.yy * r3.xy;
  r2.xy = r2.xy * g_SssBlurDirection.xx + r2.zw;
  r2.zw = g_GBuffer2.Load(r0.xyw).yw;
  r3.xy = float2(255,255) * r2.wz;
  r3.xy = round(r3.xy);
  r3.xy = (uint2)r3.xy;
  r1.w = cmp((int)r3.x != 2);
  if (r1.w != 0) {
    if (-1 != 0) discard;
  }
  r1.w = min(5, (uint)r3.y);
  r2.z = -0.0196078438 + r2.z;
  r2.z = g_SssMaxWidth * r2.z;
  bitmask.w = ((~(-1 << 31)) << 1) & 0xffffffff;  r2.w = (((uint)g_SssSampleCount << 1) & bitmask.w) | ((uint)1 & ~bitmask.w);
  r3.x = (int)r1.w * (int)r2.w;
  r4.xyzw = g_DiffIrradianceInput.Load(r0.xyw).xyzw;
  r3.y = cmp((int)r1.w == 5);
  r2.z = 0.00249999994 * r2.z;
  r3.x = g_MaterialBuffer.Load(r3.x).w;
  r2.z = r3.y ? r2.z : r3.x;
  r2.x = dot(r2.xy, r2.xy);
  r2.x = sqrt(r2.x);
  r2.x = r2.z / r2.x;
  r2.y = g_SssSampleCount;
  r2.x = r2.x / r2.y;
  r2.y = -g_SssSampleCount;
  r3.xyz = float3(0,0,0);
  r5.xyz = float3(0,0,0);
  r3.w = r2.y;
  while (true) {
    r5.w = cmp(g_SssSampleCount < (int)r3.w);
    if (r5.w != 0) break;
    r5.w = (int)r3.w;
    r6.xy = g_SssBlurDirection.xy * r5.ww;
    r6.xy = r6.xy * r2.xx + r1.yz;
    r6.xy = g_SssScreenSize.zw * r6.xy;
    r5.w = g_LinearDepthTexture.SampleLevel(g_LinearSampler_s, r6.xy, 0).x;
    r5.w = r5.w + -r1.x;
    r5.w = cmp(r2.z >= abs(r5.w));
    r5.w = r5.w ? 1.000000 : 0;
    r6.xyz = g_DiffIrradianceInput.SampleLevel(g_LinearSampler_s, r6.xy, 0).xyz;
    r6.xyz = r6.xyz + -r4.xyz;
    r6.xyz = r5.www * r6.xyz + r4.xyz;
    r5.w = mad((int)r1.w, (int)r2.w, (int)r3.w);
    r5.w = (int)r5.w + g_SssSampleCount;
    r7.xyz = g_MaterialBuffer.Load(r5.w).xyz;
    r5.xyz = r6.xyz * r7.xyz + r5.xyz;
    r3.xyz = r7.xyz + r3.xyz;
    r3.w = (int)r3.w + 1;
  }
  r1.xyz = r5.xyz / r3.xyz;
  r0.xyz = g_SpecIrradianceInput.Load(r0.xyz).xyz;
  o0.xyz = r0.xyz * r4.www + r1.xyz;
  o0.w = 1;
  return;
}