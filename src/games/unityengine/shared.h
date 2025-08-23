#ifndef SRC_UNITYENGINE_SHARED_H_
#define SRC_UNITYENGINE_SHARED_H_

#ifndef __cplusplus
//#define RENODX_COLOR_GRADE_HIGHLIGHTS_VERSION 2
#include "../../shaders/renodx.hlsl"
#endif

// Must be 32bit aligned
// Should be 4x32
struct ShaderInjectData {
  float toneMapType;
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

  float colorGradeInternalLUTStrength;
  float colorGradeInternalLUTScaling;
  float colorGradeInternalLUTShaper;
  float colorGradeLUTSampling;

  float colorGradeLUTScalingMode;
  float colorGradeUserLUTStrength;
  float colorGradeUserLUTScaling;
  float colorGradeColorSpace;

  float fxBloom;
  float fxVignette;
  float fxCA;
  float fxNoise;

  float fxFilmGrain;
  float fxFilmGrainType;
  float fxBloomUI;
  float random;
  
  float countOld;
  float countNew;
  float count2Old;
  float count2New;

  float tonemapCheck;
  float swapchainProxy;
  float FSRcheck;
  float gammaSpace;
  
  float blitCopyHack;
  float isClamped;
};

#ifndef __cplusplus
#if ((__SHADER_TARGET_MAJOR == 5 && __SHADER_TARGET_MINOR >= 1) || __SHADER_TARGET_MAJOR >= 6)
cbuffer cb13 : register(b13, space50) {
#elif (__SHADER_TARGET_MAJOR < 5) || ((__SHADER_TARGET_MAJOR == 5) && (__SHADER_TARGET_MINOR < 1))
cbuffer cb13 : register(b13) {
#endif
  ShaderInjectData injectedData : packoffset(c0);
}
#endif

#endif  // SRC_UNITYENGINE_SHARED_H_