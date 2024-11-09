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
  float4 cb0[5];
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

  r0.z = cb0[2].z;
  r1.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r0.xy = cb0[2].xy * r1.xy;
  r0.x = t2.SampleBias(s1_s, r0.xyz, cb1[79].y).w;
  r0.x = r0.x * 2 + -1;
  r0.y = 1 + -abs(r0.x);
  r0.x = cmp(r0.x >= 0);
  r0.x = r0.x ? 1 : -1;
  r0.y = sqrt(r0.y);
  r0.y = 1 + -r0.y;
  r0.x = r0.x * r0.y;
  r0.yz = cb0[4].xy * r1.xy;
  r1.xy = cb1[48].xy * r1.xy;
  r2.xy = (uint2)r0.yz;
  r2.zw = float2(0,0);
  r2.xyzw = t0.Load(r2.xyzw).xyzw;
  //r2.xyzw = saturate(r2.xyzw);
  //r0.yzw = log2(r2.xyz);
  //r0.yzw = float3(0.416666657,0.416666657,0.416666657) * r0.yzw;
  //r0.yzw = exp2(r0.yzw);
  //r0.yzw = r0.yzw * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r3.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r2.xyz);
  //r2.xyz = float3(12.9232101,12.9232101,12.9232101) * r2.xyz;
  o0.w = r2.w;
  //r0.yzw = r3.xyz ? r2.xyz : r0.yzw;
    r0.gba = renodx::color::srgb::EncodeSafe(r2.rgb);
  r0.xyz = r0.xxx * float3(0.00392156886,0.00392156886,0.00392156886) * injectedData.fxNoise + r0.yzw;
  //r2.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  //r2.xyz = float3(0.947867334,0.947867334,0.947867334) * r2.xyz;
  //r2.xyz = log2(abs(r2.xyz));
  //r2.xyz = float3(2.4000001,2.4000001,2.4000001) * r2.xyz;
  //r2.xyz = exp2(r2.xyz);
  //r3.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  //r0.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r0.xyz);
  //r0.xyz = r0.xyz ? r3.xyz : r2.xyz;
    r0.rgb = renodx::color::srgb::DecodeSafe(r0.rgb);
  r1.z = 0;
  r1.xyzw = t1.SampleLevel(s0_s, r1.xyz, 0).xyzw;
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