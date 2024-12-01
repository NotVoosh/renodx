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

float3 applyUserTonemap(float3 untonemapped){

		float3 outputColor = untonemapped;
		float3 midGray = renodx::color::y::from::BT709(renodx::tonemap::uncharted2::BT709(float3(0.18f,0.18f,0.18f), 5.f));
		float3 hueCorrectionColor = renodx::tonemap::uncharted2::BT709(untonemapped, 5.f);
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
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.reno_drt_contrast = 1.05f;
			config.reno_drt_saturation = 1.15f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if(injectedData.toneMapType >= 2.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if (injectedData.toneMapType == 4.f){		// ReinhardScalable
			config.type -= 1;
			config.reno_drt_contrast = 1.1f;
			config.reno_drt_saturation = 1.2f;
			config.reno_drt_flare = 0.f;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::REINHARD;
			}
			outputColor = renodx::tonemap::config::Apply(outputColor, config);

	return outputColor;
}