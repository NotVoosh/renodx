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

float3 applyUserTonemap(float3 untonemapped, Texture2D lutTexture, SamplerState lutSampler, float midGray, float2 screenXY){
		
		float3 outputColor;
				if(injectedData.toneMapType == 0) {
			outputColor = saturate(untonemapped);
			} else {
			outputColor = max(0, untonemapped);
			}
			outputColor = renodx::color::srgb::Decode(outputColor);
		midGray = renodx::color::y::from::BT709(midGray);
	
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if(injectedData.toneMapType <= 3){
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = injectedData.colorGradeFlare;
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);
			
			//config.reno_drt_highlights = 1.25f;
			//config.reno_drt_shadows = 1.05f;
			//config.reno_drt_contrast = 0.96f;
			//config.reno_drt_saturation = 1.05f;
			
				if (injectedData.toneMapType == 2) {													// ACES default config
			//config.shadows += 0.2;
			//config.contrast -= 0.08;
			//config.saturation -= 0.18;
			}
	
				if (injectedData.toneMapType == 4){												// Frostbite
			//config.highlights += 0.15f;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
		
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
				
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			
		
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
				
			
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
			
				if(injectedData.toneMapGammaCorrection == 1){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
	
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
	return outputColor;
}