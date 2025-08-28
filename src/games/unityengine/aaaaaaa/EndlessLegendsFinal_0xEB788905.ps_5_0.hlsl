#include "../common.hlsl"

SamplerState _SourceTexture_s : register(s0);
Texture2D<float4> _SourceTexture : register(t0);

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = _SourceTexture.Sample(_SourceTexture_s, v1.xy).xyzw;
  /*r1.x = 0.0549999997;
  r1.yzw = cmp(r0.xyz < float3(0.0404499993,0.0404499993,0.0404499993));
  r2.xyz = r0.xyz / float3(12.9200001,12.9200001,12.9200001);
  r3.xyz = int3(0,0,0);
  r4.xyz = r1.xxx + r0.xyz;
  r4.xyz = r4.xyz / float3(1.05499995,1.05499995,1.05499995);
  r3.xyz = max(r4.xyz, r3.xyz);
  r3.xyz = log2(r3.xyz);
  r3.xyz = float3(2.4000001,2.4000001,2.4000001) * r3.xyz;
  r3.xyz = exp2(r3.xyz);
  r0.xyz = r1.yzw ? r2.xyz : r3.xyz;*/
  r0.xyz = FinalizeOutput(r0.xyz, injectedData.gammaSpace != 0.f);
  o0.xyzw = r0.xyzw;
  return;
}