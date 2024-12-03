#include "./shared.h"
#include "./DICE.hlsl"

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

float3 applyVignette(float3 color, float2 xy, float intensity){
	xy = xy - 0.5f;
	float v = dot(xy, xy);
	v = saturate(1-v);
	v = pow(v, intensity);
	color *= v.xxx;
	return color;
}

float3 RenoDRTSmoothClamp(float3 untonemapped) {
  renodx::tonemap::renodrt::Config renodrtSC_config = renodx::tonemap::renodrt::config::Create();
  renodrtSC_config.nits_peak = 100.f;
  renodrtSC_config.mid_gray_value = 0.18f;
  renodrtSC_config.mid_gray_nits = 18.f;
  renodrtSC_config.exposure = 1.f;
  renodrtSC_config.highlights = 1.f;
  renodrtSC_config.shadows = 1.f;
  renodrtSC_config.contrast = 1.05f;
  renodrtSC_config.saturation = 1.04f;
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

float3 applyUserTonemap(float3 untonemapped, Texture2D lutTexture, SamplerState lutSampler, float2 screenXY){
		
		float3 outputColor = untonemapped;
				if(injectedData.toneMapType == 0.f) {
			outputColor = saturate(outputColor);
			}
			outputColor = renodx::color::srgb::Decode(outputColor);
		float3 hueCorrectionColor = RenoDRTSmoothClamp(outputColor);
	
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
			config.reno_drt_contrast = 1.1f;
			config.reno_drt_saturation = 1.05f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.005 * injectedData.colorGradeFlare;

				if(injectedData.toneMapType == 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, 1u);
			}
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);
			
				if (injectedData.toneMapType == 2.f){			// Frostbite
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, 1u);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);

			} else if (injectedData.toneMapType == 4.f){		// DICE
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
			DICESettings DICEconfig = DefaultDICESettings();
			DICEconfig.Type = 3;
			DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
				float dicePaperWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapGameNits / 80.f, true)
																		   : injectedData.toneMapGameNits / 80.f;
				float dicePeakWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / 80.f, true)
																		  : injectedData.toneMapPeakNits / 80.f;
				float3 sdrColor = DICETonemap(outputColor * dicePaperWhite, dicePaperWhite, DICEconfig) / dicePaperWhite;
			outputColor = DICETonemap(outputColor * dicePaperWhite, dicePeakWhite, DICEconfig) / dicePaperWhite;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
			
				if (injectedData.fxVignette > 0.f){
			outputColor = applyVignette(outputColor, screenXY, injectedData.fxVignette);
			}
				if (injectedData.fxFilmGrain > 0.f) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
				if(injectedData.toneMapGammaCorrection == 1.f){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
	
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
	return outputColor;
}