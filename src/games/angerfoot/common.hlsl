#include "./shared.h"

//-----EFFECTS-----//
float3 applyFilmGrain(float3 output_color, float2 TEXCOORD) {
  output_color = renodx::effects::ApplyFilmGrain(
      output_color.rgb,
      TEXCOORD.xy,
      CUSTOM_RANDOM,
      CUSTOM_FILM_GRAIN_STRENGTH * 0.03f,
      1.f);  // if 1.f = SDR range
  return output_color;
}

//-----SCALING-----//
float3 lutShaper(float3 color, bool builder = false) {
  if (CUSTOM_LUT_SHAPER == 0.f) {
    color = builder ? renodx::color::arri::logc::c1000::Decode(color, false)
                    : saturate(renodx::color::arri::logc::c1000::Encode(color, false));
  } else {
    color = builder ? renodx::color::pq::Decode(color, 100.f)
                    : renodx::color::pq::Encode(color, 100.f);
  }
  return color;
}