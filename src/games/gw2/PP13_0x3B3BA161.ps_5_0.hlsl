#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 24 06:54:39 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[2];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float2 w0 : TEXCOORD1,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v0.xy).xyz;
  r0.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  
       	float3 tintless = r0.rgb;

  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = cb0[1].www * r0.xyz + r0.www;
  
      	r0.rgb = lerp(tintless, r0.rgb, injectedData.colorGradeColorTint);

  r1.xyz = t1.Sample(s1_s, w0.xy).xyz;
  r1.xyz = cb0[0].xyz * r1.xyz * injectedData.fxBloom;			// Bloom
  o0.xyz = r1.xyz * float3(2,2,2) + r0.xyz;
  o0.w = 0;
  
        float3 vanilla = o0.rgb;
		o0.rgb = applyUserTonemap(vanilla, v0.xy);
  return;
}