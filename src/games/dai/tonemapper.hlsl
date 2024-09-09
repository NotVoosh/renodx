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
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.mid_gray_value = 0.18f;
			config.mid_gray_nits = 18.f;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = injectedData.toneMapGammaCorrection ? pow(LUTless, 2.2f)
																			  : renodx::color::bt709::from::SRGB(LUTless);
			config.hue_correction_strength = injectedData.toneMapHueCorrection;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,																	// doesn't seem to be doing anything but could depend on the scene...
			renodx::lut::config::type::GAMMA_2_2,																	// not sure
			renodx::lut::config::type::GAMMA_2_2,																	//           about this
			32.f);
			
			config.reno_drt_contrast = 1.2f;
			config.reno_drt_saturation = 1.16f;
	
		if (injectedData.toneMapGammaCorrection == 0) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		}
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
	
		if (injectedData.toneMapType == 0) {																	// vanilla, looks identical but less bright and unclamped? not sure why :s
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);							// lerp for LUT slider
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