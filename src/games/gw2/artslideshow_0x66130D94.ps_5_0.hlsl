// char select background / slideshow cutscenes

// ---- Created with 3Dmigoto v1.3.16 on Thu Aug 22 01:13:06 2024
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = t0.Sample(s0_s, v0.xy).xyz;
  o0.xyz = r0.xyz;
  o0.w = cb0[0].w;
  
		o0.rgb = max(0, o0.rgb);		// remove negative colors to fix "slideshow" cutscenes
  return;
}