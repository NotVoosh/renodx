/*
 * Copyright (C) 2024 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include <embed/shaders.h>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/random.hpp"
#include "../../utils/settings.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {
__ALL_CUSTOM_SHADERS
};

ShaderInjectData shader_injection;

float current_settings_mode = 0;

renodx::utils::settings::Settings settings = {
    new renodx::utils::settings::Setting{
        .key = "SettingsMode",
        .binding = &current_settings_mode,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .can_reset = false,
        .label = "Settings Mode",
        .labels = {"Simple", "Advanced"},
        .is_global = true,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapType",
        .binding = &shader_injection.tone_map_type,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 3.f,
        .can_reset = true,
        .label = "Tone Mapper",
        .section = "Tone Mapping",
        .tooltip = "Sets the tone mapper type",
        .labels = {"Vanilla", "None", "ACES", "RenoDRT"},
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapPeakNits",
        .binding = &shader_injection.peak_white_nits,
        .default_value = 1000.f,
        .can_reset = false,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
        .min = 48.f,
        .max = 4000.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapGameNits",
        .binding = &shader_injection.diffuse_white_nits,
        .default_value = 203.f,
        .label = "Game Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of 100% white in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapUINits",
        .binding = &shader_injection.graphics_white_nits,
        .default_value = 203.f,
        .label = "UI Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the brightness of UI and HUD elements in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "GammaCorrection",
        .binding = &shader_injection.gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a display EOTF.",
        .labels = {"Off", "2.2", "BT.1886"},
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapScaling",
        .binding = &shader_injection.tone_map_per_channel,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Scaling",
        .section = "Tone Mapping",
        .tooltip = "Luminance scales colors consistently while per-channel saturates and blows out sooner",
        .labels = {"Luminance", "Per Channel"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapWorkingColorSpace",
        .binding = &shader_injection.tone_map_working_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Working Color Space",
        .section = "Tone Mapping",
        .labels = {"BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueProcessor",
        .binding = &shader_injection.tone_map_hue_processor,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Hue Processor",
        .section = "Tone Mapping",
        .tooltip = "Selects hue processor",
        .labels = {"OKLab", "ICtCp", "darkTable UCS"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueCorrection",
        .binding = &shader_injection.tone_map_hue_correction,
        .default_value = 100.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tooltip = "Hue retention strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueShift",
        .binding = &shader_injection.tone_map_hue_shift,
        .default_value = 0.f,
        .label = "Hue Shift",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeExposure",
        .binding = &shader_injection.tone_map_exposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .max = 2.f,
        .format = "%.2f",
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlights",
        .binding = &shader_injection.tone_map_highlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeShadows",
        .binding = &shader_injection.tone_map_shadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeContrast",
        .binding = &shader_injection.tone_map_contrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeSaturation",
        .binding = &shader_injection.tone_map_saturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlightSaturation",
        .binding = &shader_injection.tone_map_highlight_saturation,
        .default_value = 50.f,
        .label = "Highlight Saturation",
        .section = "Color Grading",
        .tooltip = "Adds or removes highlight color.",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode == 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeBlowout",
        .binding = &shader_injection.tone_map_blowout,
        .default_value = 0.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeFlare",
        .binding = &shader_injection.tone_map_flare,
        .default_value = 0.f,
        .label = "Flare",
        .section = "Color Grading",
        .tooltip = "Flare/Glare Compensation",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type == 3; },
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeScene",
        .binding = &shader_injection.color_grade_strength,
        .default_value = 100.f,
        .label = "Scene Grading",
        .section = "Color Grading",
        .tooltip = "Scene grading as applied by the game",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type > 0; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainCustomColorSpace",
        .binding = &shader_injection.swap_chain_custom_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Custom Color Space",
        .section = "Color Grading",
        .tooltip = "Selects output color space"
                   "\nUS Modern for BT.709 D65."
                   "\nJPN Modern for BT.709 D93."
                   "\nUS CRT for BT.601 (NTSC-U)."
                   "\nJPN CRT for BT.601 ARIB-TR-B9 D93 (NTSC-J)."
                   "\nDefault: US CRT",
        .labels = {
            "US Modern",
            "JPN Modern",
            "US CRT",
            "JPN CRT",
        },
        .is_visible = []() { return settings[0]->GetValue() == 1; },
    },
    new renodx::utils::settings::Setting{
      .key = "FxBloom",
      .binding = &shader_injection.custom_bloom,
      .default_value = 50.f,
      .label = "Bloom",
      .section = "Effects",
      .max = 100.f,
      .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
      .key = "FxLensFlare",
      .binding = &shader_injection.custom_lens_flare,
      .default_value = 50.f,
      .label = "Lens Flare",
      .section = "Effects",
      .max = 100.f,
      .parse = [](float value) { return value * 0.02f; },
    },
        new renodx::utils::settings::Setting{
      .key = "FxFog",
      .binding = &shader_injection.custom_fog,
      .default_value = 50.f,
      .label = "Fog",
      .section = "Effects",
      .max = 100.f,
      .parse = [](float value) { return value * 0.02f; },
    },
        new renodx::utils::settings::Setting{
      .key = "FxHeatHaze",
      .binding = &shader_injection.custom_heat_haze,
      .default_value = 100.f,
      .label = "Heat Haze",
      .section = "Effects",
      .max = 100.f,
      .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "FxFilmGrain",
        .binding = &shader_injection.custom_film_grain,
        .default_value = 0.f,
        .label = "Perceptual Film Grain",
        .section = "Effects",
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "MapThreat",
        .binding = &shader_injection.map_threat,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Map Threat",
        .section = "Effects",
        .labels = {"Off", "Vanilla"},
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Reset",
        .section = "About",
        .group = "button-line-1",
        .on_change = []() {
          for (auto* setting : settings) {
            if (setting->key.empty()) continue;
            if (!setting->can_reset) continue;
            renodx::utils::settings::UpdateSetting(setting->key, setting->default_value);
          }
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Discord",
        .section = "About",
        .group = "button-line-1",
        .tint = 0x5865F2,
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://discord.gg/", "5WZXDpmbpP");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Github",
        .section = "About",
        .group = "button-line-1",
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://github.com/clshortfuse/renodx");
        },
    },
};

void OnPresetOff() {
   renodx::utils::settings::UpdateSetting("ToneMapType", 0.f);
   renodx::utils::settings::UpdateSetting("ToneMapPeakNits", 203.f);
   renodx::utils::settings::UpdateSetting("ToneMapGameNits", 203.f);
   renodx::utils::settings::UpdateSetting("ToneMapUINits", 203.f);
   renodx::utils::settings::UpdateSetting("ToneMapGammaCorrection", 0);
   renodx::utils::settings::UpdateSetting("ColorGradeExposure", 1.f);
   renodx::utils::settings::UpdateSetting("ColorGradeHighlights", 50.f);
   renodx::utils::settings::UpdateSetting("ColorGradeShadows", 50.f);
   renodx::utils::settings::UpdateSetting("ColorGradeContrast", 50.f);
   renodx::utils::settings::UpdateSetting("ColorGradeSaturation", 50.f);
   renodx::utils::settings::UpdateSetting("SwapChainCustomColorSpace", 0.f);
   renodx::utils::settings::UpdateSetting("FxBloom", 50.f);
   renodx::utils::settings::UpdateSetting("FxLensFlare", 50.f);
   renodx::utils::settings::UpdateSetting("FxFog", 50.f);
   renodx::utils::settings::UpdateSetting("HeatHaze", 100.f);
   renodx::utils::settings::UpdateSetting("FxFilmGrain", 0.f);
   renodx::utils::settings::UpdateSetting("MapThreat", 1.f);
}

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX Mad Max";

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;
      renodx::mods::swapchain::force_borderless = false;
      renodx::mods::swapchain::prevent_full_screen = false;
      renodx::mods::swapchain::use_resource_cloning = true;
      renodx::mods::swapchain::swapchain_proxy_revert_state = true;
      renodx::utils::random::binds.push_back(&shader_injection.custom_random);
      renodx::mods::swapchain::swap_chain_proxy_vertex_shader = __swap_chain_proxy_vertex_shader_dx11;
      renodx::mods::swapchain::swap_chain_proxy_pixel_shader = __swap_chain_proxy_pixel_shader_dx11;
      
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_typeless,
          .new_format = reshade::api::format::r16g16b16a16_float,
      });
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r10g10b10a2_typeless,
          .new_format = reshade::api::format::r16g16b16a16_float,
      });
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r10g10b10a2_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
      });
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r11g11b10_float,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .ignore_size = true,
      });
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .aspect_ratio = renodx::mods::swapchain::SwapChainUpgradeTarget::BACK_BUFFER,
      });

      break;    
    case DLL_PROCESS_DETACH:
      reshade::unregister_addon(h_module);
      break;
  }

  renodx::utils::random::Use(fdw_reason);
  renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);
  renodx::mods::swapchain::Use(fdw_reason, &shader_injection);
  renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);

  return TRUE;
}
