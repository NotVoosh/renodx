#include "./common.hlsl"

Texture2D<float4> t10 : register(t10);
Texture3D<float4> t9 : register(t9);
Texture3D<float4> t8 : register(t8);
Texture3D<float4> t7 : register(t7);
Texture3D<float4> t6 : register(t6);
struct t5_t {
  float val[9];
};
StructuredBuffer<t5_t> t5 : register(t5);
Texture3D<float4> t4 : register(t4);
Texture3D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s12_s : register(s12);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb5 : register(b5){
  float4 cb5[13];
}
cbuffer cb2 : register(b2){
  float4 cb2[36];
}

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v1.xy).xyz;
  r0.xyz = cb2[35].yyy * r0.xyz;
  r0.a = renodx::color::y::from::BT709(r0.rgb);
  r0.w = 5464 * r0.w;
  r0.w = log2(r0.w);
  r1.x = t5[0].val[20/4];
  r0.w = -r1.x + r0.w;
  r0.w = 5 + r0.w;
  r1.x = saturate(r0.w * 0.0909090936 + 0.0454545468);
  r1.y = 0.5;
  r0.w = t10.Sample(s12_s, r1.xy).x;
  r0.w = cb5[12].x * r0.w;
  r0.w = exp2(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.w = t1.Sample(s1_s, float2(0,0)).x;
  r1.xyzw = t2.Sample(s2_s, v1.xy).xyzw * injectedData.fxBloom;
  //r0.xyz = r0.xyz * lerp(1.f, r0.www, injectedData.fxAutoExposure) + r1.xyz;
  r0.xyz = r0.xyz * r0.www + r1.xyz;
  r0.w = r1.w * cb5[11].x + 1;
  r0.xyz = r0.xyz / r0.www;
  r1.xy = cmp(float2(0,0) != cb5[1].xy);
  r1.zw = float2(-0.5,-0.5) + v1.xy;
  r0.w = dot(r1.zw, r1.zw);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = log2(r0.w);
  r0.w = cb5[1].x * r0.w * injectedData.fxVignette;
  r0.w = exp2(r0.w);
  r2.xyz = r0.xyz * r0.www;
  r0.xyz = r1.xxx ? r2.xyz : r0.xyz;
  // grain (broken decompilation)
  r1.xz = floor(v0.xy);
  r1.xz = (uint2)r1.xz;
  r0.w = (uint)cb5[0].x;
  r1.x = mad((int)r1.x, 0x0019660d, (int)r1.z);
  r0.w = (int)r1.x + (int)r0.w;
  r1.x = (int)r0.w ^ 61;
  r0.w = (uint)r0.w >> 16;
  r0.w = (int)r0.w ^ (int)r1.x;
  r0.w = (int)r0.w * 9;
  r1.x = (uint)r0.w >> 4;
  r0.w = (int)r0.w ^ (int)r1.x;
  r0.w = (int)r0.w * 0x27d4eb2d;
  r1.x = (uint)r0.w >> 15;
  r0.w = (int)r0.w ^ (int)r1.x;
  r0.w = (uint)r0.w;
  r0.w = r0.w * 4.65661287e-10 + -1;
  // r1.xzw = r0.www * cb5[1].yyy + r0.xyz;
  // r0.xyz = r1.yyy ? r1.xzw : r0.xyz;
  r0.rgb = applyFilmGrain(r0.rgb, v1);
  float3 untonemapped = r0.rgb;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r1.xyz = r0.xyz * float3(0.97709924,0.97709924,0.97709924) + float3(1.46564889,1.46564889,1.46564889);
  r0.xyz = r0.xyz / r1.xyz;
  r0.xyz = min(float3(1,1,1), r0.xyz);
  r0.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r0.xyz);
  float3 vanilla = r0.rgb;
    float3 hdrColor;
    float3 sdrColor;
    float3 lutInput;
    float midGray = renodx::color::y::from::BT709(float3(0.10956, 0.10956, 0.10956));
  	renodx::tonemap::Config config = renodx::tonemap::config::Create();
			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
			config.saturation = injectedData.colorGradeSaturation;
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
      config.reno_drt_highlights = 1.f;
      config.reno_drt_shadows = 1.f;
      config.reno_drt_contrast = 1.f;
			config.reno_drt_dechroma = injectedData.colorGradeDechroma;
			config.reno_drt_flare = 0.05f * pow(injectedData.colorGradeFlare, 4.32192809489);
			config.hue_correction_type = injectedData.toneMapPerChannel != 0.f
      ? renodx::tonemap::config::hue_correction_type::INPUT
      : renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapPerChannel != 0.f
      ? (1.f - injectedData.toneMapHueCorrection)
      : injectedData.toneMapHueCorrection;
			config.hue_correction_color = vanilla;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
      config.reno_drt_working_color_space = (uint)injectedData.toneMapPerChannel;
			config.reno_drt_per_channel = injectedData.toneMapPerChannel != 0;
			config.reno_drt_blowout = injectedData.colorGradeBlowout;
        renodx::lut::Config lut_config = renodx::lut::config::Create();
        lut_config.lut_sampler = s3_s;
        lut_config.strength = 1.f;
        lut_config.scaling = injectedData.colorGradeLUTScaling,
        lut_config.type_input = renodx::lut::config::type::GAMMA_2_2;
        lut_config.type_output = renodx::lut::config::type::GAMMA_2_2;
        lut_config.size = 32;
        lut_config.tetrahedral = injectedData.colorGradeLUTSampling != 0.f;
			if(config.type == 0.f){
		r0.rgb = vanilla;
		} else {
    r0.rgb = untonemapped;
    }
      if(injectedData.colorGradeLUTStrength == 0.f || config.type == 1.f){
    r2.rgb = renodx::tonemap::config::Apply(r0.rgb, config);
        if(config.type == 4.f){
    config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
    config.hue_correction_strength = injectedData.toneMapHueCorrection;
    r2.rgb = applyReinhardPlus(r0.rgb, config);
      } 
    } else {
      if(config.type == 4.f){
    config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
    config.hue_correction_strength = injectedData.toneMapHueCorrection;
    hdrColor = applyReinhardPlus(r0.rgb, config);
    sdrColor = applyReinhardPlus(r0.rgb, config, true);
    lutInput = sdrColor;
    } else {
    renodx::tonemap::config::DualToneMap tone_maps = renodx::tonemap::config::ApplyToneMaps(r0.rgb, config);
      hdrColor = tone_maps.color_hdr;
      sdrColor = tone_maps.color_sdr;
      lutInput = sdrColor;
    }
    r0.rbg = renodx::color::gamma::EncodeSafe(lutInput, 2.2f);
  if (cb5[12].y != 0) {
    //r1.xyz = r0.xzy * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
    //r2.xyz = t6.SampleLevel(s3_s, r1.xyz, 0).xyz;
    //r1.xyz = t7.SampleLevel(s3_s, r1.xyz, 0).xyz;
    r2.rgb = Sample(t6, lut_config, lutInput);
    r1.rgb = Sample(t7, lut_config, lutInput);
    //r1.xyz = r1.xyz + -r2.xyz;
    //r1.xyz = cb5[2].zzz * r1.xyz + r2.xyz;
    r1.rgb = lerp(renodx::color::gamma::EncodeSafe(r2.rgb, 2.2f), renodx::color::gamma::EncodeSafe(r1.rgb, 2.2f), cb5[2].z);
    r0.w = cmp(0 < cb5[2].w);
    if (r0.w != 0) {
      //r2.xyz = r1.xyz * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
      //r2.xyz = t9.SampleLevel(s3_s, r2.xyz, 0).xyz;
      r2.rgb = Sample(t9, lut_config, renodx::color::gamma::DecodeSafe(r1.rgb));
      //r2.xyz = r2.xyz + -r1.xyz;
      //r1.xyz = cb5[2].www * r2.xyz + r1.xyz;
      r1.rgb = lerp(r1.rgb, renodx::color::gamma::EncodeSafe(r2.rgb, 2.2f), cb5[2].w);
    }
  } else {
    r1.xyz = r0.xzy;
  }
  if (cb5[12].z != 0) {
    //r2.xyz = r0.xzy * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
    //r2.xyz = t8.SampleLevel(s3_s, r2.xyz, 0).xyz;
    r2.rgb = Sample(t8, lut_config, lutInput);
    if (config.type == 0.f) {
      r2.rgb = lerp(lutInput, r2.rgb, injectedData.colorGradeLUTStrength);
    } else if (injectedData.upgradePerChannel >= 2.f) {
      r2.rgb = UpgradeToneMapPerChannel(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
    } else {
      r2.rgb = UpgradeToneMapByLuminance(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
    }
  } else {
    r0.w = cmp(cb5[2].x == 1.000000);
    if (r0.w != 0) {
      r3.xyz = r0.xzy * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
      if (cb5[12].y != 0) {
        //r4.xyz = t3.SampleLevel(s3_s, r3.xyz, 0).xyz;
        r4.rgb = Sample(t3, lut_config, lutInput);
        //r5.xyz = -r4.xyz + r1.xyz;
        //r2.xyz = cb5[2].yyy * r5.xyz + r4.xyz;
        r2.rgb = lerp(renodx::color::gamma::EncodeSafe(r4.rgb, 2.2f), r1.rgb, cb5[2].y);
        r2.rgb = renodx::color::gamma::DecodeSafe(r2.rgb, 2.2f);
        if (config.type == 0.f) {
          r2.rgb = lerp(lutInput, r2.rgb, injectedData.colorGradeLUTStrength);
        } else if (injectedData.upgradePerChannel >= 2.f) {
          r2.rgb = UpgradeToneMapPerChannel(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        } else {
          r2.rgb = UpgradeToneMapByLuminance(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        }
      } else {
        r4.xyz = r0.xzy * r0.xzy;
        r5.x = r4.x;
        r5.y = r0.x;
        r5.z = 1;
        r0.w = dot(r5.xyz, cb5[3].xyz);
        r1.w = dot(r5.xyz, cb5[4].xyz);
        r5.x = r0.w / r1.w;
        r6.x = r4.y;
        r6.y = r0.z;
        r6.z = 1;
        r0.w = dot(r6.xyz, cb5[5].xyz);
        r1.w = dot(r6.xyz, cb5[6].xyz);
        r5.y = r0.w / r1.w;
        r0.x = r4.z;
        r0.z = 1;
        r0.w = dot(r0.xyz, cb5[7].xyz);
        r1.w = dot(r0.xyz, cb5[8].xyz);
        r5.z = r0.w / r1.w;
        //r3.xyz = t3.SampleLevel(s3_s, r3.xyz, 0).xyz;
        r3.rgb = Sample(t3, lut_config, lutInput);
        //r4.xyz = r5.xyz + -r3.xyz;
        //r2.xyz = cb5[2].yyy * r4.xyz + r3.xyz;
        r2.rgb = lerp(renodx::color::gamma::EncodeSafe(r3.rgb, 2.2f), r5.rgb, cb5[2].y);
        r2.rgb = renodx::color::gamma::DecodeSafe(r2.rgb, 2.2f);
        if (config.type == 0.f) {
          r2.rgb = lerp(lutInput, r2.rgb, injectedData.colorGradeLUTStrength);
        } else if (injectedData.upgradePerChannel >= 2.f) {
          r2.rgb = UpgradeToneMapPerChannel(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        } else {
          r2.rgb = UpgradeToneMapByLuminance(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        }
      }
    } else {
      r0.w = cmp(cb5[2].x == 0.000000);
      if (r0.w != 0) {
        r3.xyz = r0.xzy * r0.xzy;
        r4.x = r3.x;
        r4.y = r0.x;
        r4.z = 1;
        r0.w = dot(r4.xyz, cb5[3].xyz);
        r1.w = dot(r4.xyz, cb5[4].xyz);
        r4.x = r0.w / r1.w;
        r5.x = r3.y;
        r5.y = r0.z;
        r5.z = 1;
        r0.w = dot(r5.xyz, cb5[5].xyz);
        r1.w = dot(r5.xyz, cb5[6].xyz);
        r4.y = r0.w / r1.w;
        r0.x = r3.z;
        r0.z = 1;
        r0.w = dot(r0.xyz, cb5[7].xyz);
        r1.w = dot(r0.xyz, cb5[8].xyz);
        r4.z = r0.w / r1.w;
        r2.xyz = cb5[12].yyy ? r1.xyz : r4.xyz;
        r2.rgb = renodx::color::gamma::DecodeSafe(r2.rgb, 2.2f);
        if (config.type == 0.f) {
          r2.rgb = lerp(lutInput, r2.rgb, injectedData.colorGradeLUTStrength);
        } else if (injectedData.upgradePerChannel >= 2.f) {
          r2.rgb = UpgradeToneMapPerChannel(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        } else {
          r2.rgb = UpgradeToneMapByLuminance(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        }
      } else {
        r0.xyz = cb5[12].yyy ? r1.xyz : r0.xzy;
        r0.rgb = renodx::color::gamma::DecodeSafe(r0.rgb, 2.2f);
        //r0.xyz = r0.xyz * float3(0.96875,0.96875,0.96875) + float3(0.015625,0.015625,0.015625);
        //r1.xyz = t3.SampleLevel(s3_s, r0.xyz, 0).xyz;
        //r0.xyz = t4.SampleLevel(s3_s, r0.xyz, 0).xyz;
        r1.rgb = Sample(t3, lut_config, r0.rgb);
        r0.rgb = Sample(t4, lut_config, r0.rgb);
        //r0.xyz = r0.xyz + -r1.xyz;
        //r2.xyz = cb5[2].yyy * r0.xyz + r1.xyz;
        r2.rgb = lerp(renodx::color::gamma::EncodeSafe(r1.rgb, 2.2f), renodx::color::gamma::EncodeSafe(r0.rgb, 2.2f), cb5[2].y);
        r2.rgb = renodx::color::gamma::DecodeSafe(r2.rgb, 2.2f);
        if (config.type == 0.f) {
          r2.rgb = lerp(lutInput, r2.rgb, injectedData.colorGradeLUTStrength);
        } else if (injectedData.upgradePerChannel >= 2.f) {
          r2.rgb = UpgradeToneMapPerChannel(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        } else {
          r2.rgb = UpgradeToneMapByLuminance(hdrColor, sdrColor, r2.rgb, injectedData.colorGradeLUTStrength);
        } 
      }
    }
  }
    }
  o0.xyz = renodx::color::gamma::EncodeSafe(r2.xyz, 2.2f);
  o0.w = 1;
  return;
}