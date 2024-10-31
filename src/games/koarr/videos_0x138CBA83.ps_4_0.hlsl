#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sat Oct  5 03:53:34 2024

SamplerState g_tex0_sampler_s : register(s0);
SamplerState g_tex1_sampler_s : register(s1);
SamplerState g_tex2_sampler_s : register(s2);
Texture2D<float4> g_tex0_texture : register(t0);
Texture2D<float4> g_tex1_texture : register(t1);
Texture2D<float4> g_tex2_texture : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float3 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = g_tex2_texture.Sample(g_tex2_sampler_s, v1.xy).xyzw;
  r0.xyz = float3(0,-0.391448975,2.01782227) * r0.www;
  r1.xyzw = g_tex1_texture.Sample(g_tex1_sampler_s, v1.xy).xyzw;
  r0.xyz = r1.www * float3(1.59579468,-0.813476563,0) + r0.xyz;
  r1.xyzw = g_tex0_texture.Sample(g_tex0_sampler_s, v1.xy).xyzw;
  r0.xyz = r1.www * float3(1.16412354,1.16412354,1.16412354) + r0.xyz;
  r0.xyz = float3(-0.87065506,0.529705048,-1.08166885) + r0.xyz;
  //r0.xyz = saturate(v2.xyz * r0.xyz);
    r0.xyz = v2.xyz * r0.xyz;
  //r0.xyz = log2(r0.xyz);
  //r0.xyz = v1.zzz * r0.xyz;		// game brightness
  //o0.xyz = exp2(r0.xyz);
    o0.xyz = r0.xyz;
  o0.w = v2.w;
    
	o0 = saturate(o0);
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(o0.rgb)
												 : renodx::color::srgb::Decode(o0.rgb);
		float videoPeak = injectedData.toneMapPeakNits / (injectedData.toneMapGameNits / 203.f);
	o0.rgb = renodx::tonemap::inverse::bt2446a::BT709(o0.rgb, 100.f, videoPeak);
	o0.rgb *= injectedData.toneMapPeakNits / videoPeak;
	o0.rgb /= injectedData.toneMapUINits;
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(o0.rgb)
												 : renodx::color::srgb::EncodeSafe(o0.rgb);
  return;
}