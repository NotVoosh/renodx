#include "../common.hlsl"

Texture2DArray<float4> t3 : register(t3);
Texture2DArray<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[53];
}
cbuffer cb0 : register(b0){
  float4 cb0[6];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r0.zw = r0.xy * cb0[1].xy + cb0[1].zw;
  r1.xy = cb1[52].xy * r0.xy;
  r0.x = t1.Sample(s1_s, r0.zw).w;
  r0.x = -0.5 + r0.x;
  r0.x = r0.x + r0.x;
  r0.yz = cb1[50].xy * v1.xy;
  r0.yz = (uint2)r0.yz;
  r0.yz = (uint2)r0.yz;
  r2.xy = float2(-1,-1) + cb1[50].xy;
  r2.xy = cb0[3].zw * r2.xy;
  r0.yz = r0.yz * cb0[3].xy + r2.xy;
  r2.xy = (uint2)r0.yz;
  r2.zw = float2(0,0);
  r0.yzw = t0.Load(r2.xyww).xyz;
  r1.w = t3.Load(r2.xyzw).x;
  if (injectedData.fxFilmGrainType == 0.f) {
  r2.xyz = r0.yzw * r0.xxx;
  r2.xyz = cb0[0].xxx * r2.xyz * injectedData.fxFilmGrain;
  r0.x = renodx::color::y::from::BT709(r0.yzw);
  r0.x = dot(r0.yzw, float3(0.212672904,0.715152204,0.0721750036));
  r0.x = injectedData.toneMapType == 0.f ? sqrt(r0.x) : renodx::math::SignSqrt(r0.x);
  r0.x = cb0[0].y * -r0.x + 1;
  r0.xyz = r2.xyz * r0.xxx + r0.yzw;
  } else {
    r0.rgb = applyFilmGrain(r0.gba, v1);
  }
  r1.z = 0;
  r2.xyzw = t2.SampleLevel(s0_s, r1.xyz, 0).xyzw;
  o0.xyz = r2.www * r0.xyz + r2.xyz;
  o0.rgb = PostToneMapScale(o0.rgb);
  o0.w = (cb0[5].x == 1.0) ? r1.w : 1;
  return;
}