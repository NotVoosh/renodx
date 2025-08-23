#include "../tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[18];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.yz = -cb0[17].yz + v1.xy;
  r1.x = cb0[17].x * r0.y;
  r0.x = frac(r1.x);
  r1.x = r0.x / cb0[17].x;
  r0.w = -r1.x + r0.y;
  r0.xyz = r0.xzw * cb0[17].www;
  r0.xyz = lutShaper(r0.xyz, true);
  float3 preCG = r0.xyz;
  r1.x = dot(float3(0.439700991,0.382977992,0.177334994), r0.xyz);
  r1.y = dot(float3(0.0897922963,0.813422978,0.0967615992), r0.xyz);
  r1.z = dot(float3(0.0175439995,0.111543998,0.870703995), r0.xyz);
  r0.xyz = acesccEncode(r1.xyz);
  r0.xyz = r0.xyz * cb0[10].xyz + cb0[8].xyz;
  r1.xyz = log2(r0.xyz);
  r1.xyz = cb0[9].xyz * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r0.xyz = (r0.xyz > (0.0).xxx) ? r1.xyz : r0.xyz;
  r0.w = step(r0.z, r0.y);
  r1.xy = r0.zy;
  r2.xy = -r1.xy + r0.yz;
  r1.zw = float2(-1.0, 2.0 / 3.0);
  r2.zw = float2(1,-1);
  r1.xyzw = r0.wwww * r2.xywz + r1.xywz;
  r0.w = step(r1.x, r0.x);
  r2.z = r1.w;
  r1.w = r0.x;
  r2.xyw = r1.wyx;
  r2.xyzw = r2.xyzw + -r1.xyzw;
  r1.xyzw = r0.wwww * r2.xyzw + r1.xyzw;
  r0.w = min(r1.w, r1.y);
  r0.w = r1.x + -r0.w;
  r2.x = r0.w * 6.0 + 0.0001;
  r1.y = r1.w + -r1.y;
  r1.y = r1.y / r2.x;
  r1.y = r1.z + r1.y;
  r1.x = 0.0001 + r1.x;
  r2.z = r0.w / r1.x;
  r2.x = abs(r1.y);
  r2.yw = float2(0.25,0.25);
  r1.xyzw = t0.Sample(s0_s, r2.xy).yxzw;
  r2.xyzw = t0.Sample(s0_s, r2.zw).zxyw;
  r2.x = saturate(r2.x);
  r0.w = r2.x + r2.x;
  r1.x = saturate(r1.x);
  r1.x = r1.x + r1.x;
  r0.w = r1.x * r0.w;
  r1.x = dot(r0.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r0.xyz = -r1.xxx + r0.xyz;
  r1.yw = float2(0.25,0.25);
  r2.xyzw = t0.Sample(s0_s, r1.xy).wxyz;
  r2.x = saturate(r2.x);
  r1.y = r2.x + r2.x;
  r0.w = r1.y * r0.w;
  r0.w = cb0[11].x * r0.w;
  r0.xyz = r0.www * r0.xyz + r1.xxx;
  r0.xyz = float3(-0.4135884,-0.4135884,-0.4135884) + r0.xyz;
  r0.xyz = r0.xyz * cb0[11].yyy + float3(0.4135884,0.4135884,0.4135884);
  r2.xyz = acescc::Decode(r0.xyz);
  r0.x = dot(float3(1.45143926,-0.236510754,-0.214928567), r2.xyz);
  r0.y = dot(float3(-0.0765537769,1.17622972,-0.0996759236), r2.xyz);
  r0.z = dot(float3(0.00831614807,-0.00603244966,0.997716308), r2.xyz);
  r2.x = dot(float3(0.390405,0.549941,0.00892632), r0.xyz);
  r2.y = dot(float3(0.0708416,0.963172,0.00135775), r0.xyz);
  r2.z = dot(float3(0.0231082,0.128021,0.936245), r0.xyz);
  r0.xyz = cb0[4].xyz * r2.xyz;
  r2.x = dot(float3(2.85847,-1.62879,-0.0248910), r0.xyz);
  r2.y = dot(float3(-0.210182,1.15820,0.000324281), r0.xyz);
  r2.z = dot(float3(-0.0418120,-0.118169,1.06867), r0.xyz);
  r0.xyz = float3(1,1,1) + -cb0[5].xyz;
  r0.xyz = cb0[7].xyz * r0.xyz;
  r3.xyz = cb0[7].xyz * cb0[5].xyz;
  r0.xyz = r2.xyz * r0.xyz + r3.xyz;
  r2.xyz = log2(r0.xyz);
  r2.xyz = cb0[6].xyz * r2.xyz;
  r2.xyz = exp2(r2.xyz);
  r0.xyw = (r0.yzx > (0.0).xxx) ? r2.yzx : r0.yzx;
  r1.x = step(r0.y, r0.x);
  r2.xy = r0.yx;
  r3.xy = -r2.xy + r0.xy;
  r2.zw = float2(-1.0, 2.0 / 3.0);
  r3.zw = float2(1,-1);
  r2.xyzw = r1.xxxx * r3.xyzw + r2.xyzw;
  r1.x = step(r2.x, r0.w);
  r0.xyz = r2.xyw;
  r2.xyw = r0.wyx;
  r2.xyzw = r2.xyzw + -r0.xyzw;
  r0.xyzw = r1.xxxx * r2.xyzw + r0.xyzw;
  r1.x = min(r0.w, r0.y);
  r1.x = -r1.x + r0.x;
  r1.y = r1.x * 6.0 + 0.0001;
  r0.y = r0.w + -r0.y;
  r0.y = r0.y / r1.y;
  r0.y = r0.z + r0.y;
  r1.z = cb0[10].w + abs(r0.y);
  r2.xyzw = t0.Sample(s0_s, r1.zw).xyzw;
  r2.x = saturate(r2.x);
  r0.y = -0.5 + r2.x;
  r0.y = r1.z + r0.y;
  r1.yz = float2(1,-1) + r0.yy;
  r0.z = (r0.y > 1) ? r1.z : r0.y;
  r0.y = (r0.y < 0) ? r1.y : r0.z;
  r0.yzw = float3(1.0, 2.0 / 3.0, 1.0 / 3.0) + r0.yyy;
  r0.yzw = frac(r0.yzw);
  r0.yzw = r0.yzw * float3(6,6,6) + float3(-3,-3,-3);
  r0.yzw = saturate(float3(-1,-1,-1) + abs(r0.yzw));
  r0.yzw = float3(-1,-1,-1) + r0.yzw;
  r1.y = 0.0001 + r0.x;
  r1.x = r1.x / r1.y;
  r0.yzw = r1.xxx * r0.yzw + float3(1,1,1);
  r0.xyz = r0.xxx * r0.yzw;
  r1.x = dot(r0.xyz, cb0[12].xyz);
  r1.y = dot(r0.xyz, cb0[13].xyz);
  r1.z = dot(r0.xyz, cb0[14].xyz);
  r0.y = dot(float3(0.695452213,0.140678704,0.163869068), r1.xyz);
  r0.z = dot(float3(0.0447945632,0.859671116,0.0955343172), r1.xyz);
  r0.w = dot(float3(-0.00552588282,0.00402521016,1.00150073), r1.xyz);
  r0.xyz = mul(ACES_to_SRGB_MAT, r0.yzw);
  r0.xyz = lerp(preCG, r0.xyz, injectedData.colorGradeInternalLUTStrength);
  //r0.xyz = applyUserTonemapACES(r0.xyz, 0);
  float midGray = vanillaACES(float3(0.18f, 0.18f, 0.18f), 0).x;
  float3 hueCorrectionColor = vanillaACES(r0.xyz, 0);
  renodx::tonemap::Config config = renodx::tonemap::config::Create();
  config.type = min(3, injectedData.toneMapType);
  config.peak_nits = injectedData.toneMapPeakNits;
  config.game_nits = injectedData.toneMapGameNits;
  config.gamma_correction = injectedData.toneMapGammaCorrection;
  config.exposure = injectedData.colorGradeExposure;
  config.highlights = injectedData.colorGradeHighlights;
  config.shadows = injectedData.colorGradeShadows;
  config.contrast = injectedData.colorGradeContrast;
  //config.saturation = injectedData.colorGradeSaturation;
  config.mid_gray_value = midGray;
  config.mid_gray_nits = midGray * 100;
  config.reno_drt_contrast = 1.6f;
  config.reno_drt_saturation = 0.92f;
  //config.reno_drt_dechroma = injectedData.colorGradeDechroma;
  config.reno_drt_flare = 0.10f * pow(injectedData.colorGradeFlare, 10.f);
  config.hue_correction_type = injectedData.toneMapPerChannel != 0.f ? renodx::tonemap::config::hue_correction_type::INPUT
                                                                     : renodx::tonemap::config::hue_correction_type::CUSTOM;
  config.hue_correction_strength = injectedData.toneMapHueCorrection;
  config.hue_correction_color = lerp(r0.xyz, hueCorrectionColor, injectedData.toneMapHueShift);
  config.reno_drt_hue_correction_method = (int)injectedData.toneMapHueProcessor;
  config.reno_drt_tone_map_method = injectedData.toneMapType == 4.f ? renodx::tonemap::renodrt::config::tone_map_method::REINHARD
                                                                    : renodx::tonemap::renodrt::config::tone_map_method::DANIELE;
  config.reno_drt_working_color_space = (int)injectedData.toneMapColorSpace;
  config.reno_drt_per_channel = injectedData.toneMapPerChannel != 0.f;
  //config.reno_drt_blowout = 1.f - injectedData.colorGradeBlowout;
  config.reno_drt_white_clip = injectedData.colorGradeClip == 0.f ? 100.f : injectedData.colorGradeClip;
  if(config.type == 0.f){
    r0.xyz = saturate(hueCorrectionColor);
  }
  if (injectedData.colorGradeInternalLUTStrength == 0.f || config.type == 1.f) {
    r0.xyz = renodx::tonemap::config::Apply(r0.xyz, config);
  } else {
    renodx::tonemap::config::DualToneMap tone_maps = renodx::tonemap::config::ApplyToneMaps(r0.xyz, config);
    float3 sdrColor = tone_maps.color_sdr;
    float3 hdrColor = tone_maps.color_hdr;
  r0.xyz = float3(0.00390625,0.00390625,0.00390625) + sdrColor;
  r0.w = 0.75;
  r1.xyzw = t0.Sample(s0_s, r0.xw).wxyz;
  r1.x = saturate(r1.x);
  r2.xyzw = t0.Sample(s0_s, r0.yw).xyzw;
  r0.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  r1.z = saturate(r0.w);
  r1.y = saturate(r2.w);
  r0.xyz = float3(0.00390625,0.00390625,0.00390625) + r1.xyz;
  r0.w = 0.75;
  r1.xyzw = t0.Sample(s0_s, r0.xw).xyzw;
  o0.x = saturate(r1.x);
  r1.xyzw = t0.Sample(s0_s, r0.yw).xyzw;
  r0.xyzw = t0.Sample(s0_s, r0.zw).xyzw;
  o0.z = saturate(r0.z);
  o0.y = saturate(r1.y);
    o0.xyz = RestoreSaturationLoss(sdrColor, o0.xyz);
    if (config.type == 0.f) {
      r0.xyz = lerp(sdrColor, o0.rgb, injectedData.colorGradeInternalLUTStrength);
    } else {
      r0.xyz = renodx::tonemap::UpgradeToneMap(hdrColor, sdrColor, o0.rgb, injectedData.colorGradeInternalLUTStrength);
    }
  }
  r0.xyz = grading(r0.xyz);
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}