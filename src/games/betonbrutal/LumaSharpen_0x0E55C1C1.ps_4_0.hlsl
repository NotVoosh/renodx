#include "./shared.h"
#include "./tonemapper.hlsl"

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[7];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(1,1) / cb1[6].xy;
  r0.z = 0;
  r1.xyzw = v0.xyxy + -r0.zyxz;
  r0.xyzw = v0.xyxy + r0.zyxz;
  r2.xyzw = t0.Sample(s0_s, r1.xy).xyzw;
  r1.xyzw = t0.Sample(s0_s, r1.zw).xyzw;
  //r1.x = dot(r1.xyz, float3(0.298999995,0.587000012,0.114));
    r1.x = dot(abs(r1.xyz), float3(0.298999995,0.587000012,0.114));
  //r1.y = dot(r2.xyz, float3(0.298999995,0.587000012,0.114));
    r1.y = dot(abs(r2.xyz), float3(0.298999995,0.587000012,0.114));
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  //r0.x = dot(r0.xyz, float3(0.298999995,0.587000012,0.114));
    r0.x = dot(abs(r0.xyz), float3(0.298999995,0.587000012,0.114));
  //r0.y = dot(r2.xyz, float3(0.298999995,0.587000012,0.114));
    r0.y = dot(abs(r2.xyz), float3(0.298999995,0.587000012,0.114));
  r2.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  //r0.z = dot(r2.xyz, float3(0.298999995,0.587000012,0.114));
    r0.z = dot(abs(r2.xyz), float3(0.298999995,0.587000012,0.114));
  r0.y = r0.z * 5 + -r0.y;
  r0.zw = r2.zx + -r0.zz;
  r0.y = r0.y + -r1.y;
  r0.x = r0.y + -r0.x;
  r0.x = r0.x + -r1.x;
  r1.x = r0.w * 0.99999994 + r0.x;
  r1.z = r0.x + r0.z;
  r0.y = 0.509369671 * r1.x;
  r0.x = r0.x * 1.70357752 + -r0.y;
  r1.y = -r1.z * 0.194207832 + r0.x;
  r1.w = 1;
  r0.xyzw = r1.xyzw + -r2.xyzw;
  o0.xyzw = cb0[2].xxxx * r0.xyzw * injectedData.fxLumaSharpen + r2.xyzw;
      if(injectedData.fxFilmGrainType == 1.f){
    o0.rgb = applyFilmGrain(o0.rgb, v0);
    }
		  	if(injectedData.toneMapGammaCorrection == 1.f) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
    o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        }
  return;
}