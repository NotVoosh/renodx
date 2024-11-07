#include "./shared.h"

float3 applyUserTonemapNeutral(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler){
		
		float3 outputColor = untonemapped;
		float3 vanillaGray = renodx::tonemap::unity::BT709(float3(0.18f,0.18f,0.18f));
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
			config.mid_gray_value = renodx::color::y::from::BT709(vanillaGray);
			config.mid_gray_nits = renodx::color::y::from::BT709(vanillaGray) * 100;
			config.reno_drt_saturation = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.01f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::ARRI_C1000_NO_CUT,
			renodx::lut::config::type::LINEAR,
			33.f);
			
				if (injectedData.toneMapType == 4.f){	// ReinhardScalable
			config.saturation *= 1.2f;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float3 sdrColor = renodx::tonemap::ReinhardScalable(outputColor, 1.f, 0.f, 0.18f, renodx::color::y::from::BT709(vanillaGray));
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::ReinhardScalable(outputColor, reinhardPeak, 0.f, 0.18f, renodx::color::y::from::BT709(vanillaGray));
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma, config.hue_correction_strength, config.hue_correction_color);
				float3 lutColor = min(1.f, renodx::lut::Sample(lutTexture, lut_config, outputColor));
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
	return outputColor;
}

float3 applyUserTonemapACES(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler){
		
		float3 outputColor = untonemapped;
		float3 vanillaGray = renodx::tonemap::ACESFittedAP1(float3(0.18f,0.18f,0.18f));
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
			config.mid_gray_value = renodx::color::y::from::BT709(vanillaGray);
			config.mid_gray_nits = renodx::color::y::from::BT709(vanillaGray) * 100;
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_contrast = 1.15f;
			config.reno_drt_saturation = 1.5f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::ARRI_C1000_NO_CUT,
			renodx::lut::config::type::LINEAR,
			33.f);

				if (injectedData.toneMapType == 4.f){	// ReinhardScalable
			config.contrast *= 1.4f;
			config.saturation *= 1.5f;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float3 sdrColor = renodx::tonemap::ReinhardScalable(outputColor, 1.f, 0.f, 0.18f, renodx::color::y::from::BT709(vanillaGray));
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::ReinhardScalable(outputColor, reinhardPeak, 0.f, 0.18f, renodx::color::y::from::BT709(vanillaGray));
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma, config.hue_correction_strength, config.hue_correction_color);
				float3 lutColor = min(1.f, renodx::lut::Sample(lutTexture, lut_config, outputColor));
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
	return outputColor;
}