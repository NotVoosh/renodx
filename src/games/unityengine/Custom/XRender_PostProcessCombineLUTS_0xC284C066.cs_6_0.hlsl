#include "../common.hlsli"

Texture2D<float4> t0 : register(t0);
Texture2D<float4> t1 : register(t1);
RWTexture3D<float3> u7 : register(u7);
cbuffer cb0 : register(b0) {
  float4 _ColorGradingCB_000 : packoffset(c000.x);
  float4 _ColorGradingCB_016 : packoffset(c001.x);
  float4 _ColorGradingCB_032 : packoffset(c002.x);
  float4 _ColorGradingCB_048 : packoffset(c003.x);
  float4 _ColorGradingCB_064 : packoffset(c004.x);
  float4 _ColorGradingCB_080 : packoffset(c005.x);
  float4 _ColorGradingCB_096 : packoffset(c006.x);
  float4 _ColorGradingCB_112 : packoffset(c007.x);
  float4 _ColorGradingCB_128 : packoffset(c008.x);
  float4 _ColorGradingCB_144 : packoffset(c009.x);
  float4 _ColorGradingCB_160 : packoffset(c010.x);
  float4 _ColorGradingCB_176 : packoffset(c011.x);
  float4 _ColorGradingCB_192 : packoffset(c012.x);
  float4 _ColorGradingCB_208 : packoffset(c013.x);
  float4 _ColorGradingCB_224 : packoffset(c014.x);
  float4 _ColorGradingCB_240 : packoffset(c015.x);
  float4 _ColorGradingCB_256 : packoffset(c016.x);
  float4 _ColorGradingCB_272 : packoffset(c017.x);
  float4 _ColorGradingCB_288 : packoffset(c018.x);
  float4 _ColorGradingCB_304 : packoffset(c019.x);
  float4 _ColorGradingCB_320 : packoffset(c020.x);
  float4 _ColorGradingCB_336 : packoffset(c021.x);
  float4 _ColorGradingCB_352 : packoffset(c022.x);
  float4 _ColorGradingCB_368 : packoffset(c023.x);
  float4 _ColorGradingCB_384 : packoffset(c024.x);
  float4 _ColorGradingCB_400 : packoffset(c025.x);
  int _ColorGradingCB_416 : packoffset(c026.x);
  int _ColorGradingCB_420 : packoffset(c026.y);
  int _ColorGradingCB_424 : packoffset(c026.z);
  int _ColorGradingCB_428 : packoffset(c026.w);
};

cbuffer cb1 : register(b1) {
  float _FilmTonemappingCB_000 : packoffset(c000.x);
  float _FilmTonemappingCB_004 : packoffset(c000.y);
  float _FilmTonemappingCB_008 : packoffset(c000.z);
  float _FilmTonemappingCB_012 : packoffset(c000.w);
  float _FilmTonemappingCB_016 : packoffset(c001.x);
  float _FilmTonemappingCB_020 : packoffset(c001.y);
  float _FilmTonemappingCB_024 : packoffset(c001.z);
  float _FilmTonemappingCB_028 : packoffset(c001.w);
};

cbuffer cb2 : register(b2) {
  float4 _PostProcessCombineLUTsCB_000 : packoffset(c000.x);
};

cbuffer cb3 : register(b3) {
  float4 _LUTBlendCB_000 : packoffset(c000.x);
  float4 _LUTBlendCB_016 : packoffset(c001.x);
};

SamplerState s0 : register(s0);

namespace unrealengine {

namespace filmtonemap {

struct Config {
  // UE parameters
  float FilmSlope;
  float FilmToe;
  float FilmShoulder;
  float FilmBlackClip;
  float FilmWhiteClip;

  // Derived values
  float toe_width;
  float shoulder_width;

