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
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    }
      if(injectedData.toneMapType == 0.f){
	color = renodx::color::bt709::clamp::BT709(color);
    }
    color *= injectedData.toneMapGameNits / 80.f;

  return color;
}

float3 UIScale(float3 color) {
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapUINits / 80.f;
    } else {
	color *= injectedData.toneMapUINits / 80.f;
	}
  	return color;
}

float3 lutShaper(float3 color, bool builder = false){

	//color = builder ? renodx::color::arri::logc::c1000::Decode(color, false)
	//				: saturate(renodx::color::arri::logc::c1000::Encode(color, false));
    color = builder ? renodx::color::pq::Decode(color, 100.f)
					: renodx::color::pq::Encode(color, 100.f);
return color;
}

float3 InverseToneMap(float3 color) {
	float scaling = injectedData.toneMapPeakNits / injectedData.toneMapGameNits;
	float videoPeak = scaling * 203.f;
      if(injectedData.toneMapGammaCorrection == 1.f){
    videoPeak = renodx::color::correct::Gamma(videoPeak, true);
    scaling = renodx::color::correct::Gamma(scaling, true);
    }
    color = renodx::color::correct::GammaSafe(color, false, 2.4f);
	color = renodx::tonemap::inverse::bt2446a::BT709(color, 100.f, videoPeak);
	color /= videoPeak;
	color *= scaling;
	return color;
}

float3 ITMScale(float3 color){
      if(injectedData.toneMapGammaCorrection == 1.f){
    color = renodx::color::correct::GammaSafe(color);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::correct::GammaSafe(color);
    } else {
	color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
	}
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

float3 applyVanillaTonemap(float3 color) {	// custom uc2
static const float A = 0.02;
static const float B = 0.24914;
static const float C = 0.19459;
static const float D = 0.30877;
static const float E = 0.02;
static const float F = 0.3;
static const float whiteLevel = 10.13;
static const float whiteClip = 0.938;

	float3 whiteScale = 1 / renodx::tonemap::ApplyCurve(whiteLevel, A, B, C, D, E, F);
	color = max(0, color);
	color = renodx::tonemap::ApplyCurve(color * whiteScale, A, B, C, D, E, F);
	color *= whiteScale;
	color /= whiteClip;

return color;
}

float3 applyUserTonemap(float3 untonemapped){

		float3 outputColor = untonemapped;
		float midGray = renodx::color::y::from::BT709(applyVanillaTonemap(float3(0.18f,0.18f,0.18f)));
		float3 hueCorrectionColor = applyVanillaTonemap(untonemapped);

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
			config.reno_drt_highlights = 0.95f;
			config.reno_drt_shadows = 1.1f;
			config.reno_drt_contrast = 0.9f;
			config.reno_drt_saturation = 0.9f;
			config.reno_drt_dechroma = injectedData.colorGradeBlowout;
			config.reno_drt_flare = 0.0025 * pow(injectedData.colorGradeFlare, 2.f);
			config.reno_drt_tone_map_method = renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
			config.reno_drt_hue_correction_method = (uint)injectedData.toneMapHueProcessor;

				if(injectedData.toneMapType >= 3.f){
			outputColor = renodx::color::correct::Hue(outputColor, hueCorrectionColor, injectedData.toneMapHueCorrection, (uint)injectedData.toneMapHueProcessor);
			}
				if(injectedData.toneMapType == 0.f){
			outputColor = saturate(hueCorrectionColor);
			}
				if (injectedData.toneMapType == 4.f) {		// Reinhard+
			config.contrast *= 0.9f;
			config.saturation *= 0.95f;
			outputColor = applyReinhardPlus(outputColor, config);
			} else {
			outputColor = renodx::tonemap::config::Apply(outputColor, config);
			}

	return outputColor;
}