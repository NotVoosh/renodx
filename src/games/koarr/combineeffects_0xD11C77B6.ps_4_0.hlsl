#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Sat Oct  5 03:53:45 2024

cbuffer g_constantsbuffer : register(b0)
{

  struct
  {
    float4 rawUVadjust;
    float4 transitionAmounts;
    float1 bloomStrength;
    float _pad1;
    float _pad2;
    float _pad3;
  } g_constants : packoffset(c0);

}

SamplerState g_correctionSampler_sampler_s : register(s0);
SamplerState g_colorSampler_sampler_s : register(s1);
SamplerState g_dofMotionBlurSampler_sampler_s : register(s2);
SamplerState g_bloomSampler_sampler_s : register(s3);
Texture2D<float4> g_correctionSampler_texture : register(t0);
Texture2D<float4> g_colorSampler_texture : register(t1);
Texture2D<float4> g_dofMotionBlurSampler_texture : register(t2);
Texture2D<float4> g_bloomSampler_texture : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = g_bloomSampler_texture.Sample(g_bloomSampler_sampler_s, v1.xy).xyzw;
  r0.xyz = g_constants.bloomStrength * r0.xyz * injectedData.fxBloom;
  r1.xyzw = g_dofMotionBlurSampler_texture.Sample(g_dofMotionBlurSampler_sampler_s, v1.xy).xyzw;
  r0.xyz = r1.xyz * r1.www + r0.xyz;
  r0.w = 1 + -r1.w;
  r1.xyzw = g_colorSampler_texture.Sample(g_colorSampler_sampler_s, v1.xy).xyzw;
  //r0.xyz = saturate(r1.xyz * r0.www + r0.xyz);
    r0.xyz = r1.xyz * r0.www + r0.xyz;
    
        float3 preLUT = r0.rgb;
    r0.rgb = float3(0.18f,0.18f,0.18f);
  r0.xyz = saturate(r0.xyz * g_constants.rawUVadjust.xyy + g_constants.rawUVadjust.zww);
  r0.zw = r0.zz * g_constants.transitionAmounts.zz + float2(-0.5,0.5);
  r1.xy = floor(r0.zw);
  r0.z = frac(r0.z);
  r1.xy = g_constants.transitionAmounts.ww * r1.xy;
  r1.z = 0;
  r1.xyzw = r1.xzyz + r0.xyxy;
  r2.xyzw = g_correctionSampler_texture.Sample(g_correctionSampler_sampler_s, r1.zw).xyzw;
  r1.xyzw = g_correctionSampler_texture.Sample(g_correctionSampler_sampler_s, r1.xy).xyzw;
  r0.xyw = r2.xyz + -r1.xyz;
  r0.xyz = r0.zzz * r0.xyw + r1.xyz;
    float vanillaGray = renodx::color::y::from::BT709(r0.rgb);
    r0.rgb = applyUserTonemap(preLUT, g_correctionSampler_texture, g_correctionSampler_sampler_s, vanillaGray, v1.xy);
    
  o0.w = dot(r0.xyz, float3(0.298999995,0.587000012,0.114));
  o0.xyz = r0.xyz;    
  return;
}