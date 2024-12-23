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
#include <embed/0x02083F96.h>      // Bloom build
#include <embed/0x8BCC2057.h>      // character select
#include <embed/0xB5038743.h>      // worldmap
#include <embed/0x4D512CDB.h>      // location markers
#include <embed/0x295B28DB.h>      // DE malice
#include <embed/0x115840E1.h>      // DE malice 2

#include <embed/0xED61CCE3.h>      // bloom-ish
#include <embed/0xB47204C8.h>      // D'sE 1
#include <embed/0xEE78FE89.h>      // D'sE 2
#include <embed/0xD5804E21.h>      // Light Rays
#include <embed/0x88DE9EDE.h>      // Mistlock 1
#include <embed/0x24CE1FCB.h>      // Mistlock 2
#include <embed/0xD90FE0AC.h>      // Mistlock 3
#include <embed/0x750F53C0.h>      // Dragonfall (Kralkatorrik)
#include <embed/0x187268D3.h>      // Environment Zone Intensity
#include <embed/0x3BC05D0D.h>      // water 1
#include <embed/0x6C5C7797.h>      // water 2
#include <embed/0x98553490.h>      // no AO
#include <embed/0x8CFDCBEF.h>	     // SoC

#include <embed/0xDF711B8B.h>      // PoA
#include <embed/0x38A5D61E.h>      // Mesmer 1
#include <embed/0x46E87959.h>      // Mesmer 2
#include <embed/0x7DF6F3AD.h>      // Mesmer 3
#include <embed/0x9D19DDCF.h>      // Mesmer 4
#include <embed/0x5019ED9B.h>      // Mesmer 5
#include <embed/0xA437811A.h>      // Necro
#include <embed/0x1036913A.h>      // Rev
#include <embed/0x053DC742.h>      // Vermillion
#include <embed/0xEC3267AA.h>      // Falling Star
#include <embed/0x3E7DA787.h>      // Metrica 1
#include <embed/0x4F249A2F.h>      // Metrica 2
#include <embed/0x00EB18B3.h>      // Metrica 3
#include <embed/0xB7069766.h>      // Metrica 4
#include <embed/0x6039EAA8.h>	     // grothmar arena
#include <embed/0x351D5100.h>      // LA clouds
#include <embed/0xAFBAF19F.h>	     // sc eyes
#include <embed/0xBFAC7226.h>	     // conflux
#include <embed/0x9CAD85A7.h>	     // sb fc
#include <embed/0x70EC17AE.h>	     // sg bp / if ss
#include <embed/0xB0009D2C.h>	     // if ss 2
#include <embed/0x881B1931.h>	     // foxfire
#include <embed/0x75F10B02.h>	     // gourd
#include <embed/0xB5A234AE.h>	     // starborn cape
#include <embed/0xA4C910A5.h>	     // mystic forge
#include <embed/0x0D1308E2.h>	     // dremwalkr daggr
#include <embed/0xC1177C5A.h>	     // mystic beast
#include <embed/0x8BBB8C81.h>	     // jahai tornado
#include <embed/0x5E04E03C.h>	     // q1 ballz
#include <embed/0x03210DDC.h>	     // q1 ballz
#include <embed/0x849571E8.h>	     // q1 ballz

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

#include <embed/0x8090A92E.h>      // cutscenes (prerendered)

