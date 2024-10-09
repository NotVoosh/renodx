// gw2radial1

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:12:36 2024

cbuffer Wheel : register(b0)
{
  float3 wipeMaskData : packoffset(c0);
  float wheelFadeIn : packoffset(c0.w);
  float animationTimer : packoffset(c1);
  float centerScale : packoffset(c1.y);
  int elementCount : packoffset(c1.z);
  float globalOpacity : packoffset(c1.w);
  float4 hoverFadeIns_[3] : packoffset(c2);
  float timeLeft : packoffset(c5);
  bool showIcon : packoffset(c5.y);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.yx;
  r0.xy = r0.xy + r0.xy;
  r0.z = max(abs(r0.x), abs(r0.y));
  r0.z = 1 / r0.z;
  r0.w = min(abs(r0.x), abs(r0.y));
  r0.z = r0.w * r0.z;
  r0.w = r0.z * r0.z;
  r1.x = r0.w * 0.0208350997 + -0.0851330012;
  r1.x = r0.w * r1.x + 0.180141002;
  r1.x = r0.w * r1.x + -0.330299497;
  r0.w = r0.w * r1.x + 0.999866009;
  r1.x = r0.z * r0.w;
  r1.x = r1.x * -2 + 1.57079637;
  r1.y = cmp(abs(r0.y) < abs(r0.x));
  r1.x = r1.y ? r1.x : 0;
  r0.z = r0.z * r0.w + r1.x;
  r0.w = cmp(r0.y < -r0.y);
  r0.w = r0.w ? -3.141593 : 0;
  r0.z = r0.z + r0.w;
  r0.w = min(r0.x, r0.y);
  r0.w = cmp(r0.w < -r0.w);
  r1.x = max(r0.x, r0.y);
  r0.x = dot(r0.xy, r0.xy);
  r0.x = sqrt(r0.x);
  r1.x = cmp(r1.x >= -r1.x);
  r0.w = r0.w ? r1.x : 0;
  r0.z = r0.w ? -r0.z : r0.z;
  r0.y = r0.z * 0.318310142 + 1;
  r1.yz = -animationTimer * float2(0.5,0.0500000007) + r0.xy;
  r1.xw = float2(0.00100000005,0.00100000005) + r1.zz;
  r0.y = r1.x * 0.5 + r1.y;
  r0.z = frac(r0.y);
  r0.y = floor(r0.y);
  r0.w = frac(r1.x);
  r0.z = cmp(r0.w < r0.z);
  r2.xyz = r0.zzz ? float3(1,0,-0) : float3(0,1,-0.5);
  r1.z = floor(r1.x);
  r1.x = -r1.z * 0.5 + r0.y;
  r0.y = r1.x + r2.x;
  r3.x = r0.y + r2.z;
  r3.y = r1.z + r2.y;
  r3.zw = float2(0,0.5) + r1.xx;
  r0.yzw = float3(0.00999999978,0.00999999978,0.00999999978) * r3.zxw;
  r2.xy = -r3.xy + r1.yw;
  r4.xyz = cmp(r0.yzw >= -r0.yzw);
  r0.yzw = frac(abs(r0.yzw));
  r0.yzw = r4.xyz ? r0.yzw : -r0.yzw;
  r3.xz = float2(0,1) + r1.zz;
  r3.xyz = float3(0.5,0.5,0.5) * r3.xyz;
  r4.xyz = cmp(r3.xyz >= -r3.xyz);
  r3.xyz = frac(abs(r3.xyz));
  r3.xyz = r4.xyz ? r3.xyz : -r3.xyz;
  r0.yzw = r0.yzw * float3(100,100,100) + r3.xyz;
  r4.xyz = r0.yzw * float3(34,34,34) + float3(1,1,1);
  r0.yzw = r4.xyz * r0.yzw;
  r4.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r0.yzw;
  r4.xyz = floor(r4.xyz);
  r0.yzw = -r4.xyz * float3(289,289,289) + r0.yzw;
  r0.yzw = r3.xyz * float3(2,2,2) + r0.yzw;
  r3.xyz = r0.yzw * float3(34,34,34) + float3(1,1,1);
  r0.yzw = r3.xyz * r0.yzw;
  r3.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r0.yzw;
  r3.xyz = floor(r3.xyz);
  r0.yzw = -r3.xyz * float3(289,289,289) + r0.yzw;
  r2.z = 0.159155071 * wipeMaskData.z;
  r0.yzw = r0.yzw * float3(0.024390243,0.024390243,0.024390243) + r2.zzz;
  r0.yzw = frac(r0.yzw);
  r0.yzw = float3(6.28318548,6.28318548,6.28318548) * r0.yzw;
  sincos(r0.w, r3.x, r4.x);
  r4.y = r3.x;
  r2.zw = float2(0.5,1) + r1.xz;
  r1.xz = r1.yw + -r1.xz;
  r1.yw = -r2.zw + r1.yw;
  r3.z = dot(r4.xy, r1.yw);
  r4.z = dot(r1.yw, r1.yw);
  r4.y = dot(r2.xy, r2.xy);
  r4.x = dot(r1.xz, r1.xz);
  r4.xyz = float3(0.800000012,0.800000012,0.800000012) + -r4.xyz;
  r4.xyz = max(float3(0,0,0), r4.xyz);
  r4.xyz = r4.xyz * r4.xyz;
  r4.xyz = r4.xyz * r4.xyz;
  sincos(r0.y, r5.x, r6.x);
  sincos(r0.z, r7.x, r8.x);
  r6.y = r5.x;
  r3.x = dot(r6.xy, r1.xz);
  r8.y = r7.x;
  r3.y = dot(r8.xy, r2.xy);
  r0.y = dot(r4.xyz, r3.xyz);
  r0.y = 11 * r0.y;
  r0.z = -0.200000003 + r0.x;
  r0.x = min(1, r0.x);
  r0.z = saturate(2.49999976 * r0.z);
  r0.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r0.w * r0.z;
  r0.z = r0.z * 0.899999976 + 0.100000001;
  r0.y = -r0.z * r0.y + 1;
  r0.z = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = -r0.z * r0.x + 1;
  r0.x = r0.x * r0.x;
  r0.x = r0.x * r0.x;
  r0.xzw = float3(0.760784328,0.741176486,0.58431375) * r0.xxx;
  r0.xyz = r0.xzw * r0.yyy;
  o0.xyz = globalOpacity * r0.xyz;
  o0.w = 0;
  
    o0.rgb = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(o0.rgb)
												 : renodx::color::srgb::Decode(o0.rgb);
	o0.rgb *= injectedData.toneMapAddonNits / 80.f;
  return;
}