// Other GW2 addons: Delta, ArcDPS...

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:13:38 2024

SamplerState sampler0_s : register(s0);
Texture2D<float4> texture0 : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = texture0.Sample(sampler0_s, v2.xy).xyzw;
  o0.xyzw = v1.xyzw * r0.xyzw;
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(o0.rgb)
												 : renodx::color::srgb::Decode(o0.rgb);
	o0.w = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Encode(o0.w)
											   : renodx::color::srgb::Encode(o0.w);						// dunno, this kinda works.
	o0.rgb *= injectedData.toneMapAddonNits / 80.f;
  return;
}