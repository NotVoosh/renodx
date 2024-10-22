#include "./shared.h"
#include "./ColorGradingLUT.hlsl"

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

float3 applyUserTonemap(float3 untonemapped, Texture2D lutTexture1, Texture2D lutTexture2, SamplerState lutSampler, float toggle, float3 preCompute){
		
		float3 outputColor;
			if(toggle != 0){
		outputColor = 0.f;
		} else {
		outputColor = max(0, untonemapped);
		}
		float3 hueCorrectionColor = renodx::tonemap::ACESFittedAP1(untonemapped);
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::ACESFittedAP1(0.18f));
		
		  renodx::tonemap::Config config = renodx::tonemap::config::Create();

			config.type = injectedData.toneMapType;
			config.peak_nits = injectedData.toneMapPeakNits;
			config.game_nits = injectedData.toneMapGameNits;
			config.gamma_correction = injectedData.toneMapGammaCorrection;
			config.exposure = injectedData.colorGradeExposure;
			config.highlights = injectedData.colorGradeHighlights;
			config.shadows = injectedData.colorGradeShadows;
			config.contrast = injectedData.colorGradeContrast;
				if(injectedData.toneMapType <= 3){
			config.saturation = injectedData.colorGradeSaturation;
			}
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.reno_drt_saturation = 1.5f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);

			renodx::lut::Config lut_config1 = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			1.f,
			renodx::lut::config::type::LINEAR,
			renodx::lut::config::type::LINEAR,
			preCompute);

			renodx::lut::Config lut_config2 = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			1.f,
			renodx::lut::config::type::SRGB,
			renodx::lut::config::type::SRGB,
			16.f);
	
				if (injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection);
			}

				if (injectedData.toneMapType == 4){																// Frostbite
			config.shadows -= 0.4f;
			config.contrast += 0.1f;
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
				float frostbitePeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
				
			outputColor = renodx::tonemap::frostbite::BT709(outputColor, frostbitePeak);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f,
																injectedData.colorGradeSaturation + 0.15f,
																0.f, 0.f);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}
				if(injectedData.colorGradeLUTExtrapolation == 1.f){
		LUTExtrapolationData extrapolationData = DefaultLUTExtrapolationData();
    	extrapolationData.inputColor = outputColor.rgb;
    	LUTExtrapolationSettings extrapolationSettings = DefaultLUTExtrapolationSettings();
    	extrapolationSettings.lutSize = round(1.0 / preCompute.y);
    // Empirically found value for Prey. Anything less will be too compressed, anything more won't have a noticieable effect.
    // This helps keep the extrapolated LUT colors at bay, avoiding them being overly saturated or overly desaturated.
    // At this point, Prey can have colors with brightness beyond 35000 nits, so obviously they need compressing.
    //extrapolationSettings.inputTonemapToPeakWhiteNits = 1000.0; // Relative to "extrapolationSettings.whiteLevelNits" // NOT NEEDED UNTIL PROVEN OTHERWISE
    // Empirically found value for Prey. This helps to desaturate extrapolated colors more towards their Vanilla (HDR tonemapper but clipped) counterpart, often resulting in a more pleasing and consistent look.
    // This can sometimes look worse, but this value is balanced to avoid hue shifts.
    //extrapolationSettings.clampedLUTRestorationAmount = 1.0 / 4.0; // NOT NEEDED UNTIL PROVEN OTHERWISE
    	extrapolationSettings.inputLinear = true;
    	extrapolationSettings.lutInputLinear = true;
    	extrapolationSettings.lutOutputLinear = true;
    	extrapolationSettings.outputLinear = true;
			outputColor = SampleLUTWithExtrapolation(lutTexture1, lutSampler, extrapolationData, extrapolationSettings);
			} else {
				float3 lutColor = renodx::lut::Sample(saturate(outputColor), lut_config1, lutTexture1);
			outputColor = RestorePostProcess(outputColor, saturate(outputColor), lutColor);			
			}
			
	return outputColor;
}