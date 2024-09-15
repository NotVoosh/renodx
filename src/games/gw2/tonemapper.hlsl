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
		
		float3 outputColor;
			
				if (injectedData.toneMapType == 0){
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);
			} else {
			outputColor = LUTless;
			}
			outputColor = max(0, renodx::color::bt709::from::SRGB(outputColor));
			
		float3 hueCorrectionColor = sign(LUTless) * pow(abs(LUTless), 2.2f);
			
			renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection - 1;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if (injectedData.toneMapType <= 3){							// Frostbite gets that later
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_saturation = 1.04f;
			config.reno_drt_flare = 0.001f;
			
				if (injectedData.toneMapType == 2) {													// ACES default config
			config.shadows += 0.2;
			config.contrast -= 0.2;
			config.saturation -= 0.17;
			}
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,							// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::GAMMA_2_2,							// not sure
			renodx::lut::config::type::GAMMA_2_2,							//           about this
			16.f);
			
				if(injectedData.toneMapType != 0) {
					if (injectedData.toneMapGammaCorrection == 0) {
				outputColor = renodx::color::correct::GammaSafe(outputColor, true);
				}
						if (injectedData.toneMapType == 4){
					outputColor = renodx::tonemap::config::Apply(outputColor, config);
					outputColor = renodx::tonemap::frostbite::BT709(outputColor, injectedData.toneMapPeakNits / injectedData.toneMapGameNits);
					
						float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, saturate(outputColor));
						
					outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);	
					outputColor = renodx::tonemap::UpgradeToneMap(outputColor, saturate(outputColor), lutColor, injectedData.colorGradeLUTStrength);
					outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																		injectedData.colorGradeSaturation + 0.04,
																		0.f, 0.f);
					} else {
					outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
					}
			}

			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = sign(outputColor) * pow(abs(outputColor), 1 / 2.2f);
			
	return outputColor;
}

float3 applyUserTonemap(float3 vanilla, float2 screenXY){
		
		float3 outputColor = vanilla;
		
			outputColor= max(0, renodx::color::bt709::from::SRGB(outputColor));
			
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
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CLAMPED;
			config.hue_correction_color = sign(vanilla) * pow(abs(vanilla), 2.2f);
			config.hue_correction_strength = min(0.99f, injectedData.toneMapHueCorrection);
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_saturation = 1.04f;
			config.reno_drt_flare = 0.001f;
			
				if (injectedData.toneMapType == 2) {													// ACES default config
			config.shadows += 0.2;
			config.contrast -= 0.2;
			config.saturation -= 0.17;
			}
			
				if (injectedData.toneMapGammaCorrection == 0) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			}
			
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
				if (injectedData.toneMapType == 4){
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, injectedData.toneMapPeakNits / injectedData.toneMapGameNits);
			outputColor = renodx::color::correct::Hue(outputColor, sign(vanilla) * pow(abs(vanilla), 2.2f), injectedData.toneMapHueCorrection);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																		injectedData.colorGradeSaturation + 0.04,
																		0.f, 0.f);
			}
			
			

			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = sign(outputColor) * pow(abs(outputColor), 1 / 2.2f);
			
	return outputColor;
}