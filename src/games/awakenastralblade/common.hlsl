#include "./shared.h"
#include "./DICE.hlsl"

//-----EFFECTS-----//
float3 applyFilmGrain(float3 outputColor, float2 screen, bool colored){
    float3 grainedColor;
      if(colored == true){
    grainedColor = renodx::effects::ApplyFilmGrainColored(
      outputColor,
      screen,
      float3(
          injectedData.random_1,
          injectedData.random_2,
          injectedData.random_3),
      injectedData.fxFilmGrain * 0.01f,
      1.f);
      } else {
    grainedColor = renodx::effects::ApplyFilmGrain(
			outputColor,
			screen,
			frac(injectedData.elapsedTime / 1000.f),
			injectedData.fxFilmGrain * 0.03f,
			1.f);
    }
    return grainedColor;
}

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::correct::GammaSafe(color, true);
    } else {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
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
  	color *= injectedData.toneMapUINits;
  	color /= 80.f;
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
float3 RenoDRTSmoothClamp(float3 untonemapped) {
  renodx::tonemap::renodrt::Config renodrtSC_config = renodx::tonemap::renodrt::config::Create();
  renodrtSC_config.nits_peak = 100.f;
  renodrtSC_config.mid_gray_value = 0.18f;
  renodrtSC_config.mid_gray_nits = 18.f;
  renodrtSC_config.exposure = 1.f;
  renodrtSC_config.highlights = 1.f;
  renodrtSC_config.shadows = 1.f;
  renodrtSC_config.contrast = 1.05f;
  renodrtSC_config.saturation = 1.05f;
  renodrtSC_config.dechroma = 0.f;
  renodrtSC_config.flare = 0.f;
  renodrtSC_config.hue_correction_strength = 0.f;
  renodrtSC_config.hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::OKLAB;
  renodrtSC_config.tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
  renodrtSC_config.hue_correction_type = renodx::tonemap::renodrt::config::hue_correction_type::INPUT;
  renodrtSC_config.working_color_space = 2u;
  renodrtSC_config.per_channel = false;
  float3 renoDRTColor = renodx::tonemap::renodrt::BT709(untonemapped, renodrtSC_config);
  return renoDRTColor;
}

float3 applyFrostbite(float3 color, renodx::tonemap::Config FbConfig){
	float FbPeak = FbConfig.peak_nits / FbConfig.game_nits;
		if(FbConfig.gamma_correction == 1.f){
	FbPeak = renodx::color::correct::Gamma(FbPeak, true);
	}
		float y = renodx::color::y::from::BT709(color * FbConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, FbConfig.exposure, FbConfig.highlights, FbConfig.shadows, FbConfig.contrast);
	color = renodx::tonemap::frostbite::BT709(color, FbPeak);
  
	  if (FbConfig.reno_drt_dechroma != 0.f || FbConfig.saturation != 1.f || FbConfig.hue_correction_strength != 0.f) {
    float3 perceptual_new;

      if (FbConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (FbConfig.hue_correction_strength != 0.f) {
      float3 perceptual_old;

      if (FbConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_old = renodx::color::oklab::from::BT709(FbConfig.hue_correction_color);
      } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_old = renodx::color::ictcp::from::BT709(FbConfig.hue_correction_color);
      } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_old = renodx::color::dtucs::uvY::from::BT709(FbConfig.hue_correction_color).zxy;
      }

      // Save chrominance to apply black
      float chrominance_pre_adjust = distance(perceptual_new.yz, 0);

      perceptual_new.yz = lerp(perceptual_new.yz, perceptual_old.yz, FbConfig.hue_correction_strength);

      float chrominance_post_adjust = distance(perceptual_new.yz, 0);

      // Apply back previous chrominance
      perceptual_new.yz *= renodx::math::DivideSafe(chrominance_pre_adjust, chrominance_post_adjust, 1.f);
    }

    if (FbConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - FbConfig.reno_drt_dechroma))));
    }

    if (FbConfig.reno_drt_blowout != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      // positive = 1 to 0, negative = 1 to 2
      float blowout_strength = 100.f;
      float blowout_change = pow(1.f - percent_max, blowout_strength * abs(FbConfig.reno_drt_blowout));
      if (FbConfig.reno_drt_blowout < 0) {
        blowout_change = (2.f - blowout_change);
      }

      perceptual_new.yz *= blowout_change;
    }

    perceptual_new.yz *= FbConfig.saturation;

    if (FbConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
    color = renodx::color::bt709::clamp::AP1(color);
    return color;
}

