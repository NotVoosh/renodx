// Custom tonemapper, where the wild things are

#include "./shared.h"

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float3 vanilla){
		
		float3 outputColor = untonemapped.rgb;
	
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
				if(injectedData.toneMapGammaCorrection == 1){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			}
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
	
	return outputColor;
}