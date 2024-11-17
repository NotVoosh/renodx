#include "./shared.h"
#include "./DICE.hlsl"

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

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler){
		
		float3 outputColor = untonemapped;
		
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
			config.reno_drt_highlights = 1.05f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.025f * pow(injectedData.colorGradeFlare, 5.f);
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::REINHARD;
			
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
			config.exposure = 1.f;
			config.highlights = 1.f;
			config.shadows = 1.f;
			config.contrast = 1.f;
			
		float3 lutInput;
					if(injectedData.colorGradeLUTSampling == 0.f){
				lutInput = renodx::color::arri::logc::c1000::Encode(untonemapped);
				} else {
				lutInput = renodx::color::pq::Encode(untonemapped, 100.f);
				}
		float3 lutOutput = renodx::lut::Sample(lutTexture, lutSampler, lutInput, 33.f);
			outputColor = lerp(outputColor, lutOutput, injectedData.colorGradeLUTStrength);

				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(outputColor);
			}
				if (injectedData.toneMapType == 2.f){			// Frostbite
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);

			} else if (injectedData.toneMapType == 4.f){		// DICE
			DICESettings DICEconfig = DefaultDICESettings();
			DICEconfig.Type = 3;
			DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
				float dicePaperWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapGameNits / 80.f, true)
																		   : injectedData.toneMapGameNits / 80.f;
				float dicePeakWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / 80.f, true)
																		  : injectedData.toneMapPeakNits / 80.f;
			outputColor = DICETonemap(outputColor * dicePaperWhite, dicePeakWhite, DICEconfig) / dicePaperWhite;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}