// Custom tonemapper

#include "./shared.h"
#include "./DICE.hlsl"

float3 applyFilmGrain(float3 outputColor, float2 screen){
    float3 grainedColor = renodx::effects::ApplyFilmGrain(
			outputColor,
			screen,
			frac(injectedData.elapsedTime / 1000.f),
			injectedData.fxFilmGrain * 0.03f,
			1.f);
		return grainedColor;
}

float3 applyVignette(float3 color, float2 xy, float intensity){
	xy = xy - 0.5f;
	float v = dot(xy, xy);
	v = saturate(1-v);
	v = pow(v, intensity);
	color *= v.xxx;
	return color;
}

float3 applyUserTonemap(float3 LUTless, Texture2D lutTexture, SamplerState lutSampler, float3 vanilla, float2 screenXY){
		
		float3 outputColor = renodx::color::srgb::Decode(LUTless);
		float3 hueCorrectionColor = renodx::tonemap::Reinhard(outputColor);
			
				if(injectedData.toneMapType == 0) {
			outputColor = saturate(outputColor);
			}
			
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
			config.reno_drt_highlights = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::ICTCP;
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);
			
				if (injectedData.toneMapType == 2.f){			// Frostbite
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::correct::Hue(outputColor, config.hue_correction_color, config.hue_correction_strength, 1);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			sdrColor = renodx::color::correct::Hue(sdrColor, config.hue_correction_color, config.hue_correction_strength, 1);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);


			} else if (injectedData.toneMapType == 4.f){		// DICE
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
			DICESettings DICEconfig = DefaultDICESettings();
			DICEconfig.Type = 3;
			DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
				float dicePaperWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapGameNits / 80.f, true)
																		   : injectedData.toneMapGameNits / 80.f;
				float dicePeakWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / 80.f, true)
																		  : injectedData.toneMapPeakNits / 80.f;
				float3 sdrColor = DICETonemap(outputColor * dicePaperWhite, dicePaperWhite, DICEconfig) / dicePaperWhite;
			outputColor = DICETonemap(outputColor * dicePaperWhite, dicePeakWhite, DICEconfig) / dicePaperWhite;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			sdrColor = renodx::color::correct::Hue(sdrColor, config.hue_correction_color, config.hue_correction_strength, 1);
			sdrColor = renodx::color::grade::UserColorGrading(sdrColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, 1.f);

			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
		//		if (injectedData.fxVignette > 0.f){
		//	outputColor = applyVignette(outputColor, screenXY, injectedData.fxVignette);
		//	}
			    if (injectedData.fxFilmGrain > 0.f) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
				if (injectedData.toneMapGammaCorrection){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
			
	return outputColor;
}

float3 applyUserTonemap(float3 vanilla, float2 screenXY){
		
		float3 outputColor = renodx::color::srgb::Decode(vanilla);
		float3 hueCorrectionColor = renodx::tonemap::Reinhard(outputColor);	
				if(injectedData.toneMapType == 0) {
			outputColor = saturate(outputColor);
			}
	
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
			config.reno_drt_highlights = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.reno_drt_hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::ICTCP;
						
				if (injectedData.toneMapType == 2.f){			// Frostbite
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::correct::Hue(outputColor, config.hue_correction_color, config.hue_correction_strength, 1);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);
			
			} else if (injectedData.toneMapType == 4.f){			// DICE
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
			DICESettings DICEconfig = DefaultDICESettings();
			DICEconfig.Type = 3;
        	DICEconfig.ShoulderStart = injectedData.diceShoulderStart;
				float dicePaperWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapGameNits / 80.f, true)
																		   : injectedData.toneMapGameNits / 80.f;
				float dicePeakWhite = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / 80.f, true)
																		  : injectedData.toneMapPeakNits / 80.f;

			outputColor = DICETonemap(outputColor * dicePaperWhite, dicePeakWhite, DICEconfig) / dicePaperWhite;
			outputColor = renodx::color::correct::Hue(outputColor, config.hue_correction_color, config.hue_correction_strength, 1);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma);

			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}
			
		//		if (injectedData.fxVignette > 0.f){
		//	outputColor = applyVignette(outputColor, screenXY, injectedData.fxVignette);
		//	}
			    if (injectedData.fxFilmGrain > 0.f) {
			outputColor = applyFilmGrain(outputColor, screenXY);
			}
	
				if (injectedData.toneMapGammaCorrection){
			outputColor = renodx::color::correct::GammaSafe(outputColor);
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			outputColor = renodx::color::correct::GammaSafe(outputColor, true);
			} else {
			outputColor *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
			}
			outputColor = renodx::color::srgb::EncodeSafe(outputColor);
			
	return outputColor;
}