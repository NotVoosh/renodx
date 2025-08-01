#include "../common.hlsl"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[7];
}

void main(
  float2 v0 : TEXCOORD0,
  float2 w0 : TEXCOORD1,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = applyCA(t0, s0_s, v0, injectedData.fxCA);
  r0.w = t0.Sample(s0_s, v0.xy).w;
  r1.xyz = t1.Sample(s1_s, w0.xy).xyz;
  r1.w = renodx::color::y::from::BT709(r0.xyz);
  r0.xyz = lerp(r1.www, r0.xyz, lerp(1.f, cb0[5].w, injectedData.colorGradeTint));
  r1.xyz = cb0[0].xyz * r1.xyz * injectedData.fxBloom;
  r0.xyz = r1.xyz * float3(2,2,2) + r0.xyz;
  r0.w = r0.w * 2 + -1;
  if (r0.w < -0.01) {
    r1.yzw = cb0[4].xyz * r0.xyz;
  } else {
    if (r0.w > 0.01) {
      r1.yzw = cb0[2].xyz * r0.xyz;
    } else {
      r0.w = 1.2 * cb0[6].z;
      r2.z = cb0[6].x * r0.w;
      r2.xy = cb0[6].xy * r0.ww + v0.xy;
      r1.x = t0.Sample(s0_s, r2.xy).w;
      r2.w = cb0[6].y * -r0.w;
      r2.xy = v0.xy + r2.zw;
      r2.x = t0.Sample(s0_s, r2.xy).w;
      r1.x = r2.x + r1.x;
      r2.xzw = cb0[6].xxy * -r0.www;
      r2.y = cb0[6].y * r0.w;
      r2.xyzw = v0.xyxy + r2.xyzw;
      r0.w = t0.Sample(s0_s, r2.xy).w;
      r0.w = r1.x + r0.w;
      r1.x = t0.Sample(s0_s, r2.zw).w;
      r0.w = r1.x + r0.w;
      r2.xyz = cb0[3].xyz + -r0.xyz;
      r2.xyz = cb0[3].www * r2.xyz + r0.xyz;
      r3.xyz = cb0[1].xyz + -r0.xyz;
      r3.xyz = cb0[1].www * r3.xyz + r0.xyz;
      r0.xyz = (r0.w > 2.04) ? r3.xyz : r0.xyz;
      r1.yzw = (r0.w < 1.96) ? r2.xyz : r0.xyz;
    }
  }
  r0.rgb = renodx::color::srgb::DecodeSafe(r1.gba);
  if (!injectedData.isUnderWater) {
    r0.rgb = applyVignette(r0.rgb, v0, injectedData.fxVignette);
  }
  r0.rgb = applyUserTonemap(r0.rgb, t2, s2_s);
  o0.rgb = renodx::color::srgb::EncodeSafe(r0.rgb);
  o0.w = 0;
  return;
}