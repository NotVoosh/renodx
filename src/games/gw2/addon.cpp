/*
 * Copyright (C) 2023 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0

#include <embed/0xAA6E9F95.h>      // final
#include <embed/0x317EFBE1.h>      // Light Adaptation
#include <embed/0xA033440E.h>      // Vignette
#include <embed/0x99068912.h>      // Depth Blur
#include <embed/0x0DFA0CA1.h>      // Fog

#include <embed/0xED61CCE3.h>      // bloom-ish
#include <embed/0xB47204C8.h>      // SSR
#include <embed/0x88DE9EDE.h>      // Mistlock 1
#include <embed/0x24CE1FCB.h>      // Mistlock 2
#include <embed/0xD90FE0AC.h>      // Mistlock 3
#include <embed/0x750F53C0.h>      // Dragonfall (Kralkatorrik)
#include <embed/0x187268D3.h>      // Environment Zone Intensity
#include <embed/0x66130D94.h>      // slideshow cutscenes
#include <embed/0xDF711B8B.h>      // PoA

#include <embed/0xA8C3C9D5.h>      // Lut Sample 1
#include <embed/0x5A098F2B.h>      // Lut Sample 2
#include <embed/0x4A18D1E0.h>      // Lut Sample 3
#include <embed/0x7DAA4AE4.h>      // Lut Sample 4
#include <embed/0xD4DFFB85.h>      // Lut Sample 5
#include <embed/0x6359AF3D.h>      // Lut Sample 6
#include <embed/0x42928281.h>      // Lut Sample 7
#include <embed/0xAA1CCED3.h>      // Lut Sample 8
#include <embed/0xF6F48311.h>      // Lut Sample 9
#include <embed/0xCE4C348D.h>      // Lut Sample 10
#include <embed/0x36078EF8.h>      // Lut Sample 11
#include <embed/0x7ED580FF.h>      // Lut Sample 12
#include <embed/0x5AAD73BD.h>      // Lut Sample 13
#include <embed/0x062969AB.h>      // Lut Sample 14
#include <embed/0x032D723E.h>      // Lut Sample 15
#include <embed/0x428D48C8.h>      // Lut Sample 16

#include <embed/0x719BE206.h>      // PP1
#include <embed/0xD8C348D5.h>      // PP2
#include <embed/0xDCE33C51.h>      // PP3
#include <embed/0x7B249DE9.h>      // PP4
#include <embed/0xA1C38898.h>      // PP5
#include <embed/0x22EFDCF6.h>      // PP6
#include <embed/0xB845E50C.h>      // PP7
#include <embed/0x48296CE5.h>      // PP8
#include <embed/0x74EBB1CB.h>      // PP9
#include <embed/0x1B61AA64.h>      // PP10
#include <embed/0x8F70C508.h>      // PP11
#include <embed/0xF3052684.h>      // PP12
#include <embed/0x3B3BA161.h>      // PP13
#include <embed/0x4DEA5928.h>      // PP14
#include <embed/0x7904D64C.h>      // PP15
#include <embed/0xC3B7FFE7.h>      // PP16

#include <embed/0x967994F1.h>      // addons

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/settings.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {
    CustomShaderEntry(0xAA6E9F95),      // final shader                                         used for UI brightness
    CustomShaderEntry(0x317EFBE1),      // Light Adaptation                                 unsaturated to be usable
    CustomShaderEntry(0xA033440E),      // Vignette
    CustomShaderEntry(0x99068912),      // Depth Blur                            "simple" scaling, might be interesting to improve
    CustomShaderEntry(0x0DFA0CA1),      // Fog                                      can be pretty thick, added alpha slider

    CustomShaderEntry(0xED61CCE3),      // bloom                               artifacts under specific circumstances, removed negative colors
    CustomShaderEntry(0xB47204C8),      // SSR                                                           //
    CustomShaderEntry(0x88DE9EDE),      // Mistlock 1                                        dirty fix for artifacts
    CustomShaderEntry(0x24CE1FCB),      // Mistlock 2                                   same here, no clue what's going on
    CustomShaderEntry(0xD90FE0AC),      // Mistlock 3                                       something about alpha
    CustomShaderEntry(0x750F53C0),      // Dragonfall                                           green artifacting
    CustomShaderEntry(0x187268D3),      // Environment Zone Intensity                   alpha stuff, no clue again but it looks nice
    CustomShaderEntry(0x66130D94),      // Slideshow cutscenes                          remove negative colors to fix stuff
    CustomShaderEntry(0xDF711B8B),      // Plains of Ashford                                    alpha saturate

    CustomShaderEntry(0xA8C3C9D5),      // Color grading LUT sampling 1                         we do tonemapping here
    CustomShaderEntry(0x5A098F2B),      // Color grading LUT sampling 2                                 //
    CustomShaderEntry(0x4A18D1E0),      // Color grading LUT sampling 3                                 //
    CustomShaderEntry(0x7DAA4AE4),      // Color grading LUT sampling 4                                 //
    CustomShaderEntry(0xD4DFFB85),      // Color grading LUT sampling 5                                 //
    CustomShaderEntry(0x6359AF3D),      // Color grading LUT sampling 6                                 //
    CustomShaderEntry(0x42928281),      // Color grading LUT sampling 7                                 //
    CustomShaderEntry(0xAA1CCED3),      // Color grading LUT sampling 8                                 //
    CustomShaderEntry(0xF6F48311),      // Color grading LUT sampling 9                                 //
    CustomShaderEntry(0xCE4C348D),      // Color grading LUT sampling 10                                //
    CustomShaderEntry(0x36078EF8),      // Color grading LUT sampling 11                                //
    CustomShaderEntry(0x7ED580FF),      // Color grading LUT sampling 12                                //
    CustomShaderEntry(0x5AAD73BD),      // Color grading LUT sampling 13                                //
    CustomShaderEntry(0x062969AB),      // Color grading LUT sampling 14                                //
    CustomShaderEntry(0x032D723E),      // Color grading LUT sampling 15                                //
    CustomShaderEntry(0x428D48C8),      // Color grading LUT sampling 16                                //

    CustomShaderEntry(0x719BE206),      // Post-processing 1                             for tonemapping when no LUT is used
    CustomShaderEntry(0xD8C348D5),      // Post-processing 2                                            //
    CustomShaderEntry(0xDCE33C51),      // Post-processing 3                                            //
    CustomShaderEntry(0x7B249DE9),      // Post-processing 4                                            //
    CustomShaderEntry(0xA1C38898),      // Post-processing 5                                            //
    CustomShaderEntry(0x22EFDCF6),      // Post-processing 6                                            //
    CustomShaderEntry(0xB845E50C),      // Post-processing 7                                            //
    CustomShaderEntry(0x48296CE5),      // Post-processing 8                                            //
    CustomShaderEntry(0x74EBB1CB),      // Post-processing 9                                            //
    CustomShaderEntry(0x1B61AA64),      // Post-processing 10                                           //
    CustomShaderEntry(0x8F70C508),      // Post-processing 11                                           //
    CustomShaderEntry(0xF3052684),      // Post-processing 12                                           //
    CustomShaderEntry(0x3B3BA161),      // Post-processing 13                                           //
    CustomShaderEntry(0x4DEA5928),      // Post-processing 14                                           //
    CustomShaderEntry(0x7904D64C),      // Post-processing 15                                           //
    CustomShaderEntry(0xC3B7FFE7),      // Post-processing 16                                           //

    CustomShaderEntry(0x967994F1),      // external/third-party addons                       Nexus, ArcDPS, maybe others...
  };

ShaderInjectData shader_injection;

renodx::utils::settings::Settings settings = {
    new renodx::utils::settings::Setting{
        .key = "toneMapType",
        .binding = &shader_injection.toneMapType,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 3.f,
        .can_reset = false,
        .label = "Tone Mapper",
        .section = "Tone Mapping",
        .tooltip = "Sets the tone mapper type",
        .labels = {"Vanilla", "None", "ACES", "RenoDRT"},
        .tint = 0x69278A,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapPeakNits",
        .binding = &shader_injection.toneMapPeakNits,
        .default_value = 1000.f,
        .can_reset = false,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
        .tint = 0xCAAA2A,
        .min = 48.f,
        .max = 4000.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapGameNits",
        .binding = &shader_injection.toneMapGameNits,
        .default_value = 203.f,
        .label = "Game Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of 100%% white in nits",
        .tint = 0xCAAA2A,
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
        .tint = 0xCAAA2A,
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapAddonNits",
        .binding = &shader_injection.toneMapAddonNits,
        .default_value = 203.f,
        .label = "Addons Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the brightness of third-party addons in nits",
        .tint = 0xCAAA2A,
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapGammaCorrection",
        .binding = &shader_injection.toneMapGammaCorrection,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .can_reset = false,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a 2.2 EOTF (use with HDR or sRGB)",
        .tint = 0x87581D,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueCorrection",
        .binding = &shader_injection.toneMapHueCorrection,
        .default_value = 0.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tint = 0x87581D,
        .max = 100.f,
        .parse = [](float value) { return value * 0.005f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeExposure",
        .binding = &shader_injection.colorGradeExposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .tint = 0xDC423E,
        .max = 10.f,
        .format = "%.2f",
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeHighlights",
        .binding = &shader_injection.colorGradeHighlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .tint = 0xD16E5A,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeShadows",
        .binding = &shader_injection.colorGradeShadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .tint = 0xC08F95,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeContrast",
        .binding = &shader_injection.colorGradeContrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .tint = 0x186885,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeSaturation",
        .binding = &shader_injection.colorGradeSaturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
        .tint = 0x186885,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeBlowout",
        .binding = &shader_injection.colorGradeBlowout,
        .default_value = 50.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .tint = 0x186885,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeLUTStrength",
        .binding = &shader_injection.colorGradeLUTStrength,
        .default_value = 100.f,
        .label = "LUT Strength",
        .section = "Color Grading",
        .tooltip = "Scales game's original Color Grading intensity.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeLUTScaling",
        .binding = &shader_injection.colorGradeLUTScaling,
        .default_value = 100.f,
        .label = "LUT Scaling",
        .section = "Color Grading",
        .tooltip = "Scales the color grade LUT to full range when size is clamped.",
        .tint = 0x2C9D5D,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeColorSpace",
        .binding = &shader_injection.colorGradeColorSpace,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .can_reset = false,
        .label = "Color Space",
        .section = "Color Grading",
        .tooltip = "Selects color space gamut when clamping.",
        .labels = {"None", "BT709", "BT2020", "AP1"},
        .tint = 0x2C9D5D,
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeColorTint",
        .binding = &shader_injection.colorGradeColorTint,
        .default_value = 100.f,
        .label = "Color Tint",
        .section = "Color Grading",
        .tooltip = "Scales game's original Color Tint.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxBloom",
        .binding = &shader_injection.fxBloom,
        .default_value = 100.f,
        .label = "Bloom",
        .section = "Effects",
        .tooltip = "Scales game's original Bloom.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxDof",
        .binding = &shader_injection.fxDof,
        .default_value = 50.f,
        .label = "Depth Blur",
        .section = "Effects",
        .tooltip = "Scales game's original Depth Blur.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxVignette",
        .binding = &shader_injection.fxVignette,
        .default_value = 50.f,
        .label = "Vignette (underwater)",
        .section = "Effects",
        .tooltip = "Scales game's original Vignette.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxFog",
        .binding = &shader_injection.fxFog,
        .default_value = 100.f,
        .label = "Fog transparency",
        .section = "Effects",
        .tooltip = "Scales game's fog transparency.",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxFilmGrain",
        .binding = &shader_injection.fxFilmGrain,
        .default_value = 0.f,
        .label = "Film Grain",
        .section = "Effects",
        .tooltip = "Scales custom Film Grain.",
        .tint = 0x2C9D5D,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Discord",
        .section = "Links",
        .group = "button-line-1",
        .tint = 0x5865F2,
        .on_change = []() {
          system("start https://discord.gg/5WZXDpmbpP");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Github",
        .section = "Links",
        .group = "button-line-1",
        .on_change = []() {
          system("start https://github.com/NotVoosh/renodx");
        },
    },
    /*
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Donate (Ko-Fi)",
        .section = "Links",
        .group = "button-line-1",
        .tint = 0x850000,
        .on_change = []() {
          system("start https://ko-fi.com/hdrden");
        },
    },
    */
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "Enable Bloom, Color Grading & Color Tint in game settings.",
        .section = "Instructions",
    },
};

