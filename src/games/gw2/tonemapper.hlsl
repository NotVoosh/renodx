// Custom tonemapper

#include "./shared.h"

float3 applyFilmGrain(float3 outputColor, float2 screen){
    float3 grainedColor = renodx::effects::ApplyFilmGrain(
			outputColor,
			screen,
			frac(injectedData.elapsedTime / 1000.f),
			injectedData.fxFilmGrain * 0.03f,
			1.f);
		return grainedColor;
}

float3 applyUserTonemap(float3 LUTless, Texture2D lutTexture, SamplerState lutSampler, float3 vanilla, float2 screenXY){
		
		float3 outputColor = renodx::color::srgb::Decode(LUTless);
		float3 hueCorrectionColor = renodx::tonemap::Reinhard(outputColor);
			
				if(injectedData.toneMapType == 0) {
			outputColor = saturate(outputColor);
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
				if (injectedData.toneMapType <= 3){							// Frostbite gets that later
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_saturation = 1.04f;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);
			
			
				if (injectedData.toneMapType == 4){
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
						
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																	  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
					
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
						
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);	
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation,
																0.f, 0.f);
				} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}

			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
				if (injectedData.toneMapGammaCorrection){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
			
	return outputColor;
}

float3 applyUserTonemap(float3 vanilla, float2 screenXY){
		
		float3 outputColor = renodx::color::srgb::Decode(vanilla);
		float3 hueCorrectionColor = renodx::tonemap::Reinhard(outputColor);	
				if(injectedData.toneMapType == 0) {
			outputColor = saturate(outputColor);
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
				if (injectedData.toneMapType <= 3){							// Frostbite gets that later
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_saturation = 1.04f;
						
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			
				if (injectedData.toneMapType == 4){
			config.highlights += 1.4f;
			
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																	  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																		injectedData.colorGradeSaturation,
																		0.f, 0.f);
			}
				
			
			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
				if (injectedData.toneMapGammaCorrection){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
			
	return outputColor;
}