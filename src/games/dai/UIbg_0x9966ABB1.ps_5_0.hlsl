// UI backgrounds (menus, radar...)

#include "./shared.h"

// ---- Created with 3Dmigoto v1.3.16 on Wed Jul 31 02:00:03 2024

cbuffer _Globals : register(b0)
{
  float2 invPixelSize : packoffset(c0);
  float4x4 mvp : packoffset(c1);
  float4 texgen0 : packoffset(c5);
  float4 texgen1 : packoffset(c6);
  float4 texgen2 : packoffset(c7);
  float4 texgen3 : packoffset(c8);
  float4 g_color : packoffset(c9);
  float4 cxmul : packoffset(c10);
  float4 cxadd : packoffset(c11);
  float4 filterTexScale : packoffset(c12);
  float4 filterOffset : packoffset(c13);
  float4 filterShadowColor : packoffset(c14);
  float4 filterShadowTexScale : packoffset(c15);
  float4 aaCircleData : packoffset(c16);
  float4 aaLinePlane0 : packoffset(c17);
  float4 aaLinePlane1 : packoffset(c18);
  float4 aaLinePlane2 : packoffset(c19);
  float4 aaLinePlane3 : packoffset(c20);
  float4 distanceFieldParams0 : packoffset(c21);
  float4 distanceFieldParams1 : packoffset(c22);
  float4 distanceFieldParams2 : packoffset(c23);
  float4 cctvDistortParams0 : packoffset(c24);
  float4 cctvDistortParams1 : packoffset(c25);
  float4 kinectTrackingParams : packoffset(c26);
  float4 combatAreaSecondColor : packoffset(c27);
  float4 combatAreaParams : packoffset(c28);
  float4 postProcessDistortParams0 : packoffset(c29);
  float4 postProcessDistortParams1 : packoffset(c30);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  out float4 o0 : SV_Target0)
{
  o0.xyzw = v2.xyzw * cxmul.xyzw * injectedData.miscWindowBox + cxadd.xyzw;           // toggles pillarboxing to workaround "Behaviour" menu game issue (ultrawide)
    
    o0 = renodx::color::bt709::from::SRGBA(o0);
    o0.rgb *= injectedData.toneMapUINits / 80.f ;                                   //  UI brightness
  return;
}