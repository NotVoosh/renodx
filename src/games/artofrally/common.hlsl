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
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapGameNits / 80.f;
    color = renodx::color::correct::GammaSafe(color, true);
    } else {
    color *= injectedData.toneMapGameNits / 80.f;
    }
  return color;
}

float3 UIScale(float3 color) {
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapUINits / 80.f;
    color = renodx::color::correct::GammaSafe(color, true);
    } else {
	color *= injectedData.toneMapUINits / 80.f;
	}
  	return color;
}

float3 FinalizeOutput(float3 color) {
  	  if(injectedData.toneMapGammaCorrection == 1.f) {
	color = renodx::color::correct::GammaSafe(color);
  	}
      if(injectedData.toneMapType == 0.f){
    color = renodx::color::bt709::clamp::BT709(color);
      }
  	return color;
}

float3 lutShaper(float3 color, bool builder = false){
		if(injectedData.colorGradeLUTSampling == 0.f){
    color = builder ? renodx::color::arri::logc::c1000::Decode(color, false)
					: saturate(renodx::color::arri::logc::c1000::Encode(color, false));
    } else {
    color = builder ? renodx::color::pq::Decode(color, 100.f)
					: renodx::color::pq::Encode(color, 100.f);
    }
return color;
}

//-----TONEMAP-----//
float3 applyReinhardPlus(float3 color, renodx::tonemap::Config RhConfig, bool correct = false){
	float RhPeak = RhConfig.peak_nits / RhConfig.game_nits;
		if(RhConfig.gamma_correction == 1.f){
	RhPeak = renodx::color::correct::Gamma(RhPeak, true);
	}
	float y;
		if(RhConfig.reno_drt_working_color_space == 0u){
	color = max(0, color);
		y = renodx::color::y::from::BT709(color * RhConfig.exposure);

	} else if(RhConfig.reno_drt_working_color_space == 1u){
	color = renodx::color::bt2020::from::BT709(color);
		y = renodx::color::y::from::BT2020(abs(color * RhConfig.exposure));

	} else if(RhConfig.reno_drt_working_color_space == 2u){
	color = renodx::color::ap1::from::BT709(color);
		y = renodx::color::y::from::AP1(color * RhConfig.exposure);
	}

	color = renodx::color::grade::UserColorGrading(color, RhConfig.exposure, RhConfig.highlights, RhConfig.shadows, RhConfig.contrast);
	color = renodx::tonemap::ReinhardScalable(color, RhPeak, 0.f, 0.18f, RhConfig.mid_gray_value);

		if(RhConfig.reno_drt_working_color_space == 1u){
	color = renodx::color::bt709::from::BT2020(color);
	} else if(RhConfig.reno_drt_working_color_space == 2u){
	color = renodx::color::bt709::from::AP1(color);
	}

	  if (RhConfig.reno_drt_dechroma != 0.f || RhConfig.saturation != 1.f || RhConfig.hue_correction_strength != 0.f) {
    float3 perceptual_new;

      if (RhConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (RhConfig.hue_correction_strength != 0.f && correct == true) {
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

float3 applyUserTonemapNeutral(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::unity::BT709(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = renodx::tonemap::unity::BT709(outputColor);

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
			config.reno_drt_dechroma = 0.f;
			config.reno_drt_flare = 0.001f * pow(injectedData.colorGradeFlare, 3.32192809489);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapHueCorrection * (1.f - injectedData.toneMapPerChannel);
			config.hue_correction_color = hueCorrectionColor;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;
			config.reno_drt_per_channel = injectedData.toneMapPerChannel != 0;
			config.reno_drt_blowout = injectedData.colorGradeBlowout;

				if(injectedData.toneMapType == 2.f){		// ACES
			config.contrast *= 0.75f;
			config.saturation *= 0.8f;
			}
				if (injectedData.toneMapType == 4.f){		// Reinhard+
			config.saturation *= 1.1f;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			outputColor = applyReinhardPlus(outputColor, config, true);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}

float3 applyUserTonemapACES(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::ACESFittedAP1(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = renodx::tonemap::ACESFittedAP1(outputColor);

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
			config.reno_drt_contrast = 1.f;
			config.reno_drt_saturation = 1.f;
			config.reno_drt_dechroma = 0.f;
			config.reno_drt_flare = 0.05f * pow(injectedData.colorGradeFlare, 4.32192809489);
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_working_color_space = (uint)injectedData.toneMapColorSpace;
			config.reno_drt_per_channel = injectedData.toneMapPerChannel != 0;
			config.reno_drt_blowout = injectedData.colorGradeBlowout;

				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if (injectedData.toneMapType == 4.f){		// Reinhard+
			config.highlights *= 0.9f;
			config.shadows *= 0.9f;
			config.contrast *= 1.3f;
			config.saturation *= 1.25f;
			outputColor = applyReinhardPlus(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}