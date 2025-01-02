#include "./shared.h"

//-----EFFECTS-----//
float3 applyFilmGrain(float3 outputColor, float2 screen){
    float3 grainedColor = renodx::effects::ApplyFilmGrain(
			outputColor,
			screen,
			frac(injectedData.elapsedTime / 1000.f),
			injectedData.fxFilmGrain * 0.03f,
			1.f);
    return grainedColor;
}

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
  if (injectedData.toneMapGammaCorrection == 1.f) {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::gamma::EncodeSafe(color, 2.2f);
  } else {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::srgb::EncodeSafe(color);
  }
  return color;
}

float3 FinalizeOutput(float3 color) {
  	if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::gamma::DecodeSafe(color, 2.2f);
  } else {
    color = renodx::color::srgb::DecodeSafe(color);
  }
  	if(injectedData.toneMapType == 0.f){
  color = renodx::color::bt709::clamp::BT709(color);
  }
  color *= injectedData.toneMapUINits;
  color /= 80.f;
  return color;
}

float3 InverseToneMap(float3 color) {
	float scaling = injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
	float videoPeak = scaling * 203.f;
      if(injectedData.toneMapGammaCorrection == 1.f){
    videoPeak = renodx::color::correct::Gamma(videoPeak, true);
    scaling = renodx::color::correct::Gamma(scaling, true);
    }
    color = renodx::color::gamma::Decode(color, 2.4f);
	color = renodx::tonemap::inverse::bt2446a::BT709(color, 100.f, videoPeak);
	color /= videoPeak;
	color *= scaling;
	return color;
}

float3 ITMScale(float3 color) {
  if (injectedData.toneMapGammaCorrection == 1.f) {
	color = renodx::color::srgb::EncodeSafe(color);
    color = renodx::color::gamma::DecodeSafe(color, 2.2f);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::gamma::EncodeSafe(color, 2.2f);
  } else {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::srgb::EncodeSafe(color);
  }
  return color;
}

//-----TONEMAP-----//
float3 applyReinhardPlus(float3 color, renodx::tonemap::Config RhConfig, bool sdr = false){
	float RhPeak = sdr ? 1.f : RhConfig.peak_nits / RhConfig.game_nits;
		if(RhConfig.gamma_correction != 0.f && sdr == false){
	RhPeak = renodx::color::correct::Gamma(RhPeak, RhConfig.gamma_correction > 0.f, abs(RhConfig.gamma_correction) == 1.f ? 2.2f : 2.4f);
	}
	
	color = sdr ? max(0, color) : renodx::color::bt2020::from::BT709(color);
		float y = sdr ? renodx::color::y::from::BT709(color * RhConfig.exposure) : renodx::color::y::from::BT2020(color * RhConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, RhConfig.exposure, RhConfig.highlights, RhConfig.shadows, RhConfig.contrast);
	color = renodx::tonemap::ReinhardScalable(color, RhPeak, 0.f, 0.18f, RhConfig.mid_gray_value);
	color = sdr ? color : renodx::color::bt709::from::BT2020(color);
	  if (RhConfig.reno_drt_dechroma != 0.f || RhConfig.saturation != 1.f || RhConfig.hue_correction_strength != 0.f) {
    float3 perceptual_new;

      if (RhConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (RhConfig.hue_correction_strength != 0.f) {
      float3 perceptual_old;

      if (RhConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_old = renodx::color::oklab::from::BT709(RhConfig.hue_correction_color);
      } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_old = renodx::color::ictcp::from::BT709(RhConfig.hue_correction_color);
      } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_old = renodx::color::dtucs::uvY::from::BT709(RhConfig.hue_correction_color).zxy;
      }

      // Save chrominance to apply black
      float chrominance_pre_adjust = distance(perceptual_new.yz, 0);

      perceptual_new.yz = lerp(perceptual_new.yz, perceptual_old.yz, RhConfig.hue_correction_strength);

      float chrominance_post_adjust = distance(perceptual_new.yz, 0);

      // Apply back previous chrominance
      perceptual_new.yz *= renodx::math::DivideSafe(chrominance_pre_adjust, chrominance_post_adjust, 1.f);
    }

    if (RhConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - RhConfig.reno_drt_dechroma))));
    }

    if (RhConfig.reno_drt_blowout != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      // positive = 1 to 0, negative = 1 to 2
      float blowout_strength = 100.f;
      float blowout_change = pow(1.f - percent_max, blowout_strength * abs(RhConfig.reno_drt_blowout));
      if (RhConfig.reno_drt_blowout < 0) {
        blowout_change = (2.f - blowout_change);
      }

      perceptual_new.yz *= blowout_change;
    }

    perceptual_new.yz *= RhConfig.saturation;

    if (RhConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
    color = renodx::color::bt709::clamp::AP1(color);
    return color;
}


float UpgradeToneMapRatio(float ap1_color_hdr, float ap1_color_sdr, float ap1_post_process_color) {
  if (ap1_color_hdr < ap1_color_sdr) {
    // If substracting (user contrast or paperwhite) scale down instead
    // Should only apply on mismatched HDR
    return ap1_color_hdr / ap1_color_sdr;
  } else {
    float ap1_delta = ap1_color_hdr - ap1_color_sdr;
    ap1_delta = max(0, ap1_delta);  // Cleans up NaN
    const float ap1_new = ap1_post_process_color + ap1_delta;

    const bool ap1_valid = (ap1_post_process_color > 0);  // Cleans up NaN and ignore black
    return ap1_valid ? (ap1_new / ap1_post_process_color) : 0;
  }
}

