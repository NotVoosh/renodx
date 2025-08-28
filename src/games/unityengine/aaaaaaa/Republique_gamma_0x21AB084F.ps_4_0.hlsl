#include "../tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  /*r1.xyz = log2(r0.xyz);
  r1.xyz = float3(0.416666657,0.416666657,0.416666657) * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r1.xyz = r1.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  r1.xyz = -r0.xyz * float3(12.9200001,12.9200001,12.9200001) + r1.xyz;
  r2.xyz = cmp(r0.xyz >= float3(0.00313080009,0.00313080009,0.00313080009));
  r2.xyz = r2.xyz ? float3(1,1,1) : 0;
  r0.xyz = float3(12.9200001,12.9200001,12.9200001) * r0.xyz;
  o0.xyz = r2.xyz * r1.xyz + r0.xyz;*/
  if (injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)) {
    r0.xyz = applyUserNoTonemap(r0.xyz);
  }
  if (injectedData.countOld == injectedData.countNew) {
    r0.xyz = PostToneMapScale(r0.xyz);
  }
  r0.xyz = renodx::color::srgb::EncodeSafe(r0.xyz);
  o0.xyz = r0.xyz;
  o0.w = saturate(r0.w);
  return;
}