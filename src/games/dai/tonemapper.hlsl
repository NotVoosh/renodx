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
			config.saturation = injectedData.colorGradeSaturation;
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.reno_drt_highlights = 1.2f;
			config.reno_drt_contrast = 1.3f;
			config.reno_drt_saturation = 1.3f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.005 * injectedData.colorGradeFlare;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::GAMMA_2_2,
			renodx::lut::config::type::GAMMA_2_2,
			32.f);

		if (injectedData.toneMapGammaCorrection == 0.f) {
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
		}
		if(injectedData.toneMapType >= 2.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
		}
		if (injectedData.toneMapType == 4.f){							// ReinhardScalable
			config.type -= 1;
			config.reno_drt_shadows = 0.85f;
			config.reno_drt_flare = 0.f;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::REINHARD;
		}
		if (injectedData.toneMapType == 4.f){							// ReinhardScalable
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.2f, 0.85f, 1.3f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float3 sdrColor = renodx::tonemap::ReinhardScalable(max(0.f, outputColor), 1.f, 0.f, 0.18f, midGray);
				float reinhardPeak = injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = sign(outputColor) * renodx::tonemap::ReinhardScalable(abs(outputColor), reinhardPeak, 0.f, 0.18f, midGray);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, 1.3f);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, 1.3f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);
		} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
		}
	
		if (injectedData.toneMapType == 0.f) {
			outputColor = lerp(LUTless, vanilla, injectedData.colorGradeLUTStrength);
			outputColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::Decode(outputColor)
															  : renodx::color::srgb::Decode(outputColor);
			outputColor = saturate(outputColor);
		}
		
		if (injectedData.fxFilmGrain > 0.f) {
			outputColor = applyFilmGrain(outputColor, screenXY);
		}
	
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = injectedData.toneMapGammaCorrection ? renodx::color::gamma::EncodeSafe(outputColor)
															  : renodx::color::srgb::EncodeSafe(outputColor);
	
	return outputColor;
}