// Haven 2 skybox with massive sun

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:00:42 2024

cbuffer _Globals : register(b0)
{
  float4 g_sunColorAndSize : packoffset(c0);
  float4 g_sunDirAndSkyGradientScale : packoffset(c1);
  float g_panoramicRotation : packoffset(c2);
  float4 g_panoramicUVRanges : packoffset(c3);
  float g_panoramicTileFactor : packoffset(c4);
  float4 g_cloudLayerSunColor : packoffset(c5);
  float4 g_cloudLayerLightingParams0 : packoffset(c6);
  float4 g_cloudLayerLightingParams1 : packoffset(c7);
  float4 g_cloudLayer0Color : packoffset(c8);
  float4 g_cloudLayerParams : packoffset(c9);
  float4 g_cloudLayer0UVTransform0 : packoffset(c10);
  float4 g_cloudLayer0UVTransform1 : packoffset(c11);
  float4 g_cloudLayer1UVTransform0 : packoffset(c12);
  float4 g_cloudLayer1UVTransform1 : packoffset(c13);
  float4 g_cloudLayer1Color : packoffset(c14);
  float4 g_fogParams : packoffset(c15);
  float2 g_forwardScatteringParams : packoffset(c16);
  float4 g_forwardScatteringColorPresence : packoffset(c17);
  float4 g_fogCoefficients : packoffset(c18);
  float4 g_fogColorCoefficients : packoffset(c19);
  float4 g_fogColor : packoffset(c20);
  float g_fogStartDistance : packoffset(c21);
  float4 g_heightFogCoefficients : packoffset(c22);
  float4x4 g_invViewProjMatrix : packoffset(c23);
  float3 g_camPos : packoffset(c27);
  float2 g_screenSizeInv : packoffset(c28);
  float g_hdrExposureMultiplier : packoffset(c28.z);
  float g_drawEnvmap : packoffset(c28.w);
  float g_drawThetaPhiEnvmap : packoffset(c29);
  float4 g_alphaSelector : packoffset(c30);
  float g_hdriRotationAngle : packoffset(c31);
  float g_hdriCosRotation : packoffset(c31.y);
  float g_hdriSinRotation : packoffset(c31.z);
}

