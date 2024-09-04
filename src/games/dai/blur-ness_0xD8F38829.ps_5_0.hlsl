#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:03:36 2024

cbuffer _Globals : register(b0)
{
  float2 invPixelSize : packoffset(c0);
  float4x4 motionBlurFastStableVelocityParams_Vertex : packoffset(c1);
  float4 motionBlurFastStableVelocityParams_Pixel : packoffset(c5);
  float4 motionBlurParams : packoffset(c6);
  float4 motionBlurParams2 : packoffset(c7);
  float4x4 invViewProjectionMatrix : packoffset(c8);
  float4x4 prevViewProjectionMatrix : packoffset(c12);
  float4 cameraPosAndDepthCutoff : packoffset(c16);
  float4 radialBlurParams : packoffset(c17);
  float cutoffGradientScale : packoffset(c18);
}

SamplerState mainTextureSampler_s : register(s1);
SamplerState randomTextureSampler_s : register(s2);
SamplerState velocityTextureSampler_s : register(s3);
Texture2D<float4> mainTexture : register(t1);
Texture2D<float4> randomTexture : register(t2);
Texture2D<float4> velocityTexture : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = invPixelSize.xy * v0.xy;
  r0.zw = velocityTexture.Sample(velocityTextureSampler_s, r0.xy).xy;
  r1.xy = float2(-1,1) * motionBlurParams.xx;
  r0.zw = r1.xy * r0.zw;
  r1.x = dot(r0.zw, r0.zw);
  r1.x = sqrt(r1.x);
  r1.x = motionBlurParams.y * r1.x;
  r1.y = cmp(1 < r1.x);
  r1.xz = r0.zw / r1.xx;
  r0.zw = r1.yy ? r1.xz : r0.zw;
  r1.xyzw = mainTexture.SampleLevel(mainTextureSampler_s, r0.xy, 0).xyzw;
    if (injectedData.fxBlur == 0) {                                         // a simple toggle. Something in there causes artifacts
        o0.xyz = r1.xyz;
        o0.w = 1;
        return;
    }
  r1.w = -motionBlurParams2.x + r1.w;
  r1.w = min(motionBlurParams2.y, r1.w);
  r2.xy = r0.zw / invPixelSize.xy;
  r2.x = dot(r2.xy, r2.xy);
  r2.x = sqrt(r2.x);
  r2.x = max(1, r2.x);
  r2.y = cmp(1 < r2.x);
  r2.x = 0.25 * r2.x;
  r2.x = ceil(r2.x);
  r2.x = 4 * r2.x;
  r2.x = r2.y ? r2.x : 1;
  r2.x = min(motionBlurParams.w, r2.x);
  r2.y = 1 / r2.x;
  r2.zw = r2.yy * r0.zw;
  r3.xy = float2(0.03125,0.03125) * v0.xy;
  r3.x = randomTexture.SampleLevel(randomTextureSampler_s, r3.xy, 0).x;
  r3.x = motionBlurParams.z * r3.x;
  r0.xy = r2.zw * r3.xx + r0.xy;
  r3.xyz = r1.xyz;
  r2.zw = r0.xy;
  r3.w = 1;
  r4.x = 1;
  while (true) {
    r4.y = cmp(r4.x >= r2.x);
    if (r4.y != 0) break;
    r4.yz = r0.zw * r2.yy + r2.zw;
    r5.xyzw = mainTexture.SampleLevel(mainTextureSampler_s, r4.yz, 0).xyzw;
    r4.w = cmp(r1.w < r5.w);
    r4.w = r4.w ? 1.000000 : 0;
    r5.xyz = r5.xyz * r4.www + r3.xyz;
    r4.w = r4.w + r3.w;
    r4.yz = r0.zw * r2.yy + r4.yz;
    r6.xyzw = mainTexture.SampleLevel(mainTextureSampler_s, r4.yz, 0).xyzw;
    r5.w = cmp(r1.w < r6.w);
    r5.w = r5.w ? 1.000000 : 0;
    r5.xyz = r6.xyz * r5.www + r5.xyz;
    r4.w = r5.w + r4.w;
    r4.yz = r0.zw * r2.yy + r4.yz;
    r6.xyzw = mainTexture.SampleLevel(mainTextureSampler_s, r4.yz, 0).xyzw;
    r5.w = cmp(r1.w < r6.w);
    r5.w = r5.w ? 1.000000 : 0;
    r5.xyz = r6.xyz * r5.www + r5.xyz;
    r4.w = r5.w + r4.w;
    r2.zw = r0.zw * r2.yy + r4.yz;
    r6.xyzw = mainTexture.SampleLevel(mainTextureSampler_s, r2.zw, 0).xyzw;
    r4.y = cmp(r1.w < r6.w);
    r4.y = r4.y ? 1.000000 : 0;
    r3.xyz = r6.xyz * r4.yyy + r5.xyz;
    r3.w = r4.w + r4.y;
    r4.x = 4 + r4.x;
  }
  o0.xyz = r3.xyz / r3.www;
  o0.w = 1;
  return;
}