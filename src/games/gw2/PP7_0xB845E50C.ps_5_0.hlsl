#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Fri Aug 23 08:45:51 2024
Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[8];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float2 w0 : TEXCOORD1,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r1.xyz = t1.Sample(s1_s, w0.xy).xyz;
  r1.w = dot(r0.xyz, float3(0.333333313,0.333333313,0.333333313));
  r2.xyz = r0.xyz / r1.www;
  r2.xyz = -cb0[5].xyz + r2.xyz;
  r1.w = dot(abs(r2.xyz), float3(0.333333313,0.333333313,0.333333313));
  r1.w = min(1, r1.w);
  r1.w = 1 + -r1.w;
  r1.w = r1.w * 0.999989986 + 9.99999975e-06;
  r1.w = log2(r1.w);
  r1.w = cb0[5].w * r1.w;
  r1.w = exp2(r1.w);
  r1.w = cb0[6].w * r1.w;
  r2.x = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  r2.xyz = cb0[6].xyz * r2.xxx + -r0.xyz;
  r0.xyz = r1.www * r2.xyz * injectedData.colorGradeColorTint + r0.xyz;     // Color Tint
  r0.xyz = float3(1,1,1) + -r0.xyz;
  r1.xyz = cb0[0].xyz * r1.xyz * injectedData.fxBloom;				        // Bloom
  r1.xyz = -r1.xyz * float3(2,2,2) + float3(1,1,1);
    
   		r1.rgb = max(0, r1.rgb);				// highlight color fix

  r0.xyz = -r0.xyz * r1.xyz + float3(1,1,1);
  r0.w = r0.w * 2 + -1;
  r1.x = cmp(r0.w < -0.00999999978);
  if (r1.x != 0) {
    r1.xyz = cb0[4].xyz * r0.xyz;
  } else {
    r0.w = cmp(0.00999999978 < r0.w);
    if (r0.w != 0) {
      r1.xyz = cb0[2].xyz * r0.xyz;
    } else {
      r0.w = 1.20000005 * cb0[7].z;
      r2.z = cb0[7].x * r0.w;
      r2.xy = cb0[7].xy * r0.ww + v0.xy;
      r1.w = t0.Sample(s0_s, r2.xy).w;
      r2.w = cb0[7].y * -r0.w;
      r2.xy = v0.xy + r2.zw;
      r2.x = t0.Sample(s0_s, r2.xy).w;
      r1.w = r2.x + r1.w;
      r2.xzw = cb0[7].xxy * -r0.www;
      r2.y = cb0[7].y * r0.w;
      r2.xyzw = v0.xyxy + r2.xyzw;
      r0.w = t0.Sample(s0_s, r2.xy).w;
      r0.w = r1.w + r0.w;
      r1.w = t0.Sample(s0_s, r2.zw).w;
      r0.w = r1.w + r0.w;
      r1.w = cmp(r0.w < 1.96000004);
      r2.xyz = cb0[3].xyz + -r0.xyz;
      r2.xyz = cb0[3].www * r2.xyz + r0.xyz;
      r0.w = cmp(2.03999996 < r0.w);
      r3.xyz = cb0[1].xyz + -r0.xyz;
      r3.xyz = cb0[1].www * r3.xyz + r0.xyz;
      r0.xyz = r0.www ? r3.xyz : r0.xyz;
      r1.xyz = r1.www ? r2.xyz : r0.xyz;
    }
  }
  o0.xyz = r1.xyz;
  o0.w = 0;
  
  		float3 vanilla = o0.rgb;
		o0.rgb = applyUserTonemap(vanilla, v0.xy);
  return;
}