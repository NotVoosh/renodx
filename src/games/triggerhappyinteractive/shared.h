#ifndef SRC_TRIGGERHAPPYINTERACTIVE_SHARED_H_
#define SRC_TRIGGERHAPPYINTERACTIVE_SHARED_H_

#ifndef __cplusplus
#include "../../shaders/renodx.hlsl"
#endif

// Must be 32bit aligned
// Should be 4x32
struct ShaderInjectData {
  float toneMapType;
  float toneMapTypeAlt;
  float toneMapPeakNits;
  float toneMapGameNits;
  float toneMapUINits;
  float toneMapGammaCorrection;
  float toneMapHueProcessor;
  float toneMapHueShift;
  float toneMapHueCorrection;
  float toneMapColorSpace;
  float toneMapPerChannel;
  float toneMapShoulderStart;
  float colorGradeExposure;
  float colorGradeHighlights;
  float colorGradeShadows;
  float colorGradeContrast;
  float colorGradeSaturation;
  float colorGradeBlowout;
  float colorGradeDechroma;
  float colorGradeFlare;
  float colorGradeClip;
  float colorGradeLUTStrength;
  float colorGradeLUTScaling;
  float colorGradeLUTSampling;
  float colorGradeLUTShaper;
  float fxBloom;
  float fxVignette;
  float fxChroma;
  float fxNoise;
  float fxFilmGrain;
  float fxFilmGrainType;
  
  float random_1;
  float random_2;
  float random_3;
  bool is_UI;
};

#ifndef __cplusplus
cbuffer cb13 : register(b13) {
  ShaderInjectData injectedData : packoffset(c0);
}
#endif

#endif  // SRC_TRIGGERHAPPYINTERACTIVE_SHARED_H_