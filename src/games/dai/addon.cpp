/*
 * Copyright (C) 2023 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0

#include <embed/0x5545BDF0.h>     // Title Menu background video
#include <embed/0xA13A374B.h>     // Loading Screen
#include <embed/0xE8AAA41F.h>     // UI main
#include <embed/0xD86EF7C9.h>     // UI text
#include <embed/0x9966ABB1.h>     // UI background
#include <embed/0x7CE83E95.h>     // UI outline
#include <embed/0x602C6565.h>     // UI bars
#include <embed/0x9CCDDA64.h>     // UI radar

#include <embed/0x39C155AA.h>     // tonemapper 1
#include <embed/0x59D67072.h>     // tonemapper 2
#include <embed/0xA6483DBE.h>     // tonemapper 3
#include <embed/0x4A22EBE7.h>     // tonemapper 4
#include <embed/0x83C78E9A.h>     // tonemapper 5
#include <embed/0x74DD925C.h>     // tonemapper 6

#include <embed/0xB3B5916C.h>     // tonemapper Cutscene 1
#include <embed/0x298147DD.h>     // tonemapper Cutscene 2
#include <embed/0xEE7DEA72.h>     // tonemapper Cutscene 3

#include <embed/0xD8F38829.h>     // Motion Blur
#include <embed/0x398F1A8B.h>     // Depth of Field
#include <embed/0x268B7BD3.h>     // Exposure
#include <embed/0x9BC42038.h>     // SSS

#include <embed/0xAFE82993.h>     // skybox 1
#include <embed/0xA5134DDA.h>     // skybox 2
#include <embed/0xD0A58868.h>     // skybox 3
#include <embed/0x4E925154.h>     // skybox 4

//#include <embed/0x79766F9D.h>     // Resolution scaling
//#include <embed/0xE6C75B8E.h>     // Resolution scaling 2

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/settings.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {
    CustomShaderEntry(0x5545BDF0),      // Title Menu background video                           this could be better I think, dunno
    CustomShaderEntry(0xA13A374B),      // Loading Screen                                        may look slightly off? need to check
    CustomShaderEntry(0xE8AAA41F),      // UI main
    CustomShaderEntry(0xD86EF7C9),      // UI text
    CustomShaderEntry(0x9966ABB1),      // UI (alpha) background 
    CustomShaderEntry(0x7CE83E95),      // UI outline (minimap or such, round-shape?)
    CustomShaderEntry(0x602C6565),      // UI bars (outline around objective, line-shape?)
    CustomShaderEntry(0x9CCDDA64),      // UI radar purple quest areas                           NOT SURE it needs anything, CHECK

    CustomShaderEntry(0x39C155AA),      // tonemapper 1                                          basic gameplay
    CustomShaderEntry(0x59D67072),      // tonemapper 2                                          same here, so why switch... EXPOSURE?
    CustomShaderEntry(0xA6483DBE),      // tonemapper 3                                          "nightmare" vision
    CustomShaderEntry(0x4A22EBE7),      // tonemapper 4                                               //
    CustomShaderEntry(0x83C78E9A),      // tonemapper 5                                          Ocularum
    CustomShaderEntry(0x74DD925C),      // tonemapper 6                                             //

    CustomShaderEntry(0xB3B5916C),      // tonemapper Cutscene 1                                 Cutscenes only I think?
    CustomShaderEntry(0x298147DD),      // tonemapper Cutscene 2                                          //
    CustomShaderEntry(0xEE7DEA72),      // tonemapper Cutscene 3                                 same but why is it different...

    CustomShaderEntry(0xD8F38829),      // Blur effect                                           causes artifacts when enabled
    CustomShaderEntry(0x398F1A8B),      // Depth of Field                                        part of it (close-mid range blur?) causes artifacts
    CustomShaderEntry(0x268B7BD3),      // Exposure                                              Very strong, not sure if and how I deal with that
    //CustomShaderEntry(0x9BC42038),      // Sub-Surface Scattering                              causes eyebrows artifacts in very few dialog cutscenes

    CustomShaderEntry(0xAFE82993),      // skybox 1                                              Haven
    CustomShaderEntry(0xA5134DDA),      // skybox 2                                                //
    CustomShaderEntry(0xD0A58868),      // skybox 3                                              The Hinterlands
    CustomShaderEntry(0x4E925154),      // skybox 4                                                   //.
    //CustomCountedShader(0x79766F9D),  // Resolution scale                                      two parts: width and height, happens after tonemap
    //CustomCountedShader(0xE6C75B8E),  // Resolution scale 2                                    can't be used: upgrade breaks tonemap RTV falls back to rgba8
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
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapPeakNits",
        .binding = &shader_injection.toneMapPeakNits,
        .default_value = 1000.f,
        .can_reset = false,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
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
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapGammaCorrection",
        .binding = &shader_injection.toneMapGammaCorrection,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 0.f,
        .can_reset = false,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a 2.2 EOTF (use with HDR or sRGB)",
        .labels = {"Off", "On"},
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueCorrection",
        .binding = &shader_injection.toneMapHueCorrection,
        .default_value = 50.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeExposure",
        .binding = &shader_injection.colorGradeExposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .max = 10.f,
        .format = "%.2f",
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeHighlights",
        .binding = &shader_injection.colorGradeHighlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeShadows",
        .binding = &shader_injection.colorGradeShadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeContrast",
        .binding = &shader_injection.colorGradeContrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeSaturation",
        .binding = &shader_injection.colorGradeSaturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
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
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeLUTStrength",
        .binding = &shader_injection.colorGradeLUTStrength,
        .default_value = 100.f,
        .label = "LUT Strength",
        .section = "Color Grading",
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
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxBloom",
        .binding = &shader_injection.fxBloom,
        .default_value = 50.f,
        .label = "Bloom",
        .section = "Effects",
        .tooltip = "Can cause little flashing lights artifacts, reduce or disable.",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxVignette",
        .binding = &shader_injection.fxVignette,
        .default_value = 5.f,
        .label = "Vignette",
        .section = "Effects",
        .max = 10.f,
        .parse = [](float value) { return value * 0.2f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxSkyExposure",
        .binding = &shader_injection.fxSkyExposure,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 1,
        .can_reset = false,
        .label = "Sky Exposure",
        .section = "Effects",
        .tooltip = "Highly effective...",
        .labels = {"Original", "Reduced"},
    },
    new renodx::utils::settings::Setting{
        .key = "fxDof",
        .binding = &shader_injection.fxDof,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0,
        .can_reset = false,
        .label = "Depth of Field",
        .section = "Effects",
        .tooltip = "Can cause heavy artifacts in cutscenes when enabled.",
        .labels = {"Off", "On"},
    },
    new renodx::utils::settings::Setting{
        .key = "fxBlur",
        .binding = &shader_injection.fxBlur,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 0,
        .can_reset = false,
        .label = "Motion/Radial Blur",
        .section = "Effects",
        .tooltip = "Can cause heavy artifacts when enabled.",
        .labels = {"Off", "On"},
    },
    new renodx::utils::settings::Setting{
        .key = "miscWindowBox",
        .binding = &shader_injection.miscWindowBox,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 1,
        .label = "Window-boxing",
        .section = "Misc",
        .tooltip = "Disable in Behaviours menu on ultrawide ratio. Has unintended side-effects.",
        .labels = {"Off", "On"},
    },
    new renodx::utils::settings::Setting{
        .key = "miscFixes",
        .binding = &shader_injection.miscFixes,
        .value_type = renodx::utils::settings::SettingValueType::BOOLEAN,
        .default_value = 1,
        .label = "Multiple fixes",
        .section = "Misc",
        .tooltip = "Things",
        .labels = {"Off", "On"},
    },
};

void OnPresetOff() {
  renodx::utils::settings::UpdateSetting("toneMapType", 0.f);
  renodx::utils::settings::UpdateSetting("toneMapPeakNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGameNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapUINits", 203.f);
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
  renodx::utils::settings::UpdateSetting("fxBloom", 50.f);
  renodx::utils::settings::UpdateSetting("fxVignette", 5.f);
  renodx::utils::settings::UpdateSetting("fxSkyExposure", 0);
  renodx::utils::settings::UpdateSetting("fxDof", 1);
  renodx::utils::settings::UpdateSetting("fxBlur", 1);
  renodx::utils::settings::UpdateSetting("miscWindowBox", 1);
  renodx::utils::settings::UpdateSetting("miscFixes", 0);
}

}  // namespace

// NOLINTBEGIN(readability-identifier-naming)

extern "C" __declspec(dllexport) const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) const char* DESCRIPTION = "RenoDX for Dragon Age: Inquisition";

// NOLINTEND(readability-identifier-naming)

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;
      //renodx::mods::swapchain::upgrade_unknown_resource_views = true;
      renodx::mods::swapchain::force_borderless = false;
      renodx::mods::swapchain::prevent_full_screen = false;
      //renodx::mods::swapchain::use_resize_buffer = true;
      //renodx::mods::swapchain::use_resize_buffer_on_set_full_screen = true;
      renodx::mods::swapchain::use_resize_buffer_on_demand = false;
      //renodx::mods::swapchain::use_resize_buffer_on_present = true;
      //renodx::mods::shader::expected_constant_buffer_index = 2;
      renodx::mods::shader::trace_unmodified_shaders = true;
      //renodx::mods::shader::force_pipeline_cloning = true;

      // RGBA8_unorm
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .index = -1,
          .ignore_size =  false,
          //.aspect_ratio = 16.f / 9.f,
      });
      /*
      // RGBA8_unorm
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .index = 999,
          .ignore_size = true,
          //.aspect_ratio = 16.f / 9.f,
      });
      */

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
