// Custom tonemapper, where the wild things are

#include "./shared.h"




float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float3 LUTless, float3 vanilla){
		
		float3 outputColor = untonemapped.rgb;

		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection - 1;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
			config.saturation = injectedData.colorGradeSaturation;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = lerp(																	// renodx::tonemap::ACESFittedSDR maybe?
			untonemapped,
			renodx::tonemap::Reinhard(untonemapped),
			injectedData.toneMapHueCorrection);

			config.reno_drt_contrast = 1.1f;
			config.reno_drt_saturation = 1.05f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,																	// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::SRGB,																	// not sure
			renodx::lut::config::type::SRGB,																	//           about this
			32.f);
			
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);

	
		if (injectedData.toneMapType == 0) {																	// vanilla, looks identical but less bright and unclamped? not sure why :s
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);							// lerp for LUT slider
			outputColor = renodx::color::bt709::from::SRGB(outputColor);
		}
		
		if (injectedData.toneMapGammaCorrection) {																// not sure that's needed. thought better have it in case.
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / 80.f;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		} else {
			outputColor *= injectedData.toneMapGameNits / 80.f;
		}
		
	return outputColor;
}