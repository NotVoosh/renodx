#include "../tonemap.hlsl"

Texture3D<float4> t2 : register(t2);
Texture3D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[3];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  o0.w = r0.w;
  float3 preCG = r0.xyz;
  float3 sdrColor = lerp(preCG, renodx::tonemap::renodrt::NeutralSDR(preCG), saturate(renodx::tonemap::renodrt::NeutralSDR(preCG)));
  if(injectedData.toneMapType != 0.f){
    r0.xyz = sdrColor;
  }
  renodx::lut::Config lut_config1 = renodx::lut::config::Create();
  lut_config1.lut_sampler = s1_s;
  lut_config1.scaling = injectedData.colorGradeUserLUTScaling;
  lut_config1.type_input = renodx::lut::config::type::GAMMA_2_0;
  lut_config1.type_output = renodx::lut::config::type::GAMMA_2_0;
  lut_config1.tetrahedral = injectedData.colorGradeLUTSampling != 0.f;
  lut_config1.recolor = 1.f;
  renodx::lut::Config lut_config2 = renodx::lut::config::Create();
  lut_config2.lut_sampler = s2_s;
  lut_config2.scaling = injectedData.colorGradeUserLUTScaling;
  lut_config2.type_input = renodx::lut::config::type::GAMMA_2_0;
  lut_config2.type_output = renodx::lut::config::type::GAMMA_2_0;
  lut_config2.tetrahedral = injectedData.colorGradeLUTSampling != 0.f;
  lut_config2.recolor = 1.f;
  /*r0.xyz = sqrt(r0.xyz);
  r1.xyzw = t2.Sample(s2_s, r0.xyz).xyzw;
  r2.xyzw = t1.Sample(s1_s, r0.xyz).xyzw;*/
  r1.xyz = renodx::lut::Sample(r0.xyz, lut_config2, t2);
  r2.xyz = renodx::lut::Sample(r0.xyz, lut_config1, t1);
  r1.xyz = renodx::math::SignSqrt(r1.xyz);
  r2.xyz = renodx::math::SignSqrt(r2.xyz);
  r1.xyz = -r2.xyz + r1.xyz;
  r1.xyz = cb0[2].xxx * r1.xyz + r2.xyz;
  if(injectedData.toneMapType != 0.f){
    r1.xyz = renodx::math::SignPow(r1.xyz, 2.f);
    r0.xyz = renodx::tonemap::UpgradeToneMap(preCG, sdrColor, r1.xyz, injectedData.colorGradeUserLUTStrength);
    r1.xyz = renodx::math::SignSqrt(r1.xyz);
  }
  /*r1.xyz = r1.xyz + -r0.xyz;
  r0.xyz = cb0[2].yyy * r1.xyz + r0.xyz;*/
  r1.xyz = r1.xyz + -renodx::math::SignSqrt(preCG);
  r0.xyz = cb0[2].yyy * r1.xyz + renodx::math::SignSqrt(preCG);
  r0.xyz = renodx::math::SignPow(r0.xyz, 2.f);
  /*if(injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)){
    r0.xyz = applyUserNoTonemap(r0.xyz);
  }*/
  if (injectedData.countOld == injectedData.countNew) {
  r0.xyz = PostToneMapScale(r0.xyz);
  }
  o0.xyz = r0.xyz;
  return;
}