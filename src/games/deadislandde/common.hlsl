#include "./shared.h"

//-----EFFECTS-----//
float3 applyFilmGrain(float3 outputColor, float2 screen) {
  float3 grainedColor = renodx::effects::ApplyFilmGrain(
        outputColor,
        screen,
        injectedData.random,
        injectedData.fxFilmGrain * 0.03f,
        1.f);
  return grainedColor;
}

//-----SCALING-----//
float3 PostToneMapScale(float3 color) {
  if (injectedData.toneMapGammaCorrection == 2.f) {
    color = renodx::color::correct::GammaSafe(color, false, 2.4f);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::correct::GammaSafe(color, true, 2.4f);
  } else if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::correct::GammaSafe(color, false, 2.2f);
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    color = renodx::color::correct::GammaSafe(color, true, 2.2f);
  } else {
    color *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
  }
  return color;
}

float3 FinalizeOutput(float3 color) {
  if (injectedData.toneMapGammaCorrection == 2.f) {
    color = renodx::color::correct::GammaSafe(color, false, 2.4f);
  } else if (injectedData.toneMapGammaCorrection == 1.f) {
    color = renodx::color::correct::GammaSafe(color, false, 2.2f);
  }
  color *= injectedData.toneMapUINits;
  if (injectedData.toneMapType == 0.f) {
    color = renodx::color::bt709::clamp::BT709(color);
  } else {
    color = renodx::color::bt709::clamp::BT2020(color);
  }
  color /= 80.f;
  return color;
}

//-----TONEMAP-----//
float3 applyFrostbite(float3 input, renodx::tonemap::Config FbConfig, bool sdr = false) {
  float3 color = input;
  float FbPeak = sdr ? 1.f : FbConfig.peak_nits / FbConfig.game_nits;
  if (FbConfig.gamma_correction == 0.f) {
    FbPeak = renodx::color::srgb::Encode(FbPeak);
    FbPeak = renodx::color::gamma::Decode(FbPeak, 2.2f);
  } else if (FbConfig.gamma_correction == 2.f) {
    FbPeak = renodx::color::gamma::Encode(FbPeak, 2.4f);
    FbPeak = renodx::color::gamma::Decode(FbPeak, 2.2f);
  }

  float y = renodx::color::y::from::BT709(color * FbConfig.exposure);
  color = renodx::color::grade::UserColorGrading(color, FbConfig.exposure, FbConfig.highlights, FbConfig.shadows, FbConfig.contrast);
  color = renodx::tonemap::frostbite::BT709(color, FbPeak, injectedData.toneMapShoulderStart, injectedData.colorGradeBlowout / 2.f, injectedData.toneMapHueCorrection);

  if (FbConfig.saturation != 1.f || FbConfig.reno_drt_dechroma != 0.f) {
    float3 perceptual_new;

    if (FbConfig.reno_drt_hue_correction_method == 0u) {
      perceptual_new = renodx::color::oklab::from::BT709(color);
    } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
      perceptual_new = renodx::color::ictcp::from::BT709(color);
    } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
      perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
    }

    if (FbConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - FbConfig.reno_drt_dechroma))));
    }

    perceptual_new.yz *= FbConfig.saturation;

    if (FbConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (FbConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (FbConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
  color = renodx::color::bt709::clamp::AP1(color);
  return color;
}

float3 DICEMap(float3 color, float output_luminance_max, float highlights_shoulder_start = 0.f,
  float highlights_modulation_pow = 1.f, bool perChannel = true) {
if (!perChannel) {
const float source_luminance = renodx::color::y::from::BT709(color);
if (source_luminance > 0.0f) {
const float compressed_luminance =
renodx::tonemap::dice::internal::LuminanceCompress(source_luminance, output_luminance_max, highlights_shoulder_start, false,
            renodx::math::FLT_MAX, highlights_modulation_pow);
color *= compressed_luminance / source_luminance;
}
return color;
} else {
color.r = renodx::tonemap::dice::internal::LuminanceCompress(color.r, output_luminance_max, highlights_shoulder_start, false,
                renodx::math::FLT_MAX, highlights_modulation_pow);
color.g = renodx::tonemap::dice::internal::LuminanceCompress(color.g, output_luminance_max, highlights_shoulder_start, false,
                renodx::math::FLT_MAX, highlights_modulation_pow);
color.b = renodx::tonemap::dice::internal::LuminanceCompress(color.b, output_luminance_max, highlights_shoulder_start, false,
                renodx::math::FLT_MAX, highlights_modulation_pow);
return color;
}
}

float3 applyDICE(float3 input, renodx::tonemap::Config DiceConfig, bool sdr = false) {
  float3 color = input;
  float DicePaperWhite = DiceConfig.game_nits / 80.f;
  float DicePeak = sdr ? DicePaperWhite : DiceConfig.peak_nits / 80.f;
  if (!sdr) {
  if (DiceConfig.gamma_correction == 0.f) {
    DicePeak = renodx::color::srgb::Encode(DicePeak);
    DicePeak = renodx::color::gamma::Decode(DicePeak, 2.2f);
    DicePaperWhite = renodx::color::srgb::Encode(DicePaperWhite);
    DicePaperWhite = renodx::color::gamma::Decode(DicePaperWhite, 2.2f);
  } else if (DiceConfig.gamma_correction == 2.f) {
    DicePeak = renodx::color::gamma::Encode(DicePeak, 2.4f);
    DicePeak = renodx::color::gamma::Decode(DicePeak, 2.2f);
    DicePaperWhite = renodx::color::gamma::Encode(DicePaperWhite, 2.4f);
    DicePaperWhite = renodx::color::gamma::Decode(DicePaperWhite, 2.2f);
  }
  }

  float y = renodx::color::y::from::BT709(color * DiceConfig.exposure);
  color = renodx::color::grade::UserColorGrading(color, DiceConfig.exposure, DiceConfig.highlights, DiceConfig.shadows, DiceConfig.contrast);
  color = DICEMap(color * DicePaperWhite, DicePeak, injectedData.toneMapShoulderStart * DicePaperWhite, 1.f, DiceConfig.reno_drt_per_channel) / DicePaperWhite;

  if (DiceConfig.saturation != 1.f || DiceConfig.hue_correction_strength != 0.f || DiceConfig.reno_drt_blowout != 0.f || DiceConfig.reno_drt_dechroma != 0.f) {
    float3 perceptual_new;

    if (DiceConfig.reno_drt_hue_correction_method == 0u) {
      perceptual_new = renodx::color::oklab::from::BT709(color);
    } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
      perceptual_new = renodx::color::ictcp::from::BT709(color);
    } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
      perceptual_new = renodx::color::dtucs::uvY::from::BT709(color).zxy;
    }

    if (DiceConfig.hue_correction_strength != 0.f) {
      float3 perceptual_old;
      if (DiceConfig.hue_correction_type == renodx::tonemap::config::hue_correction_type::INPUT) {
        DiceConfig.hue_correction_color = input;
      }
      if (DiceConfig.reno_drt_hue_correction_method == 0u) {
        perceptual_old = renodx::color::oklab::from::BT709(DiceConfig.hue_correction_color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
        perceptual_old = renodx::color::ictcp::from::BT709(DiceConfig.hue_correction_color);
      } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
        perceptual_old = renodx::color::dtucs::uvY::from::BT709(DiceConfig.hue_correction_color).zxy;
      }

      // Save chrominance to apply black
      float chrominance_pre_adjust = distance(perceptual_new.yz, 0);

      perceptual_new.yz = lerp(perceptual_new.yz, perceptual_old.yz, DiceConfig.hue_correction_strength);

      float chrominance_post_adjust = distance(perceptual_new.yz, 0);

      // Apply back previous chrominance
      perceptual_new.yz *= renodx::math::DivideSafe(chrominance_pre_adjust, chrominance_post_adjust, 1.f);
    }

    if (DiceConfig.reno_drt_dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - DiceConfig.reno_drt_dechroma))));
    }

    if (DiceConfig.reno_drt_blowout != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      // positive = 1 to 0, negative = 1 to 2
      float blowout_strength = 100.f;
      float blowout_change = pow(1.f - percent_max, blowout_strength * abs(DiceConfig.reno_drt_blowout));
      if (DiceConfig.reno_drt_blowout < 0) {
        blowout_change = (2.f - blowout_change);
      }

      perceptual_new.yz *= blowout_change;
    }

    perceptual_new.yz *= DiceConfig.saturation;

    if (DiceConfig.reno_drt_hue_correction_method == 0u) {
      color = renodx::color::bt709::from::OkLab(perceptual_new);
    } else if (DiceConfig.reno_drt_hue_correction_method == 1u) {
      color = renodx::color::bt709::from::ICtCp(perceptual_new);
    } else if (DiceConfig.reno_drt_hue_correction_method == 2u) {
      color = renodx::color::bt709::from::dtucs::uvY(perceptual_new.yzx);
    }
  }
  color = renodx::color::bt709::clamp::AP1(color);
  return color;
}

