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
		
		float3 outputColor = untonemapped.rgb;
		float3 hueCorrectionColor = renodx::color::gamma::Decode(LUTless);
	
		midGray = renodx::color::y::from::BT709(float3(midGray,midGray,midGray));
	
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if(injectedData.toneMapType <= 3){
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CLAMPED;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_contrast = 1.2f;
			config.reno_drt_saturation = 1.23f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::GAMMA_2_2,
			renodx::lut::config::type::GAMMA_2_2,
			32.f);

		if (injectedData.toneMapGammaCorrection == 0) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		}
		
		if (injectedData.toneMapType == 4.f){							// ReinhardScalable
			config.shadows -= 0.2f;
			config.contrast += 0.1f;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
		
				float3 sdrColor = renodx::tonemap::ReinhardScalable(outputColor, 1.f, 0.f, 0.18f, midGray);
				float reinhardPeak = injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::ReinhardScalable(outputColor, reinhardPeak, 0.f, 0.18f, midGray);
				
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation + 0.2f,
																0.f, 0.f);
		} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
		}
	
		if (injectedData.toneMapType == 0) {
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);
			outputColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(outputColor)
															  : renodx::color::srgb::Decode(outputColor);
		}
		
		if (injectedData.fxFilmGrain > 0.f) {
			outputColor = applyFilmGrain(outputColor, screenXY);
		}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(outputColor)
															  : renodx::color::srgb::EncodeSafe(outputColor);
	
	return outputColor;
}