void OnPresetOff() {
  renodx::utils::settings::UpdateSetting("toneMapType", 0.f);
  renodx::utils::settings::UpdateSetting("toneMapPeakNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGameNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapUINits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapAddonNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGammaCorrection", 0);
  renodx::utils::settings::UpdateSetting("toneMapHueCorrection", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
  renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeBlowout", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeColorSpace", 1.f);
  renodx::utils::settings::UpdateSetting("colorGradeColorTint", 100.f);
  renodx::utils::settings::UpdateSetting("fxBloom", 100.f);
  renodx::utils::settings::UpdateSetting("fxDof", 50.f);
  renodx::utils::settings::UpdateSetting("fxVignette", 50.f);
  renodx::utils::settings::UpdateSetting("fxFog", 100.f);
  renodx::utils::settings::UpdateSetting("fxFilmGrain", 0.f);
}

auto start = std::chrono::steady_clock::now();

void OnPresent(
    reshade::api::command_queue* queue,
    reshade::api::swapchain* swapchain,
    const reshade::api::rect* source_rect,
    const reshade::api::rect* dest_rect,
    uint32_t dirty_rect_count,
    const reshade::api::rect* dirty_rects) {
  auto end = std::chrono::steady_clock::now();
  shader_injection.elapsedTime = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
}

}  // namespace

// NOLINTBEGIN(readability-identifier-naming)

extern "C" __declspec(dllexport) const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) const char* DESCRIPTION = "RenoDX for Guild Wars 2";

// NOLINTEND(readability-identifier-naming)

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;
      renodx::mods::swapchain::force_borderless = false;
      renodx::mods::swapchain::prevent_full_screen = false;
      renodx::mods::swapchain::use_resize_buffer = false;
      //renodx::mods::shader::trace_unmodified_shaders = true;

      // RGBA8_unorm
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .ignore_size = false,
      });
      // BGRA8_unorm
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::b8g8r8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .index = -1,
          .ignore_size = false,
      });

      // BGRA8_unorm
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::b8g8r8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .index = 6,
          .ignore_size = true,
      });
      
      reshade::register_event<reshade::addon_event::present>(OnPresent);

      break;
    case DLL_PROCESS_DETACH:
      reshade::unregister_addon(h_module);
      break;
  }

  renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);

  renodx::mods::swapchain::Use(fdw_reason);

  renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);

  return TRUE;
}
