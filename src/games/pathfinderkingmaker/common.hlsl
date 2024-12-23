#include "./shared.h"

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

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
  if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::gamma::DecodeSafe(color, 2.2f);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::gamma::EncodeSafe(color, 2.2f);
  } else {
    color = renodx::color::srgb::DecodeSafe(color);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::srgb::EncodeSafe(color);
  }
  return color;
}

float3 FinalizeOutput(float3 color) {
  	if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::gamma::DecodeSafe(color, 2.2f);
  } else {
    color = renodx::color::srgb::DecodeSafe(color);
  }
  color *= injectedData.toneMapUINits;
  color /= 80.f;
  return color;
}

float3 lutShaper(float3 color, bool builder = false){

    //color = builder ? renodx::color::arri::logc::c1000::Decode(color, false)
	//				: saturate(renodx::color::arri::logc::c1000::Encode(color, false));
    color = builder ? renodx::color::pq::Decode(color, 100.f)
					: renodx::color::pq::Encode(color, 100.f);

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

/*float3 applyVanillaTonemap(float3 color) {	// custom uc2
static const half A = ;
static const half B = ;
static const half C = ;
static const half D = ;
static const half E = ;
static const half F = ;
static const half W1 = ;
static const half W2 = ;

	float3 white = 1 / renodx::tonemap::ApplyCurve(W1, A, B, C, D, E, F);
	color = max(0, color);
	color = renodx::tonemap::ApplyCurve(color * white, A, B, C, D, E, F);
	color *= white;
	color /= W2;

return color;
}*/

float3 applyUserTonemap(float3 untonemapped){
		
		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(renodx::tonemap::uncharted2::BT709(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = renodx::tonemap::uncharted2::BT709(untonemapped);

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
			config.reno_drt_highlights = 1.1f;
			config.reno_drt_contrast = 1.1f;
			config.reno_drt_saturation = 1.15f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.0025 * injectedData.colorGradeFlare;
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, 1u);
			}
				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(renodx::tonemap::uncharted2::BT709(max(0, untonemapped)));
			}
				if (injectedData.toneMapType == 4.f) {		// Reinhard+
			config.shadows *= 0.9f;
			config.contrast *= 1.15f;
			config.saturation *= 1.2f;
			outputColor = applyReinhardPlus(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}