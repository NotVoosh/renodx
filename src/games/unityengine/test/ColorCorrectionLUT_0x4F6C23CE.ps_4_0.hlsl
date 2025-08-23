#include "../tonemap.hlsl"

Texture3D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[3];
}

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  float3 preCG = r0.xyz;
  float3 sdrColor = lerp(preCG, renodx::tonemap::renodrt::NeutralSDR(preCG), saturate(renodx::tonemap::renodrt::NeutralSDR(preCG)));
  if(injectedData.toneMapType != 0.f){
    r0.xyz = sdrColor;
  }
  renodx::lut::Config lut_config = renodx::lut::config::Create();
  lut_config.lut_sampler = s1_s;
  lut_config.scaling = injectedData.colorGradeUserLUTScaling;
  lut_config.type_input = renodx::lut::config::type::GAMMA_2_0;
  lut_config.type_output = renodx::lut::config::type::GAMMA_2_0;
  lut_config.size = 1 / (2 * cb0[2].y);
  lut_config.tetrahedral = injectedData.colorGradeLUTSampling != 0.f;
  lut_config.recolor = 1.f;
  //r0.xyz = sqrt(r0.xyz);
  o0.w = r0.w;
  //r0.xyz = r0.xyz * cb0[2].xxx + cb0[2].yyy;
  if(injectedData.toneMapType == 0.f){
    lut_config.strength = injectedData.colorGradeUserLUTStrength;
  } else {
    lut_config.strength = 1.f;
  }
  //r0.xyzw = t1.Sample(s1_s, r0.xyz).xyzw;
  r0.xyz = renodx::lut::Sample(r0.xyz, lut_config, t1);
  if(injectedData.toneMapType != 0.f){
    r0.xyz = renodx::tonemap::UpgradeToneMap(preCG, sdrColor, r0.xyz, injectedData.colorGradeUserLUTStrength);
  }
  if(injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)){
    r0.xyz = applyUserNoTonemap(r0.xyz);
  }
  //o0.xyz = r0.xyz * r0.xyz;
  if (injectedData.countOld == injectedData.countNew) {
  r0.xyz = PostToneMapScale(r0.xyz);
  }
  o0.xyz = r0.xyz;
  return;
}