#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 03:03:01 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  //r0.xyzw = cb0[0].xxxx * r0.xyzw;					// in-game "Gamma" (brightness) setting
  o0.xyzw = r0.xyzw;
			if(injectedData.toneMapType == 0.f){
		o0.rgb = saturate(o0.rgb);
		}
			
		o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::DecodeSafe(o0.rgb)
													 : renodx::color::srgb::DecodeSafe(o0.rgb);
		
	o0.rgb *= injectedData.toneMapUINits;
	
		if(injectedData.toneMapType > 1){							// if not "untonemapped"
	float y_max = injectedData.toneMapPeakNits;
	float y = renodx::color::y::from::BT709(abs(o0.rgb));
			if (y > y_max) {
		o0.rgb *= y_max / y;
		}
	}
    o0.rgb /= 80.f;
  return;
}