/*
 * Copyright (C) 2023 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0

#include <deps/imgui/imgui.h>
#include <embed/shaders.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/date.hpp"
#include "../../utils/random.hpp"
#include "../../utils/settings.hpp"
#include "./shared.h"

namespace {

int unityTonemapper = 0;  // 1 = none, 2 = neutral/sapphire/custom, 3 = ACES
float g_use_swapchain_proxy = 0.f;
float countMid = 0.f;
float countOffset = 0.f;
float count2Mid = 0.f;
float count2Offset = 0.f;
float gammaSpace = 0.f;
bool gammaSpaceLock = false;
float blitCopyHack = 0.f;
bool blitCopyCheck = false;
bool forceDetect = false;
float FSRcheck = 0.f;
bool isClamped = false;
bool lutSampler = false;
bool lutBuilder = false;

ShaderInjectData shader_injection;

// LutGen, LutBuilder3D
// can hide
bool Tonemap1(reshade::api::command_list* cmd_list) {
  unityTonemapper = 1;
  forceDetect = true;
  return true;
}
bool Tonemap2(reshade::api::command_list* cmd_list) {
  unityTonemapper = 2;
  forceDetect = true;
  return true;
}
bool Tonemap3(reshade::api::command_list* cmd_list) {
  unityTonemapper = 3;
  forceDetect = true;
  return true;
}

// LutBuilderHdr NoTonemap, Lut3DBaker NoTonemap, Lut2DBaker, LutBuilderLdr,
// can have multiple draws
bool LutBuilderTonemap1(reshade::api::command_list* cmd_list) {
  unityTonemapper = unityTonemapper <= 1.f ? 1 : unityTonemapper;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  forceDetect = true;
  lutBuilder = true;
  return true;
}
bool LutBuilderTonemap2(reshade::api::command_list* cmd_list) {
  unityTonemapper = 2;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  forceDetect = true;
  lutBuilder = true;
  return true;
}
bool LutBuilderTonemap3(reshade::api::command_list* cmd_list) {
  unityTonemapper = 3;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  forceDetect = true;
  lutBuilder = true;
  return true;
}
bool Count(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  return true;
}
bool CountLinear(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  forceDetect = true;
  return true;
}
bool CountGamma(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 1.f;
  gammaSpaceLock = true;
  forceDetect = true;
  return true;
}

bool CountTonemapAdaptive(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  unityTonemapper = unityTonemapper <= 1.f ? 1.f : unityTonemapper;
  forceDetect = true;
  return true;
}

bool CountTonemap1(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  unityTonemapper = 1;
  forceDetect = true;
  return true;
}

bool CountLinearTonemap1(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  unityTonemapper = 1;
  forceDetect = true;
  return true;
}
bool CountGammaTonemap1(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  gammaSpace = 1.f;
  gammaSpaceLock = true;
  unityTonemapper = 1;
  forceDetect = true;
  return true;
}
bool CountLinearTonemap2(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  unityTonemapper = 2;
  forceDetect = true;
  return true;
}
bool CountLinearTonemap3(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  unityTonemapper = 3;
  forceDetect = true;
  return true;
}

// Uberpost
bool Uberpost(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  forceDetect = true;
  isClamped = isClamped ? isClamped : unityTonemapper != 1.f;
  lutSampler = true;
  return true;
}
bool UberpostLinear(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = isClamped ? isClamped : unityTonemapper != 1.f;
  lutSampler = true;
  return true;
}
bool UberpostGamma(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 1.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = isClamped ? isClamped : unityTonemapper != 1.f;
  lutSampler = true;
  return true;
}
// Uber
bool UberLinear(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = true;
  lutSampler = true;
  return true;
}
bool UberGamma(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 1.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = true;
  lutSampler = true;
  return true;
}
bool UberNeutralLinear(reshade::api::command_list* cmd_list) {
  unityTonemapper = 2;
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = true;
  lutSampler = true;
  return true;
}
bool UberNeutralGamma(reshade::api::command_list* cmd_list) {
  unityTonemapper = 2;
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 1.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = true;
  lutSampler = true;
  return true;
}
bool UberACESLinear(reshade::api::command_list* cmd_list) {
  unityTonemapper = 3;
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  gammaSpace = 0.f;
  gammaSpaceLock = true;
  forceDetect = true;
  isClamped = true;
  lutSampler = true;
  return true;
}

// FSR
bool FSR1(reshade::api::command_list* cmd_list) {
  FSRcheck = 1.f;
  return true;
}

// These were inlined, don't know the purpose of the code so I named it custom
bool Custom1(reshade::api::command_list* cmd_list) {
  unityTonemapper = unityTonemapper <= 1.f ? 1 : unityTonemapper;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  // shader_injection.blitCopyHack = blitCopyHack != 2.f ? 0.f : shader_injection.blitCopyHack;
  forceDetect = true;
  return true;
}

// Blit copy
bool Custom2(reshade::api::command_list* cmd_list) {
  blitCopyCheck = true;
  unityTonemapper = shader_injection.blitCopyHack == 1.f ? (unityTonemapper <= 1.f ? 1 : unityTonemapper) : unityTonemapper;
  countMid += shader_injection.blitCopyHack >= 1.f ? 1.f : 0.f;
  shader_injection.countNew += shader_injection.blitCopyHack >= 1.f ? 1.f : 0.f;
  shader_injection.count2New += shader_injection.blitCopyHack == 1.f ? 1.f : 0.f;
  count2Mid += shader_injection.blitCopyHack == 1.f ? 1.f : 0.f;
  return true;
}

// Blend for bloom
bool Custom3(reshade::api::command_list* cmd_list) {
  countMid += 1.f;
  shader_injection.countNew += 1.f;
  shader_injection.count2New += 1.f;
  count2Mid += 1.f;
  unityTonemapper = 1;
  // shader_injection.blitCopyHack = blitCopyHack != 2.f ? 0.f : shader_injection.blitCopyHack;
  forceDetect = true;
  return true;
}

#define FSR1OnReplace(value)  \
  {                           \
      value,                  \
      {                       \
          .crc32 = value,     \
          .code = __##value,  \
          .on_replace = FSR1, \
      },                      \
  }

#define FSR1OnDrawn(value)   \
  {                          \
      value,                 \
      {                      \
          .crc32 = value,    \
          .code = __##value, \
          .on_drawn = FSR1,  \
      },                     \
  }

#define CountLinearOnReplace(value)  \
  {                                  \
      value,                         \
      {                              \
          .crc32 = value,            \
          .code = __##value,         \
          .on_replace = CountLinear, \
      },                             \
  }

#define CountGammaOnReplace(value)  \
  {                                 \
      value,                        \
      {                             \
          .crc32 = value,           \
          .code = __##value,        \
          .on_replace = CountGamma, \
      },                            \
  }

#define CountTonemapAdaptiveOnReplace(value)  \
  {                                           \
      value,                                  \
      {                                       \
          .crc32 = value,                     \
          .code = __##value,                  \
          .on_replace = CountTonemapAdaptive, \
      },                                      \
  }

#define CountTonemap1OnReplace(value)  \
  {                                    \
      value,                           \
      {                                \
          .crc32 = value,              \
          .code = __##value,           \
          .on_replace = CountTonemap1, \
      },                               \
  }

#define CountLinearTonemap1OnReplace(value)  \
  {                                          \
      value,                                 \
      {                                      \
          .crc32 = value,                    \
          .code = __##value,                 \
          .on_replace = CountLinearTonemap1, \
      },                                     \
  }

#define CountLinearTonemap2OnReplace(value)  \
  {                                          \
      value,                                 \
      {                                      \
          .crc32 = value,                    \
          .code = __##value,                 \
          .on_replace = CountLinearTonemap2, \
      },                                     \
  }

#define CountLinearTonemap3OnReplace(value)  \
  {                                          \
      value,                                 \
      {                                      \
          .crc32 = value,                    \
          .code = __##value,                 \
          .on_replace = CountLinearTonemap3, \
      },                                     \
  }

#define CountGammaTonemap1OnReplace(value)  \
  {                                         \
      value,                                \
      {                                     \
          .crc32 = value,                   \
          .code = __##value,                \
          .on_replace = CountGammaTonemap1, \
      },                                    \
  }

#define CountOnReplace(value)  \
  {                            \
      value,                   \
      {                        \
          .crc32 = value,      \
          .code = __##value,   \
          .on_replace = Count, \
      },                       \
  }

#define UberPostOnReplace(value)  \
  {                               \
      value,                      \
      {                           \
          .crc32 = value,         \
          .code = __##value,      \
          .on_replace = Uberpost, \
      },                          \
  }

#define UberLinearOnReplace(value)  \
  {                                 \
      value,                        \
      {                             \
          .crc32 = value,           \
          .code = __##value,        \
          .on_replace = UberLinear, \
      },                            \
  }

#define UberPostLinearOnReplace(value)  \
  {                                     \
      value,                            \
      {                                 \
          .crc32 = value,               \
          .code = __##value,            \
          .on_replace = UberpostLinear, \
      },                                \
  }

#define UberNeutralLinearOnReplace(value)  \
  {                                        \
      value,                               \
      {                                    \
          .crc32 = value,                  \
          .code = __##value,               \
          .on_replace = UberNeutralLinear, \
      },                                   \
  }

#define UberGammaOnReplace(value)  \
  {                                \
      value,                       \
      {                            \
          .crc32 = value,          \
          .code = __##value,       \
          .on_replace = UberGamma, \
      },                           \
  }

#define UberPostGammaOnReplace(value)  \
  {                                    \
      value,                           \
      {                                \
          .crc32 = value,              \
          .code = __##value,           \
          .on_replace = UberpostGamma, \
      },                               \
  }

#define UberNeutralGammaOnReplace(value)  \
  {                                       \
      value,                              \
      {                                   \
          .crc32 = value,                 \
          .code = __##value,              \
          .on_replace = UberNeutralGamma, \
      },                                  \
  }

#define UberACESLinearOnReplace(value)  \
  {                                     \
      value,                            \
      {                                 \
          .crc32 = value,               \
          .code = __##value,            \
          .on_replace = UberACESLinear, \
      },                                \
  }

#define LutBuilderTonemap1OnReplace(value)  \
  {                                         \
      value,                                \
      {                                     \
          .crc32 = value,                   \
          .code = __##value,                \
          .on_replace = LutBuilderTonemap1, \
      },                                    \
  }

#define LutBuilderTonemap2OnReplace(value)  \
  {                                         \
      value,                                \
      {                                     \
          .crc32 = value,                   \
          .code = __##value,                \
          .on_replace = LutBuilderTonemap2, \
      },                                    \
  }

#define LutBuilderTonemap3OnReplace(value)  \
  {                                         \
      value,                                \
      {                                     \
          .crc32 = value,                   \
          .code = __##value,                \
          .on_replace = LutBuilderTonemap3, \
      },                                    \
  }

#define Tonemap1OnReplace(value)  \
  {                               \
      value,                      \
      {                           \
          .crc32 = value,         \
          .code = __##value,      \
          .on_replace = Tonemap1, \
      },                          \
  }

#define Tonemap2OnReplace(value)  \
  {                               \
      value,                      \
      {                           \
          .crc32 = value,         \
          .code = __##value,      \
          .on_replace = Tonemap2, \
      },                          \
  }

#define Tonemap3OnReplace(value)  \
  {                               \
      value,                      \
      {                           \
          .crc32 = value,         \
          .code = __##value,      \
          .on_replace = Tonemap3, \
      },                          \
  }

#define NoTonemapOnReplace(value) \
  {                               \
      value,                      \
      {                           \
          .crc32 = value,         \
          .code = __##value,      \
          .on_replace = Tonemap3, \
      },                          \
  }

#define Custom1OnReplace(value)  \
  {                              \
      value,                     \
      {                          \
          .crc32 = value,        \
          .code = __##value,     \
          .on_replace = Custom1, \
      },                         \
  }

#define Custom2OnReplace(value)  \
  {                              \
      value,                     \
      {                          \
          .crc32 = value,        \
          .code = __##value,     \
          .on_replace = Custom2, \
      },                         \
  }

#define Custom3OnReplace(value)  \
  {                              \
      value,                     \
      {                          \
          .crc32 = value,        \
          .code = __##value,     \
          .on_replace = Custom3, \
      },                         \
  }

renodx::mods::shader::CustomShaders custom_shaders = {
    ////// HDRP START //////
    // only needed to workaround fsr1
    FSR1OnReplace(0x18151718),
    FSR1OnReplace(0xA7F94682),
    FSR1OnReplace(0xE59F5A45),
    FSR1OnReplace(0x59A9259E),
    FSR1OnReplace(0xB9857DFB),
    FSR1OnReplace(0x7158A819),
    FSR1OnReplace(0xF6574655),
    FSR1OnReplace(0x45C0BC06),
    FSR1OnReplace(0x2248992F),
    FSR1OnReplace(0xA53F9357),
    ////// HDRP END //////
    ////// CUSTOM START //////
    CountLinearOnReplace(0x459D4153),
    CountLinearOnReplace(0xB0826385),
    CountLinearTonemap1OnReplace(0x07FD3D55),  // Neva
    CountOnReplace(0x4C1E450F),                // RetroPixelPro
    CountLinearTonemap1OnReplace(0xBD332C3A),  // PostFx GlowComposite
    CountLinearTonemap1OnReplace(0x3E8A6AF2),  // CameraFilterPack 2Lut
    // CountLinearOnReplace(0xB47E4A58, &CountLinear),    // Water Effect
    CountLinearTonemap2OnReplace(0xFE4139AC),  // TLSA
    CountLinearTonemap1OnReplace(0x21AB084F),  // Gamma (Republique)
    CountLinearTonemap2OnReplace(0x0D0F308B),  // Kyoto PostProcess
    CountGammaTonemap1OnReplace(0x50962AFA),   // EtG gammagamma
    CountGammaTonemap1OnReplace(0x50962AFA),   // EtG pixelator
    CountLinearTonemap3OnReplace(0xB587B9F9),  // Frame Composite (Wheel World)
    ////// CUSTOM END //////
    ////// DIVISION START //////
    // Chromatic Aberration
    CountTonemapAdaptiveOnReplace(0xEEE589B3),
    CountTonemapAdaptiveOnReplace(0x937A4C13),
    CountTonemapAdaptiveOnReplace(0x3F6031DA),
    CountTonemapAdaptiveOnReplace(0x0E6D86E9),
    // Vignetting
    CountTonemapAdaptiveOnReplace(0x88608A73),
    CountTonemapAdaptiveOnReplace(0x23E39077),
    CountTonemapAdaptiveOnReplace(0x35E7772D),
    CountTonemapAdaptiveOnReplace(0x1BA9B943),
    CountTonemapAdaptiveOnReplace(0x28A6A0C0),
    CountTonemapAdaptiveOnReplace(0x85285389),
    // Bloom
    CountTonemapAdaptiveOnReplace(0x5D9A0B26),  // Fast Bloom
    CountTonemapAdaptiveOnReplace(0xAC07576C),  // SENaturalBloom
    CountTonemapAdaptiveOnReplace(0x5D511B6E),  // SENaturalBloom
    CountTonemapAdaptiveOnReplace(0xAEFFC61C),  // Blend for bloom
    // Color Correction Curves
    CountTonemapAdaptiveOnReplace(0x488FE86B),  // Simple
    CountTonemapAdaptiveOnReplace(0x116B98EA),  // Simple
    //
    CountOnReplace(0x0BF02D38),               // Noise and Grain
    CountGammaTonemap1OnReplace(0xB55175D9),  // Screen Sobel Outline
    // Colorful
    CountTonemapAdaptiveOnReplace(0x7108F19B),  // BCG
    CountTonemapAdaptiveOnReplace(0xFD95CDDE),  // HSV (maybe gamma ?)
    CountTonemapAdaptiveOnReplace(0xB2C03C2D),  // Photo Filter
    // CC
    CountTonemapAdaptiveOnReplace(0x50D362B8),  // Fast Vignette
    CountGammaTonemap1OnReplace(0xDAEBFDF2),    // Lookup Filter (maybe not gamma)
    // Scion Combination Pass
    CountTonemapAdaptiveOnReplace(0x12FB835F),
    CountTonemapAdaptiveOnReplace(0x5456E1AA),
    CountTonemapAdaptiveOnReplace(0x956198C2),
    CountTonemapAdaptiveOnReplace(0xA5B9C43C),
    CountTonemapAdaptiveOnReplace(0xA206F965),
    CountTonemapAdaptiveOnReplace(0x0DA28928),
    CountLinearTonemap2OnReplace(0x2E658124),
    ////// DIVISION END //////
    ////// UBER START //////
    /// to be verified ///
    CountGammaTonemap1OnReplace(0x3E60912E),
    /// Post FX ///
    // LUT
    CountLinearOnReplace(0x0E014F53),
    CountLinearOnReplace(0x7E130053),
    CountLinearOnReplace(0x01D2D2B8),
    CountLinearOnReplace(0x7BB0D55E),
    CountLinearOnReplace(0x3DA8F050),
    CountLinearOnReplace(0xFE41EA26),
    CountLinearOnReplace(0xFC2F2508),
    CountLinearOnReplace(0xFB3D67A8),
    CountLinearOnReplace(0xF7099E42),
    CountLinearOnReplace(0xF9B0D779),
    CountLinearOnReplace(0xF1C2CE47),
    CountLinearOnReplace(0xECDC6EC9),
    CountLinearOnReplace(0xE9A6F5FA),
    CountLinearOnReplace(0xD7048ECF),
    CountLinearOnReplace(0xCACDD22E),
    CountLinearOnReplace(0xC3EA0270),
    CountLinearOnReplace(0xB5617B06),
    CountLinearOnReplace(0xA810454B),
    CountLinearOnReplace(0xA79BF32E),
    CountLinearOnReplace(0xA34CD90A),
    CountLinearOnReplace(0x51459A11),
    CountLinearOnReplace(0x8903C9E4),
    CountLinearOnReplace(0x6420BDE4),
    CountLinearOnReplace(0x959B3FB7),
    CountLinearOnReplace(0x761CCEC0),
    CountLinearOnReplace(0x702E161F),
    CountLinearOnReplace(0x76E8C9E0),
    CountLinearOnReplace(0x43CD25CE),
    CountLinearOnReplace(0x16C17744),
    CountLinearOnReplace(0x9FDCD9DC),
    CountLinearOnReplace(0x7F1AF2FE),
    CountLinearOnReplace(0xBACB2204),
    CountLinearOnReplace(0xB48DB980),
    CountLinearOnReplace(0x7007E15E),
    CountLinearOnReplace(0x6848BE5C),
    CountGammaOnReplace(0x8C89A7D0),
    CountGammaOnReplace(0x46AE5D9D),
    CountGammaOnReplace(0xA9BA96AB),
    CountGammaOnReplace(0x851392C2),
    CountGammaOnReplace(0xA316B6FD),
    CountGammaOnReplace(0xE1A21B07),
    CountGammaOnReplace(0xEE5CA39C),
    CountGammaOnReplace(0x734AEDAD),
    CountGammaOnReplace(0x5311B657),
    CountGammaOnReplace(0x9B557C06),
    // no LUT
    CountLinearTonemap1OnReplace(0xD73AD73D),  // user LUT
    CountLinearTonemap1OnReplace(0x9031E6E6),  // user LUT
    CountLinearTonemap1OnReplace(0x2AA95E6B),
    CountLinearTonemap1OnReplace(0x7CE8D532),
    CountLinearTonemap1OnReplace(0x73B11B12),
    CountGammaTonemap1OnReplace(0x153D1995),
    CountGammaTonemap1OnReplace(0x1CAABDB2),
    CountGammaTonemap1OnReplace(0xCE0AF0C9),
    CountGammaTonemap1OnReplace(0x5B924DC5),
    /// Uber (SDR internal LUT) ///
    // SRGB LUT
    UberLinearOnReplace(0x1C8D5E9F),
    UberLinearOnReplace(0x2B2B673C),
    UberLinearOnReplace(0x4A9DC131),
    UberLinearOnReplace(0x4B0DE7CD),
    UberLinearOnReplace(0x5CD23656),
    UberLinearOnReplace(0x8CBAADE3),
    UberLinearOnReplace(0x9EA7EE21),
    UberLinearOnReplace(0x47DDAF39),
    UberLinearOnReplace(0x485D45AC),
    UberLinearOnReplace(0x937ECFDB),
    UberLinearOnReplace(0x6529C56E),
    UberLinearOnReplace(0x8191B510),
    UberLinearOnReplace(0x23448FC5),
    UberLinearOnReplace(0x31271C46),
    UberLinearOnReplace(0x206927BB),
    UberLinearOnReplace(0xC493FA01),
    UberLinearOnReplace(0xE002CDC8),
    UberLinearOnReplace(0xFBF8FE52),
    UberLinearOnReplace(0xFDE5FE89),
    UberGammaOnReplace(0x1237D610),
    UberGammaOnReplace(0x2DFCB189),
    UberGammaOnReplace(0x3F4B346E),
    UberGammaOnReplace(0x3F7E2590),
    UberGammaOnReplace(0x05D7FD3F),
    UberGammaOnReplace(0x5ED6AF8F),
    UberGammaOnReplace(0x6B383D5D),
    UberGammaOnReplace(0x26D16BD4),
    UberGammaOnReplace(0x28E64619),
    UberGammaOnReplace(0x9DC0BD71),
    UberGammaOnReplace(0x73A5E561),
    UberGammaOnReplace(0x092D4CC5),
    UberGammaOnReplace(0x05004E3A),
    UberGammaOnReplace(0x6409B3A8),
    UberGammaOnReplace(0x97379D6B),
    UberGammaOnReplace(0xAC23ED8C),
    UberGammaOnReplace(0xC85DC52C),
    UberGammaOnReplace(0xDEF5AB02),
    UberGammaOnReplace(0xF647C7C7),
    UberGammaOnReplace(0xFE221F8E),
    // Linear LUT
    // NoTonemap
    UberLinearOnReplace(0x71A2C76F),
    UberLinearOnReplace(0xD1414798),
    UberLinearOnReplace(0xDC56B686),
    UberLinearOnReplace(0xE9E072CB),
    UberLinearOnReplace(0x2A1C50A3),
    UberLinearOnReplace(0x2B67D8D5),
    UberLinearOnReplace(0x3C1076FD),
    UberLinearOnReplace(0x76DB4A6B),
    UberLinearOnReplace(0x81F618AE),
    UberLinearOnReplace(0x2546D5B8),
    UberLinearOnReplace(0xF211C0FB),
    UberLinearOnReplace(0x5D2E23EB),
    UberLinearOnReplace(0x0948E708),
    UberLinearOnReplace(0x3168A95B),
    UberLinearOnReplace(0x9862BA48),
    UberLinearOnReplace(0x1906BE79),
    UberLinearOnReplace(0x15A063ED),
    UberLinearOnReplace(0x22F1555A),
    UberLinearOnReplace(0xBB09D0B3),
    UberLinearOnReplace(0xB2FA9650),
    UberLinearOnReplace(0x614D4290),
    UberLinearOnReplace(0x333D4088),
    UberLinearOnReplace(0xA1BB94CF),
    UberLinearOnReplace(0xB75D73F2),
    UberLinearOnReplace(0x4892C014),
    UberLinearOnReplace(0x077C4EBE),
    UberLinearOnReplace(0x70F983D7),
    UberLinearOnReplace(0x5808E5C6),
    UberLinearOnReplace(0x3816ADE8),
    UberLinearOnReplace(0x9BD5D660),
    UberLinearOnReplace(0xA57C372D),
    UberLinearOnReplace(0x943DD65F),
    UberLinearOnReplace(0x6BC3D81A),
    UberLinearOnReplace(0x5EE0EFE9),
    UberLinearOnReplace(0x7C36C890),
    UberLinearOnReplace(0x8596AD69),
    UberLinearOnReplace(0x83BB5283),
    UberLinearOnReplace(0x53F75ED5),
    UberLinearOnReplace(0x80C9179E),
    UberLinearOnReplace(0xB8F165EF),
    UberGammaOnReplace(0xA6918C83),
    UberGammaOnReplace(0xB68E535D),
    UberGammaOnReplace(0xAE4C1F32),
    UberGammaOnReplace(0x36C8462C),
    UberGammaOnReplace(0x7BF140C8),
    UberGammaOnReplace(0x6C62EB79),
    UberGammaOnReplace(0x6D14DFE7),
    UberGammaOnReplace(0x743B1716),
    UberGammaOnReplace(0xB8273F73),
    UberGammaOnReplace(0x8D662497),
    UberGammaOnReplace(0x96AF3D66),
    UberGammaOnReplace(0x91F65AEA),
    UberGammaOnReplace(0x7721FCA2),
    UberGammaOnReplace(0x014A40C4),
    UberGammaOnReplace(0xD8E61F5F),
    UberGammaOnReplace(0xDE7ECF75),
    UberGammaOnReplace(0xE4BA540E),
    UberGammaOnReplace(0x1CDF4AD9),
    UberGammaOnReplace(0x1D4D40B0),
    UberGammaOnReplace(0x4A87FC29),
    UberGammaOnReplace(0x24D21B11),
    UberGammaOnReplace(0x29B13A00),
    UberGammaOnReplace(0xFAE40278),
    UberGammaOnReplace(0xFC0CC93E),
    UberGammaOnReplace(0xFEECAC6F),
    UberGammaOnReplace(0x319DDF0E),
    UberGammaOnReplace(0xAE1D9195),
    UberGammaOnReplace(0x9048747B),
    UberGammaOnReplace(0x33D922FC),
    // Neutral
    UberNeutralLinearOnReplace(0x0B383A2F),
    UberNeutralLinearOnReplace(0x6A5ACB6F),
    UberNeutralLinearOnReplace(0x009A1C24),
    UberNeutralLinearOnReplace(0x66C3EBEB),
    UberNeutralLinearOnReplace(0x96A8E4B9),
    UberNeutralLinearOnReplace(0x5217FBA3),
    UberNeutralLinearOnReplace(0x5456BDEE),
    UberNeutralLinearOnReplace(0x8613B876),
    UberNeutralLinearOnReplace(0xA8F6504E),
    UberNeutralLinearOnReplace(0xAC471C80),
    UberNeutralLinearOnReplace(0xAD809271),
    UberNeutralLinearOnReplace(0xC999597C),
    UberNeutralLinearOnReplace(0xE73E4C20),
    UberNeutralLinearOnReplace(0xD5C07171),
    UberNeutralLinearOnReplace(0xF849180D),
    UberNeutralLinearOnReplace(0x312AE5CE),
    UberNeutralLinearOnReplace(0x4CBE7398),
    UberNeutralLinearOnReplace(0x04D5BD3C),
    UberNeutralGammaOnReplace(0x692D142C),
    UberNeutralGammaOnReplace(0x0EA73DAA),
    // ACES
    UberACESLinearOnReplace(0x1C42C445),
    UberACESLinearOnReplace(0x2C36979C),
    UberACESLinearOnReplace(0x4B92CD8E),
    UberACESLinearOnReplace(0xEF39E7C4),
    UberACESLinearOnReplace(0xFDA8A0F6),
    UberACESLinearOnReplace(0x9A27FDCD),
    UberACESLinearOnReplace(0x9D2A9AD7),
    UberACESLinearOnReplace(0x51B31CD0),
    UberACESLinearOnReplace(0x60CD88E9),
    UberACESLinearOnReplace(0x63F63B73),
    UberACESLinearOnReplace(0x65EDD253),
    UberACESLinearOnReplace(0x72D26F35),
    UberACESLinearOnReplace(0x232C3736),
    UberACESLinearOnReplace(0x501CABD3),
    UberACESLinearOnReplace(0x622FF869),
    UberACESLinearOnReplace(0x709B90C7),
    UberACESLinearOnReplace(0x08331DE7),
    UberACESLinearOnReplace(0xA6AFBE57),
    UberACESLinearOnReplace(0xA9329B7F),
    UberACESLinearOnReplace(0xB4323752),
    UberACESLinearOnReplace(0xC9F897D5),
    UberACESLinearOnReplace(0xC593D007),
    UberACESLinearOnReplace(0xD8C3ADEB),
    UberACESLinearOnReplace(0xE651D798),
    UberACESLinearOnReplace(0x6FEECA44),
    UberACESLinearOnReplace(0x6F7A89B5),
    UberACESLinearOnReplace(0x182FA95D),
    UberACESLinearOnReplace(0xC01FA28B),
    UberACESLinearOnReplace(0xB28D0124),
    UberACESLinearOnReplace(0x2C0EA618),
    /// Uberpost (HDR internal LUT) ///
    // LUT
    UberPostLinearOnReplace(0xC77C6136),
    UberPostLinearOnReplace(0x8E8030DA),
    UberPostLinearOnReplace(0xF9D83ECD),
    UberPostLinearOnReplace(0x70F25296),
    UberPostLinearOnReplace(0xD25C43B1),
    UberPostLinearOnReplace(0xD4543B6E),
    UberPostLinearOnReplace(0xD86170D7),
    UberPostLinearOnReplace(0xDB814E6C),
    UberPostLinearOnReplace(0xE0D21C32),
    UberPostLinearOnReplace(0xE0E4140C),
    UberPostLinearOnReplace(0xE46F9DE9),
    UberPostLinearOnReplace(0xE279EC1D),
    UberPostLinearOnReplace(0x0EC64D75),
    UberPostLinearOnReplace(0x0F4188A5),
    UberPostLinearOnReplace(0x1BF2161B),
    UberPostLinearOnReplace(0x1E7FFDBB),
    UberPostLinearOnReplace(0x1E66576A),
    UberPostLinearOnReplace(0x1F59543C),
    UberPostLinearOnReplace(0x2EB942D3),
    UberPostLinearOnReplace(0x2F17859B),
    UberPostLinearOnReplace(0x3C71577B),
    UberPostLinearOnReplace(0x3D7D2ACF),
    UberPostLinearOnReplace(0x4A872453),
    UberPostLinearOnReplace(0x9CFC6AFA),
    UberPostLinearOnReplace(0x4C89E2E6),
    UberPostLinearOnReplace(0x4D9C39DC),
    UberPostLinearOnReplace(0x4DD5AD48),
    UberPostLinearOnReplace(0x5A6D38E4),
    UberPostLinearOnReplace(0x5A9A3BCA),
    UberPostLinearOnReplace(0x8C673209),
    UberPostLinearOnReplace(0x9DBEB2FA),
    UberPostLinearOnReplace(0x41CA1DD6),
    UberPostLinearOnReplace(0x69C7EC21),
    UberPostLinearOnReplace(0x116ED5A6),
    UberPostLinearOnReplace(0x404CC9B9),
    UberPostLinearOnReplace(0x599DC26E),
    UberPostLinearOnReplace(0x783ABD54),
    UberPostLinearOnReplace(0x916E68A2),
    UberPostLinearOnReplace(0x995B36D9),
    UberPostLinearOnReplace(0x1666C38C),
    UberPostLinearOnReplace(0x3655F826),
    UberPostLinearOnReplace(0x81198D61),
    UberPostLinearOnReplace(0x99273E5D),
    UberPostLinearOnReplace(0xAB9BAF73),
    UberPostLinearOnReplace(0xBD3E0603),
    UberPostLinearOnReplace(0xBE55DA79),
    UberPostLinearOnReplace(0xBE655D3E),
    UberPostLinearOnReplace(0xC1D1E672),
    UberPostLinearOnReplace(0xD213345E),
    UberPostLinearOnReplace(0xE5994A4B),
    UberPostLinearOnReplace(0xECD0DFE1),
    UberPostLinearOnReplace(0xEF7C8F91),
    UberPostLinearOnReplace(0xF2CB5D37),
    UberPostLinearOnReplace(0xF455EE3C),
    UberPostLinearOnReplace(0xFA2F9A68),
    UberPostLinearOnReplace(0xFC0ECCE8),
    UberPostLinearOnReplace(0xFF4E4EF2),
    UberPostLinearOnReplace(0x6BE60185),
    UberPostLinearOnReplace(0x6D14F22A),
    UberPostLinearOnReplace(0x06D31F1D),
    UberPostLinearOnReplace(0x7E2A04D8),
    UberPostLinearOnReplace(0x9BC48214),
    UberPostLinearOnReplace(0x9CC447BF),
    UberPostLinearOnReplace(0x9DD6F785),
    UberPostLinearOnReplace(0x18DC6A24),
    UberPostLinearOnReplace(0x41B1FF38),
    UberPostLinearOnReplace(0x46D3ECE8),
    UberPostLinearOnReplace(0x63D93240),
    UberPostLinearOnReplace(0x71A4E35E),
    UberPostLinearOnReplace(0x86E67F52),
    UberPostLinearOnReplace(0x272EB112),
    UberPostLinearOnReplace(0x440F1911),
    UberPostLinearOnReplace(0x728A5929),
    UberPostLinearOnReplace(0x808BC2A2),
    UberPostLinearOnReplace(0x957EC72A),
    UberPostLinearOnReplace(0x2706BB7A),
    UberPostLinearOnReplace(0x3087C1DD),
    UberPostLinearOnReplace(0x7213BEF2),
    UberPostLinearOnReplace(0x8135A20B),
    UberPostLinearOnReplace(0x038607D0),
    UberPostLinearOnReplace(0x43621B25),
    UberPostLinearOnReplace(0x063470DC),
    UberPostLinearOnReplace(0xA46C1ECB),
    UberPostLinearOnReplace(0xA34705B5),
    UberPostLinearOnReplace(0xAF565E99),
    UberPostLinearOnReplace(0xAFBE175C),
    UberPostLinearOnReplace(0xB8D14E32),
    UberPostLinearOnReplace(0xB8308863),
    UberPostLinearOnReplace(0xC5D7F1A1),
    UberPostLinearOnReplace(0xC63B24BB),
    UberPostLinearOnReplace(0xCF7B19D4),
    UberPostLinearOnReplace(0x7E2F585E),
    UberPostLinearOnReplace(0x14AC9B94),
    UberPostLinearOnReplace(0x02E86441),
    UberPostLinearOnReplace(0xA42C0E37),
    UberPostLinearOnReplace(0xB4780190),  // user LUT
    UberPostLinearOnReplace(0x83CC7F92),  // user LUT
    UberPostLinearOnReplace(0x2998DD23),  // user LUT
    UberPostLinearOnReplace(0xAE047DF6),  // user LUT
    UberPostLinearOnReplace(0x127B53F7),  // user LUT
    UberPostLinearOnReplace(0x0733A496),  // user LUT
    UberPostLinearOnReplace(0x10D74361),  // user LUT
    UberPostLinearOnReplace(0xADFD88AD),  // user LUT
    UberPostLinearOnReplace(0x95B85C10),  // user LUT
    UberPostLinearOnReplace(0x6C71F0B5),  // user LUT
    UberPostLinearOnReplace(0xC2976820),  // user LUT
    UberPostLinearOnReplace(0x4069CE6C),  // user LUT
    UberPostLinearOnReplace(0x134700A7),  // user LUT
    UberPostLinearOnReplace(0xB39F3D8A),  // user LUT
    UberPostLinearOnReplace(0x7CA9D945),  // user LUT
    UberPostLinearOnReplace(0x4233DBE0),  // user LUT
    UberPostLinearOnReplace(0x8C592D8D),  // user LUT
    UberPostLinearOnReplace(0x9CB51433),
    UberPostLinearOnReplace(0x18486417),
    UberPostGammaOnReplace(0x0CA6FA43),
    UberPostGammaOnReplace(0x06C7255C),
    UberPostGammaOnReplace(0x30E315A6),
    UberPostGammaOnReplace(0x06EEEE16),
    UberPostGammaOnReplace(0x6F30CACB),
    UberPostGammaOnReplace(0x32B27DC5),
    UberPostGammaOnReplace(0x58F9D31B),
    UberPostGammaOnReplace(0x78EF9B01),
    UberPostGammaOnReplace(0x0105BFBA),
    UberPostGammaOnReplace(0x177B85BE),
    UberPostGammaOnReplace(0x478DF3D8),
    UberPostGammaOnReplace(0x5616E459),
    UberPostGammaOnReplace(0x15032A70),
    UberPostGammaOnReplace(0xB4FCC459),
    UberPostGammaOnReplace(0xBEDE7F5E),
    UberPostGammaOnReplace(0xC3DC274E),
    UberPostGammaOnReplace(0xC8C2F1A0),
    UberPostGammaOnReplace(0xDF21D66E),
    UberPostGammaOnReplace(0xD32FF805),
    UberPostGammaOnReplace(0xEB0157F3),
    UberPostGammaOnReplace(0xEC929462),
    UberPostGammaOnReplace(0x10A31D94),
    UberPostGammaOnReplace(0xD0CC549E),
    UberPostGammaOnReplace(0x164B94AF),
    UberPostGammaOnReplace(0x9326C2CF),
    UberPostOnReplace(0x3BF59C8D),  // linear/gamma (cbuffer)
    UberPostOnReplace(0x664C7B0C),  // linear/gamma (cbuffer)
    UberPostOnReplace(0xABB348D3),  // linear/gamma (cbuffer)
                                    // No LUT (unknown)       // TO DO: CHECK
    CountLinearTonemap1OnReplace(0x9E21F0DF),
    CountGammaTonemap1OnReplace(0x34A4537A),
    CountLinearOnReplace(0x92C3775F),
    CountLinearTonemap1OnReplace(0x4757CDEB),
    CountLinearOnReplace(0xA8773EA9),
    CountGammaTonemap1OnReplace(0x53DF7115),  // CotL
    CountGammaTonemap1OnReplace(0x56C90ED5),  // CotL
    CountGammaTonemap1OnReplace(0x70EEA44B),  // CotL
    CountGammaTonemap1OnReplace(0x6946B0AB),  // CotL
    CountGammaTonemap1OnReplace(0x79295705),  // CotL
    CountGammaTonemap1OnReplace(0xA1EA3B3E),  // CotL
    CountGammaTonemap1OnReplace(0xC7B8A4A1),  // CotL
    CountGammaTonemap1OnReplace(0xE832FE2B),  // CotL
    CountGammaTonemap1OnReplace(0xE9177A14),  // CotL
    CountGammaTonemap1OnReplace(0xF89DA645),  // CotL
    CountGammaTonemap1OnReplace(0xF180FFF6),  // CotL
    CountGammaTonemap1OnReplace(0xFF444EF2),  // CotL
    CountGammaTonemap1OnReplace(0x4CEC1E87),  // CotL
    CountLinearOnReplace(0x83B430B4),
    CountLinearTonemap1OnReplace(0xB47EF759),
    CountGammaTonemap1OnReplace(0xBFCFF9BC),
    CountGammaTonemap1OnReplace(0xD12C9D2F),
    CountGammaTonemap1OnReplace(0xEAD9C39B),
    CountGammaTonemap1OnReplace(0xF25F3D34),
    CountLinearTonemap1OnReplace(0xF95C788E),
    CountLinearTonemap1OnReplace(0x6DD82EF0),
    // 0x2365EDDF
    // 0x455563C6

    CountLinearOnReplace(0xEBC7375B),
    CountLinearOnReplace(0x5C428D81),
    /// Uber weird ///
    // Sapphire (Windbound)
    CountLinearTonemap2OnReplace(0x2B0930CC),
    CountLinearTonemap2OnReplace(0x8D4D9A63),
    CountLinearTonemap2OnReplace(0x8DF1BF80),
    CountLinearTonemap2OnReplace(0x14A5B821),
    CountLinearTonemap2OnReplace(0x15E132D9),
    CountLinearTonemap2OnReplace(0x171A0A90),
    CountLinearTonemap2OnReplace(0x85653627),
    CountLinearTonemap2OnReplace(0xAE663C8F),
    CountLinearTonemap2OnReplace(0xBA4DCC6E),
    CountLinearTonemap2OnReplace(0xE01E2588),
    // Neutral
    CountLinearTonemap2OnReplace(0x794570B1),  // Unlit Composite
                                               // Beautify
    CountLinearTonemap2OnReplace(0xECBDB4D4),
    CountLinearTonemap2OnReplace(0xBF6B8004),  // LUT
    CountLinearTonemap2OnReplace(0x33BF2974),
    // No Tonemap

    CountTonemapAdaptiveOnReplace(0x4F6C23CE),  // ColorCorrectionLUT (baked)
    Custom1OnReplace(0x1EFD76DD),
    Custom2OnReplace(0x49E25D6C),
    Custom2OnReplace(0x8674BE1F),
    Custom3OnReplace(0xB9321BA4),  // Blend for bloom
    Custom3OnReplace(0xE60F40B0),
    CountLinearTonemap1OnReplace(0x4A979145),  // brightness
    CountLinearOnReplace(0xF3B603D6),          // amplify color base
    CountGammaTonemap1OnReplace(0xDF0F14A0),   // amplify color base
    CountGammaOnReplace(0xDF0F14A0),           // amplify color blend
    CountLinearOnReplace(0x01C485EF),          // amplify color base linear
    CountLinearOnReplace(0x864A0CDA),          // amplify color base
    CountLinearOnReplace(0x733AC097),          // pp tonemap

    // CountLinearOnReplace(0xDA7FDEFA),
    /*CustomShaderEntryCallback(0x2E658124, [](reshade::api::command_list* cmd_list) {    // scion combination pass
    unityTonemapper = 2;
    countMid += 1.f;
    shader_injection.countNew += 1.f;
    return true;
    }),*/
    CountOnReplace(0xDDC38AD4),  // colorful/levels
    CountOnReplace(0xADFFB914),  // CRT/PostProcessing
    ////// UBER END //////
    ////// POSTFINAL START //////
    //
    CountLinearOnReplace(0x1EF2268F),
    CountLinearOnReplace(0x366EE13E),
    CountGammaOnReplace(0xD90A4513),
    CountGammaOnReplace(0xEB23B0ED),
    // FXAA
    CountLinearOnReplace(0x0D7738C5),
    CountLinearOnReplace(0x3E0783E6),
    CountLinearOnReplace(0x0175C0E5),
    CountLinearOnReplace(0x5CC458E2),
    CountLinearOnReplace(0x623A834B),
    CountLinearOnReplace(0x83775429),
    CountLinearOnReplace(0xA95311EA),
    CountLinearOnReplace(0xABF2B519),
    CountLinearOnReplace(0xB2E77E10),
    CountLinearOnReplace(0xB13A3CBB),
    CountLinearOnReplace(0xCC8B6ACF),
    CountLinearOnReplace(0xD00B5B47),
    CountLinearOnReplace(0xDCD2C9A2),
    CountLinearOnReplace(0xE6835798),
    CountLinearOnReplace(0x0D8F51E1),
    CountLinearOnReplace(0x0D090F81),
    CountGammaOnReplace(0xA978F0C8),
    CountGammaOnReplace(0xD19EDE35),
    CountGammaOnReplace(0xF8281A99),
    // postFX AA
    CountLinearOnReplace(0x0366C4CE),
    CountLinearOnReplace(0xF4CA60E0),
    CountLinearOnReplace(0x53E384E8),
    CountLinearOnReplace(0x6C84328D),
    // Unknown space
    CountOnReplace(0x9E4CBF41),
    CountOnReplace(0x4528B1BE),
    // rcas
    CountLinearOnReplace(0x7CEF5F47),
    CountLinearOnReplace(0x7DD6578D),
    CountLinearOnReplace(0x08B68C4E),
    CountLinearOnReplace(0x72E35D2A),
    CountOnReplace(0x7E3B8386),  // (LBA TQ)
    // scaling setup (fsr/sqrt)
    FSR1OnReplace(0xC244242D),
    FSR1OnReplace(0xE102D2F9),
    FSR1OnReplace(0x7D998063),
    FSR1OnReplace(0x3110C812),
    CountLinearOnReplace(0xD2FB319D),
    CountLinearOnReplace(0x6738FBF0),
    CountLinearOnReplace(0x98451591),  // beautify
    CountGammaOnReplace(0x33503511),   // crt filter
    CountLinearOnReplace(0x0D4651C9),  // gamesfarm postfx
    CountLinearOnReplace(0x0299214E),  // gamesfarm postfx
    CountLinearOnReplace(0x244A72BB),  // gamesfarm postfx
    // FSR1OnDrawn(0xFC718347),                              // EASU (LBA)
    // CountOnReplace(0x81E0C934),    // fxaa3
    CountOnReplace(0xC32E5F94),          // HxVolumetricApply
    CountTonemap1OnReplace(0x81E0C934),  // fxaa3
    CountLinearOnReplace(0x2975BCA8),
    // CountLinearOnReplace(0x9325D090),    // sunshafts composite
    ////// POSTFINAL END    //////
    ////// LUTBUILDER START //////
    /// 2D Baker ///
    LutBuilderTonemap1OnReplace(0x6BA3776A),
    LutBuilderTonemap1OnReplace(0xDE54BEC4),  // merger
                                              // user LUT
    LutBuilderTonemap1OnReplace(0x425A05B0),
    LutBuilderTonemap1OnReplace(0xA7199AE8),
    /// 3D Baker ///
    // No Tonemap
    LutBuilderTonemap1OnReplace(0x34EF56B6),
    LutBuilderTonemap1OnReplace(0x995B320A),
    // Neutral
    LutBuilderTonemap2OnReplace(0xBE750C14),
    LutBuilderTonemap2OnReplace(0xC0683CB5),
    // ACES
    LutBuilderTonemap3OnReplace(0x0D6DE82C),
    LutBuilderTonemap3OnReplace(0x5B6D435F),
    LutBuilderTonemap3OnReplace(0x6EA48EC8),
    LutBuilderTonemap3OnReplace(0x47A1239F),
    // Custom
    LutBuilderTonemap2OnReplace(0x9192FB27),
    /// Post Fx Lut Generator ///
    // No Tonemap
    Tonemap1OnReplace(0x30261E46),
    Tonemap1OnReplace(0x38B119B1),
    Tonemap1OnReplace(0x09E8D72B),
    // Neutral (variable parameters)
    Tonemap2OnReplace(0x6A8BFC0E),
    Tonemap2OnReplace(0x3F73DF46),
    // ACES
    Tonemap3OnReplace(0xF70A0EED),
    Tonemap3OnReplace(0x33891579),
    Tonemap3OnReplace(0x65D3755B),
    /// Builder 3D ///
    // No Tonemap
    Tonemap1OnReplace(0xE6786595),
    Tonemap1OnReplace(0x5BD02347),
    // Neutral
    Tonemap2OnReplace(0x7E72688E),
    Tonemap2OnReplace(0x61FFF3FD),
    Tonemap2OnReplace(0xD849047B),
    // ACES
    Tonemap3OnReplace(0x7F27D36D),
    Tonemap3OnReplace(0x17CE181A),
    Tonemap3OnReplace(0x3661DD34),
    Tonemap3OnReplace(0x3917A841),
    Tonemap3OnReplace(0x6811A33B),
    Tonemap3OnReplace(0xF5AC76A9),
    // Custom
    Tonemap2OnReplace(0x3B4291E8),
    Tonemap2OnReplace(0x7D343D34),
    /// Builder Hdr ///
    // No Tonemap
    LutBuilderTonemap1OnReplace(0x6C5FFF35),
    LutBuilderTonemap1OnReplace(0x9B213AF8),
    LutBuilderTonemap1OnReplace(0x39CEB40A),
    LutBuilderTonemap1OnReplace(0x404D05C7),
    LutBuilderTonemap1OnReplace(0x508ABDBD),
    // Neutral
    LutBuilderTonemap2OnReplace(0x6C506E30),
    LutBuilderTonemap2OnReplace(0x819CADDA),
    LutBuilderTonemap2OnReplace(0x850A0BF8),
    LutBuilderTonemap2OnReplace(0x15F8BFBD),
    // ACES
    LutBuilderTonemap3OnReplace(0x5E10541B),
    LutBuilderTonemap3OnReplace(0x13A5D726),
    LutBuilderTonemap3OnReplace(0x31B52561),
    LutBuilderTonemap3OnReplace(0x042C6BD1),
    LutBuilderTonemap3OnReplace(0x64B708E6),
    LutBuilderTonemap3OnReplace(0xCE436C36),
    LutBuilderTonemap3OnReplace(0xE6EC2E40),
    /// Builder Ldr ///
    LutBuilderTonemap1OnReplace(0x62F196B6),
    LutBuilderTonemap1OnReplace(0x48B66B90),
    LutBuilderTonemap1OnReplace(0x13EEF169),
    LutBuilderTonemap1OnReplace(0x085F1ADA),
    LutBuilderTonemap1OnReplace(0x731B4F3C),
    LutBuilderTonemap1OnReplace(0x562744E8),
    LutBuilderTonemap1OnReplace(0x574581C7),
    LutBuilderTonemap1OnReplace(0xB3DF43CA),
    LutBuilderTonemap1OnReplace(0xDA75BEB5),
    LutBuilderTonemap1OnReplace(0xED457D04),
    LutBuilderTonemap1OnReplace(0xFFA5BFB6),
    // GenUberLut (Bionic Bay)
    LutBuilderTonemap1OnReplace(0x894B73C7),
    LutBuilderTonemap1OnReplace(0xDA07C0CD),
    LutBuilderTonemap1OnReplace(0xEFB0C6F3),
    LutBuilderTonemap1OnReplace(0xCD470040),
    LutBuilderTonemap1OnReplace(0x94FB997A),
    /*CustomShaderEntryCallback(0xFBC5BA43, [](reshade::api::command_list* cmd_list) {      // AgX...
    unityTonemapper = 3;
    return true;
    }),*/
    /*CustomShaderEntryCallback(0xB1ACA37F, [](reshade::api::command_list* cmd_list) {    // tonemap-colorgrading (hejl-dawson)
    unityTonemapper = 2;
    countMid += 1.f;
    shader_injection.countNew += 1.f;
    return true;
    }),*/
    /*CustomShaderEntryCallback(0x20133A8B, [](reshade::api::command_list* cmd_list) {  // final
    finalBlitCheck = true;
    return true;
    }),*/
};

