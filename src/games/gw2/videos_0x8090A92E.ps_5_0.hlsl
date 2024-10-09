// video cutscenes

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sun Sep 22 18:03:18 2024
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[5];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t1.Sample(s1_s, v0.xy).w;
  r0.xyzw = cb0[1].xyzw * r0.xxxx;
  r1.x = t0.Sample(s0_s, v0.xy).w;
  r0.xyzw = r1.xxxx * cb0[4].xyzw + r0.xyzw;
  r1.x = t2.Sample(s2_s, v0.xy).w;
  r0.xyzw = r1.xxxx * cb0[2].xyzw + r0.xyzw;
  r0.xyzw = cb0[3].xyzw + r0.xyzw;
  o0.xyzw = cb0[0].xyzw * r0.xyzw;
  
	o0.rgba = saturate(o0.rgba);
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