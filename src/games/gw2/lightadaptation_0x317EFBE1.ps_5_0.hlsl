#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:12:39 2024
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
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(1,0) + v0.xy;
  r0.x = dot(r0.xy, float2(0.0671105608,0.00583714992));
  r0.x = frac(r0.x);
  r0.x = 52.9829178 * r0.x;
  r0.x = frac(r0.x);
  r0.y = max(9.99999975e-06, cb0[1].x);
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  
		float3 preLA = r1.rgb;
		
  //r1.xyz = r1.xyz * r1.xyz;
	r1.rgb = sign(r1.rgb) * pow(abs(r1.rgb), 2);
  //o0.w = saturate(r1.w);
	o0.w = r1.w;
  r0.z = dot(float3(0.212599993,0.715200007,0.0722000003), r1.xyz);
  //r0.w = log2(r0.z);
  //r0.y = r0.y * r0.w;
  //r0.y = exp2(r0.y);
	r0.y = sign(r0.z) * pow(abs(r0.z), r0.y);
  r0.y = cb0[0].x * r0.y;
  r0.w = 4 * r0.z;
  r0.w = r0.w * r0.w;
  r0.w = 0.166666672 * r0.w;
  r0.w = min(r0.w, r0.z);
  r2.xyz = t1.Sample(s1_s, float2(0,0)).yzw;
  r0.w = r2.y * r0.w;
  r0.y = r0.y * r2.x + r0.w;
  //r2.y = saturate(r0.z * r2.z + r0.y);
	r2.y = r0.z * r2.z + r0.y;		
  r0.y = dot(float3(0.0193000007,0.119199999,0.950500011), r1.xyz);
  r0.w = dot(float3(0.412400007,0.357600003,0.180500001), r1.xyz);
  r1.x = r0.w + r0.z;
  r0.y = r1.x + r0.y;
  r0.xy = float2(-0.5,9.99999975e-06) + r0.xy;
  r0.z = r0.z / r0.y;
  r0.y = r0.w / r0.y;
  r0.w = 9.99999975e-06 + r0.z;
  r0.w = r2.y / r0.w;
  r1.x = 1 + -r0.y;
  r2.x = r0.y * r0.w;
  r0.y = r1.x + -r0.z;
  r2.z = r0.y * r0.w;
  r0.y = dot(float3(3.24049997,-1.53709996,-0.49849999), r2.xyz);
  //r1.x = sqrt(r0.y);
	r1.x = sign(r0.y) * sqrt(abs(r0.y));
  r0.y = dot(float3(-0.969299972,1.87600005,0.0416000001), r2.xyz);
  r0.z = dot(float3(0.0555999987,-0.203999996,1.05719995), r2.xyz);
  //r1.yz = sqrt(r0.yz);
	r1.yz = sign(r0.yz) * sqrt(abs(r0.yz));
  //o0.xyz = saturate(r0.xxx * float3(0.00392156886,0.00392156886,0.00392156886) + r1.xyz);
	o0.xyz = r0.xxx * float3(0.00392156886,0.00392156886,0.00392156886) + r1.xyz;
	
		o0.rgb = lerp(preLA, o0.rgb, injectedData.fxLightAdaptation);
		o0.rgb = max(0, o0.rgb);			// clear NaNs from Depth Blur
  return;
}