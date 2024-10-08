#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Wed Aug 21 20:34:01 2024
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
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

  r0.xyz = t1.Sample(s1_s, w0.xy).xyz;
  r0.xyz = cb0[0].xyz * r0.xyz * injectedData.fxBloom;						// Bloom
  r1.xyz = t0.Sample(s0_s, v0.xy).xyz;
		if(injectedData.toneMapType == 0){
  r0.xyz = -r0.xyz * float3(2,2,2) + float3(1,1,1);
  r1.xyz = float3(1,1,1) + -r1.xyz;
  r0.xyz = saturate(-r1.xyz * r0.xyz + float3(1,1,1));
	} else {
    r0.rgb = r1.rgb + r0.rgb * float3(2,2,2);
  }
		float3 LUTless = r0.rgb;
		
  r0.x = r0.x * 0.05859375 + 0.001953125;
  r1.zw = float2(0.9375,15) * r0.yz;
  r0.y = floor(r1.w);
  r1.x = r0.y * 0.0625 + r0.x;
  r0.xyzw = float4(0.0625,0.03125,0,0.03125) + r1.xzxz;
  r1.x = frac(r1.w);
  r1.yzw = t2.Sample(s2_s, r0.xy).xyz;
  r0.xyz = t2.Sample(s2_s, r0.zw).xyz;
  r1.yzw = r1.yzw + -r0.xyz;
  o0.xyz = r1.xxx * r1.yzw + r0.xyz;
  o0.w = 0;
  
		float3 vanilla = o0.rgb;
		o0.rgb = applyUserTonemap(LUTless, t2, s2_s, vanilla, v0.xy);
  return;
}