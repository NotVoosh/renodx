#include "./tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  o0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
    if(injectedData.blitCopyHack >= 1.f){
      if(injectedData.gammaSpace == 1.f){
        o0.xyz = renodx::color::srgb::DecodeSafe(o0.xyz);
      }
      if (injectedData.blitCopyHack != 2.f && (injectedData.count2Old == injectedData.count2New)) {
        o0.xyz = applyUserNoTonemap(o0.xyz);
      }
      if(injectedData.gammaSpace == 1.f){
      if(injectedData.countOld == injectedData.countNew) {
        o0.xyz = PostToneMapScale(o0.xyz, true);
      } else {
        o0.xyz = renodx::color::srgb::EncodeSafe(o0.xyz);
      }
    } else if(injectedData.countOld == injectedData.countNew) {
      o0.xyz = PostToneMapScale(o0.xyz);
    }
    }
  return;
}