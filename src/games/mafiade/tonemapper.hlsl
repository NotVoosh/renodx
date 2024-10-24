// Custom tonemapper, where the wild things are

#include "./shared.h"

float3 applyUserTonemap(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float linearWhite){
		
		float3 outputColor = untonemapped;
		float3 vanillaGray = renodx::tonemap::uncharted2::BT709(float3(0.18f,0.18f,0.18f), linearWhite);
		float3 hueCorrectionColor = renodx::tonemap::uncharted2::BT709(outputColor, linearWhite);
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			//config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if(injectedData.toneMapType <= 3){
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.mid_gray_value = renodx::color::y::from::BT709(vanillaGray);
			config.mid_gray_nits = renodx::color::y::from::BT709(vanillaGray) * 100;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_color = hueCorrectionColor;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;

			config.reno_drt_saturation = 1.1f;
	
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::GAMMA_2_2,
			renodx::lut::config::type::LINEAR,
			16.f);
				if(injectedData.toneMapGammaCorrection == 0){
			outputColor = renodx::color::correct::Gamma(outputColor, true);
			}
				if(injectedData.toneMapType == 4){
			config.shadows -= 0.2f;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, injectedData.toneMapPeakNits / injectedData.toneMapGameNits);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation + 0.1f,
																0.f, 0.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
	
	return outputColor;
}

float3 applyUserTonemapNoir(float3 untonemapped, Texture3D lutTexture, SamplerState lutSampler, float linearWhite){
		
		float3 outputColor = untonemapped;
		float3 vanillaGray = renodx::tonemap::uncharted2::BT709(float3(0.18f,0.18f,0.18f), linearWhite);
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			//config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
			config.mid_gray_value = renodx::color::y::from::BT709(vanillaGray);
			config.mid_gray_nits = renodx::color::y::from::BT709(vanillaGray) * 100;
			//config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
	
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::GAMMA_2_2,
			renodx::lut::config::type::LINEAR,
			16.f);
				if(injectedData.toneMapGammaCorrection == 0){
			outputColor = renodx::color::correct::Gamma(outputColor, true);
			}
				if(injectedData.toneMapType == 4){
			config.shadows -= 0.2f;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
				float3 sdrColor = renodx::tonemap::frostbite::BT709(outputColor, 1.f);
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, injectedData.toneMapPeakNits / injectedData.toneMapGameNits);
				float3 lutColor = renodx::lut::Sample(lutTexture, lut_config, sdrColor);
			outputColor = renodx::tonemap::UpgradeToneMap(outputColor, sdrColor, lutColor, injectedData.colorGradeLUTStrength);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config, lut_config, lutTexture);
			}
	
	return outputColor;
}