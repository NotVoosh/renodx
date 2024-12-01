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

float3 sampleLUT(float3 color, Texture3D lutTexture, SamplerState lutSampler){
	float3 lutInput;
		if(injectedData.colorGradeLUTSampling == 0.f){
    lutInput = saturate(renodx::color::arri::logc::c1000::Encode(color, false));
      } else {
    lutInput = renodx::color::pq::Encode(color, 100.f);
    }
    float3 lutOutput = renodx::lut::Sample(lutTexture, lutSampler, lutInput, 32.f);

return lutOutput;
}

float3 applyUserTonemap(float3 untonemapped, bool ACES){
		
		float3 outputColor = untonemapped;
		float3 hueCorrectionColor = renodx::tonemap::ACESFittedAP1(untonemapped);
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::ACESFittedAP1(float3(0.18f,0.18f,0.18f)));
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
			config.mid_gray_value = ACES ? midGray : 0.18f;
			config.mid_gray_nits = ACES ? midGray * 100 : 18.f;
			config.reno_drt_highlights = 1.2f;
			config.reno_drt_shadows = 1.2f;
			config.reno_drt_contrast = 1.3f;
			config.reno_drt_saturation = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.005 * injectedData.colorGradeFlare;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if(injectedData.toneMapType >= 3.f && ACES == 1){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if (injectedData.toneMapType == 4.f){		// ReinhardScalable
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.2f, 1.05f, 1.3f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = sign(outputColor) * renodx::tonemap::ReinhardScalable(abs(outputColor), reinhardPeak, 0.f, 0.18f, midGray);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, 1.2f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}