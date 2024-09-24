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

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float3 vanilla){
		
		float3 outputColor = untonemapped.rgb;
		float3 hueCorrectionColor = renodx::color::correct::GammaSafe(vanilla);
	
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
		//		if(injectedData.toneMapType <= 3){
		//	config.saturation = injectedData.colorGradeSaturation;
		//	}
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = injectedData.colorGradeFlare;
			config.mid_gray_value = 0.18f;
			config.mid_gray_nits = 18.f;	
	
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::ARRI_C1000_NO_CUT,
			renodx::lut::config::type::LINEAR,
			32.f);
			
			config.reno_drt_saturation = 1.04f;

				if(injectedData.toneMapType == 2){															// ACES default
			config.shadows += 0.2;
			config.contrast -= 0.2;
			config.saturation -= 0.3;
			}
			
				if(injectedData.toneMapGammaCorrection == 1) {
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			}
	
			if (injectedData.toneMapType == 4){																// Frostbite
			config.highlights += 0.14;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
		
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
		
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, injectedData.toneMapPeakNits / injectedData.toneMapGameNits);
				
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
				
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
		//	outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
		//														injectedData.colorGradeSaturation,
		//														0.f, 0.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
	return outputColor;
}