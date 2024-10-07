// used during "Nightmare" vision, special post processing, switches with tonemap4

#include "./shared.h"
#include "./tonemapper.hlsl"																			// custom tonemapper

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:00:47 2024

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
SamplerState colorGradingTextureSampler_s : register(s1);
SamplerState distortionTextureSampler_s : register(s2);
SamplerState tonemapBloomTextureSampler_s : register(s3);
Texture2D<float4> mainTexture : register(t0);
Texture3D<float4> colorGradingTexture : register(t1);
Texture2D<float4> distortionTexture : register(t2);
Texture2D<float4> tonemapBloomTexture : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = distortionTexture.Sample(distortionTextureSampler_s, v2.xy).xy;
  r0.xy = r0.xy * distortionScaleOffset.xy + distortionScaleOffset.zw;
  r0.xy = v2.xy + r0.xy;
	
		float2 screen = r0.xy;
	
  r0.zw = chromostereopsisParams.yz + r0.xy;
  r0.z = mainTexture.Sample(mainTextureSampler_s, r0.zw).x;
  r1.xyz = mainTexture.Sample(mainTextureSampler_s, r0.xy).xyz;
  r0.z = -r1.x + r0.z;
  r1.x = chromostereopsisParams.x * r0.z + r1.x;
  r0.zw = -chromostereopsisParams.yz + r0.xy;
  r2.xyz = tonemapBloomTexture.Sample(tonemapBloomTextureSampler_s, r0.xy).xyz;
  r0.x = mainTexture.Sample(mainTextureSampler_s, r0.zw).z;
  r0.x = r0.x + -r1.z;
  r1.z = chromostereopsisParams.x * r0.x + r1.z;
  r0.xyz = r2.xyz * bloomScale.xyz * injectedData.fxBloom + r1.xyz;											// Bloom slider
  r0.xyz = colorScale.xyz * r0.xyz;
  r1.xy = float2(-0.5,-0.5) + v2.xy;
  r1.xy = vignetteParams.xy * r1.xy;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = saturate(-r0.w * vignetteColor.w + 1);
  r0.w = log2(r0.w);
  r0.w = vignetteParams.z * injectedData.fxVignette * r0.w;													// Vignette slider
  r0.w = exp2(r0.w);
  r0.xyz = r0.xyz * r0.www;
	
		float3 untonemapped = r0.xyz;
	
  r0.xyz += float3(-0.00400000019,-0.00400000019,-0.00400000019);
  r0.xyz = max(float3(0,0,0), r0.xyz);			
  r1.xyz = r0.xyz * float3(6.19999981,6.19999981,6.19999981) + float3(0.5,0.5,0.5);							// OG tonemapper start
  r1.xyz = r1.xyz * r0.xyz;
  r2.xyz = r0.xyz * float3(6.19999981,6.19999981,6.19999981) + float3(1.70000005,1.70000005,1.70000005);
  r0.xyz = r0.xyz * r2.xyz + float3(0.0599999987,0.0599999987,0.0599999987);
  r0.xyz = r1.xyz / r0.xyz;
  
		float vanillaGray = 0.225399712683f;
		float3 LUTless = r0.xyz;
		
  r0.xyz = r0.xyz * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
  r0.xyz = colorGradingTexture.Sample(colorGradingTextureSampler_s, r0.xyz).xyz;							// OG LUT
  o0.w = dot(r0.xyz, float3(0.298999995,0.587000012,0.114));
  o0.xyz = r0.xyz;																							// vanilla output
  
    	float3 vanilla = o0.rgb;
	
	o0.rgb = applyUserTonemap(untonemapped.rgb, colorGradingTexture, colorGradingTextureSampler_s, LUTless.rgb, vanilla.rgb, screen.xy, vanillaGray);
  return;
}