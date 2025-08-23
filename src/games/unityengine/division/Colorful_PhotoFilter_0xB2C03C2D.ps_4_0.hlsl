#include "../tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[4];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  float3 preCG = r0.xyz;
  r1.x = dot(r0.xyz, float3(0.222000003,0.707000017,0.0710000023));
  r1.y = saturate(-0.5 + r1.x);
  r1.y = r1.y + r1.y;
  r1.z = saturate(r1.x + r1.x);
  r1.x = saturate(cb0[3].x * r1.x);
  r2.xyz = cb0[2].xyz * r1.zzz;
  r3.xyz = -r1.zzz * cb0[2].xyz + float3(1,1,1);
  r1.yzw = r1.yyy * r3.xyz + r2.xyz;
  r1.yzw = r1.yzw + -r0.xyz;
  o0.xyz = r1.xxx * r1.yzw + r0.xyz;
  o0.w = saturate(r0.w);
  o0.xyz = lerp(preCG, o0.xyz, injectedData.colorGradeUserLUTStrength);
  if(injectedData.gammaSpace != 0.f){
    o0.xyz = renodx::color::srgb::DecodeSafe(o0.xyz);
  }
  if (injectedData.tonemapCheck == 1.f && (injectedData.count2Old == injectedData.count2New)) {
    o0.xyz = applyUserNoTonemap(o0.xyz);
  }
  if (injectedData.countOld == injectedData.countNew) {
    o0.xyz = PostToneMapScale(o0.xyz, injectedData.gammaSpace != 0.f);
  } else if(injectedData.gammaSpace != 0.f){
    o0.xyz = renodx::color::srgb::EncodeSafe(o0.xyz);
  }
  return;
}