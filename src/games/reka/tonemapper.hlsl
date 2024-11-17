#include "./shared.h"

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

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler){

		float3 outputColor = untonemapped;
		float3 midGray = renodx::color::y::from::BT709(renodx::tonemap::uncharted2::BT709(float3(0.18f,0.18f,0.18f), 5.f));
		float3 hueCorrectionColor = renodx::tonemap::uncharted2::BT709(untonemapped, 5.f);
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
			config.reno_drt_contrast = 1.05f;
			config.reno_drt_saturation = 1.15f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.hue_correction_color = hueCorrectionColor;
			config.reno_drt_hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::ICTCP;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::ARRI_C1000_NO_CUT,
			renodx::lut::config::type::LINEAR,
			32.f);

			outputColor = renodx::lut::Sample(lutTexture, lut_config, outputColor);
				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if (injectedData.toneMapType == 4.f){			// Reinhard
			config.saturation *= 1.2f;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.1f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::ReinhardScalable(outputColor, reinhardPeak, 0.f, 0.18f, midGray);
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, 1);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, 1.2f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}