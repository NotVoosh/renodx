#include "./shared.h"
#include "./tonemapper.hlsl"

Texture2DArray<float4> t3 : register(t3);

Texture2DArray<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

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

  r0.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r0.zw = r0.xy * cb0[1].xy + cb0[1].zw;
  r0.z = t1.SampleBias(s1_s, r0.zw, cb1[79].y).w;
  r0.z = -0.5 + r0.z;
  r0.z = r0.z + r0.z;
  r1.xy = cb0[4].xy * r0.xy;
  r1.xy = (uint2)r1.xy;
  r1.zw = float2(0,0);
  r1.xyzw = t0.Load(r1.xyzw).xyzw;
  //r1.xyzw = saturate(r1.xyzw);
  r2.xyz = r1.xyz * r0.zzz;
  r2.xyz = cb0[0].xxx * r2.xyz * injectedData.fxFilmGrain;
  r0.z = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  //r0.z = sqrt(r0.z);
    r0.b = sign(r0.b) * sqrt(abs(r0.b));
  r0.z = cb0[0].y * -r0.z + 1;
  r1.xyz = injectedData.fxFilmGrainType ? applyFilmGrain(r1.rgb, v1) : r2.xyz * r0.zzz + r1.xyz;
  o0.w = r1.w;
  //r2.xyz = log2(abs(r1.xyz));
  //r2.xyz = float3(0.416666657,0.416666657,0.416666657) * r2.xyz;
  //r2.xyz = exp2(r2.xyz);
  //r2.xyz = r2.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r3.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r1.xyz);
  //r1.xyz = float3(12.9232101,12.9232101,12.9232101) * r1.xyz;
  //r1.xyz = r3.xyz ? r1.xyz : r2.xyz;
    r1.rgb = renodx::color::srgb::EncodeSafe(r1.rgb);
  r2.xy = cb0[2].xy * r0.xy;
  r0.xy = cb1[48].xy * r0.xy;
  r2.z = cb0[2].z;
  r0.w = t3.SampleBias(s1_s, r2.xyz, cb1[79].y).w;
  r0.w = r0.w * 2 + -1;
  r1.w = 1 + -abs(r0.w);
  r0.w = cmp(r0.w >= 0);
  r0.w = r0.w ? 1 : -1;
  r1.w = sqrt(r1.w);
  r1.w = 1 + -r1.w;
  r0.w = r1.w * r0.w;
  r1.xyz = r0.www * float3(0.00392156886,0.00392156886,0.00392156886) * injectedData.fxNoise + r1.xyz;
  //r2.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r1.xyz;
  //r2.xyz = float3(0.947867334,0.947867334,0.947867334) * r2.xyz;
  //r2.xyz = log2(abs(r2.xyz));
  //r2.xyz = float3(2.4000001,2.4000001,2.4000001) * r2.xyz;
  //r2.xyz = exp2(r2.xyz);
  //r3.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r1.xyz;
  //r1.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r1.xyz);
  //r1.xyz = r1.xyz ? r3.xyz : r2.xyz;
    r1.rgb = renodx::color::srgb::DecodeSafe(r1.rgb);
  r0.z = 0;
  r0.xyzw = t2.SampleLevel(s0_s, r0.xyz, 0).xyzw;
  o0.xyz = r0.www * r1.xyz + r0.xyz;
		  	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
    o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        }
  return;
}