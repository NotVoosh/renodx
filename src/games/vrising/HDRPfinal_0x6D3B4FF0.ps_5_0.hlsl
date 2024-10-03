#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Sun Jul 21 04:53:53 2024
Texture2DArray<float4> t1 : register(t1);

Texture2DArray<float4> t0 : register(t0);

cbuffer cb1 : register(b1)
{
  float4 cb1[49];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[9];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[48].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(-1,-1) + cb1[48].xy;
  r0.zw = cb0[6].zw * r0.zw;
  r0.xy = r0.xy * cb0[6].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(0,0);
  r1.xyz = t0.Load(r0.xyww).xyz;		
  r0.x = t1.Load(r0.xyzw).x;
  //r0.yzw = log2(abs(r1.xyz));													//
  //r0.yzw = float3(0.416666657,0.416666657,0.416666657) * r0.yzw;				// pow(r1.xyz, 1 / 2.4f)
  //r0.yzw = exp2(r0.yzw);														//
  //r0.yzw = r0.yzw * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r2.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r1.xyz);
  //r1.xyz = float3(12.9232101,12.9232101,12.9232101) * r1.xyz;
  //r0.yzw = r2.xyz ? r1.xyz : r0.yzw;
  //r0.yzw = log2(r0.yzw);														//
  //r0.yzw = cb0[8].yyy * r0.yzw;												// pow(r0.yzw, cb0[8].y) => 2.2
  //o0.xyz = exp2(r0.yzw);														//
		o0.rgb = applyFilmGrain(r1.rgb, v1.xy);
		  	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
            } else {
        o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        }
  r0.y = cmp(cb0[8].x == 1.000000);
  o0.w = r0.y ? r0.x : 1;
  return;
}