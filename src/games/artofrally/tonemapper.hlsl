#include "./shared.h"

float3 sampleLUT(float3 color, Texture3D lutTexture, SamplerState lutSampler){
	float3 lutInput;
		if(injectedData.colorGradeLUTSampling == 0.f){
    lutInput = renodx::color::arri::logc::c1000::Encode(color, false);
      } else {
    lutInput = renodx::color::pq::Encode(color, 100.f);
    }
    float3 lutOutput = renodx::lut::Sample(lutTexture, lutSampler, lutInput, 33.f);

return lutOutput;
}

float3 applyUserTonemapNeutral(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::unity::BT709(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = renodx::tonemap::unity::BT709(outputColor);

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
			config.reno_drt_saturation = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.01f * pow(injectedData.colorGradeFlare, 10.f);
			
				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if(injectedData.toneMapType == 2.f){		// ACES
			config.contrast *= 0.7f;
			config.saturation *= 0.7f;
			}
				if (injectedData.toneMapType == 4.f){		// ReinhardScalable
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

float3 applyUserTonemapACES(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::ACESFittedAP1(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = renodx::tonemap::ACESFittedAP1(outputColor);

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
			config.reno_drt_highlights = 1.15f;
			config.reno_drt_contrast = 1.15f;
			config.reno_drt_saturation = 1.5f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);

				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if (injectedData.toneMapType == 4.f){		// ReinhardScalable
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 0.9f, 1.35f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = sign(outputColor) * renodx::tonemap::ReinhardScalable(abs(outputColor), reinhardPeak, 0.f, 0.18f, midGray);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, 1.5f);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}
	return outputColor;
}