  float log_toe_threshold;
  float log_mid_anchor;
  float log_shoulder_threshold;
};

namespace config {

Config Create(
    float FilmSlope,
    float FilmToe,
    float FilmShoulder,
    float FilmBlackClip,
    float FilmWhiteClip) {
  Config p;
  p.FilmSlope = FilmSlope;
  p.FilmToe = FilmToe;
  p.FilmShoulder = FilmShoulder;
  p.FilmBlackClip = FilmBlackClip;
  p.FilmWhiteClip = FilmWhiteClip;

  p.toe_width = (FilmBlackClip + 1.0f) - FilmToe;
  p.shoulder_width = (FilmWhiteClip + 1.0f) - FilmShoulder;
  if (FilmToe > 0.8) {
    p.log_toe_threshold = (((0.82 - FilmToe) / FilmSlope) - 0.7447274923324585f);
  } else {
    float toe_norm = (FilmBlackClip + 0.18) / p.toe_width;
    p.log_toe_threshold = (-0.7447274923324585f - ((log2(toe_norm / (2.0f - toe_norm)) * 0.3465735912322998f) * (p.toe_width / FilmSlope)));
  }

  p.log_mid_anchor = ((1.0f - FilmToe) / FilmSlope) - p.log_toe_threshold;
  p.log_shoulder_threshold = (FilmShoulder / FilmSlope) - p.log_mid_anchor;

  return p;
}

}  // config

#define FILMTONECURVE_GENERATOR(T)                                                                                                                                                      \
  T ApplyToneCurve(T untonemapped, const Config p) {                                                                                                                                    \
    T untonemapped_log = log2(untonemapped) * 0.3010300099849701f;                                                                                                                      \
                                                                                                                                                                                        \
    /* Straight */                                                                                                                                                                      \
    T straight_curve = p.FilmSlope * (untonemapped_log + p.log_mid_anchor);                                                                                                             \
                                                                                                                                                                                        \
    /* Construct Toe and blend with Straight */                                                                                                                                         \
    T toe_offset = untonemapped_log - p.log_toe_threshold;                                                                                                                              \
    T toe_curve =                                                                                                                                                                       \
        renodx::math::Select((untonemapped_log < p.log_toe_threshold),                                                                                                                  \
                             (((p.toe_width * 2.f) / (exp2((toe_offset * 1.4426950216293335f) * ((p.FilmSlope * -2.f) / p.toe_width)) + 1.f)) - p.FilmBlackClip),                       \
                             straight_curve);                                                                                                                                           \
                                                                                                                                                                                        \
    /* Construct Shoulder and blend with Straight */                                                                                                                                    \
    T shoulder_offset = untonemapped_log - p.log_shoulder_threshold;                                                                                                                    \
    T shoulder_curve =                                                                                                                                                                  \
        renodx::math::Select((untonemapped_log > p.log_shoulder_threshold),                                                                                                             \
                             ((1.f + p.FilmWhiteClip) - ((p.shoulder_width * 2.f) / (exp2((shoulder_offset * 1.4426950216293335f) * ((p.FilmSlope * 2.f) / p.shoulder_width)) + 1.f))), \
                             straight_curve);                                                                                                                                           \
                                                                                                                                                                                        \
    /* Blend between Toe and Shoulder */                                                                                                                                                \
    T t_linear = saturate(toe_offset / (p.log_shoulder_threshold - p.log_toe_threshold));                                                                                               \
    T t_blend = renodx::math::Select((p.log_shoulder_threshold < p.log_toe_threshold), (1.f - t_linear), t_linear);                                                                     \
    T film_tonemapped = (((t_blend * t_blend) * (shoulder_curve - toe_curve)) * (3.f - (t_blend * 2.f))) + toe_curve;                                                                   \
                                                                                                                                                                                        \
    return film_tonemapped;                                                                                                                                                             \
  }
FILMTONECURVE_GENERATOR(float)
FILMTONECURVE_GENERATOR(float3)
#undef FILMTONECURVE_GENERATOR

float3 ApplyToneCurve(
    float3 untonemapped,
    float FilmSlope, float FilmToe, float FilmShoulder, float FilmBlackClip, float FilmWhiteClip) {
  unrealengine::filmtonemap::Config filmic_params = config::Create(FilmSlope, FilmToe, FilmShoulder, FilmBlackClip, FilmWhiteClip);
  return ApplyToneCurve(untonemapped, filmic_params);
}

namespace extended {

float ComputeFilmicSlopeAtInput(const Config p, float x) {
  // Scale epsilon with x so it works for very small or big inputs
  float eps = max(x * (1.0f / 1024.0f), 1e-5f);

  float y_minus = ApplyToneCurve(x - eps, p);
  float y_plus = ApplyToneCurve(x + eps, p);

  return (y_plus - y_minus) / (2.0f * eps);
}

#define FILMTONECURVE_EXTENDED_GENERATOR(T)                                             \
  T ApplyToneCurveExtended(T untonemapped, T vanilla, const Config p) {                 \
    /* Evaluate Filmic at pivot */                                                      \
    float pivot_input = 0.18f; /* tonemapper is centered around 0.18*/                  \
    float y_offset = 0.18f;                                                             \
    float pivot_slope = ComputeFilmicSlopeAtInput(p, pivot_input);                      \
                                                                                        \
    /* Linear HDR tail anchored at (pivot_input, pivot_output) */                       \
    T extended_tail = pivot_slope * (untonemapped - pivot_input) + y_offset;            \
                                                                                        \
    /* use vanilla below pivot, extended after*/                                        \
    return renodx::math::Select(untonemapped < (T)pivot_input, vanilla, extended_tail); \
  }
FILMTONECURVE_EXTENDED_GENERATOR(float)
FILMTONECURVE_EXTENDED_GENERATOR(float3)
#undef FILMTONECURVE_EXTENDED_GENERATOR

float3 ApplyToneCurveExtended(
    float3 untonemapped,
    float FilmSlope, float FilmToe, float FilmShoulder, float FilmBlackClip, float FilmWhiteClip) {
  unrealengine::filmtonemap::Config filmic_params = config::Create(FilmSlope, FilmToe, FilmShoulder, FilmBlackClip, FilmWhiteClip);
  float3 vanilla = unrealengine::filmtonemap::ApplyToneCurve(untonemapped, filmic_params);
  return ApplyToneCurveExtended(untonemapped, vanilla, filmic_params);
}

float3 ApplyToneCurveExtended(
    float3 untonemapped, float3 vanilla,
    float FilmSlope, float FilmToe, float FilmShoulder, float FilmBlackClip, float FilmWhiteClip) {
  unrealengine::filmtonemap::Config filmic_params = config::Create(FilmSlope, FilmToe, FilmShoulder, FilmBlackClip, FilmWhiteClip);
  return ApplyToneCurveExtended(untonemapped, vanilla, filmic_params);
}

}  // extended

}  // filmtonemap

}  // unrealengine

