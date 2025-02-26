#include "./common.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float3 o1 : TEXCOORD0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  o0.xyz = v0.xyz;
  o0.w = 1;
  r0.x = t0.SampleLevel(s0_s, float2(0.5, 0.5), 0).y;
  if (injectedData.fxAutoExposureMax != 1.f) {
    r0.x = min(r0.x, pow(7.5f, injectedData.fxAutoExposureMax));
  }
  if (injectedData.fxAutoExposureMin != 0.f) {
    r0.x = max(r0.x, pow(0.01f, 1.f - injectedData.fxAutoExposureMin));
  }
  o1.z = r0.x;
  o1.xy = v1.xy;
  return;
}