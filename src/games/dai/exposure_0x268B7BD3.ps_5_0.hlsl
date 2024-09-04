// sky exposure I think. removing it causes several other issues.

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 01:53:47 2024

cbuffer _Globals : register(b0)
{
  float2 invPixelSize : packoffset(c0);
  float4 depthFactors : packoffset(c1);
  float2 fadeParams : packoffset(c2);
  float4 color : packoffset(c3);
  float4 colorMatrix0 : packoffset(c4);
  float4 colorMatrix1 : packoffset(c5);
  float4 colorMatrix2 : packoffset(c6);
  float exponent : packoffset(c7);
  float4 ironsightsDofParams : packoffset(c8);
  uint4 mainTextureDimensions : packoffset(c9);
  float cubeArrayIndex : packoffset(c10);
  float4 combineTextureWeights[2] : packoffset(c11);
  float4 colorScale : packoffset(c13);
  float2 invTexelSize : packoffset(c14);
  float4 downsampleQuarterZOffset : packoffset(c15);
  int sampleCount : packoffset(c16);
  float filterWidth : packoffset(c16.y);
  float mipLevelSource : packoffset(c16.z);
  float convolveSpecularPower : packoffset(c16.w);
  float convolveBlurRadius : packoffset(c17);
  int convolveSampleCount : packoffset(c17.y);
  float3 dofDepthScaleFactors : packoffset(c18);
  float4 radialBlurScales : packoffset(c19);
  float2 radialBlurCenter : packoffset(c20);
  float4 poissonRadialBlurConstants : packoffset(c21);
  float blendFactor : packoffset(c22);
  float3 tonemapGlareIntensity : packoffset(c22.y);
  float3 filmGrainColorScale : packoffset(c23);
  float4 filmGrainTextureScaleAndOffset : packoffset(c24);
  float3 depthScaleFactors : packoffset(c25);
  float4 dofParams : packoffset(c26);
  float4 dofParams2 : packoffset(c27);
  float4 dofDebugParams : packoffset(c28);
  float3 bloomScale : packoffset(c29);
  float3 invGamma : packoffset(c30);
  float3 luminanceVector : packoffset(c31);
  float3 vignetteParams : packoffset(c32);
  float4 vignetteColor : packoffset(c33);
  float4 chromostereopsisParams : packoffset(c34);
  float4 distortionScaleOffset : packoffset(c35);
}

SamplerState mainTextureSampler_s : register(s0);
Texture2D<float4> mainTexture : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = mainTexture.Sample(mainTextureSampler_s, v2.xy).xyz;
  //r0.x = dot(r0.xyz, luminanceVector.xyz);
        if(injectedData.fxSkyExposure) {                                      // Best I could find right now
    r0.x = dot(r0.xyz, luminanceVector.xyz);                                  // Bright scenes are less bright and dark scenes less dark
        }                                                                     // Maybe also a bit slower?
  r0.x = 9.99999975e-06 + r0.x;
  r0.x = log2(r0.x);
  o0.xyzw = float4(0.693147182,0.693147182,0.693147182,0.693147182) * r0.xxxx;
  return;
}