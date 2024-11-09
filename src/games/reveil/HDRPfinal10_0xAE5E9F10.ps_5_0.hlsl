#include "./shared.h"

Texture2DArray<float4> t2 : register(t2);

Texture2DArray<float4> t1 : register(t1);

Texture2DArray<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[80];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[46].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(-1,-1) + cb1[46].xy;
  r0.zw = cb0[3].zw * r0.zw;
  r0.xy = r0.xy * cb0[3].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(0,0);
  r0.xyzw = t0.Load(r0.xyzw).xyzw;
  //r0.xyzw = saturate(r0.xyzw);
  //r1.xyz = log2(r0.xyz);
  //r1.xyz = float3(0.416666657,0.416666657,0.416666657) * r1.xyz;
  //r1.xyz = exp2(r1.xyz);
  //r1.xyz = r1.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r2.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r0.xyz);
  //r0.xyz = float3(12.9232101,12.9232101,12.9232101) * r0.xyz;
  o0.w = r0.w;
  //r0.xyz = r2.xyz ? r0.xyz : r1.xyz;
    r0.rgb = renodx::color::srgb::EncodeSafe(r0.rgb);
  r1.z = cb0[2].z;
  r2.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r1.xy = cb0[2].xy * r2.xy;
  r2.xy = cb1[48].xy * r2.xy;
  r0.w = t2.SampleBias(s1_s, r1.xyz, cb1[79].y).w;
  r0.w = r0.w * 2 + -1;
  r1.x = 1 + -abs(r0.w);
  r0.w = cmp(r0.w >= 0);
  r0.w = r0.w ? 1 : -1;
  r1.x = sqrt(r1.x);
  r1.x = 1 + -r1.x;
  r0.w = r1.x * r0.w;
  r0.xyz = r0.www * float3(0.00392156886,0.00392156886,0.00392156886) * injectedData.fxNoise + r0.xyz;
  //r1.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  //r1.xyz = float3(0.947867334,0.947867334,0.947867334) * r1.xyz;
  //r1.xyz = log2(abs(r1.xyz));
  //r1.xyz = float3(2.4000001,2.4000001,2.4000001) * r1.xyz;
  //r1.xyz = exp2(r1.xyz);
  //r3.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  //r0.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r0.xyz);
  //r0.xyz = r0.xyz ? r3.xyz : r1.xyz;
    r0.rgb = renodx::color::srgb::DecodeSafe(r0.rgb);
  r2.z = 0;
  r1.xyzw = t1.SampleLevel(s0_s, r2.xyz, 0).xyzw;
  o0.xyz = r1.www * r0.xyz + r1.xyz;
		  	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
    o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        }
  return;
}