SamplerState g_skyGradientSampler_s : register(s0);
SamplerState g_acosLUTSampler_s : register(s1);
SamplerState g_panoramicSampler_s : register(s3);
SamplerState g_panoramicAlphaSampler_s : register(s4);
SamplerState g_cloudLayer0Sampler_s : register(s5);
SamplerState g_cloudLayer1Sampler_s : register(s6);
SamplerState g_cloudLayerMaskSampler_s : register(s7);
SamplerState g_forwardScatteringTextureSampler_s : register(s12);
Texture2D<float4> g_skyGradientTexture : register(t0);
Texture2D<float4> g_acosLUTTexture : register(t1);
Texture2D<float3> g_panoramicTexture : register(t3);
Texture2D<float> g_panoramicAlphaTexture : register(t4);
Texture2D<float> g_cloudLayer0Texture : register(t5);
Texture2D<float> g_cloudLayer1Texture : register(t6);
Texture2D<float> g_cloudLayerMaskTexture : register(t7);
Texture2D<float4> g_depthTexture : register(t10);
Texture2D<float4> g_forwardScatteringTexture : register(t12);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float3 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v1.xyz, v1.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v1.xyz * r0.xxx;
  r1.xy = (int2)v0.xy;
  r2.xy = g_screenSizeInv.xy * v0.xy;
  r0.w = cmp(abs(r0.z) < abs(r0.x));
  if (r0.w != 0) {
    r0.w = r0.z;
    r2.z = r0.x;
    r2.w = 1;
  } else {
    r0.w = r0.x;
    r2.z = r0.z;
    r2.w = 3;
  }
  r3.x = dot(r0.xz, float2(1,-1));
  r3.x = cmp(0 < r3.x);
  if (r3.x != 0) {
    r2.w = 4 + r2.w;
    r3.x = -1;
  } else {
    r3.x = 1;
  }
  r0.w = r0.w / abs(r2.z);
  r2.z = r0.w * r0.w;
  r2.z = r2.z * 0.200000003 + 0.800000012;
  r0.w = r0.w / r2.z;
  r0.w = r0.w * r3.x + r2.w;
  r0.w = r0.w * 0.125 + 0.125;
  r0.w = frac(r0.w);
  r3.x = 1 + -r0.w;
  r0.w = r0.y * 0.499023438 + 0.500976563;
  r4.x = frac(r0.w);
  r4.yw = float2(0.5,1);
  r0.w = g_acosLUTTexture.SampleLevel(g_acosLUTSampler_s, r4.xy, 0).x;
  r3.y = -r0.w;
  r4.z = g_panoramicRotation;
  r2.zw = r4.zw + r3.xy;
  r4.xyzw = g_skyGradientTexture.SampleLevel(g_skyGradientSampler_s, r2.zw, 0).xyzw;
  r3.z = 1 + r3.y;
  r3.yz = saturate(r3.xz * g_panoramicUVRanges.xy + g_panoramicUVRanges.zw);
  r0.w = g_panoramicRotation + r3.y;
  r3.x = g_panoramicTileFactor * r0.w;
  r5.xyz = g_panoramicTexture.SampleLevel(g_panoramicSampler_s, r3.xz, 0).xyz;
  r0.w = g_panoramicAlphaTexture.SampleLevel(g_panoramicAlphaSampler_s, r3.xz, 0).x;
  r3.z = g_cloudLayerMaskTexture.SampleLevel(g_cloudLayerMaskSampler_s, r3.xz, 0).x;
  r2.z = dot(g_sunDirAndSkyGradientScale.xyz, r0.xyz);
  r2.w = cmp(0 >= r0.y);
  if (r2.w != 0) {
    r6.xyzw = float4(12742000,12742000,12742000,12742000) + g_cloudLayerParams.xxyy;
    r6.xyzw = -g_cloudLayerParams.xxyy * r6.xyzw;
    r2.w = 6371000 * r0.y;
    r6.xyzw = r2.wwww * r2.wwww + -r6.xyzw;
    r6.xyzw = sqrt(r6.xyzw);
    r6.xyzw = r0.yyyy * float4(6371000,6371000,6371000,6371000) + r6.xyzw;
    r6.xyzw = -abs(r6.zwxy) * r0.xzxz;
    r0.xy = r6.zw;
    r0.z = 1;
    r7.x = dot(r0.xyz, g_cloudLayer0UVTransform0.xyz);
    r7.y = dot(r0.xyz, g_cloudLayer0UVTransform1.xyz);
    r6.z = 1;
    r0.x = dot(r6.xyz, g_cloudLayer1UVTransform0.xyz);
    r0.y = dot(r6.xyz, g_cloudLayer1UVTransform1.xyz);
  } else {
    r7.xy = float2(0,0);
    r0.xy = float2(0,0);
  }
  r0.z = g_cloudLayer0Texture.Sample(g_cloudLayer0Sampler_s, r7.xy).x;
  r0.x = g_cloudLayer1Texture.Sample(g_cloudLayer1Sampler_s, r0.xy).x;
  r0.xy = saturate(g_cloudLayerParams.wz * r0.xz);
  //r0.z = 1 + -g_sunColorAndSize.w;
    r0.z = injectedData.miscFixes
         ? 1 + -g_sunColorAndSize.w * 0.05
         : 1 + -g_sunColorAndSize.w;
  r2.w = -r0.z * r0.z + 1;
  r2.w = max(0, r2.w);
  r2.w = r2.w * r2.w;
  r5.w = r0.z * r0.z + 1;
  r0.z = r0.z + r0.z;
  r0.z = saturate(-r0.z * r2.z + r5.w);
  r0.z = log2(r0.z);
  r0.z = 1.5 * r0.z;
  r0.z = exp2(r0.z);
  r0.z = 12.566371 * r0.z;
  r0.z = r2.w / r0.z;
  r0.z = min(1, r0.z);
  //r6.xyz = g_sunColorAndSize.xyz * r0.zzz;
    r6.xyz = injectedData.miscFixes
           ? g_sunColorAndSize.xyz * r0.zzz * 5
           : g_sunColorAndSize.xyz * r0.zzz;
  r0.xy = float2(1,1) + -r0.xy;
  r3.y = r0.y * r0.x;
  r3.w = r3.y * r3.z;
  r3.x = 1;
  o1.x = dot(r3.xyzw, g_alphaSelector.xyzw);
  r1.zw = float2(0,0);
  r1.z = g_depthTexture.Load(r1.xyz).x;
  r0.xy = r2.xy * float2(2,2) + float2(-1,-1);
  r1.xy = float2(1,-1) * r0.xy;
  r1.w = 1;
  r0.x = dot(r1.xyzw, g_invViewProjMatrix._m00_m10_m20_m30);
  r0.y = dot(r1.xyzw, g_invViewProjMatrix._m01_m11_m21_m31);
  r0.z = dot(r1.xyzw, g_invViewProjMatrix._m02_m12_m22_m32);
  r1.x = dot(r1.xyzw, g_invViewProjMatrix._m03_m13_m23_m33);
  r0.xyz = r0.xyz / r1.xxx;
  r0.xyz = g_camPos.xyz + -r0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.yz = g_fogParams.zw / r4.ww;
  r1.xz = saturate(r0.xx * r0.yz + g_fogParams.xy);
  r0.xy = r1.xz * r1.xz;
  r3.xy = r1.xz * r0.xy;
  r7.x = r3.x;
  r7.y = r0.x;
  r7.z = r1.x;
  r7.w = 1;
  r0.x = saturate(dot(r7.xyzw, g_fogCoefficients.xyzw));
  r1.x = r3.y;
  r1.y = r0.y;
  r1.w = 1;
  r0.y = saturate(dot(r1.xyzw, g_fogColorCoefficients.xyzw));
  r0.z = g_forwardScatteringParams.x * r2.z + 1;
  r0.z = r0.z * r0.z;
  r0.z = g_forwardScatteringParams.y / r0.z;
  r1.xyz = g_forwardScatteringColorPresence.xyz * r0.zzz;
  r0.z = 1 + -r0.x;
  r0.x = r0.z * r0.y + r0.x;
  r3.xyz = r1.xyz * r0.xxx;
  r2.xyz = g_forwardScatteringTexture.SampleLevel(g_forwardScatteringTextureSampler_s, r2.xy, 0).xyz;
  r0.xyz = -r1.xyz * r0.xxx + r2.xyz;
  r0.xyz = g_forwardScatteringColorPresence.www * r0.xyz + r3.xyz;
  r1.xyz = r5.xyz + -r4.xyz;
  r1.xyz = r0.www * r1.xyz + r4.xyz;
  r1.xyz = r1.xyz * g_sunDirAndSkyGradientScale.www + r6.xyz;
  r0.xyz = r1.xyz + r0.xyz;
  o0.w = 1;
  o0.xyz = g_hdrExposureMultiplier * r0.xyz;
  return;
}