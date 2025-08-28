#include "../tonemap.hlsl"

Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[39];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cb0[29].y;
  r1.yz = -cb0[28].yz + w1.xy;
  r2.x = cb0[28].x * r1.y;
  r1.x = frac(r2.x);
  r2.x = r1.x / cb0[28].x;
  r1.w = -r2.x + r1.y;
  r2.xyz = cb0[28].www * r1.xzw;
  r2.xyz = lutShaper(r2.xyz, true, 2);
  float3 preCG = renodx::color::srgb::DecodeSafe(r2.xyz);
  float3 sdrColor = lerp(preCG, renodx::tonemap::renodrt::NeutralSDR(preCG), saturate(renodx::tonemap::renodrt::NeutralSDR(preCG)));
  float3 userLutInput = injectedData.toneMapType != 0.f ? sdrColor : preCG;
  renodx::lut::Config lut_config = renodx::lut::config::Create();
  lut_config.lut_sampler = s0_s;
  lut_config.strength = injectedData.colorGradeUserLUTStrength;
  lut_config.scaling = injectedData.colorGradeUserLUTScaling;
  lut_config.type_input = renodx::lut::config::type::SRGB;
  lut_config.type_input = renodx::lut::config::type::SRGB;
  lut_config.precompute = cb0[29].xyz;
  lut_config.recolor = injectedData.toneMapType != 0.f ? 1.f : 0.f;
  lut_config.tetrahedral = false;
  /*r3.xyz = cb0[29].zzz * saturate(r2.zxy);
  r1.y = floor(r3.x);
  r3.xw = float2(0.5,0.5) * cb0[29].xy;
  r3.yz = r3.yz * cb0[29].xy + r3.xw;
  r3.x = r1.y * cb0[29].y + r3.y;
  r1.y = saturate(r2.z) * cb0[29].z + -r1.y;*/
  r0.yw = float2(0,0.25);
  /*r0.xy = r3.xz + r0.xy;
  r3.xyzw = t0.Sample(s0_s, r3.xz).xyzw;
  r4.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r4.xyz = r4.xyz + -r3.xyz;
  r3.xyz = r1.yyy * r4.xyz + r3.xyz;*/
  r3.xyz = renodx::lut::Sample(saturate(userLutInput), lut_config, t0);
  if (injectedData.toneMapType != 0.f) {
    lut_config.strength = 1.f;
    r3.xyz = renodx::tonemap::UpgradeToneMap(preCG, sdrColor, r3.xyz, injectedData.colorGradeUserLUTStrength);
  }
  r3.xyz = renodx::color::srgb::EncodeSafe(r3.xyz);
  r1.xyz = -r2.xyz + r3.xyz;
  r1.xyz = cb0[29].www * r1.xyz + r2.xyz;
  r1.xyz = r1.xyz * cb0[32].www + float3(-0.217637643,-0.217637643,-0.217637643);
  r1.xyz = r1.xyz * cb0[32].zzz + float3(0.217637643,0.217637643,0.217637643);
  r2.x = dot(float3(0.390405,0.549941,0.00892632), r1.xyz);
  r2.y = dot(float3(0.0708416,0.963172,0.00135775), r1.xyz);
  r2.z = dot(float3(0.0231082,0.128021,0.936245), r1.xyz);
  r1.xyz = cb0[30].xyz * r2.xyz;
  r2.x = dot(float3(2.858470,-1.628790,-0.024891), r1.xyz);
  r2.y = dot(float3(-0.210182,1.158200,0.000324281), r1.xyz);
  r2.z = dot(float3(-0.041812,-0.118169,1.068670), r1.xyz);
  r1.xyz = cb0[31].xyz * r2.xyz;
  r2.x = dot(r1.xyz, cb0[33].xyz);
  r2.y = dot(r1.xyz, cb0[34].xyz);
  r2.z = dot(r1.xyz, cb0[35].xyz);
  float3 preLGG = r2.xyz;
  r1.xyz = r2.xyz * cb0[38].xyz + cb0[36].xyz;
  r2.xyz = log2(abs(r1.xyz));
  r1.xyz = saturate(r1.xyz * renodx::math::FLT_MAX + float3(0.5,0.5,0.5));
  r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyz = cb0[37].xyz * r2.xyz;
  r2.xyz = exp2(r2.xyz);
  r1.xyz = r2.xyz * r1.xyz;
  r1.xyz = liftGammaGainScaling(r1.xyz, preLGG, cb0[36].xyz, cb0[37].xyz, cb0[38].xyz, 2);
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r0.x = step(r1.z, r1.y);
  r2.xy = r1.zy;
  r3.xy = -r2.xy + r1.yz;
  r2.zw = float2(-1.0, 2.0 / 3.0);
  r3.zw = float2(1,-1);
  r2.xyzw = r0.xxxx * r3.xywz + r2.xywz;
  r0.x = step(r2.x, r1.x);
  r3.z = r2.w;
  r2.w = r1.x;
  r1.z = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r3.xyw = r2.wyx;
  r3.xyzw = r3.xyzw + -r2.xyzw;
  r2.xyzw = r0.xxxx * r3.xyzw + r2.xyzw;
  r0.x = min(r2.w, r2.y);
  r0.x = r2.x + -r0.x;
  r0.y = r0.x * 6.0 + 0.0001;
  r2.y = r2.w + -r2.y;
  r0.y = r2.y / r0.y;
  r0.y = r2.z + r0.y;
  r0.z = abs(r0.y);
  r3.xyzw = t1.SampleLevel(s1_s, r0.zw, 0).yxzw;
  r4.x = cb0[32].x + r0.z;
  r3.x = saturate(r3.x);
  r0.y = r3.x + r3.x;
  r0.z = 0.0001 + r2.x;
  r1.x = r0.x / r0.z;
  r1.yw = float2(0.25,0.25);
  r3.xyzw = t1.SampleLevel(s1_s, r1.xy, 0).zxyw;
  r5.xyzw = t1.SampleLevel(s1_s, r1.zw, 0).wxyz;
  r5.x = saturate(r5.x);
  r3.x = saturate(r3.x);
  r0.x = dot(r3.xx, r0.yy);
  r0.x = r5.x * r0.x;
  r0.x = dot(cb0[32].yy, r0.xx);
  r4.y = 0.25;
  r3.xyzw = t1.SampleLevel(s1_s, r4.xy, 0).xyzw;
  r3.x = saturate(r3.x);
  r0.y = r3.x + r4.x;
  r0.yzw = float3(-0.5,0.5,-1.5) + r0.yyy;
  r0.w = (r0.y > 1) ? r0.w : r0.y;
  r0.y = (r0.y < 0) ? r0.z : r0.w;
  r0.yzw = float3(1.0, 2.0 / 3.0, 1.0 / 3.0) + r0.yyy;
  r0.yzw = frac(r0.yzw);
  r0.yzw = r0.yzw * float3(6,6,6) + float3(-3,-3,-3);
  r0.yzw = saturate(float3(-1,-1,-1) + abs(r0.yzw));
  r0.yzw = float3(-1,-1,-1) + r0.yzw;
  r0.yzw = r1.xxx * r0.yzw + float3(1,1,1);
  r1.xyz = r2.xxx * r0.yzw;
  r1.x = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r0.yzw = r2.xxx * r0.yzw + -r1.xxx;
  r0.xyz = r0.xxx * r0.yzw + r1.xxx;
  if (injectedData.toneMapType == 0.f) {
    r0.xyz = saturate(r0.xyz);
  } else {
    r0.xyz = renodx::color::srgb::DecodeSafe(r0.xyz);
    r0.w = max(r0.x, r0.y);
    r0.w = max(r0.w, r0.z);
    r0.w = 1 + r0.w;
    r0.w = 1 / r0.w;
    r0.xyz = r0.xyz * r0.www;
    r0.xyz = renodx::color::srgb::EncodeSafe(r0.xyz);
  }
  r0.xyz = float3(0.00390625,0.00390625,0.00390625) + r0.xyz;
  r0.w = 0.75;
  r1.xyzw = t1.Sample(s1_s, r0.xw).wxyz;
  r1.x = saturate(r1.x);
  r2.xyzw = t1.Sample(s1_s, r0.yw).xyzw;
  r0.xyzw = t1.Sample(s1_s, r0.zw).xyzw;
  r1.z = saturate(r0.w);
  r1.y = saturate(r2.w);
  r0.xyz = float3(0.00390625,0.00390625,0.00390625) + r1.xyz;
  r0.w = 0.75;
  r1.xyzw = t1.Sample(s1_s, r0.xw).xyzw;
  o0.x = saturate(r1.x);
  r1.xyzw = t1.Sample(s1_s, r0.yw).xyzw;
  r0.xyzw = t1.Sample(s1_s, r0.zw).xyzw;
  o0.z = saturate(r0.z);
  o0.y = saturate(r1.y);
  o0.w = 1;
  if (injectedData.toneMapType != 0.f) {
    r0.xyz = renodx::color::srgb::DecodeSafe(o0.xyz);
    r0.w = max(r0.x, r0.y);
    r0.w = max(r0.w, r0.z);
    r0.w = 1 + -r0.w;
    r0.w = 1 / r0.w;
    r0.xyz = r0.xyz * r0.www;
    o0.xyz = renodx::color::srgb::EncodeSafe(r0.xyz);
  }
  o0.xyz = renodx::color::srgb::DecodeSafe(o0.xyz);
  o0.xyz = lerp(preCG, o0.xyz, injectedData.colorGradeInternalLUTStrength);
  if (injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)) {
    o0.xyz = applyUserNoTonemap(o0.xyz);
  }
  o0.xyz = renodx::color::srgb::EncodeSafe(o0.xyz);
  return;
}