renodx::mods::shader::CustomShaders other_shaders = {
    __ALL_CUSTOM_SHADERS,
};

float current_settings_mode = 0;
renodx::utils::settings::Settings settings = {
    new renodx::utils::settings::Setting{
        .key = "SettingsMode",
        .binding = &current_settings_mode,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .can_reset = false,
        .label = "Settings Mode",
        .labels = {"Simple", "Intermediate", "Advanced"},
        .tint = 0xDB9D47,
        .is_global = true,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapType",
        .binding = &shader_injection.toneMapType,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 3.f,
        .can_reset = true,
        .label = "Tone Mapper",
        .section = "Tone Mapping",
        .tooltip = "Sets the tone mapper type",
        .labels = {"Vanilla", "None", "Frostbite", "RenoDRT (Reinhard)", "DICE"},
        .tint = 0x38F6FC,
        .is_visible = []() { return settings[0]->GetValue() >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapPeakNits",
        .binding = &shader_injection.toneMapPeakNits,
        .default_value = 1000.f,
        .can_reset = false,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
        .tint = 0x38F6FC,
        .min = 48.f,
        .max = 4000.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapGameNits",
        .binding = &shader_injection.toneMapGameNits,
        .default_value = 203.f,
        .label = "Game Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of 100% white in nits",
        .tint = 0x38F6FC,
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapUINits",
        .binding = &shader_injection.toneMapUINits,
        .default_value = 203.f,
        .label = "UI Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the brightness of UI and HUD elements in nits",
        .tint = 0x38F6FC,
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapGammaCorrection",
        .binding = &shader_injection.toneMapGammaCorrection,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a display EOTF.",
        .labels = {"Off", "2.2", "BT.1886"},
        .tint = 0x38F6FC,
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapPerChannel",
        .binding = &shader_injection.toneMapPerChannel,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Scaling",
        .section = "Tone Mapping",
        .tooltip = "Luminance scales colors consistently while per-channel saturates and blows out sooner",
        .labels = {"Luminance", "Per Channel"},
        .tint = 0x38F6FC,
        .is_enabled = []() { return shader_injection.toneMapType >= 3.f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapColorSpace",
        .binding = &shader_injection.toneMapColorSpace,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .label = "Working Color Space",
        .section = "Tone Mapping",
        .labels = {"BT709", "BT2020", "AP1"},
        .tint = 0x38F6FC,
        .is_enabled = []() { return shader_injection.toneMapType >= 3.f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck == 3.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueProcessor",
        .binding = &shader_injection.toneMapHueProcessor,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .label = "Hue Processor",
        .section = "Tone Mapping",
        .labels = {"OKLab", "ICtCp", "darktable UCS"},
        .tint = 0x38F6FC,
        .is_enabled = []() { return shader_injection.toneMapType >= 3.f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueShift",
        .binding = &shader_injection.toneMapHueShift,
        .default_value = 50.f,
        .label = "Hue Shift",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .tint = 0x38F6FC,
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 3.f && shader_injection.toneMapPerChannel == 0.f; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueCorrection",
        .binding = &shader_injection.toneMapHueCorrection,
        .default_value = 0.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tint = 0x38F6FC,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapShoulderStart",
        .binding = &shader_injection.toneMapShoulderStart,
        .default_value = 1.f,
        .label = "Rolloff/Shoulder Start",
        .section = "Tone Mapping",
        .tint = 0x38F6FC,
        .max = 1.f,
        .format = "%.2f",
        .is_visible = []() { return (shader_injection.toneMapType == 2.f || shader_injection.toneMapType == 5.f) && (abs(shader_injection.tonemapCheck) == 1.f); },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeExposure",
        .binding = &shader_injection.colorGradeExposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 10.f,
        .format = "%.2f",
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeHighlights",
        .binding = &shader_injection.colorGradeHighlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeShadows",
        .binding = &shader_injection.colorGradeShadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeContrast",
        .binding = &shader_injection.colorGradeContrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeSaturation",
        .binding = &shader_injection.colorGradeSaturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeBlowout",
        .binding = &shader_injection.colorGradeBlowout,
        .default_value = 50.f,
        .label = "Highlights Saturation",
        .section = "Color Grading",
        .tooltip = "Adds or removes highlights color.",
        .tint = 0x452f7A,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeDechroma",
        .binding = &shader_injection.colorGradeDechroma,
        .default_value = 0.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .tint = 0x452f7A,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeFlare",
        .binding = &shader_injection.colorGradeFlare,
        .default_value = 0.f,
        .label = "Flare",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType == 3.f; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeClip",
        .binding = &shader_injection.colorGradeClip,
        .default_value = 0.f,
        .label = "Clipping",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType == 3.f; },
        .parse = [](float value) { return value; },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeInternalLUTStrength",
        .binding = &shader_injection.colorGradeInternalLUTStrength,
        .default_value = 100.f,
        .label = "Internal LUT Strength",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeInternalLUTScaling",
        .binding = &shader_injection.colorGradeInternalLUTScaling,
        .default_value = 0.f,
        .label = "Internal LUT Scaling",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeLUTScalingMode",
        .binding = &shader_injection.colorGradeLUTScalingMode,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "LUT Scaling Mode",
        .section = "Color Grading",
        .labels = {"Something", "Something Else"},
        .tint = 0x452f7A,
        .is_enabled = []() { return shader_injection.colorGradeInternalLUTScaling > 0.f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeInternalLUTShaper",
        .binding = &shader_injection.colorGradeInternalLUTShaper,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 1.f,
        .label = "LUT Shaper",
        .section = "Color Grading",
        .labels = {"Vanilla", "PQ"},
        .tint = 0x452f7A,
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeUserLUTStrength",
        .binding = &shader_injection.colorGradeUserLUTStrength,
        .default_value = 100.f,
        .label = "User LUT Strength",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 1 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeUserLUTScaling",
        .binding = &shader_injection.colorGradeUserLUTScaling,
        .default_value = 0.f,
        .label = "User LUT Scaling",
        .section = "Color Grading",
        .tint = 0x452f7A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode >= 2 && shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeLUTSampling",
        .binding = &shader_injection.colorGradeLUTSampling,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 1.f,
        .label = "LUT Sampling",
        .section = "Color Grading",
        .labels = {"Trilinear", "Tetrahedral"},
        .tint = 0x452f7A,
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeColorSpace",
        .binding = &shader_injection.colorGradeColorSpace,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Output Color Space",
        .section = "Color Grading",
        .tooltip = "Emulates display color temperature."
                   "\nOff for BT.709 D65."
                   "\nJPN Modern for BT.709 D93."
                   "\nJPN CRT for BT.601 ARIB-TR-B9 D93."
                   "\nJPN CRT 2 for BT.601 ARIB-TR-B9 9300k 27 MPCD."
                   "\nUS CRT for BT.601 (NTSC-U).",
        .labels = {"Off", "JPN Modern", "JPN CRT", "JPN CRT 2", "US CRT"},
        .tint = 0x452f7A,
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxBloom",
        .binding = &shader_injection.fxBloom,
        .default_value = 50.f,
        .label = "Bloom",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxCA",
        .binding = &shader_injection.fxCA,
        .default_value = 50.f,
        .label = "Chromatic Aberration",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxVignette",
        .binding = &shader_injection.fxVignette,
        .default_value = 50.f,
        .label = "Vignette",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxNoise",
        .binding = &shader_injection.fxNoise,
        .default_value = 50.f,
        .label = "Dithering Noise",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxFilmGrain",
        .binding = &shader_injection.fxFilmGrain,
        .default_value = 50.f,
        .label = "Film Grain",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxFilmGrainType",
        .binding = &shader_injection.fxFilmGrainType,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 0.f,
        .can_reset = false,
        .label = "Film Grain Type",
        .section = "Effects",
        .labels = {"Vanilla", "Perceptual"},
        .tint = 0x4D7180,
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxBloomUI",
        .binding = &shader_injection.fxBloomUI,
        .default_value = 50.f,
        .label = "UI Bloom",
        .section = "Effects",
        .tint = 0x4D7180,
        .max = 100.f,
        .is_enabled = []() { return settings[40]->GetValue() >= 1; },
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 2; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Reset",
        .section = "Color Grading Templates",
        .group = "button-line-1",
        .tint = 0xDB9D47,
        .on_change = []() {
          renodx::utils::settings::UpdateSetting("toneMapType", 3.f);
          renodx::utils::settings::UpdateSetting("toneMapPerChannel", 1.f);
          renodx::utils::settings::UpdateSetting("toneMapColorSpace", 2.f);
          renodx::utils::settings::UpdateSetting("toneMapHueProcessor", 2.f);
          renodx::utils::settings::UpdateSetting("toneMapHueShift", 50.f);
          renodx::utils::settings::UpdateSetting("toneMapHueCorrection", 0.f);
          renodx::utils::settings::UpdateSetting("toneMapShoulderStart", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeBlowout", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeDechroma", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeFlare", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeClip", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeInternalLUTStrength", 100.f);
          renodx::utils::settings::UpdateSetting("colorGradeInternalLUTScaling", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeInternalLUTShaper", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeUserLUTStrength", 100.f);
          renodx::utils::settings::UpdateSetting("colorGradeUserLUTScaling", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTSampling", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeColorSpace", 0.f); },
        .is_visible = []() { return shader_injection.tonemapCheck != 0.f; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "Work in progress",
        .section = "About",
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "HDR Den Discord",
        .section = "About",
        .group = "button-line-2",
        .tint = 0x5865F2,
        .on_change = []() { renodx::utils::platform::LaunchURL("https://discord.gg/XUhv", "tR54yc"); },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Github",
        .section = "About",
        .group = "button-line-2",
        .on_change = []() { renodx::utils::platform::LaunchURL("https://github.com/clshortfuse/renodx"); },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Voosh's Ko-Fi",
        .section = "About",
        .group = "button-line-2",
        .tint = 0xFF5A16,
        .on_change = []() { renodx::utils::platform::LaunchURL("https://ko-fi.com/notvoosh"); },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "Version: " + std::string(renodx::utils::date::ISO_DATE),
        .section = "About",
        .tooltip = std::string(__DATE__),
    },
};

void OnPresetOff() {
  renodx::utils::settings::UpdateSetting("toneMapType", 0.f);
  renodx::utils::settings::UpdateSetting("toneMapPeakNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGameNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapUINits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGammaCorrection", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
  renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTSampling", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeInternalLUTShaper", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeColorSpace", 0.f);
  renodx::utils::settings::UpdateSetting("fxBloom", 50.f);
  renodx::utils::settings::UpdateSetting("fxVignette", 50.f);
  renodx::utils::settings::UpdateSetting("fxCA", 50.f);
  renodx::utils::settings::UpdateSetting("fxNoise", 50.f);
  renodx::utils::settings::UpdateSetting("fxFilmGrain", 50.f);
  renodx::utils::settings::UpdateSetting("fxFilmGrainType", 0.f);
  renodx::utils::settings::UpdateSetting("fxBloomUI", 50.f);
}

void AddTGTFoAUpgrades() {
  renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
      .old_format = reshade::api::format::r8g8b8a8_typeless,
      .new_format = reshade::api::format::r16g16b16a16_typeless,
      .ignore_size = false,
      .usage_include = reshade::api::resource_usage::render_target,
      .usage_exclude = reshade::api::resource_usage::unordered_access | reshade::api::resource_usage::undefined,
  });
}

void AddGamePatches() {
  auto process_path = renodx::utils::platform::GetCurrentProcessPath();
  auto filename = process_path.filename().string();
  auto product_name = renodx::utils::platform::GetProductName(process_path);

  if (filename == "Fall of Avalon.exe") {
    AddTGTFoAUpgrades();
  } else if (filename == "Ultros.exe" || filename == "Batbarian Testament of the Primordials.exe") {
    shader_injection.isClamped = 2.f;
  } else {
    return;
  }
  reshade::log::message(reshade::log::level::info, std::format("Applied patches for {} ({}).", filename, product_name).c_str());
}

const std::unordered_map<std::string, reshade::api::format> UPGRADE_TARGETS_TYPELESS = {
    {"R8G8B8A8_TYPELESS", reshade::api::format::r8g8b8a8_typeless},
    {"R10G10B10A2_TYPELESS", reshade::api::format::r10g10b10a2_typeless},
    {"R16G16B16A16_TYPELESS", reshade::api::format::r16g16b16a16_typeless},
    {"B8G8R8A8_TYPELESS", reshade::api::format::b8g8r8a8_typeless},
};

const std::unordered_map<std::string, reshade::api::format> UPGRADE_TARGETS = {
    {"R11G11B10_FLOAT", reshade::api::format::r11g11b10_float},
    {"R8G8B8A8_UNORM", reshade::api::format::r8g8b8a8_unorm},
    {"B8G8R8A8_UNORM", reshade::api::format::b8g8r8a8_unorm},
    {"R8G8B8A8_SNORM", reshade::api::format::r8g8b8a8_snorm},
    {"R8G8B8A8_UNORM_SRGB", reshade::api::format::r8g8b8a8_unorm_srgb},
    {"B8G8R8A8_UNORM_SRGB", reshade::api::format::b8g8r8a8_unorm_srgb},
    {"R10G10B10A2_UNORM", reshade::api::format::r10g10b10a2_unorm},
    {"B10G10R10A2_UNORM", reshade::api::format::b10g10r10a2_unorm},
};

const auto UPGRADE_TYPE_NONE = 0.f;
const auto UPGRADE_TYPE_OUTPUT_SIZE = 1.f;
const auto UPGRADE_TYPE_OUTPUT_RATIO = 2.f;
const auto UPGRADE_TYPE_ANY = 3.f;

const std::unordered_map<
    std::string,                             // Filename or ProductName
    std::unordered_map<std::string, float>>  // {Key, Value}
    GAME_DEFAULT_SETTINGS = {
        {
            "AI-LIMIT.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R8G8B8A8_UNORM", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R8G8B8A8_UNORM_SRGB", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R11G11B10_FLOAT", UPGRADE_TYPE_OUTPUT_RATIO},
            },
        },
        {
            "Bendy - Lone Wolf.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_ANY},
                {"Swapchain_Encoding", 1.f},
                {"Blit_Copy_Hack", 0.f},
            },
        },
        {
            "Diplomacy is Not an Option.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_ANY},
                {"Upgrade_R11G11B10_FLOAT", UPGRADE_TYPE_ANY},
                {"Blit_Copy_Hack", 3.f},
            },
        },
        {
            "Fall of Avalon.exe",
            {
                {"Upgrade_R11G11B10_FLOAT", UPGRADE_TYPE_OUTPUT_SIZE},
            },
        },
        {
            "KingdomsAndCastles.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_ANY},
                {"Swapchain_Encoding", 1.f},
                {"Scaling_Offset", 1.f},
                {"Tonemap_Offset", 1.f},
                {"Blit_Copy_Hack", 2.f},
            },
        },
        {
            "Oblivion Override.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_ANY},
                {"Swapchain_Encoding", 1.f},
                {"Scaling_Offset", 1.f},
                {"Tonemap_Offset", 1.f},
                {"Use_Swapchain_Proxy", 1.f},
            },
        },
        {
            "RimWorldWin64.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_ANY},
                {"Swapchain_Encoding", 1.f},
            },
        },
        {
            "Schedule I.exe",
            {
                {"Upgrade_R8G8B8A8_TYPELESS", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R8G8B8A8_UNORM", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R8G8B8A8_UNORM_SRGB", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R11G11B10_FLOAT", UPGRADE_TYPE_OUTPUT_RATIO},
                {"Upgrade_R10G10B10A2_TYPELESS", UPGRADE_TYPE_OUTPUT_RATIO},
            },
        },
};

