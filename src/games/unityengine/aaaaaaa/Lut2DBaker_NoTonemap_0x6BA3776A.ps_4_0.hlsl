#include "../tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
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

  r0.yz = -cb0[28].yz + w1.xy;
  r1.x = cb0[28].x * r0.y;
  r0.x = frac(r1.x);
  r1.x = r0.x / cb0[28].x;
  r0.w = -r1.x + r0.y;
  r0.xyz = cb0[28].www * r0.xzw;
  r0.xyz = lutShaper(r0.xyz, true, 2);
  float3 preCG = renodx::color::srgb::DecodeSafe(r0.xyz);
  r0.xyz = r0.xyz * cb0[32].www + float3(-0.217637643,-0.217637643,-0.217637643);
  r0.xyz = r0.xyz * cb0[32].zzz + float3(0.217637643,0.217637643,0.217637643);
  r1.x = dot(float3(0.390404999,0.549941003,0.00892631989), r0.xyz);
  r1.y = dot(float3(0.070841603,0.963172019,0.00135775004), r0.xyz);
  r1.z = dot(float3(0.0231081992,0.128021002,0.936245024), r0.xyz);
  r0.xyz = cb0[30].xyz * r1.xyz;
  r1.x = dot(float3(2.85846996,-1.62879002,-0.0248910002), r0.xyz);
  r1.y = dot(float3(-0.210181996,1.15820003,0.000324280991), r0.xyz);
  r1.z = dot(float3(-0.0418119989,-0.118169002,1.06867003), r0.xyz);
  r0.xyz = cb0[31].xyz * r1.xyz;
  r1.x = dot(r0.xyz, cb0[33].xyz);
  r1.y = dot(r0.xyz, cb0[34].xyz);
  r1.z = dot(r0.xyz, cb0[35].xyz);
  float3 preLGG = r1.xyz;
  r0.xyz = r1.xyz * cb0[38].xyz + cb0[36].xyz;
  r1.xyz = log2(abs(r0.xyz));
  r0.xyz = saturate(r0.xyz * renodx::math::FLT_MAX + float3(0.5,0.5,0.5));
  r0.xyz = r0.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r1.xyz = cb0[37].xyz * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = liftGammaGainScaling(r0.xyz, preLGG, cb0[36].xyz, cb0[37].xyz, cb0[38].xyz, 2);
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.w = step(r0.z, r0.y);
  r1.xy = r0.zy;
  r2.xy = -r1.xy + r0.yz;
  r1.zw = float2(-1.0, 2.0 / 3.0);
  r2.zw = float2(1,-1);
  r1.xyzw = r0.wwww * r2.xywz + r1.xywz;
  r0.w = step(r1.x, r0.x);
  r2.z = r1.w;
  r1.w = r0.x;
  r3.x = dot(r0.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r2.xyw = r1.wyx;
  r2.xyzw = r2.xyzw + -r1.xyzw;
  r0.xyzw = r0.wwww * r2.xyzw + r1.xyzw;
  r1.x = min(r0.w, r0.y);
  r1.x = -r1.x + r0.x;
  r1.y = r1.x * 6.0 + 0.0001;
  r0.y = r0.w + -r0.y;
  r0.y = r0.y / r1.y;
  r0.y = r0.z + r0.y;
  r2.x = abs(r0.y);
  r3.z = cb0[32].x + r2.x;
  r3.yw = float2(0.25,0.25);
  r4.xyzw = t0.SampleLevel(s0_s, r3.zw, 0).xyzw;
  r5.xyzw = t0.SampleLevel(s0_s, r3.xy, 0).wxyz;
  r5.x = saturate(r5.x);
  r4.x = saturate(r4.x);
  r0.y = r4.x + r3.z;
  r0.yzw = float3(-0.5,0.5,-1.5) + r0.yyy;
  r0.w = (r0.y > 1) ? r0.w : r0.y;
  r0.y = (r0.y < 0) ? r0.z : r0.w;
  r0.yzw = float3(1.0, 2.0 / 3.0, 1.0 / 3.0) + r0.yyy;
  r0.yzw = frac(r0.yzw);
  r0.yzw = r0.yzw * float3(6,6,6) + float3(-3,-3,-3);
  r0.yzw = saturate(float3(-1,-1,-1) + abs(r0.yzw));
  r0.yzw = float3(-1,-1,-1) + r0.yzw;
  r1.y = 0.0001 + r0.x;
  r2.z = r1.x / r1.y;
  r0.yzw = r2.zzz * r0.yzw + float3(1,1,1);
  r1.xyz = r0.xxx * r0.yzw;
  r1.x = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r0.xyz = r0.xxx * r0.yzw + -r1.xxx;
  r2.yw = float2(0.25,0.25);
  r3.xyzw = t0.SampleLevel(s0_s, r2.xy, 0).yxzw;
  r2.xyzw = t0.SampleLevel(s0_s, r2.zw, 0).zxyw;
  r2.x = saturate(r2.x);
  r3.x = saturate(r3.x);
  r0.w = r3.x + r3.x;
  r0.w = dot(r2.xx, r0.ww);
  r0.w = r5.x * r0.w;
  r0.w = dot(cb0[32].yy, r0.ww);
  r0.xyz = r0.www * r0.xyz + r1.xxx;
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