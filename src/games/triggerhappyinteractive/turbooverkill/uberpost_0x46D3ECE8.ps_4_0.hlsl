#include "../common.hlsl"

Texture3D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0) {
  float4 cb0[43];
}

#define cmp -

void main(
    float4 v0: SV_POSITION0,
    float2 v1: TEXCOORD0,
    float2 w1: TEXCOORD1,
    out float4 o0: SV_Target0) {
  float4 r0, r1;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t1.Sample(s1_s, v1.xy).xyzw;
  r1.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  r1.xyz = r1.xyz * r0.xxx;
  r0.xyzw = cb0[36].zzzz * r1.xyzw;
  r0.xyz = lutShaper(r0.rgb);
  if (injectedData.colorGradeLUTSampling == 0.f) {
  r0.xyz = cb0[36].yyy * r0.xyz;
  r1.x = 0.5 * cb0[36].x;
  r0.xyz = r0.xyz * cb0[36].xxx + r1.xxx;
  r1.xyzw = t2.Sample(s2_s, r0.xyz).wxyz;
  } else {
    r1.gba = renodx::lut::SampleTetrahedral(t2, r0.rgb, 1 / cb0[36].x);
  }
  r0.x = cmp(0.5 < cb0[42].x);
  if (r0.x != 0) {
    r1.x = renodx::color::y::from::BT709(r1.gba);
  } else {
    r1.x = r0.w;
  }
  if (injectedData.fxFilmGrain > 0.f) {
    r1.gba = applyFilmGrain(r1.gba, w1, injectedData.fxFilmGrainType != 0.f);
  }
  r1.gba = PostToneMapScale(r1.gba);
  o0.xyzw = r1.yzwx;
  return;
}
