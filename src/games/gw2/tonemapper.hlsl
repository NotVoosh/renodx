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
			
			
			
			renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
				if(injectedData.fxRaiseJoko && injectedData.colorGradeLUTStrength > 0.5f){
			outputColor = renodx::color::correct::Gamma(outputColor, true);
			outputColor += lerp(0, 0.0030 * injectedData.fxRaiseJoko, injectedData.colorGradeLUTStrength * 2 - 1);
			outputColor = renodx::color::correct::Gamma(outputColor);
			config.shadows = injectedData.colorGradeShadows - lerp(0, 0.08 * injectedData.fxRaiseJoko, injectedData.colorGradeLUTStrength * 2 - 1);
			config.contrast = injectedData.colorGradeContrast + lerp(0, 0.15 * injectedData.fxRaiseJoko, injectedData.colorGradeLUTStrength * 2 -1);
			} else {
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
			}
			config.saturation = injectedData.colorGradeSaturation;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = lerp(
				LUTless,
				renodx::tonemap::Reinhard(LUTless),
				injectedData.toneMapHueCorrection);
			config.hue_correction_strength = injectedData.toneMapHueCorrection / 2;
			config.reno_drt_saturation = 1.04f;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,							// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::SRGB,							// not sure
			renodx::lut::config::type::SRGB,							//           about this
			16.f);
			
				if(injectedData.toneMapType != 0) {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}

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
			config.reno_drt_saturation = 1.02f;
			
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			
			    if (injectedData.fxFilmGrain) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::srgb::from::BT709(outputColor);
			
	return outputColor;
}