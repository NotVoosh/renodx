// Title Menu background video. also other pre-rendered cutscenes

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 01:56:03 2024

SamplerState yTextureSampler_s : register(s0);
SamplerState crTextureSampler_s : register(s1);
SamplerState cbTextureSampler_s : register(s2);
Texture2D<float4> yTexture : register(t0);
Texture2D<float4> crTexture : register(t1);
Texture2D<float4> cbTexture : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float2 v2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.w = 1;
  r1.y = crTexture.Sample(crTextureSampler_s, v2.xy).x;
  r1.z = cbTexture.Sample(cbTextureSampler_s, v2.xy).x;
  r1.x = yTexture.Sample(yTextureSampler_s, v2.xy).x;
  r1.w = 1;
  r0.y = dot(r1.xyzw, float4(1.16412354,-0.813476563,-0.391448975,0.529705048));
  r0.x = dot(r1.xyw, float3(1.16412354,1.59579468,-0.87065506));
  r0.z = dot(r1.xzw, float3(1.16412354,2.01782227,-1.08166885));   
  o0.xyzw = v1.xyzw * r0.xyzw;
  
  	o0.rgba = saturate(r0.rgba);									// clean invalid colors
    o0.rgba = injectedData.toneMapGammaCorrection ? pow(o0.rgba, 2.2f)
												 : renodx::color::bt709::from::SRGBA(o0.rgba);
		float videoPeak = injectedData.toneMapPeakNits / (injectedData.toneMapGameNits / 203.f);
	o0.rgb = renodx::tonemap::inverse::bt2446a::BT709(o0.rgb, 100.f, videoPeak);
	o0.rgb *= injectedData.toneMapPeakNits / videoPeak;
	o0.rgb /= injectedData.toneMapUINits;
    o0.rgb = sign(o0.rgb) * pow(abs(o0.rgb), 1 / 2.2f);
	
  return;
}