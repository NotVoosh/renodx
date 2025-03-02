#include "./common.hlsl"

cbuffer cb_g_ColorBalance : register(b5){
  struct
  {
    float4 m_PreLutScale;
    float4 m_PreLutOffset;
    float4 m_DepthControl;
  } g_ColorBalance : packoffset(c0);
}
SamplerState s_PointClamp_s : register(s10);
SamplerState s_TrilinearClamp_s : register(s12);
Texture2D<float4> t_FrameBuffer : register(t0);
Texture3D<float4> t_ColorBalance3DTexture : register(t1);

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t_FrameBuffer.Sample(s_PointClamp_s, v1.xy).xyz;
  float3 linearInput = renodx::color::srgb::DecodeSafe(r0.rgb);
  //r0.xyz = r0.xyz * g_ColorBalance.m_PreLutScale.xyz + g_ColorBalance.m_PreLutOffset.xyz;
  //r0.xyz = t_ColorBalance3DTexture.Sample(s_TrilinearClamp_s, r0.xyz).xyz;
  renodx::lut::Config lut_config = renodx::lut::config::Create();
  lut_config.lut_sampler = s_TrilinearClamp_s;
  lut_config.strength = 1.f;
  lut_config.scaling = injectedData.colorGradeLUTScaling,
  lut_config.type_input = renodx::lut::config::type::SRGB;
  lut_config.type_output = renodx::lut::config::type::SRGB;
  lut_config.size = 16;
  lut_config.tetrahedral = injectedData.colorGradeLUTSampling != 0.f;
  r0.rgb = Sample(t_ColorBalance3DTexture, lut_config, saturate(linearInput));
  float3 linearOutput = r0.rgb;
  if(injectedData.toneMapType == 1.f && injectedData.colorGradeLUTStrengthB == 0.f){
    r0.rgb = linearInput;
  } else if (injectedData.toneMapType == 0.f) {
    r0.rgb = lerp(linearInput, linearOutput, injectedData.colorGradeLUTStrengthB);
  } else if(injectedData.upgradePerChannel == 1.f || injectedData.upgradePerChannel == 3.f) {
    r0.xyz = UpgradeToneMapPerChannel(linearInput, saturate(linearInput), linearOutput, injectedData.colorGradeLUTStrengthB);
  } else {
    r0.rgb = UpgradeToneMapByLuminance(linearInput, saturate(linearInput), linearOutput, injectedData.colorGradeLUTStrengthB);
  }
  o0.rgb = PostToneMapScale(r0.rgb);
  o0.w = 0;
  return;
}