float g_upgrade_copy_destinations = 0.f;
float g_use_resource_cloning = 0.f;
float toggleBlitHack = 0.f;

void AddAdvancedSettings() {
  auto process_path = renodx::utils::platform::GetCurrentProcessPath();
  auto filename = process_path.filename().string();
  auto default_settings = GAME_DEFAULT_SETTINGS.find(filename);

  {
    std::stringstream s;
    if (default_settings == GAME_DEFAULT_SETTINGS.end()) {
      auto product_name = renodx::utils::platform::GetProductName(process_path);

      default_settings = GAME_DEFAULT_SETTINGS.find(product_name);

      if (default_settings == GAME_DEFAULT_SETTINGS.end()) {
        s << "No default settings for ";
      } else {
        s << "Marked default values for ";
        gammaSpaceLock = true;
      }
      s << filename;
      s << " (" << product_name << ")";
    } else {
      s << "Marked default values for ";
      s << filename;
      gammaSpaceLock = true;
    }
    reshade::log::message(reshade::log::level::info, s.str().c_str());
  }

  auto add_setting = [&](auto* setting) {
    if (default_settings != GAME_DEFAULT_SETTINGS.end()) {
      auto values = default_settings->second;
      if (auto values_pair = values.find(setting->key);
          values_pair != values.end()) {
        setting->default_value = static_cast<float>(values_pair->second);
        std::stringstream s;
        s << "Default value for ";
        s << setting->key;
        s << ": ";
        s << setting->default_value;
        reshade::log::message(reshade::log::level::info, s.str().c_str());
      }
    }
    renodx::utils::settings::LoadSetting(renodx::utils::settings::global_name, setting);
    settings.push_back(setting);
  };
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Swapchain_Encoding",
        .binding = &gammaSpace,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .can_reset = false,
        .label = "Swapchain Encoding",
        .section = "Compatibility",
        .tooltip = "Disabled if detected automatically.",
        .labels = {"Linear", "Gamma"},
        .tint = 0x1C1C3C,
        .is_enabled = []() { return !gammaSpaceLock; },
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    gammaSpace = setting->GetValue();
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Scaling_Offset",
        .binding = &countOffset,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Scaling offset",
        .section = "Compatibility",
        .tooltip = "Moves Game Brightness application if possible.",
        .labels = {"0", "1", "2", "3", "4", "5"},
        .tint = 0x1C1C3C,
        .is_enabled = []() { return shader_injection.countOld + countOffset > 1.f; },
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    countOffset = setting->GetValue();
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Tonemap_Offset",
        .binding = &count2Offset,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Tonemap offset",
        .section = "Compatibility",
        .tooltip = "Moves Tonemap/Color Grading application if possible.",
        .labels = {"0", "1", "2", "3", "4", "5"},
        .tint = 0x1C1C3C,
        .is_enabled = []() { return shader_injection.count2Old + count2Offset > 1.f; },
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    count2Offset = setting->GetValue();
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Blit_Copy_Hack",
        .binding = &blitCopyHack,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Blit Copy Hack",
        .section = "Compatibility",
        .tooltip =
            "\nHijacks Copy shader to apply Tonemap/Color Grade/Scaling."
            "\nAuto triggers when no other shader is available."
            "\nAffected by offsets",
        .labels = {"Off", "Auto", "On", "Scaling only"},
        .tint = 0x1C1C3C,
        .is_enabled = []() { return toggleBlitHack; },
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    blitCopyHack = setting->GetValue();
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Upgrade_CopyDestinations",
        .binding = &g_upgrade_copy_destinations,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Upgrade Copy Destinations",
        .section = "Resource Upgrades",
        .tooltip = "Includes upgrading texture copy destinations.",
        .labels = {
            "Off",
            "On",
        },
        .tint = 0xAFD8B5,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    g_upgrade_copy_destinations = setting->GetValue();
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Use_Resource_Cloning",
        .binding = &g_use_resource_cloning,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Use Resource Cloning",
        .section = "Resource Upgrades",
        .labels = {
            "Off",
            "On",
        },
        .tint = 0xAFD8B5,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    g_use_resource_cloning = setting->GetValue();
  }
  for (const auto& [key, format] : UPGRADE_TARGETS_TYPELESS) {
    auto* new_setting = new renodx::utils::settings::Setting{
        .key = "Upgrade_" + key,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = key,
        .section = "Resource Upgrades",
        .labels = {
            "Off",
            "Output size",
            "Output ratio",
            "Any size",
        },
        .tint = 0xDF7211,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(new_setting);
    auto value = new_setting->GetValue();
    if (value > 0) {
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = format,
          .new_format = reshade::api::format::r16g16b16a16_typeless,
          .ignore_size = (value == UPGRADE_TYPE_ANY),
          .use_resource_view_cloning = g_use_resource_cloning == 1.f,
          .aspect_ratio = static_cast<float>((value == UPGRADE_TYPE_OUTPUT_RATIO)
                                                 ? renodx::mods::swapchain::SwapChainUpgradeTarget::BACK_BUFFER
                                                 : renodx::mods::swapchain::SwapChainUpgradeTarget::ANY),
          .usage_include = reshade::api::resource_usage::render_target
                           | reshade::api::resource_usage::unordered_access
                           | (g_upgrade_copy_destinations == 0.f
                                  ? reshade::api::resource_usage::undefined
                                  : reshade::api::resource_usage::copy_dest),
      });
      std::stringstream s;
      s << "Applying user resource upgrade for ";
      s << format << ": " << value;
      reshade::log::message(reshade::log::level::info, s.str().c_str());
    }
  }
  for (const auto& [key, format] : UPGRADE_TARGETS) {
    auto* new_setting = new renodx::utils::settings::Setting{
        .key = "Upgrade_" + key,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = key,
        .section = "Resource Upgrades",
        .labels = {
            "Off",
            "Output size",
            "Output ratio",
            "Any size",
        },
        .tint = 0xDF7211,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(new_setting);
    auto value = new_setting->GetValue();
    if (value > 0) {
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = format,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .ignore_size = (value == UPGRADE_TYPE_ANY),
          .use_resource_view_cloning = g_use_resource_cloning == 1.f,
          .aspect_ratio = static_cast<float>((value == UPGRADE_TYPE_OUTPUT_RATIO)
                                                 ? renodx::mods::swapchain::SwapChainUpgradeTarget::BACK_BUFFER
                                                 : renodx::mods::swapchain::SwapChainUpgradeTarget::ANY),
          .usage_include = reshade::api::resource_usage::render_target
                           | (g_upgrade_copy_destinations == 0.f
                                  ? reshade::api::resource_usage::undefined
                                  : reshade::api::resource_usage::copy_dest),
      });
      std::stringstream s;
      s << "Applying user resource upgrade for ";
      s << format << ": " << value;
      reshade::log::message(reshade::log::level::info, s.str().c_str());
    }
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "Use_Swapchain_Proxy",
        .binding = &g_use_swapchain_proxy,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Swapchain Proxy",
        .section = "Resource Upgrades",
        .labels = {
            "Off",
            "On",
            "On (Compatibility Mode)",
        },
        .tint = 0x896895,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);
    g_use_swapchain_proxy = setting->GetValue();
    if (g_use_swapchain_proxy >= 1.f) {
      /*renodx::mods::swapchain::swap_chain_proxy_vertex_shader = __swap_chain_proxy_vertex_shader;
      renodx::mods::swapchain::swap_chain_proxy_pixel_shader = __swap_chain_proxy_pixel_shader;*/
      renodx::mods::swapchain::swap_chain_proxy_shaders = {
          {
              reshade::api::device_api::d3d11,
              {
                  .vertex_shader = __swap_chain_proxy_vertex_shader_dx11,
                  .pixel_shader = __swap_chain_proxy_pixel_shader_dx11,
              },
          },
          {
              reshade::api::device_api::d3d12,
              {
                  .vertex_shader = __swap_chain_proxy_vertex_shader_dx12,
                  .pixel_shader = __swap_chain_proxy_pixel_shader_dx12,
              },
          },
      };
      renodx::mods::swapchain::swapchain_proxy_compatibility_mode = g_use_swapchain_proxy == 2.f;
      shader_injection.swapchainProxy = 1.f;
    }
  }
  {
    auto* force_borderless_setting = new renodx::utils::settings::Setting{
        .key = "ForceBorderless",
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Force Borderless Window",
        .section = "Resource Upgrades",
        .labels = {
            "Disabled",
            "Enabled",
        },
        .tint = 0x896895,
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(force_borderless_setting);
    if (force_borderless_setting->GetValue() == 0) {
      renodx::mods::swapchain::force_borderless = false;
    }
  }
  {
    auto* setting = new renodx::utils::settings::Setting{
        .key = "PreventFullscreen",
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Prevent Exclusive Fullscreen",
        .section = "Resource Upgrades",
        .labels = {
            "Disabled",
            "Enabled",
        },
        .tint = 0x896895,
        .on_change_value = [](float previous, float current) { renodx::mods::swapchain::prevent_full_screen = (current == 1.f); },
        .is_global = true,
        .is_visible = []() { return settings[0]->GetValue() >= 2; },
    };
    add_setting(setting);

    renodx::mods::swapchain::prevent_full_screen = (setting->GetValue() == 1.f);
  }
  settings.push_back({new renodx::utils::settings::Setting{
      .value_type = renodx::utils::settings::SettingValueType::TEXT,
      .label = "The application must be restarted for upgrades to take effect.",
      .section = "Resource Upgrades",
      .is_visible = []() { return settings[0]->GetValue() >= 2; },
  }});
}

