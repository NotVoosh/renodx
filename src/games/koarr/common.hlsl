#include "./shared.h"
#include "./DICE.hlsl"

//-----EFFECTS-----//
float3 applyFilmGrain(float3 outputColor, float2 screen)
{
    float3 grainedColor = renodx::effects::ApplyFilmGrain(
			outputColor,
			screen,
			frac(injectedData.elapsedTime / 1000.f),
			injectedData.fxFilmGrain * 0.03f,
			1.f);
    return grainedColor;
}

float3 applyVignette(float3 inputColor, float2 screen, float slider) {
  static float intensity = 1.f;	// internal
  static float roundness = 1.f;	// parameters
  static float light = 0.f;		// for now
  
	float Vintensity = intensity * min(1, slider);	// Slider below 1 to Vintensity
	float Vroundness = roundness * max(1, slider);	// Slider above 1 to Vroundness
	float2 Vcoord = screen - 0.5f;					// get screen center
	Vcoord *= Vintensity;
	float v = dot(Vcoord, Vcoord);
	v = saturate(1 - v);
	v = pow(v, Vroundness);
	float3 output = inputColor * min(1, v + light);
	return output;
}

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
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

float3 FinalizeOutput(float3 color) {
  	if (injectedData.toneMapGammaCorrection == 1.f) {
	color = renodx::color::gamma::DecodeSafe(color);
  } else {
	color = renodx::color::srgb::DecodeSafe(color);
  }
  color *= injectedData.toneMapUINits;
  color /= 80.f;
  return color;
}

float3 videoScale(float3 color) {
  	if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::gamma::Decode(color, 2.2f);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::gamma::Encode(color, 2.2f);
  } else {
    color = renodx::color::srgb::Decode(color);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::srgb::Encode(color);
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
  renodrtSC_config.hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::ICTCP;
  renodrtSC_config.tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
  renodrtSC_config.hue_correction_type = renodx::tonemap::renodrt::config::hue_correction_type::INPUT;
  renodrtSC_config.working_color_space = 2u;
  renodrtSC_config.per_channel = false;
  float3 renoDRTColor = renodx::tonemap::renodrt::BT709(untonemapped, renodrtSC_config);
  return renoDRTColor;
}

float3 applyFrostbite(float3 color, renodx::tonemap::Config FbConfig, bool sdr = false){
	float FbPeak = sdr ? 1.f : FbConfig.peak_nits / FbConfig.game_nits;
		if(FbConfig.gamma_correction == 1.f && sdr == false){
	FbPeak = renodx::color::correct::Gamma(FbPeak, true);
	}
		float y = renodx::color::y::from::BT709(color * FbConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, FbConfig.exposure, FbConfig.highlights, FbConfig.shadows, FbConfig.contrast);
	color = renodx::tonemap::frostbite::BT709(color, FbPeak);
	  if (FbConfig.reno_drt_dechroma != 0.f || FbConfig.saturation != 1.f) {
    float3 perceptual_new;

      if (FbConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }


    if (FbConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - FbConfig.reno_drt_dechroma))));
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

float3 applyDICE(float3 color, renodx::tonemap::Config DiceConfig, bool sdr = false){
	DICESettings DICEconfig = DefaultDICESettings();
	DICEconfig.Type = 3;
	DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
	float DicePaperWhite = DiceConfig.game_nits / 80.f;
	float DicePeak = sdr ? DicePaperWhite : DiceConfig.peak_nits / 80.f;
		if(DiceConfig.gamma_correction == 1.f && sdr == false){
	DicePaperWhite = renodx::color::correct::Gamma(DicePaperWhite, true);
	DicePeak = renodx::color::correct::Gamma(DicePeak, true);
	}

		float y = renodx::color::y::from::BT709(color * DiceConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, DiceConfig.exposure, DiceConfig.highlights, DiceConfig.shadows, DiceConfig.contrast);
	color = DICETonemap(color * DicePaperWhite, DicePeak, DICEconfig) / DicePaperWhite;

	  if (DiceConfig.reno_drt_dechroma != 0.f || DiceConfig.saturation != 1.f) {
    float3 perceptual_new;

      if (DiceConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (DiceConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - DiceConfig.reno_drt_dechroma))));
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

float3 applyUserTonemap(float3 untonemapped, Texture2D lutTexture, SamplerState lutSampler){
		
		float3 outputColor = renodx::color::srgb::DecodeSafe(untonemapped);
			if(injectedData.toneMapType == 0.f){
		outputColor = saturate(outputColor);
			}
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
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.001 * pow(injectedData.colorGradeFlare, 2.3f);
			config.reno_drt_hue_correction_method = hueProcessor;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);

				if(injectedData.toneMapType >= 2.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, hueProcessor);
			}
				if (injectedData.toneMapType == 2.f){			// Frostbite
				float3 sdrColor = applyFrostbite(outputColor, config, true);
			outputColor = applyFrostbite(outputColor, config);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);

			} else if (injectedData.toneMapType == 4.f){		// DICE
				float3 sdrColor = applyDICE(outputColor, config, true);
			outputColor = applyDICE(outputColor, config);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);

			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
			outputColor = renodx::color::bt709::clamp::BT709(outputColor);
	return outputColor;
}