#include "./common.hlsl"

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0){
  float4 cb0[6];
}

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v2.xy).xyzw;
  r0.xyzw = cb0[5].xyzw + r0.xyzw;
  r0.xyzw = v1.xyzw * r0.xyzw;
  //r1.xyz = log2(r0.xyz);
  //r1.xyz = float3(0.416666657,0.416666657,0.416666657) * r1.xyz;
  //r1.xyz = exp2(r1.xyz);
  //r1.xyz = r1.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r2.xyz = float3(12.9200001,12.9200001,12.9200001) * r0.xyz;
  //r0.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r0.xyz);
  o0.w = r0.w;
  //r0.xyz = r0.xyz ? r2.xyz : r1.xyz;
  //r0.xyz = log2(r0.xyz);
  //r0.xyz = cb0[3].xxx * r0.xyz;
  //o0.xyz = exp2(r0.xyz);
		r0.rgb = PostToneMapScale(r0.rgb);
  o0.rgb = r0.rgb;
  return;
}