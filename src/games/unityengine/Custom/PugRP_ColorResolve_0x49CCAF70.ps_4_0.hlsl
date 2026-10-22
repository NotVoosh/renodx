#include "../common.hlsli"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[173];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t1.SampleBias(s1_s, v1.xy, cb0[4].x).xyzw;
  r0.xyz = cb0[172].xxx * r0.xyz;
  o0.w = max(cb0[171].w, r0.w);
  r0.xyz = cb0[168].yyy * r0.xyz;
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    r0.xyz = max(float3(0,0,0), r0.xyz);
  }
  r0.xyz = renodx::math::SignPow(r0.xyz, cb0[168].x);
  r1.xyz = Bt709AcesTonemap(r0.xyz);
  r2.xyz = -r1.xyz + r0.xyz;
  r0.x = renodx::color::y::from::BT709(r0.xyz);
  r0.x = cb0[167].w * -r0.x;
  r0.x = 1.44269502 * r0.x;
  r0.x = exp2(r0.x);
  r0.xyz = r0.xxx * r2.xyz + r1.xyz;
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    r0.xyz = max(float3(0, 0, 0), r0.xyz);
  }
  r0.xyz = renodx::math::SignPow(r0.xyz, cb0[172].y);
  r1.xy = v1.xy * cb0[164].zw + cb0[133].xy;
  r1.xy = cb0[132].xy * r1.xy;
  r1.xyzw = t0.SampleBias(s0_s, r1.xy, cb0[4].x).xyzw;
  r1.xyz = float3(-0.5,-0.5,-0.5) + r1.xyz;
  r1.xyz = cb0[169].xxx * r1.xyz;
  r0.xyz = applyDither(r0.xyz, r1.xyz * (1.0 / 255.0));
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    r0.xyz = saturate(r0.xyz);
  }
  r1.xyz = cb0[171].xyz + -r0.xyz;
  r0.xyz = cb0[171].www * r1.xyz + r0.xyz;
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    r0.xyz = saturate(r0.xyz);
  }
  r0.xyz = handleUserLUT(r0.xyz, t2, s2_s, float3(1 / 1024, 1 / 32, 31), 0, true);
  if (CUSTOM_COUNT_OLD_2 == CUSTOM_COUNT_NEW_2) {
    r0.xyz = GradeAndDisplayMap(r0.xyz);
  }
  if (CUSTOM_COUNT_OLD == CUSTOM_COUNT_NEW) {
    r0.xyz = PostToneMapScale(r0.xyz);
  }
  o0.xyz = r0.xyz;
  return;
}