float3 UpgradeToneMapPerChannel(float3 color_hdr, float3 color_sdr, float3 post_process_color, float post_process_strength) {
  // float ratio = 1.f;

  float3 bt2020_hdr = max(0, renodx::color::bt2020::from::BT709(color_hdr));
  float3 bt2020_sdr = max(0, renodx::color::bt2020::from::BT709(color_sdr));
  float3 bt2020_post_process = max(0, renodx::color::bt2020::from::BT709(post_process_color));

  float3 ratio = float3(
      UpgradeToneMapRatio(bt2020_hdr.r, bt2020_sdr.r, bt2020_post_process.r),
      UpgradeToneMapRatio(bt2020_hdr.g, bt2020_sdr.g, bt2020_post_process.g),
      UpgradeToneMapRatio(bt2020_hdr.b, bt2020_sdr.b, bt2020_post_process.b));

  float3 color_scaled = max(0, bt2020_post_process * ratio);
  color_scaled = renodx::color::bt709::from::BT2020(color_scaled);
  float peak_correction = saturate(1.f - renodx::color::y::from::BT2020(bt2020_post_process));
  color_scaled = renodx::color::correct::Hue(color_scaled, post_process_color, peak_correction);
  return lerp(color_hdr, color_scaled, post_process_strength);
}

float3 UpgradeToneMap(float3 color_hdr, float3 color_sdr, float3 post_process_color, float post_process_strength) {
float ratio = 1.f;

  float3 bt2020_hdr = max(0, renodx::color::bt2020::from::BT709(color_hdr));
  float3 bt2020_sdr = max(0, renodx::color::bt2020::from::BT709(color_sdr));
  float3 bt2020_post_process = max(0, renodx::color::bt2020::from::BT709(post_process_color));
  float y_bt2020_hdr = renodx::color::y::from::BT2020(bt2020_hdr);
  float y_bt2020_sdr = renodx::color::y::from::BT2020(bt2020_sdr);
  float y_bt2020_post_process = renodx::color::y::from::BT2020(bt2020_post_process);

    if (y_bt2020_hdr < y_bt2020_sdr) {
    // If substracting (user contrast or paperwhite) scale down instead
    // Should only apply on mismatched HDR
    ratio = y_bt2020_hdr / y_bt2020_sdr;
  } else {
    float y_bt2020_delta = y_bt2020_hdr - y_bt2020_sdr;
    y_bt2020_delta = max(0, y_bt2020_delta);  // Cleans up NaN
    const float y_bt2020_new = y_bt2020_post_process + y_bt2020_delta;
    const bool y_bt2020_valid = (y_bt2020_post_process > 0);  // Cleans up NaN and ignore black
    ratio = y_bt2020_valid ? (y_bt2020_new / y_bt2020_post_process) : 0;
  }
  float3 color_scaled = max(0, bt2020_post_process * ratio);
  color_scaled = renodx::color::bt709::from::BT2020(color_scaled);
  float peak_correction = saturate(1.f - renodx::color::y::from::BT2020(bt2020_post_process));
  color_scaled = renodx::color::correct::Hue(color_scaled, post_process_color, peak_correction);
  return lerp(color_hdr, color_scaled, post_process_strength);
}

float3 vanillaTonemap(float3 color){
  const float a = 2.51f;
  const float b = 0.03f;
  const float c = 2.43f;
  const float d = 0.59f;
  const float e = 0.14f;
  return clamp((color * (a * color + b)) / (color * (c * color + d) + e), 0.0f, 1.0f);
}
/*
float3 Apply(float3 inputColor, renodx::tonemap::Config tm_config, renodx::lut::Config lut_config, Texture3D lutTexture, bool perChannel){
  if(lut_config.strength == 0.f || tm_config.type == 1.f){
    return renodx::tonemap::config::Apply(inputColor, tm_config);
  } else {
    renodx::tonemap::config::DualToneMap tone_maps = renodx::tonemap::config::ApplyToneMaps(inputColor, tm_config);
    float3 color_hdr = tone_maps.color_hdr;
    float3 color_sdr = tone_maps.color_sdr;

    float previous_lut_config_strength = lut_config.strength;
    lut_config.strength = 1.f;
    float3 color_lut = renodx::lut::Sample(lutTexture, lut_config, color_sdr);
      if(tm_config.type == 0.f){
    return lerp(inputColor, color_lut, previous_lut_config_strength);
    } else if (perChannel == true){
    return UpgradeToneMapPerChannel(color_hdr, color_sdr, color_lut, previous_lut_config_strength);
    } else {
    return UpgradeToneMap(color_hdr, color_sdr, color_lut, previous_lut_config_strength);
    }
  }
}
  
float3 applyUserTonemap(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(vanillaTonemap(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = vanillaTonemap(outputColor);

		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection - 1.f;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
			config.saturation = injectedData.colorGradeSaturation;
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.reno_drt_contrast = 1.f;
			config.reno_drt_dechroma = 0.f;
			config.reno_drt_flare = 0.1f * pow(injectedData.colorGradeFlare, 5.32192809489);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapHueCorrection * (1.f - injectedData.toneMapPerChannel);
			config.hue_correction_color = hueCorrectionColor;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_per_channel = injectedData.toneMapPerChannel != 0;
			config.reno_drt_blowout = injectedData.colorGradeBlowout;
	
				if(injectedData.toneMapType == 0.f){
			outputColor = hueCorrectionColor;
			}
				if (injectedData.toneMapType == 4.f){		// Reinhard+
			config.highlights *= 0.9f;
			config.shadows *= 0.95f;
			config.contrast *= 1.35f;
			config.saturation *= 1.3f;
      config.hue_correction_strength = injectedData.toneMapHueCorrection;
			outputColor = applyReinhardPlus(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}
*/