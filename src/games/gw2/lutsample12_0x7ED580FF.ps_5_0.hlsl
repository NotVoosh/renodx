#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 24 06:12:50 2024
Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[9];
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
  r1.w = dot(r0.xyz, float3(0.212500006,0.715399981,0.0720999986));
  
   		float3 tintless = r0.rgb;

  r2.xyz = -r1.www + r0.xyz;
  r2.xyz = cb0[5].www * r2.xyz + r1.www;
  r2.w = dot(r0.xyz, float3(0.333333313,0.333333313,0.333333313));
  r0.xyz = r0.xyz / r2.www;
  r0.xyz = -cb0[6].xyz + r0.xyz;
  r0.x = dot(abs(r0.xyz), float3(0.333333313,0.333333313,0.333333313));
  r0.x = min(1, r0.x);
  r0.x = 1 + -r0.x;
  r0.x = r0.x * 0.999989986 + 9.99999975e-06;
  r0.x = log2(r0.x);
  r0.x = cb0[6].w * r0.x;
  r0.x = exp2(r0.x);
  r0.x = cb0[7].w * r0.x;
  r3.xyz = cb0[7].xyz * r1.www + -r2.xyz;
  r0.xyz = r0.xxx * r3.xyz + r2.xyz;
    
		r0.rgb = lerp(tintless, r0.rgb, injectedData.colorGradeColorTint);
    
  r1.xyz = cb0[0].xyz * r1.xyz * injectedData.fxBloom;				// Bloom
  r0.xyz = r1.xyz * float3(2,2,2) + r0.xyz;
  r0.w = r0.w * 2 + -1;
  r1.x = cmp(r0.w < -0.00999999978);
  if (r1.x != 0) {
    r1.yzw = cb0[4].xyz * r0.xyz;
  } else {
    r0.w = cmp(0.00999999978 < r0.w);
    if (r0.w != 0) {
      r1.yzw = cb0[2].xyz * r0.xyz;
    } else {
      r0.w = 1.20000005 * cb0[8].z;
      r2.z = cb0[8].x * r0.w;
      r2.xy = cb0[8].xy * r0.ww + v0.xy;
      r1.x = t0.Sample(s0_s, r2.xy).w;
      r2.w = cb0[8].y * -r0.w;
      r2.xy = v0.xy + r2.zw;
      r2.x = t0.Sample(s0_s, r2.xy).w;
      r1.x = r2.x + r1.x;
      r2.xzw = cb0[8].xxy * -r0.www;
      r2.y = cb0[8].y * r0.w;
      r2.xyzw = v0.xyxy + r2.xyzw;
      r0.w = t0.Sample(s0_s, r2.xy).w;
      r0.w = r1.x + r0.w;
      r1.x = t0.Sample(s0_s, r2.zw).w;
      r0.w = r1.x + r0.w;
      r1.x = cmp(r0.w < 1.96000004);
      r2.xyz = cb0[3].xyz + -r0.xyz;
      r2.xyz = cb0[3].www * r2.xyz + r0.xyz;
      r0.w = cmp(2.03999996 < r0.w);
      r3.xyz = cb0[1].xyz + -r0.xyz;
      r3.xyz = cb0[1].www * r3.xyz + r0.xyz;
      r0.xyz = r0.www ? r3.xyz : r0.xyz;
      r1.yzw = r1.xxx ? r2.xyz : r0.xyz;
    }
  }
  //r1.yzw = saturate(r1.yzw);

		float3 LUTless = r1.gba;
		
  r0.zw = float2(0.9375,15) * r1.zw;
  r0.y = r1.y * 0.05859375 + 0.001953125;
  r1.x = floor(r0.w);
  r0.x = r1.x * 0.0625 + r0.y;
  r1.xyzw = float4(0.0625,0.03125,0,0.03125) + r0.xzxz;
  r0.xyz = t2.Sample(s2_s, r1.zw).xyz;
  r1.xyz = t2.Sample(s2_s, r1.xy).xyz;
  r0.w = frac(r0.w);
  r1.xyz = r1.xyz + -r0.xyz;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
  o0.w = 0;
  
      	float3 vanilla = o0.rgb;

		o0.rgb = applyUserTonemap(LUTless, t2, s2_s, vanilla, v0.xy);
  return;
}