float3 applyDICE(float3 color, renodx::tonemap::Config DiceConfig){
	DICESettings DICEconfig = DefaultDICESettings();
	DICEconfig.Type = 3;
	DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
	float DicePaperWhite = DiceConfig.game_nits / 80.f;
	float DicePeak = DiceConfig.peak_nits / 80.f;
		if(DiceConfig.gamma_correction == 1.f){
	DicePaperWhite = renodx::color::correct::Gamma(DicePaperWhite, true);
	DicePeak = renodx::color::correct::Gamma(DicePeak, true);
	}

		float y = renodx::color::y::from::BT709(color * DiceConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, DiceConfig.exposure, DiceConfig.highlights, DiceConfig.shadows, DiceConfig.contrast);
	color = DICETonemap(color * DicePaperWhite, DicePeak, DICEconfig) / DicePaperWhite;

	  if (DiceConfig.reno_drt_dechroma != 0.f || DiceConfig.saturation != 1.f || DiceConfig.hue_correction_strength != 0.f) {
    float3 perceptual_new;

      if (DiceConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (DiceConfig.hue_correction_strength != 0.f) {
      float3 perceptual_old;

      if (DiceConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_old = renodx::color::oklab::from::BT709(DiceConfig.hue_correction_color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_old = renodx::color::ictcp::from::BT709(DiceConfig.hue_correction_color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_old = renodx::color::dtucs::uvY::from::BT709(DiceConfig.hue_correction_color).zxy;
      }

      // Save chrominance to apply black
      float chrominance_pre_adjust = distance(perceptual_new.yz, 0);

      perceptual_new.yz = lerp(perceptual_new.yz, perceptual_old.yz, DiceConfig.hue_correction_strength);

      float chrominance_post_adjust = distance(perceptual_new.yz, 0);

      // Apply back previous chrominance
      perceptual_new.yz *= renodx::math::DivideSafe(chrominance_pre_adjust, chrominance_post_adjust, 1.f);
    }

    if (DiceConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - DiceConfig.reno_drt_dechroma))));
    }

    if (DiceConfig.reno_drt_blowout != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      // positive = 1 to 0, negative = 1 to 2
      float blowout_strength = 100.f;
      float blowout_change = pow(1.f - percent_max, blowout_strength * abs(DiceConfig.reno_drt_blowout));
      if (DiceConfig.reno_drt_blowout < 0) {
        blowout_change = (2.f - blowout_change);
      }

      perceptual_new.yz *= blowout_change;
    }

    perceptual_new.yz *= DiceConfig.saturation;

    if (DiceConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
    color = renodx::color::bt709::clamp::AP1(color);
    return color;
}

float3 applyUserTonemap(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float3 hueCorrectionColor = RenoDRTSmoothClamp(outputColor);
		int hueProcessor;
			if(injectedData.forceHueProcessor == 0.f){
		hueProcessor = abs((int)injectedData.toneMapType - 4);
		} else {
		hueProcessor = (int)injectedData.forceHueProcessor - 1;
		}
		
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
			config.mid_gray_value = 0.19f;
			config.mid_gray_nits = 19.f;
			config.reno_drt_contrast = 1.04f;
			config.reno_drt_saturation = 1.05f;
			config.reno_drt_dechroma = 0.f;
			config.reno_drt_flare = 0.001 * pow(injectedData.colorGradeFlare, 4.32192809489);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.hue_correction_color = hueCorrectionColor;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = hueProcessor;
			config.reno_drt_blowout = injectedData.colorGradeBlowout;

				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if (injectedData.toneMapType == 2.f){	// Frostbite
			outputColor = applyFrostbite(outputColor, config);

			} else if (injectedData.toneMapType == 4.f){		// DICE
			outputColor = applyDICE(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}