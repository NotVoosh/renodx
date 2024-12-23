#include "./shared.h"
#include "./ColorGradingLUT.hlsl"

//-----EFFECTS-----//
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

float3 sampleLUT(float3 color, Texture2D lutTexture, SamplerState lutSampler, float3 preCompute){
			
			renodx::lut::Config lut_config = renodx::lut::config::Create(
			lutSampler,
			injectedData.colorGradeLUTStrength,
			injectedData.colorGradeLUTScaling,
			renodx::lut::config::type::LINEAR,
			renodx::lut::config::type::LINEAR,
			preCompute);
		
		float3 input = color;
		float3 lutColor = renodx::lut::Sample(saturate(input), lut_config, lutTexture);
		float3 output = RestorePostProcess(input, saturate(input), lutColor);

	return output;
}

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::correct::GammaSafe(color, true);
    } else {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    }
  return color;
}

float3 FinalizeOutput(float3 color) {
  	  if(injectedData.toneMapGammaCorrection == 1.f) {
	color = renodx::color::correct::GammaSafe(color);
  	}
  	color *= injectedData.toneMapUINits;
  	color /= 80.f;
  	return color;
}

//-----TONEMAP-----//
float3 applyReinhardPlus(float3 color, renodx::tonemap::Config RhConfig){
	float RhPeak = RhConfig.peak_nits / RhConfig.game_nits;
		if(RhConfig.gamma_correction == 1.f){
	RhPeak = renodx::color::correct::Gamma(RhPeak, true);
	}
	
	color = renodx::color::ap1::from::BT709(color);
		float y = renodx::color::y::from::AP1(color * RhConfig.exposure);
	color = renodx::color::grade::UserColorGrading(color, RhConfig.exposure, RhConfig.highlights, RhConfig.shadows, RhConfig.contrast);
	color = renodx::tonemap::ReinhardScalable(color, RhPeak, 0.f, 0.18f, RhConfig.mid_gray_value);
	color = renodx::color::bt709::from::AP1(color);
	  if (RhConfig.reno_drt_dechroma != 0.f || RhConfig.saturation != 1.f) {
    float3 perceptual_new;

      if (RhConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_new = renodx::color::oklab::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_new = renodx::color::ictcp::from::BT709(color);
      } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
      }

    if (RhConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - RhConfig.reno_drt_dechroma))));
    }

    perceptual_new.yz *= RhConfig.saturation;

    if (RhConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (RhConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (RhConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
    color = renodx::color::bt709::clamp::AP1(color);
    return color;
}

float3 applyUserTonemap(float3 untonemapped){
		
		float3 outputColor = untonemapped;
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
			config.reno_drt_highlights = 1.2f;
			config.reno_drt_shadows = 1.2f;
			config.reno_drt_contrast = 1.3f;
			config.reno_drt_saturation = 1.2f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.005 * injectedData.colorGradeFlare;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if (injectedData.toneMapType == 4.f){		// Reinhard+
			config.highlights *= 1.05f;
			config.shadows *= 1.1f;
			config.contrast *= 1.35f;
			config.saturation *= 1.25f;
			outputColor = applyReinhardPlus(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}	
			
	return outputColor;
}