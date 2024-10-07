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

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float3 LUTless, float3 vanilla, float2 screenXY, float midGray){
		
		float3 outputColor = max(0, untonemapped.rgb);
		float3 hueCorrectionColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(vanilla)
																		: renodx::color::srgb::Decode(vanilla);
		midGray = renodx::color::y::from::BT709(midGray);
	
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
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(LUTless)
																		  	  : renodx::color::srgb::Decode(LUTless);	
			config.hue_correction_strength = injectedData.toneMapHueCorrection / 3;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::GAMMA_2_2,
			renodx::lut::config::type::GAMMA_2_2,
			32.f);
			
			config.reno_drt_saturation = 1.2f;
			
		if(injectedData.toneMapType == 2){				// ACES default config
		config.contrast -= 0.14f;
		}
		if (injectedData.toneMapGammaCorrection == 0) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		}
		
		if (injectedData.toneMapType == 4){																// Frostbite
			config.shadows -= 0.1;
			config.contrast += 0.2;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
		
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? injectedData.toneMapPeakNits / injectedData.toneMapGameNits
																		  : renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true);
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
				
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
				
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation + 0.3,
																0.f, 0.f);
		} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
				if (injectedData.toneMapType == 2) {													// ACES hue correction
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			}
		}
	
		if (injectedData.toneMapType == 0) {
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);
			outputColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(outputColor)
															  :renodx::color::srgb::Decode(outputColor);
		}
		
		if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
		}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::gamma::EncodeSafe(outputColor);
	
	return outputColor;
}