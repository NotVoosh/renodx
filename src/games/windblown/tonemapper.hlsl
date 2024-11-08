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
			if(toggle != 0.f){
		outputColor = 0.f;
		} else {
		outputColor = untonemapped;
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
			config.saturation = injectedData.colorGradeSaturation;
			config.mid_gray_value = midGray;
			config.mid_gray_nits = midGray * 100;
			config.reno_drt_highlights = 1.15f;
			config.reno_drt_contrast = 1.15f;
			config.reno_drt_saturation = 1.5f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
			config.hue_correction_type = renodx::tonemap::config::hue_correction_type::CUSTOM;
			config.hue_correction_strength = injectedData.toneMapHueCorrection;
			config.hue_correction_color = hueCorrectionColor;
			config.reno_drt_hue_correction_method = renodx::tonemap::renodrt::config::hue_correction_method::ICTCP;

			renodx::lut::Config lut_config1 = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
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
			
				if (injectedData.toneMapType == 4.f){									// ReinhardScalable
			config.shadows *= 0.9f;
			config.contrast *= 1.35f;
			config.saturation *= 1.5f;
			outputColor = renodx::color::grade::UserColorGrading(outputColor, config.exposure, config.highlights, config.shadows, config.contrast);
				float reinhardPeak = injectedData.toneMapGammaCorrection ? renodx::color::correct::Gamma(injectedData.toneMapPeakNits / injectedData.toneMapGameNits, true)
																		  : injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
			outputColor = renodx::tonemap::ReinhardScalable(outputColor, reinhardPeak, 0.f, 0.18f, midGray);
			outputColor = renodx::color::grade::UserColorGrading(outputColor, 1.f, 1.f, 1.f, 1.f, config.saturation, config.reno_drt_dechroma, config.hue_correction_strength, config.hue_correction_color);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

			float3 lutColor;
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
			lutColor = SampleLUTWithExtrapolation(lutTexture1, lutSampler, extrapolationData, extrapolationSettings);
			outputColor = lutColor;
			} else {
			lutColor = renodx::lut::Sample(saturate(outputColor), lut_config1, lutTexture1);
			outputColor = RestorePostProcess(outputColor, saturate(outputColor), lutColor);			
			}
			
	return outputColor;
}