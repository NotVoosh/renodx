// Custom tonemapper, where the wild things are

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

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float3 LUTless, float3 vanilla, float2 screenXY){
		
		float3 outputColor = max(0, untonemapped.rgb);
		float3 hueCorrectionColor = injectedData.toneMapGammaCorrection ? pow(vanilla, 2.2f)
																		: renodx::color::bt709::from::SRGB(vanilla);
	
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection - 1;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if(injectedData.toneMapType <= 3){
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = injectedData.colorGradeFlare;
			config.mid_gray_value = 0.18f;
			config.mid_gray_nits = 18.f;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = injectedData.toneMapGammaCorrection ? pow(LUTless, 2.2f)
																		: renodx::color::bt709::from::SRGB(LUTless);	
			config.hue_correction_strength = injectedData.toneMapHueCorrection / 3;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,															// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::GAMMA_2_2,														// not sure
			renodx::lut::config::type::GAMMA_2_2,														//           about this
			32.f);
			
			config.reno_drt_contrast = 1.145f;
			config.reno_drt_saturation = 1.09f;
			
		if (injectedData.toneMapGammaCorrection == 0) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		}
		
		if (injectedData.toneMapType == 4){																// Frostbite
			config.highlights -= 0.1;
			config.shadows -= 0.35;
			config.contrast += 0.2;
			config.saturation += 0.05;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
		
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? injectedData.toneMapPeakNits / injectedData.toneMapGameNits
																		  : renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true);
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
				
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
				
			
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation + 0.07,
																0.f, 0.f);
		} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
				if (injectedData.toneMapType == 2) {													// ACES hue correction
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			}
		}
	
		if (injectedData.toneMapType == 0) {
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);
			outputColor = injectedData.toneMapGammaCorrection ? pow(outputColor, 2.2f)
															  :renodx::color::bt709::from::SRGB(outputColor);
		}
		
		if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
		}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = sign(outputColor) * pow(abs(outputColor), 1 / 2.2f);
	
	return outputColor;
}