float3 RestoreSaturationLoss(float3 color_input, float3 color_output, float strength) {
  float3 clamped = saturate(color_input);
  float3 perceptual_in = renodx::color::oklab::from::BT709(color_input);
  float3 perceptual_clamped = renodx::color::oklab::from::BT709(clamped);
  float3 perceptual_out = renodx::color::oklab::from::BT709(color_output);

  float chroma_in = distance(perceptual_in.yz, 0);
  float chroma_clamped = distance(perceptual_clamped.yz, 0);
  float chroma_out = distance(perceptual_out.yz, 0);
  float chroma_loss = renodx::math::DivideSafe(chroma_in, chroma_clamped, 0.f);
  float chroma_new = chroma_out * chroma_loss;

  perceptual_out.yz *= lerp(1.f, renodx::math::DivideSafe(chroma_new, chroma_out, 1.f), strength);

  return renodx::color::bt709::from::OkLab(perceptual_out);
}

float gammaCorrectPeak(float peak) {
  if (injectedData.toneMapGammaCorrection == 0.f) {
   return renodx::color::gamma::Decode(renodx::color::srgb::Encode(peak / injectedData.toneMapGameNits), 2.2f) * injectedData.toneMapGameNits;
  } else if (injectedData.toneMapGammaCorrection == 2.f) {
    return renodx::color::gamma::Decode(renodx::color::gamma::Encode(peak / injectedData.toneMapGameNits, 2.4), 2.2f) * injectedData.toneMapGameNits;
 } else {
   return peak;
 }
}

float3 rolloff(float3 input) {
  float peak = (injectedData.toneMapPeakNits + 1.f) / injectedData.toneMapGameNits;
  if (injectedData.toneMapGammaCorrection != 0.f) {
    peak = renodx::color::correct::Gamma(peak, true, injectedData.toneMapGammaCorrection == 1.f ? 2.2f : 2.4f);
  }
  return renodx::tonemap::ExponentialRollOff(input, injectedData.toneMapPeakNits / injectedData.toneMapGameNits, peak);
}