bool fired_on_init_swapchain = false;

void OnInitSwapchain(reshade::api::swapchain* swapchain, bool resize) {
  if (fired_on_init_swapchain) return;
  fired_on_init_swapchain = true;
  auto peak = renodx::utils::swapchain::GetPeakNits(swapchain);
  if (peak.has_value()) {
    settings[2]->default_value = peak.value();
    settings[2]->can_reset = true;
  }
}

void OnPresent(
    reshade::api::command_queue* queue,
    reshade::api::swapchain* swapchain,
    const reshade::api::rect* source_rect,
    const reshade::api::rect* dest_rect,
    uint32_t dirty_rect_count,
    const reshade::api::rect* dirty_rects) {
  if (unityTonemapper != shader_injection.tonemapCheck) {
    if (unityTonemapper == 3) {
      settings[1]->labels = {"Vanilla", "None", "ACES", "RenoDRT (Daniele)", "RenoDRT (Reinhard)"};
      settings[10]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[17]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[18]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[19]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[20]->is_enabled = []() { return shader_injection.toneMapType == 4.f; };
      shader_injection.tonemapCheck = unityTonemapper;
    } else if (unityTonemapper == 2) {
      settings[1]->labels = {"Vanilla", "None", "ACES", "RenoDRT (Reinhard)", "RenoDRT (Daniele)"};
      settings[10]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[17]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[18]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[19]->is_enabled = []() { return shader_injection.toneMapType >= 3.f; };
      settings[20]->is_enabled = []() { return shader_injection.toneMapType == 3.f; };
      shader_injection.tonemapCheck = unityTonemapper;
    } else if (unityTonemapper == 1) {
      settings[1]->labels = {"Vanilla", "None", "Frostbite", "RenoDRT (Reinhard)", "DICE"};
      settings[10]->is_enabled = []() { return shader_injection.toneMapType >= 2.f; };
      settings[17]->is_enabled = []() { return shader_injection.toneMapType >= 2.f; };
      settings[18]->is_enabled = []() { return shader_injection.toneMapType >= 2.f; };
      settings[19]->is_enabled = []() { return shader_injection.toneMapType == 3.f; };
      settings[20]->is_enabled = []() { return shader_injection.toneMapType == 3.f; };
      shader_injection.tonemapCheck = unityTonemapper;
    }
  }
  shader_injection.countOld = max(1.f, countMid - countOffset);
  shader_injection.count2Old = max(1.f, count2Mid - count2Offset);
  countMid = 0.f;
  count2Mid = 0.f;
  shader_injection.countNew = 0.f;
  shader_injection.count2New = 0.f;
  shader_injection.FSRcheck = FSRcheck;
  FSRcheck = 0.f;
  if (shader_injection.gammaSpace != gammaSpace) {
    shader_injection.gammaSpace = gammaSpace;
    renodx::utils::settings::UpdateSetting("Swapchain_Encoding", shader_injection.gammaSpace);
    renodx::utils::settings::SaveGlobalSettings();
  }
  if (blitCopyHack >= 2.f) {
    shader_injection.blitCopyHack = blitCopyHack - 1.f;
  } else if (blitCopyHack == 1.f && !forceDetect) {
    shader_injection.blitCopyHack = 1.f;
  } else {
    shader_injection.blitCopyHack = 0.f;
  }
  forceDetect = false;
  toggleBlitHack = blitCopyCheck;
  blitCopyCheck = 0.f;
}

