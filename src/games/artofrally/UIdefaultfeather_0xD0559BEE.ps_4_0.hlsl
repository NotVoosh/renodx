#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Mon Oct  7 17:00:31 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = frac(v2.yx);
  r0.zw = float2(4,4) * r0.xy;
  r0.xy = float2(1,1) + -r0.xy;
  r0.xy = r0.zw * r0.xy;
  r0.xy = rsqrt(r0.xy);
  r0.xy = float2(1,1) / r0.xy;
  r0.xy = sqrt(r0.xy);
  r0.xy = r0.xy + r0.xy;
  r0.xy = min(float2(1,1), r0.xy);
  r0.z = min(r0.x, r0.y);
  r0.x = max(r0.x, r0.y);
  r0.x = r0.z * r0.x;
  r1.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r1.xyzw = cb0[3].xyzw + r1.xyzw;
  r1.xyzw = v1.xyzw * r1.xyzw;
  o0.w = r1.w * r0.x;
  o0.xyz = r1.xyz;
         	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
        o0.rgb *= injectedData.toneMapGameNits / 80.f;
        o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
        o0.rgb *= injectedData.toneMapGameNits / 80.f;
        }
  return;
}