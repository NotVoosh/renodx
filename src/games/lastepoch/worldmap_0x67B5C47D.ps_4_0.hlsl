#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Sun Sep 29 06:14:06 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[6];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  float2 w2 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = v1.xyzw * r0.xyzw;
  r1.x = cb0[5].x * cb0[5].y + cb0[5].y;
  r2.xyzw = t1.Sample(s1_s, w2.xy).xyzw;
  r1.x = cmp(r2.x < r1.x);
  r1.y = cmp(cb0[5].y >= r2.x);
  r2.w = r1.x ? r0.w : 0;
  r2.xyz = r1.xxx ? cb0[4].xyz : 0;
  r0.xyzw = r1.yyyy ? r0.xyzw : r2.xyzw;
  o0.xyz = r0.xyz * r0.www;
  o0.w = r0.w;
    
         	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
        o0.rgb *= injectedData.toneMapGameNits / 80.f;
        o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
        o0.rgb *= injectedData.toneMapGameNits / 80.f;
        }
  return;
}