void MergeShaders() {
  custom_shaders.max_load_factor(0.7f);
  custom_shaders.reserve(custom_shaders.size() + other_shaders.size());
  for (auto& kv : other_shaders) {
    custom_shaders.insert_or_assign(kv.first, std::move(kv.second));
  }
}
bool initialized = false;

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX for Unity Engine";

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      MergeShaders();
      if (!reshade::register_addon(h_module)) return FALSE;
      if (!initialized) {
        // renodx::mods::swapchain::swapchain_proxy_compatibility_mode = false;
        renodx::mods::swapchain::swapchain_proxy_revert_state = true;
        // renodx::mods::shader::force_pipeline_cloning = true;
        renodx::mods::shader::expected_constant_buffer_space = 50;
        renodx::mods::shader::expected_constant_buffer_index = 13;
        renodx::mods::shader::allow_multiple_push_constants = true;
        renodx::mods::swapchain::expected_constant_buffer_index = 13;
        renodx::mods::swapchain::expected_constant_buffer_space = 50;
        renodx::mods::swapchain::use_resource_cloning = true;
        renodx::utils::random::binds.push_back(&shader_injection.random);
        AddAdvancedSettings();
        //  internal LUT
        renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
            .old_format = reshade::api::format::r8g8b8a8_typeless,
            .new_format = reshade::api::format::r16g16b16a16_typeless,
            .dimensions = {.width = 1024, .height = 32},
        });
        AddGamePatches();
        reshade::register_event<reshade::addon_event::init_swapchain>(OnInitSwapchain);
        reshade::register_event<reshade::addon_event::present>(OnPresent);
        initialized = true;
      }
      break;
    case DLL_PROCESS_DETACH:
      reshade::unregister_addon(h_module);
      reshade::unregister_event<reshade::addon_event::init_swapchain>(OnInitSwapchain);
      reshade::unregister_event<reshade::addon_event::present>(OnPresent);
      break;
  }
  renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);
  if (g_use_swapchain_proxy >= 1.f) {
    renodx::mods::swapchain::Use(fdw_reason, &shader_injection);
  } else {
    renodx::mods::swapchain::Use(fdw_reason);
  }
  renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);
  renodx::utils::random::Use(fdw_reason);
  return TRUE;
}
