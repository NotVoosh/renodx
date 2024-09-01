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
		
		float3 outputColor = LUTless;

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
			config.saturation = injectedData.colorGradeSaturation;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CLAMPED;
			config.hue_correction_color = vanilla;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_saturation = 1.04f;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,							// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::SRGB,							// not sure
			renodx::lut::config::type::SRGB,							//           about this
			16.f);
			
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			
			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::srgb::from::BT709(outputColor);
			
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
			config.saturation = injectedData.colorGradeSaturation;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CLAMPED;
			config.hue_correction_color = vanilla;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_saturation = 1.04f;
			
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			
			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::srgb::from::BT709(outputColor);
			
	return outputColor;
}