[numthreads(8, 8, 8)]
void main(
  uint3 SV_DispatchThreadID : SV_DispatchThreadID,
  uint3 SV_GroupID : SV_GroupID,
  uint3 SV_GroupThreadID : SV_GroupThreadID,
  uint SV_GroupIndex : SV_GroupIndex
) {
  float _37;
  float _38;
  float _39;
  if (CUSTOM_INTERNAL_LUT_SHAPER == 0.f) {
  _37 = exp2((((_PostProcessCombineLUTsCB_000.z * (float((uint)SV_DispatchThreadID.x) + 0.5f)) + -0.015625f) * 14.45161247253418f) + -8.550177574157715f) + -0.002667719032615423f;
  _38 = exp2((((_PostProcessCombineLUTsCB_000.w * (float((uint)SV_DispatchThreadID.y) + 0.5f)) + -0.015625f) * 14.45161247253418f) + -8.550177574157715f) + -0.002667719032615423f;
  _39 = exp2((float((uint)SV_DispatchThreadID.z) * 0.4516128897666931f) + -8.550177574157715f) + -0.002667719032615423f;
  } else {
  _37 = ((_PostProcessCombineLUTsCB_000.z * (float((uint)SV_DispatchThreadID.x) + 0.5f)) + -0.015625f) * 1.03225803f;
  _38 = ((_PostProcessCombineLUTsCB_000.w * (float((uint)SV_DispatchThreadID.y) + 0.5f)) + -0.015625f) * 1.03225803f;
  _39 = float((uint)SV_DispatchThreadID.z) * 0.0322580636f;
  float3 decodedLutInput = lutShaper(float3(_37, _38, _39), true);
  _37 = decodedLutInput.x;
  _38 = decodedLutInput.y;
  _39 = decodedLutInput.z;
  }
  float _42 = mad(0.04737945273518562f, _39, mad(0.3395231366157532f, _38, (_37 * 0.6130974292755127f)));
  float _45 = mad(0.013452398590743542f, _39, mad(0.9163538813591003f, _38, (_37 * 0.07019372284412384f)));
  float _48 = mad(0.8698146343231201f, _39, mad(0.10956977307796478f, _38, (_37 * 0.0206155925989151f)));
  float _49 = dot(float3(_42, _45, _48), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _53 = (_42 / _49) + -1.0f;
  float _54 = (_45 / _49) + -1.0f;
  float _55 = (_48 / _49) + -1.0f;
  float _65 = (1.0f - exp2((_49 * _49) * (_ColorGradingCB_016.z * -4.0f))) * (1.0f - exp2(dot(float3(_53, _54, _55), float3(_53, _54, _55)) * -4.0f));
  float _81 = ((mad(-0.06368312239646912f, _48, mad(-0.3292921185493469f, _45, (_42 * 1.3704124689102173f))) - _42) * _65) + _42;
  float _82 = ((mad(-0.010861371643841267f, _48, mad(1.0970927476882935f, _45, (_42 * -0.08343351632356644f))) - _45) * _65) + _45;
  float _83 = ((mad(1.2036949396133423f, _48, mad(-0.0986257940530777f, _45, (_42 * -0.02579331584274769f))) - _48) * _65) + _48;
  float _88 = dot(float3(_81, _82, _83), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _102 = _ColorGradingCB_096.w + _ColorGradingCB_176.w;
  float _116 = _ColorGradingCB_080.w * _ColorGradingCB_160.w;
  float _130 = _ColorGradingCB_064.w * _ColorGradingCB_144.w;
  float _144 = _ColorGradingCB_048.w * _ColorGradingCB_128.w;
  float _155 = _ColorGradingCB_032.w * _ColorGradingCB_112.w;
  float _159 = _ColorGradingCB_032.x * (_81 - _88);
  float _162 = _ColorGradingCB_032.y * (_82 - _88);
  float _165 = _ColorGradingCB_032.z * (_83 - _88);
  float _220 = saturate(_88 / _ColorGradingCB_000.z);
  float _224 = (_220 * _220) * (3.0f - (_220 * 2.0f));
  float _225 = 1.0f - _224;
  float _234 = _ColorGradingCB_336.w + _ColorGradingCB_096.w;
  float _243 = _ColorGradingCB_320.w * _ColorGradingCB_080.w;
  float _252 = _ColorGradingCB_304.w * _ColorGradingCB_064.w;
  float _261 = _ColorGradingCB_288.w * _ColorGradingCB_048.w;
  float _267 = _ColorGradingCB_272.w * _ColorGradingCB_032.w;
  float _328 = saturate((_88 - _ColorGradingCB_000.w) / (_ColorGradingCB_016.x - _ColorGradingCB_000.w));
  float _332 = (_328 * _328) * (3.0f - (_328 * 2.0f));
  float _341 = _ColorGradingCB_256.w + _ColorGradingCB_096.w;
  float _350 = _ColorGradingCB_240.w * _ColorGradingCB_080.w;
  float _359 = _ColorGradingCB_224.w * _ColorGradingCB_064.w;
  float _368 = _ColorGradingCB_208.w * _ColorGradingCB_048.w;
  float _374 = _ColorGradingCB_192.w * _ColorGradingCB_032.w;
  float _432 = _224 - _332;
  float _443 = ((_332 * (((_ColorGradingCB_336.x + _ColorGradingCB_096.x) + _234) + (((_ColorGradingCB_320.x * _ColorGradingCB_080.x) * _243) * exp2(log2(exp2(((_ColorGradingCB_288.x * _ColorGradingCB_048.x) * _261) * log2(max(0.0f, (((_159 * _ColorGradingCB_272.x) * _267) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_304.x * _ColorGradingCB_064.x) * _252)))))) + (_225 * (((_ColorGradingCB_096.x + _ColorGradingCB_176.x) + _102) + (((_ColorGradingCB_080.x * _ColorGradingCB_160.x) * _116) * exp2(log2(exp2(((_ColorGradingCB_048.x * _ColorGradingCB_128.x) * _144) * log2(max(0.0f, (((_159 * _ColorGradingCB_112.x) * _155) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_064.x * _ColorGradingCB_144.x) * _130))))))) + ((((_ColorGradingCB_256.x + _ColorGradingCB_096.x) + _341) + (((_ColorGradingCB_240.x * _ColorGradingCB_080.x) * _350) * exp2(log2(exp2(((_ColorGradingCB_208.x * _ColorGradingCB_048.x) * _368) * log2(max(0.0f, (((_159 * _ColorGradingCB_192.x) * _374) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_224.x * _ColorGradingCB_064.x) * _359))))) * _432);
  float _445 = ((_332 * (((_ColorGradingCB_336.y + _ColorGradingCB_096.y) + _234) + (((_ColorGradingCB_320.y * _ColorGradingCB_080.y) * _243) * exp2(log2(exp2(((_ColorGradingCB_288.y * _ColorGradingCB_048.y) * _261) * log2(max(0.0f, (((_162 * _ColorGradingCB_272.y) * _267) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_304.y * _ColorGradingCB_064.y) * _252)))))) + (_225 * (((_ColorGradingCB_096.y + _ColorGradingCB_176.y) + _102) + (((_ColorGradingCB_080.y * _ColorGradingCB_160.y) * _116) * exp2(log2(exp2(((_ColorGradingCB_048.y * _ColorGradingCB_128.y) * _144) * log2(max(0.0f, (((_162 * _ColorGradingCB_112.y) * _155) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_064.y * _ColorGradingCB_144.y) * _130))))))) + ((((_ColorGradingCB_256.y + _ColorGradingCB_096.y) + _341) + (((_ColorGradingCB_240.y * _ColorGradingCB_080.y) * _350) * exp2(log2(exp2(((_ColorGradingCB_208.y * _ColorGradingCB_048.y) * _368) * log2(max(0.0f, (((_162 * _ColorGradingCB_192.y) * _374) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_224.y * _ColorGradingCB_064.y) * _359))))) * _432);
  float _447 = ((_332 * (((_ColorGradingCB_336.z + _ColorGradingCB_096.z) + _234) + (((_ColorGradingCB_320.z * _ColorGradingCB_080.z) * _243) * exp2(log2(exp2(((_ColorGradingCB_288.z * _ColorGradingCB_048.z) * _261) * log2(max(0.0f, (((_165 * _ColorGradingCB_272.z) * _267) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_304.z * _ColorGradingCB_064.z) * _252)))))) + (_225 * (((_ColorGradingCB_096.z + _ColorGradingCB_176.z) + _102) + (((_ColorGradingCB_080.z * _ColorGradingCB_160.z) * _116) * exp2(log2(exp2(((_ColorGradingCB_048.z * _ColorGradingCB_128.z) * _144) * log2(max(0.0f, (((_165 * _ColorGradingCB_112.z) * _155) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_064.z * _ColorGradingCB_144.z) * _130))))))) + ((((_ColorGradingCB_256.z + _ColorGradingCB_096.z) + _341) + (((_ColorGradingCB_240.z * _ColorGradingCB_080.z) * _350) * exp2(log2(exp2(((_ColorGradingCB_208.z * _ColorGradingCB_048.z) * _368) * log2(max(0.0f, (((_165 * _ColorGradingCB_192.z) * _374) + _88)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((_ColorGradingCB_224.z * _ColorGradingCB_064.z) * _359))))) * _432);
  _443 = lerp(_42, _443, CUSTOM_INTERNAL_LUT_STRENGTH);
  _445 = lerp(_45, _445, CUSTOM_INTERNAL_LUT_STRENGTH);
  _447 = lerp(_48, _447, CUSTOM_INTERNAL_LUT_STRENGTH);
  float _461 = ((mad(0.06136061251163483f, _447, mad(-4.540197551250458e-09f, _445, (_443 * 0.9386393427848816f))) - _443) * _ColorGradingCB_016.y) + _443;
  float _462 = ((mad(0.169205904006958f, _447, mad(0.8307941555976868f, _445, (_443 * 6.984919309616089e-10f))) - _445) * _ColorGradingCB_016.y) + _445;
  float _463 = (mad(2.3283064365386963e-10f, _445, (_443 * -9.313225746154785e-10f)) * _ColorGradingCB_016.y) + _447;
  float _466 = mad(0.16386906802654266f, _463, mad(0.14067870378494263f, _462, (_461 * 0.6954522132873535f)));
  float _469 = mad(0.0955343171954155f, _463, mad(0.8596711158752441f, _462, (_461 * 0.044794563204050064f)));
  float _472 = mad(1.0015007257461548f, _463, mad(0.004025210160762072f, _462, (_461 * -0.005525882821530104f)));
  float _476 = max(max(_466, _469), _472);
  float _481 = (max(_476, 1.000000013351432e-10f) - max(min(min(_466, _469), _472), 1.000000013351432e-10f)) / max(_476, 0.009999999776482582f);
  float _494 = ((_469 + _466) + _472) + (sqrt((((_472 - _469) * _472) + ((_469 - _466) * _469)) + ((_466 - _472) * _466)) * 1.75f);
  float _495 = _494 * 0.3333333432674408f;
  float _496 = _481 + -0.4000000059604645f;
  float _497 = _496 * 5.0f;
  float _501 = max((1.0f - abs(_496 * 2.5f)), 0.0f);
  float _512 = ((float((int)(((int)(uint)((bool)(_497 > 0.0f))) - ((int)(uint)((bool)(_497 < 0.0f))))) * (1.0f - (_501 * _501))) + 1.0f) * 0.02500000037252903f;
  float _521;
  float _554;
  float _568;
  float _633;
  if (!(_495 <= 0.0533333346247673f)) {
    if (!(_495 >= 0.1599999964237213f)) {
      _521 = (((0.23999999463558197f / _494) + -0.5f) * _512);
    } else {
      _521 = 0.0f;
    }
  } else {
    _521 = _512;
  }
  float _522 = _521 + 1.0f;
  float _523 = _522 * _466;
  float _524 = _522 * _469;
  float _525 = _522 * _472;
  if (!((bool)(_523 == _524) && (bool)(_524 == _525))) {
    float _532 = ((_523 * 2.0f) - _524) - _525;
    float _535 = ((_469 - _472) * 1.7320507764816284f) * _522;
    float _537 = atan(_535 / _532);
    bool _540 = (_532 < 0.0f);
    bool _541 = (_532 == 0.0f);
    bool _542 = (_535 >= 0.0f);
    bool _543 = (_535 < 0.0f);
    _554 = select((_542 && _541), 90.0f, select((_543 && _541), -90.0f, (select((_543 && _540), (_537 + -3.1415927410125732f), select((_542 && _540), (_537 + 3.1415927410125732f), _537)) * 57.2957763671875f)));
  } else {
    _554 = 0.0f;
  }
  float _559 = min(max(select((_554 < 0.0f), (_554 + 360.0f), _554), 0.0f), 360.0f);
  if (_559 < -180.0f) {
    _568 = (_559 + 360.0f);
  } else {
    if (_559 > 180.0f) {
      _568 = (_559 + -360.0f);
    } else {
      _568 = _559;
    }
  }
  float _572 = saturate(1.0f - abs(_568 * 0.014814814552664757f));
  float _574 = 3.0f - (_572 * 2.0f);
  float _576 = _572 * _572;
  float _583 = (((_574 * _574) * ((_481 * 0.18000000715255737f) * (0.029999999329447746f - _523))) * (_576 * _576)) + _523;
  float _593 = max(0.0f, mad(-0.21492856740951538f, _525, mad(-0.2365107536315918f, _524, (_583 * 1.4514392614364624f))));
  float _594 = max(0.0f, mad(-0.09967592358589172f, _525, mad(1.17622971534729f, _524, (_583 * -0.07655377686023712f))));
  float _595 = max(0.0f, mad(0.9977163076400757f, _525, mad(-0.006032449658960104f, _524, (_583 * 0.008316148072481155f))));
  float _596 = dot(float3(_593, _594, _595), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _610 = (_FilmTonemappingCB_012 + 1.0f) - _FilmTonemappingCB_004;
  float _613 = _FilmTonemappingCB_016 + 1.0f;
  float _615 = _613 - _FilmTonemappingCB_008;
  if (_FilmTonemappingCB_004 > 0.800000011920929f) {
    _633 = (((0.8199999928474426f - _FilmTonemappingCB_004) / _FilmTonemappingCB_000) + -0.7447274923324585f);
  } else {
    float _624 = (_FilmTonemappingCB_012 + 0.18000000715255737f) / _610;
    _633 = (-0.7447274923324585f - ((log2(_624 / (2.0f - _624)) * 0.3465735912322998f) * (_610 / _FilmTonemappingCB_000)));
  }
  float _636 = ((1.0f - _FilmTonemappingCB_004) / _FilmTonemappingCB_000) - _633;
  float _638 = (_FilmTonemappingCB_008 / _FilmTonemappingCB_000) - _636;
  float _642 = lerp(_596, _593, 0.9599999785423279f);
  float _643 = lerp(_596, _594, 0.9599999785423279f);
  float _644 = lerp(_596, _595, 0.9599999785423279f);
  float3 RRTresult = float3(_642, _643, _644);
  _642 = log2(_642) * 0.3010300099849701f;
  _643 = log2(_643) * 0.3010300099849701f;
  _644 = log2(_644) * 0.3010300099849701f;
  float _648 = (_642 + _636) * _FilmTonemappingCB_000;
  float _649 = (_643 + _636) * _FilmTonemappingCB_000;
  float _650 = (_644 + _636) * _FilmTonemappingCB_000;
  float _651 = -0.0f - _FilmTonemappingCB_012;
  float _652 = _610 * 2.0f;
  float _655 = _642 - _633;
  float _656 = _643 - _633;
  float _657 = _644 - _633;
  float _658 = ((_FilmTonemappingCB_000 * -2.0f) / _610) * 1.4426950216293335f;
  float _671 = _615 * 2.0f;
  float _677 = ((_FilmTonemappingCB_000 * 2.0f) / _615) * 1.4426950216293335f;
  float _702 = ((_651 - _648) + (_652 / (exp2(_658 * _655) + 1.0f))) * float((bool)(bool)(_642 < _633));
  float _703 = ((_651 - _649) + (_652 / (exp2(_658 * _656) + 1.0f))) * float((bool)(bool)(_643 < _633));
  float _704 = ((_651 - _650) + (_652 / (exp2(_658 * _657) + 1.0f))) * float((bool)(bool)(_644 < _633));
  float _723 = _638 - _633;
  float _727 = saturate(_655 / _723);
  float _728 = saturate(_656 / _723);
  float _729 = saturate(_657 / _723);
  bool _730 = (_638 < _633);
  float _734 = select(_730, (1.0f - _727), _727);
  float _735 = select(_730, (1.0f - _728), _728);
  float _736 = select(_730, (1.0f - _729), _729);
  float _755 = (_702 + _648) + (((_734 * _734) * ((((_613 - _648) - (_671 / (exp2(_677 * (_642 - _638)) + 1.0f))) * float((bool)(bool)(_642 > _638))) - _702)) * (3.0f - (_734 * 2.0f)));
  float _756 = (_703 + _649) + (((_735 * _735) * ((((_613 - _649) - (_671 / (exp2(_677 * (_643 - _638)) + 1.0f))) * float((bool)(bool)(_643 > _638))) - _703)) * (3.0f - (_735 * 2.0f)));
  float _757 = (_704 + _650) + (((_736 * _736) * ((((_613 - _650) - (_671 / (exp2(_677 * (_644 - _638)) + 1.0f))) * float((bool)(bool)(_644 > _638))) - _704)) * (3.0f - (_736 * 2.0f)));
  float3 sdrTonemappedAp1 = float3(_755, _756, _757);
  float _758 = dot(float3(_755, _756, _757), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _777 = ((max(0.0f, (lerp(_758, _755, 0.9300000071525574f))) - _461) * _ColorGradingCB_016.w) + _461;
  float _778 = ((max(0.0f, (lerp(_758, _756, 0.9300000071525574f))) - _462) * _ColorGradingCB_016.w) + _462;
  float _779 = ((max(0.0f, (lerp(_758, _757, 0.9300000071525574f))) - _463) * _ColorGradingCB_016.w) + _463;
  float _795 = ((mad(-0.06537103652954102f, _779, mad(1.4667166396975517e-06f, _778, (_777 * 1.0653746128082275f))) - _777) * _ColorGradingCB_016.y) + _777;
  float _796 = ((mad(-0.20366773009300232f, _779, mad(1.2036634683609009f, _778, (_777 * -3.3905962482094765e-07f))) - _778) * _ColorGradingCB_016.y) + _778;
  float _797 = ((mad(0.9999996423721313f, _779, mad(2.1886080503463745e-08f, _778, (_777 * 1.862645149230957e-08f))) - _779) * _ColorGradingCB_016.y) + _779;
  float _810 = max(0.0f, mad(-0.08325886726379395f, _797, mad(-0.6217920184135437f, _796, (_795 * 1.7050509452819824f))));
  float _811 = max(0.0f, mad(-0.010548318736255169f, _797, mad(1.140804648399353f, _796, (_795 * -0.13025641441345215f))));
  float _812 = max(0.0f, mad(1.1529723405838013f, _797, mad(-0.1289689689874649f, _796, (_795 * -0.024003352969884872f))));
  float3 sdrTonemappedBt709 = float3(_810, _811, _812);
  if (RENODX_TONE_MAP_TYPE == 0.f) {
  } else if (RENODX_TONE_MAP_TYPE == 1.f) {
    _795 = _443;
    _796 = _445;
    _797 = _447;
    _810 = mad(-0.08325886726379395f, _797, mad(-0.6217920184135437f, _796, (_795 * 1.7050509452819824f)));
    _811 = mad(-0.010548318736255169f, _797, mad(1.140804648399353f, _796, (_795 * -0.13025641441345215f)));
    _812 = mad(1.1529723405838013f, _797, mad(-0.1289689689874649f, _796, (_795 * -0.024003352969884872f)));
  } else {
    float3 extendedTonemapAp1 = unrealengine::filmtonemap::extended::ApplyToneCurveExtended(RRTresult, sdrTonemappedAp1, _FilmTonemappingCB_000, _FilmTonemappingCB_004, _FilmTonemappingCB_008, _FilmTonemappingCB_012, _FilmTonemappingCB_016);
    _755 = extendedTonemapAp1.x;
    _756 = extendedTonemapAp1.y;
    _757 = extendedTonemapAp1.z;
    _758 = dot(float3(_755, _756, _757), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
    _777 = ((max(0.0f, (lerp(_758, _755, 0.9300000071525574f))) - _461) * _ColorGradingCB_016.w) + _461;
    _778 = ((max(0.0f, (lerp(_758, _756, 0.9300000071525574f))) - _462) * _ColorGradingCB_016.w) + _462;
    _779 = ((max(0.0f, (lerp(_758, _757, 0.9300000071525574f))) - _463) * _ColorGradingCB_016.w) + _463;
    _795 = ((mad(-0.06537103652954102f, _779, mad(1.4667166396975517e-06f, _778, (_777 * 1.0653746128082275f))) - _777) * _ColorGradingCB_016.y) + _777;
    _796 = ((mad(-0.20366773009300232f, _779, mad(1.2036634683609009f, _778, (_777 * -3.3905962482094765e-07f))) - _778) * _ColorGradingCB_016.y) + _778;
    _797 = ((mad(0.9999996423721313f, _779, mad(2.1886080503463745e-08f, _778, (_777 * 1.862645149230957e-08f))) - _779) * _ColorGradingCB_016.y) + _779;
    _810 = mad(-0.08325886726379395f, _797, mad(-0.6217920184135437f, _796, (_795 * 1.7050509452819824f)));
    _811 = mad(-0.010548318736255169f, _797, mad(1.140804648399353f, _796, (_795 * -0.13025641441345215f)));
    _812 = mad(1.1529723405838013f, _797, mad(-0.1289689689874649f, _796, (_795 * -0.024003352969884872f)));
    float3 extendedTonemapBt709 = float3(_810, _811, _812);
    extendedTonemapBt709 = CorrectHueAndChrominanceOKLAB(extendedTonemapBt709, sdrTonemappedBt709, RENODX_TONE_MAP_SDRHUE, RENODX_TONE_MAP_SDRCHROMINANCE);
    _810 = extendedTonemapBt709.x;
    _811 = extendedTonemapBt709.y;
    _812 = extendedTonemapBt709.z;
  }
  float3 preLUT = float3(_810, _811, _812);
  float3 lutInput = preLUT;
  float compression_scale;
  float max_channel_scale;
  GamutCompression(lutInput, compression_scale);
  NeutwoMaxCh(lutInput, max_channel_scale);
  _810 = saturate(lutInput.x);
  _811 = saturate(lutInput.y);
  _812 = saturate(lutInput.z);
  float _831 = (exp2(log2(abs(_810)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f;
  float _832 = (exp2(log2(abs(_811)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f;
  float _833 = (exp2(log2(abs(_812)) * 0.4166666567325592f) * 1.0549999475479126f) + -0.054999999701976776f;
  float _846 = (((_810 * 12.920000076293945f) - _831) * float((bool)(bool)(_810 <= 0.0031308000907301903f))) + _831;
  float _847 = (((_811 * 12.920000076293945f) - _832) * float((bool)(bool)(_811 <= 0.0031308000907301903f))) + _832;
  float _848 = (((_812 * 12.920000076293945f) - _833) * float((bool)(bool)(_812 <= 0.0031308000907301903f))) + _833;
  float _857 = _848 * 15.0f;
  float _858 = floor(_857);
  float _859 = _857 - _858;
  float _862 = ((_858 + 0.03125f) + (_846 * 0.9375f)) * 0.0625f;
  float _863 = 0.96875f - (_847 * 0.9375f);
  float4 _864 = t0.SampleLevel(s0, float2(_862, _863), 0.0f);
  float _868 = _862 + 0.0625f;
  float4 _869 = t0.SampleLevel(s0, float2(_868, _863), 0.0f);
  float4 _889 = t1.SampleLevel(s0, float2(_862, _863), 0.0f);
  float4 _893 = t1.SampleLevel(s0, float2(_868, _863), 0.0f);
  float _909 = (((lerp(_864.x, _869.x, _859)) * _LUTBlendCB_000.y) + (_846 * _LUTBlendCB_000.x)) + ((lerp(_889.x, _893.x, _859)) * _LUTBlendCB_000.z);
  float _910 = (((lerp(_864.y, _869.y, _859)) * _LUTBlendCB_000.y) + (_847 * _LUTBlendCB_000.x)) + ((lerp(_889.y, _893.y, _859)) * _LUTBlendCB_000.z);
  float _911 = (((lerp(_864.z, _869.z, _859)) * _LUTBlendCB_000.y) + (_848 * _LUTBlendCB_000.x)) + ((lerp(_889.z, _893.z, _859)) * _LUTBlendCB_000.z);
  float3 postLUT = renodx::color::srgb::DecodeSafe(float3(_909, _910, _911));
  NeutwoMaxChInverse(postLUT, max_channel_scale);
  GamutDecompression(postLUT, compression_scale);
  float _920 = lerp(preLUT.x, postLUT.x, CUSTOM_USER_LUT_STRENGTH);
  float _921 = lerp(preLUT.y, postLUT.y, CUSTOM_USER_LUT_STRENGTH);
  float _922 = lerp(preLUT.z, postLUT.z, CUSTOM_USER_LUT_STRENGTH);
  u7[int3((uint)(SV_DispatchThreadID.x), (uint)(SV_DispatchThreadID.y), (uint)(SV_DispatchThreadID.z))] = renodx::color::srgb::EncodeSafe(float3(_920, _921, _922)) * 0.9523810148239136f;
}
