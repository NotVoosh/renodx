#include "./common.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0){
  float4 cb0[3];
}

#define cmp -

void main(
  float2 v0 : TEXCOORD0,
  float4 v1 : SV_POSITION0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
    o0.rgb = renodx::color::bt709::clamp::AP1(r0.rgb);
      if(injectedData.fxFilmGrain > 0.f){
    o0.rgb = applyFilmGrain(o0.rgb, v0);
      }
    o0.rgb = PostToneMapScale(o0.rgb);
  o0.w = 1;
  return;
}