#include <embed/0x967994F1.h>      // addons (Nexus/Arc)
#include <embed/0x286DAA52.h>      // gw2radial1
#include <embed/0x09C864EA.h>      // gw2radial2
#include <embed/0x094260C9.h>      // gw2radial3

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/settings.hpp"
#include "../../utils/date.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {
    CustomShaderEntry(0xAA6E9F95),      // final shader                                         used for UI brightness
    CustomShaderEntry(0x317EFBE1),      // Light Adaptation                                 unsaturated to be usable
    CustomShaderEntry(0xA033440E),      // Vignette
    CustomShaderEntry(0x99068912),      // Depth Blur                            "simple" scaling, might be interesting to improve
    CustomShaderEntry(0x0DFA0CA1),      // Fog                                      can be pretty thick, added alpha slider
    CustomShaderEntry(0x02083F96),      // Bloom Build
    CustomShaderEntry(0x8BCC2057),      // character selection background
    CustomShaderEntry(0xB5038743),      // worldmap
    CustomShaderEntry(0x4D512CDB),      // location markers
    CustomShaderEntry(0x295B28DB),      // DE malice
    CustomShaderEntry(0x115840E1),      // DE malice2
	
    CustomShaderEntry(0xED61CCE3),      // bloom                               artifacts under specific circumstances, removed negative colors
    CustomShaderEntry(0xB47204C8),      // D'SE                                                          //
    CustomShaderEntry(0xEE78FE89),      // D'SE 2                                                        //
    CustomShaderEntry(0xD5804E21),      // Light rays                                                    // (to prevent leaks)
    CustomShaderEntry(0x88DE9EDE),      // Mistlock 1                                        dirty fix for artifacts
    CustomShaderEntry(0x24CE1FCB),      // Mistlock 2                                   same here, no clue what's going on
    CustomShaderEntry(0xD90FE0AC),      // Mistlock 3                                       something about alpha
    CustomShaderEntry(0x750F53C0),      // Dragonfall                                          green artifacting
    CustomShaderEntry(0x187268D3),      // Environment Zone Intensity                   alpha stuff, no clue again but it looks nice
    CustomShaderEntry(0x3BC05D0D),      // Underwater fog kinda 1                           cleared negative colors
    CustomShaderEntry(0x6C5C7797),      // Underwater fog kinda 2                                     //
    CustomShaderEntry(0x98553490),      // no AO (Crystal Oasis, maybe other)                         //
	CustomShaderEntry(0x8CFDCBEF),      // SoC						                                  //

    CustomShaderEntry(0xDF711B8B),      // Plains of Ashford                                    alpha saturate
    CustomShaderEntry(0x38A5D61E),      // Mesmer spell 1                                             //
    CustomShaderEntry(0x46E87959),      // Mesmer spell 2                                             //
    CustomShaderEntry(0x7DF6F3AD),      // Mesmer spell 3                                             //
    CustomShaderEntry(0x9D19DDCF),      // Mesmer spell 4                                             //
    CustomShaderEntry(0x5019ED9B),      // Mesmer spell 5                                             //
    CustomShaderEntry(0xA437811A),      // necro spell                                                //
  	CustomShaderEntry(0x1036913A),      // revenant spell                                             //
    CustomShaderEntry(0x053DC742),      // vermillion feather                                         //
    CustomShaderEntry(0xEC3267AA),      // falling star spear                                        /=/
    CustomShaderEntry(0x3E7DA787),      // Metrica 1                                    something something saturate something
    CustomShaderEntry(0x4F249A2F),      // Metrica 2                                                  //
    CustomShaderEntry(0x00EB18B3),      // Metrica 3                                                  //
    CustomShaderEntry(0xB7069766),      // Metrica 4                                                  //
	CustomShaderEntry(0x6039EAA8),      // Grothmar Arena                                             //
    CustomShaderEntry(0x351D5100),      // LA cloud                                                   //
    CustomShaderEntry(0xAFBAF19F),      // sc eyes                                                    //
    CustomShaderEntry(0xBFAC7226),      // conflux                                                    //
    CustomShaderEntry(0x9CAD85A7),      // sb fc                                                      //   (VS wtf)
    CustomShaderEntry(0x70EC17AE),      // if ss / sg bp                                              //
    CustomShaderEntry(0xB0009D2C),      // if ss  2                                                   //
    CustomShaderEntry(0x881B1931),      // foxfire                                                    //
    CustomShaderEntry(0x75F10B02),      // gourd                                                      //
    CustomShaderEntry(0xB5A234AE),      // starborn cape                                              //
    CustomShaderEntry(0xA4C910A5),      // mystic forge                                               //
    CustomShaderEntry(0x0D1308E2),      // dremwalkr daggr                                            //
    CustomShaderEntry(0xC1177C5A),      // mystic beast                                               //
    CustomShaderEntry(0x8BBB8C81),      // jahai tornado                                              //
    CustomShaderEntry(0x5E04E03C),      // q1 ballz                                                   //
    CustomShaderEntry(0x03210DDC),      // q1 ballz                                                   //
    CustomShaderEntry(0x849571E8),      // q1 ballz                                                   //

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

    CustomShaderEntry(0x8090A92E),      // pre-rendered cutscenes

    CustomShaderEntry(0x967994F1),      // external/third-party addons                       Nexus, ArcDPS, maybe others...
    CustomShaderEntry(0x286DAA52),      // gw2radial1
    CustomShaderEntry(0x09C864EA),      // gw2radial2
    CustomShaderEntry(0x094260C9),      // gw2radial3
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
        .labels = {"Vanilla", "None", "Frostbite", "RenoDRT", "DICE"},
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
        .tooltip = "Sets the value of 100% white in nits",
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
        .default_value = 1,
        .can_reset = false,
        .label = "Gamma Correction",
        .section = "Tone Mapping",
        .tooltip = "Emulates a 2.2 EOTF (use with HDR or sRGB)",
        .tint = 0x87581D,
    },
    new renodx::utils::settings::Setting{
        .key = "toneMapHueCorrection",
        .binding = &shader_injection.toneMapHueCorrection,
        .default_value = 75.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tint = 0x87581D,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "diceShoulderStart",
        .binding = &shader_injection.diceShoulderStart,
        .default_value = 0.33f,
        .label = "DICE Shoulder Start",
        .section = "Tone Mapping",
        .tint = 0x87581D,
        .max = 0.99f,
        .format = "%.2f",
        .is_enabled = []() { return shader_injection.toneMapType == 4.f; },
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
        .default_value = 0.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .tint = 0x186885,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType >= 2.f; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "colorGradeFlare",
        .binding = &shader_injection.colorGradeFlare,
        .default_value = 25.f,
        .label = "Flare",
        .section = "Color Grading",
        .tooltip = "Embrace the darkness... (Gently.)",
        .tint = 0x3A5953,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.toneMapType == 3.f; },
        .parse = [](float value) { return value * 0.02f; },
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
        .key = "colorGradeColorTint",
        .binding = &shader_injection.colorGradeColorTint,
        .default_value = 100.f,
        .label = "Color Tint",
        .section = "Color Grading",
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
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxLightAdaptation",
        .binding = &shader_injection.fxLightAdaptation,
        .default_value = 100.f,
        .label = "Light Adaptation",
        .section = "Effects",
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
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxVignette",
        .binding = &shader_injection.fxVignette,
        .default_value = 50.f,
        .label = "Vignette (Underwater)",
        .section = "Effects",
        .tint = 0x67A833,
        .max = 100.f,
        .parse = [](float value) { return -value * 0.02f + 2; },
    },
    new renodx::utils::settings::Setting{
        .key = "fxFog",
        .binding = &shader_injection.fxFog,
        .default_value = 100.f,
        .label = "Fog transparency",
        .section = "Effects",
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
        .tint = 0x2C9D5D,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Vibrant Filmic",
        .section = "Color Grading Templates",
        .group = "templates",
        .tooltip = "Powered by RenoDRT",
        .tint = 0x186885,
        .on_change = []() {
          renodx::utils::settings::UpdateSetting("toneMapType", 3.f);
          renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeHighlights", 65.f);
          renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeContrast", 55.f);
          renodx::utils::settings::UpdateSetting("colorGradeSaturation", 75.f);
          renodx::utils::settings::UpdateSetting("colorGradeBlowout", 80.f);
          renodx::utils::settings::UpdateSetting("colorGradeFlare", 40.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 100.f);
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Enhanced Vanilla",
        .section = "Color Grading Templates",
        .group = "templates",
        .tooltip = "Can be used with any Tone Mapper",
        .tint = 0x186885,
        .on_change = []() {
          renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeShadows", 55.f);
          renodx::utils::settings::UpdateSetting("colorGradeContrast", 60.f);
          renodx::utils::settings::UpdateSetting("colorGradeSaturation", 60.f);
          renodx::utils::settings::UpdateSetting("colorGradeBlowout", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeFlare", 20.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 100.f);
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Reset",
        .section = "Color Grading Templates",
        .group = "templates",
        .tooltip = "Reverts to default Color Grading.",
        .tint = 0x2C9D5D,
        .on_change = []() {
          renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
          renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
          renodx::utils::settings::UpdateSetting("colorGradeBlowout", 0.f);
          renodx::utils::settings::UpdateSetting("colorGradeFlare", 25.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
          renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 100.f);
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "Render Sampling should be native. Enable Bloom, Color Grading & Color Tint in game settings."
                 "\nYou can tune them down above (Light Adaptation & Depth Blur aswell).",
        .section = "Notes",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "RenoDX by ShortFuse, game mod by Voosh (or Not). Shout-out to HDR Den!",
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "HDR Den Discord",
        .section = "About",
        .group = "button-line-1",
        .tint = 0x5865F2,
        .on_change = []() {
          static const std::string obfuscated_link = std::string("start https://discord.gg/XUhv") + std::string("tR54yc");
          system(obfuscated_link.c_str());
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Github",
        .section = "About",
        .group = "button-line-1",
        .on_change = []() {
          system("start https://github.com/clshortfuse/renodx");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "ShortFuse's Ko-Fi",
        .section = "About",
        .group = "button-line-1",
        .tint = 0xFF5F5F,
        .on_change = []() {
          system("start https://ko-fi.com/shortfuse");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "HDR Den's Ko-Fi",
        .section = "About",
        .group = "button-line-1",
        .tint = 0xFF5F5F,
        .on_change = []() {
          system("start https://ko-fi.com/hdrden");
        },
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
  renodx::utils::settings::UpdateSetting("toneMapAddonNits", 203.f);
  renodx::utils::settings::UpdateSetting("toneMapGammaCorrection", 0);
  renodx::utils::settings::UpdateSetting("toneMapHueCorrection", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeExposure", 1.f);
  renodx::utils::settings::UpdateSetting("colorGradeHighlights", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeShadows", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeContrast", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeSaturation", 50.f);
  renodx::utils::settings::UpdateSetting("colorGradeBlowout", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeFlare", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTStrength", 100.f);
  renodx::utils::settings::UpdateSetting("colorGradeLUTScaling", 0.f);
  renodx::utils::settings::UpdateSetting("colorGradeColorTint", 100.f);
  renodx::utils::settings::UpdateSetting("fxBloom", 100.f);
  renodx::utils::settings::UpdateSetting("fxLightAdaptation", 100.f);
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

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX for Guild Wars 2";

// NOLINTEND(readability-identifier-naming)

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;
      renodx::mods::swapchain::force_borderless = false;
      renodx::mods::swapchain::prevent_full_screen = false;
      //renodx::mods::shader::trace_unmodified_shaders = true;
      // copy / UI things
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::b8g8r8a8_unorm,
          .new_format = reshade::api::format::r16g16b16a16_float,
          .index = 6,
          .ignore_size = true,
      });

      // pretty much everything else
      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
        .old_format = reshade::api::format::b8g8r8a8_unorm,
        .new_format = reshade::api::format::r16g16b16a16_float,
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
