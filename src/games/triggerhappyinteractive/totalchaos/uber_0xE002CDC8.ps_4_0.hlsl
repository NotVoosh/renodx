#include "../common.hlsl"

Texture2D<float4> t5 : register(t5);
Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s5_s : register(s5);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[42];
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

  r0.xyzw = t2.Sample(s2_s, v1.xy).xyzw;
  r1.xyzw = t1.Sample(s1_s, w1.xy).xyzw;
  r0.xyz = r1.xyz * r0.xxx;
  if (cb0[40].y < 0.5) {
    r1.xy = -cb0[38].xy + v1.xy;
    r1.yz = cb0[39].xx * abs(r1.yx) * min(1.f, injectedData.fxVignette);
    r0.w = cb0[22].x / cb0[22].y;
    r0.w = -1 + r0.w;
    r0.w = cb0[39].w * r0.w + 1;
    r1.x = r1.z * r0.w;
    r1.xy = saturate(r1.xy);
    r1.xy = log2(r1.xy);
    r1.xy = cb0[39].zz * r1.xy;
    r1.xy = exp2(r1.xy);
    r0.w = dot(r1.xy, r1.xy);
    r0.w = 1 + -r0.w;
    r0.w = max(0, r0.w);
    r0.w = log2(r0.w);
    r0.w = cb0[39].y * r0.w * max(1.f, injectedData.fxVignette);
    r0.w = exp2(r0.w);
    r1.xyz = float3(1,1,1) + -cb0[37].xyz;
    r1.xyz = r0.www * r1.xyz + cb0[37].xyz;
    r1.xyz = r1.xyz * r0.xyz;
    r2.x = -1 + r1.w;
    r2.w = r0.w * r2.x + 1;
  } else {
    r3.xyzw = t4.Sample(s4_s, v1.xy).xyzw;
    r0.w = renodx::color::srgb::DecodeSafe(r3.w);
    r3.xyz = float3(1,1,1) + -cb0[37].xyz;
    r3.xyz = r0.www * r3.xyz + cb0[37].xyz;
    r3.xyz = r0.xyz * r3.xyz + -r0.xyz;
    r1.xyz = cb0[40].xxx * r3.xyz + r0.xyz;
    r0.x = -1 + r1.w;
    r2.w = r0.w * r0.x + 1;
  }
  if (injectedData.fxFilmGrainType == 0.f) {
  r0.xy = w1.xy * cb0[41].xy + cb0[41].zw;
  r0.xyzw = t5.Sample(s5_s, r0.xy).xyzw;
  r0.w = renodx::color::y::from::BT709(r1.rgb);
  r0.w = renodx::math::SignSqrt(r0.w);
  r0.w = cb0[40].z * -r0.w + 1;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = cb0[40].www * r0.xyz * injectedData.fxFilmGrain;
  r2.xyz = r0.xyz * r0.www + r1.xyz;
  } else {
    r2.rgb = applyFilmGrain(r1.rgb, w1, false);
  }
  r2.w = saturate(r2.w);
  r0.rgb = applyUserTonemapTC(r2.rgb, t3, s3_s, cb0[36].xyz);
  r1.xy = v1.xy * cb0[30].xy + cb0[30].zw;
  r1.xyzw = t0.Sample(s0_s, r1.xy).xyzw;
  r0.w = r1.w * 2 + -1;
  r1.x = saturate(r0.w * 3.40282347e+38 + 0.5);
  r1.x = r1.x * 2 + -1;
  r0.w = 1 + -abs(r0.w);
  r0.w = sqrt(r0.w);
  r0.w = 1 + -r0.w;
  r0.w = r1.x * r0.w;
  r0.rgb = renodx::color::srgb::EncodeSafe(r0.rgb);
  r0.xyz = r0.www * float3(0.00392156886,0.00392156886,0.00392156886) * injectedData.fxNoise + r0.xyz;
  r0.rgb = renodx::color::srgb::DecodeSafe(r0.rgb);
  o0.xyz = PostToneMapScale(r0.xyz);
  o0.w = r2.w;
  return;
}