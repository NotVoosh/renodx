// Depth of Field. Mainly used in cutscenes, I think? Only artifacts in cutscenes for sure.

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 01:54:38 2024

cbuffer ShaderConstants : register(b0)
{
  float g_OutFocusFarStart : packoffset(c0);
  float g_OutFocusFarEnd : packoffset(c0.y);
  float g_MaxFarCoCSize : packoffset(c0.z);
  float g_AddBlur : packoffset(c0.w);
  uint2 g_FullScreenSize : packoffset(c1);
  float2 g_FullPixelSize : packoffset(c1.z);
  float2 g_BokehTextureOffset : packoffset(c2);
  float g_EnergyScale : packoffset(c2.z);
  float g_InfocusMultiplier : packoffset(c2.w);
  float2 g_MinRadiusToLayer4 : packoffset(c3);
  float2 g_MinRadiusToLayer8 : packoffset(c3.z);
  float g_MergeRadiusThreshold : packoffset(c4);
  float g_MergeColorThreshold : packoffset(c4.y);
  float g_DepthDiscontinuityThreshold : packoffset(c4.z);
  float g_DepthFileterEnable : packoffset(c4.w);
  float2 g_VignetteBlurScale : packoffset(c5);
  float g_VignetteBlurExponent : packoffset(c5.z);
  uint g_MaxExtraBlurSize : packoffset(c5.w);
  uint2 g_CurrentScreenSize : packoffset(c6);
  float2 g_CurrentPixelSize : packoffset(c6.z);
  uint2 g_EnergyPixelCoord : packoffset(c7);
  float g_EnergyRadius : packoffset(c7.z);
  float g_energyPad : packoffset(c7.w);
  float4 g_PhysicalCamDof : packoffset(c8);
  float g_EdgeBlurGain : packoffset(c9);
  float g_EdgeBlurFadeNearDepth : packoffset(c9.y);
  float g_EdgeBlurFadeFarDepth : packoffset(c9.z);
  float g_OutFocusNearStart : packoffset(c9.w);
  float g_DistanceBlurGain : packoffset(c10);
  float g_DistanceBlurHalfDistance : packoffset(c10.y);
  float g_DistanceBlurExponent : packoffset(c10.z);
  float g_OutFocusNearEnd : packoffset(c10.w);
}

SamplerState g_LinearSampler_s : register(s0);
Texture2D<float4> g_RGBTexture : register(t0);
Texture2D<float> g_LinearZTexture : register(t1);
Texture2D<float4> g_LayerTexture0 : register(t2);
Texture2D<float4> g_LayerTexture1 : register(t3);
Texture2D<float4> g_LayerTexture2 : register(t4);
Texture2D<float4> g_LayerTexture3 : register(t5);
Texture2D<float4> g_LayerTexture4 : register(t6);
Texture2D<float4> g_LayerTexture5 : register(t7);


// 3Dmigoto declarations
#include "./shared.h"

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (int2)v0.xy;
  r0.zw = float2(0,0);
  r1.x = g_LinearZTexture.Load(r0.xyw).x;
  r0.xyz = g_RGBTexture.Load(r0.xyz).xyz;
  	if(injectedData.fxDof == 0) {																		// a simple DoF toggle
	o0.rgb = r0.xyz;
	o0.w = 1;
	return;
	}
  r0.xyz = g_InfocusMultiplier * r0.xyz;
  r1.yz = trunc(v0.xy);
  r1.w = cmp(0 < g_VignetteBlurScale.x);
  r1.w = r1.w ? 1.000000 : 0;
  r1.yz = r1.yz * g_FullPixelSize.xy + float2(-0.5,-0.5);
  r1.yz = g_VignetteBlurScale.xy * r1.yz;
  r1.y = dot(r1.yz, r1.yz);
  r1.y = log2(r1.y);
  r1.y = g_VignetteBlurExponent * r1.y;
  r1.y = exp2(r1.y);
  r1.y = saturate(r1.y * r1.w + g_AddBlur);
  r1.z = cmp(r1.x >= g_OutFocusFarStart);
  if (r1.z != 0) {
    r1.z = -g_OutFocusFarStart + r1.x;
    r1.w = g_OutFocusFarEnd + -g_OutFocusFarStart;
    r1.z = saturate(r1.z / r1.w);
  } else {
    r1.w = cmp(g_OutFocusNearStart >= r1.x);
    if (r1.w != 0) {
      r1.x = -g_OutFocusNearStart + r1.x;
      r1.w = g_OutFocusNearEnd + -g_OutFocusNearStart;
      r1.z = saturate(r1.x / r1.w);
    } else {
      r1.z = 0;
    }
  }
  r1.x = g_MaxExtraBlurSize;
  r1.x = dot(r1.yy, r1.xx);
  r1.x = r1.z * g_MaxFarCoCSize + r1.x;
  r1.yz = g_FullPixelSize.xy * v0.xy;
  r1.w = cmp(1 < r1.x);
  r2.xyzw = g_LayerTexture0.Sample(g_LinearSampler_s, r1.yz).xyzw;											// Artifacts here !!!
  r3.xyzw = g_LayerTexture1.Sample(g_LinearSampler_s, r1.yz).xyzw;
  r4.xyzw = g_LayerTexture2.Sample(g_LinearSampler_s, r1.yz).xyzw;
  if (r1.w != 0) {
    r2.xyzw = r3.xyzw + r2.xyzw;
    r2.xyzw = r2.xyzw + r4.xyzw;
    r1.x = -1 + r1.x;
    r1.x = min(1, r1.x);
    r0.w = 1;
    r2.xyzw = r2.xyzw + -r0.xyzw;                                                                           // and there? but that's basically removing the whole DoF so dunno
    r2.xyzw = r1.xxxx * r2.xyzw + r0.xyzw;
  } else {
    r2.xyz = r0.xyz;
    r2.w = 1;
  }
  r3.xyzw = g_LayerTexture3.Sample(g_LinearSampler_s, r1.yz).xyzw;
  r4.xyzw = g_LayerTexture4.Sample(g_LinearSampler_s, r1.yz).xyzw;
  r1.xyzw = g_LayerTexture5.Sample(g_LinearSampler_s, r1.yz).xyzw;
  r3.xyzw = r4.xyzw + r3.xyzw;
  r1.xyzw = r3.xyzw + r1.xyzw;
  r1.xyzw = r2.xyzw + r1.xyzw;
  r0.w = cmp(9.99999975e-06 < r1.w);
  if (r0.w != 0) {
    r0.xyz = r1.xyz / r1.www;
  }
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}