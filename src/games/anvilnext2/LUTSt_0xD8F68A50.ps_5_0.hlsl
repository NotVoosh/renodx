#include "./common.hlsl"

Texture3D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s12_s : register(s12);
SamplerState s10_s : register(s10);
cbuffer cb5 : register(b5){
  float4 cb5[2];
}
cbuffer cb1 : register(b1){
  float4 cb1[137];
}

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  const float4 icb[] = { { -0.500000, 0, 0, 0},
                              { 0, 0, 0, 0},
                              { -0.375000, 0, 0, 0},
                              { 0.125000, 0, 0, 0},
                              { -0.468750, 0, 0, 0},
                              { 0.031250, 0, 0, 0},
                              { -0.343750, 0, 0, 0},
                              { 0.156250, 0, 0, 0},
                              { 0.250000, 0, 0, 0},
                              { -0.250000, 0, 0, 0},
                              { 0.375000, 0, 0, 0},
                              { -0.125000, 0, 0, 0},
                              { 0.281250, 0, 0, 0},
                              { -0.218750, 0, 0, 0},
                              { 0.406250, 0, 0, 0},
                              { -0.093750, 0, 0, 0},
                              { -0.312500, 0, 0, 0},
                              { 0.187500, 0, 0, 0},
                              { -0.437500, 0, 0, 0},
                              { 0.062500, 0, 0, 0},
                              { -0.281250, 0, 0, 0},
                              { 0.218750, 0, 0, 0},
                              { -0.406250, 0, 0, 0},
                              { 0.093750, 0, 0, 0},
                              { 0.437500, 0, 0, 0},
                              { -0.062500, 0, 0, 0},
                              { 0.312500, 0, 0, 0},
                              { -0.187500, 0, 0, 0},
                              { 0.468750, 0, 0, 0},
                              { -0.031250, 0, 0, 0},
                              { 0.343750, 0, 0, 0},
                              { -0.156250, 0, 0, 0},
                              { -0.453125, 0, 0, 0},
                              { 0.046875, 0, 0, 0},
                              { -0.328125, 0, 0, 0},
                              { 0.171875, 0, 0, 0},
                              { -0.484375, 0, 0, 0},
                              { 0.015625, 0, 0, 0},
                              { -0.359375, 0, 0, 0},
                              { 0.140625, 0, 0, 0},
                              { 0.296875, 0, 0, 0},
                              { -0.203125, 0, 0, 0},
                              { 0.421875, 0, 0, 0},
                              { -0.078125, 0, 0, 0},
                              { 0.265625, 0, 0, 0},
                              { -0.234375, 0, 0, 0},
                              { 0.390625, 0, 0, 0},
                              { -0.109375, 0, 0, 0},
                              { -0.265625, 0, 0, 0},
                              { 0.234375, 0, 0, 0},
                              { -0.390625, 0, 0, 0},
                              { 0.109375, 0, 0, 0},
                              { -0.296875, 0, 0, 0},
                              { 0.203125, 0, 0, 0},
                              { -0.421875, 0, 0, 0},
                              { 0.078125, 0, 0, 0},
                              { 0.484375, 0, 0, 0},
                              { -0.015625, 0, 0, 0},
                              { 0.359375, 0, 0, 0},
                              { -0.140625, 0, 0, 0},
                              { 0.453125, 0, 0, 0},
                              { -0.046875, 0, 0, 0},
                              { 0.328125, 0, 0, 0},
                              { -0.171875, 0, 0, 0} };
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s10_s, v1.xy).xyzw;
  r1.x = cmp(0 < cb1[136].w);
  if (r1.x != 0) {
    r1.xyzw = float4(4,4,4,4) * v0.xxyy;
    r1.xyzw = cmp(r1.xyzw >= -r1.yyww);
    r1.xyzw = r1.xyzw ? float4(4,0.25,4,0.25) : float4(-4,-0.25,-4,-0.25);
    r1.yw = v0.xy * r1.yw;
    r1.yw = frac(r1.yw);
    r1.xy = r1.xz * r1.yw;
    r1.x = r1.x * 4 + r1.y;
    r1.x = (uint)r1.x;
    r1.xyz = icb[r1.x+0].xxx * float3(0.0078125,0.0078125,0.0078125) + r0.xyz;
    r1.xyz = saturate(r1.xyz * cb5[0].xyz + cb5[1].xyz);
    r1.xyz = t1.Sample(s12_s, r1.xyz).xyz;
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = float3(1.10000002,1.10000002,1.10000002) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r1.xyz = float3(0.0500000007,0.0500000007,0.0500000007) + r1.xyz;
    r1.xyz = float3(0.769230783,0.769230783,0.769230783) * r1.xyz;
    r1.xyz = min(float3(1,1,1), r1.xyz);
    r2.xyz = r1.xyz * float3(-2,-2,-2) + float3(3,3,3);
    r1.xyz = r1.xyz * r1.xyz;
    r1.xyz = r2.xyz * r1.xyz;
    r2.xyz = log2(r1.xyz);
    r2.xyz = float3(2.20000005,2.20000005,2.20000005) * r2.xyz;
    r2.xyz = exp2(r2.xyz);
    r3.xyz = r2.xyz * r2.xyz;
    r4.xyz = float3(6534,6534,6534) * r2.xyz;
    r3.xyz = r3.xyz * float3(-6659,-6659,-6659) + r4.xyz;
    r3.xyz = float3(125,125,125) + r3.xyz;
    r3.xyz = sqrt(r3.xyz);
    r4.xyz = float3(25,25,25) * r2.xyz;
    r3.xyz = r3.xyz * float3(2.23606801,2.23606801,2.23606801) + r4.xyz;
    r3.xyz = float3(-25,-25,-25) + r3.xyz;
    r2.xyz = r2.xyz * float3(320,320,320) + float3(-320,-320,-320);
    r2.xyz = -r3.xyz / r2.xyz;
    r3.xyz = r1.xyz * r1.xyz;
    r4.xyz = float3(6534,6534,6534) * r1.xyz;
    r3.xyz = r3.xyz * float3(-6659,-6659,-6659) + r4.xyz;
    r3.xyz = float3(125,125,125) + r3.xyz;
    r3.xyz = sqrt(r3.xyz);
    r4.xyz = float3(25,25,25) * r1.xyz;
    r3.xyz = r3.xyz * float3(2.23606801,2.23606801,2.23606801) + r4.xyz;
    r3.xyz = float3(-25,-25,-25) + r3.xyz;
    r1.xyz = r1.xyz * float3(320,320,320) + float3(-320,-320,-320);
    r1.xyz = -r3.xyz / r1.xyz;
    r1.x = dot(r1.xyz, float3(0.212599993,0.715200007,0.0722000003));
    r1.y = 1 + r1.x;
    r1.x = r1.x / r1.y;
    r1.x = r1.x * 0.111111112 + 1;
    r1.xyz = r2.xyz * r1.xxx;
    r2.x = dot(float3(0.627403975,0.329281986,0.0433136001), r1.xyz);
    r2.y = dot(float3(0.0690969974,0.919539988,0.0113612004), r1.xyz);
    r2.z = dot(float3(0.0163915996,0.088013202,0.895595014), r1.xyz);
    r1.xyz = float3(100,100,100) * r2.xyz;
    r1.xyz = r1.xyz / cb1[136].www;
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = float3(0.159301758,0.159301758,0.159301758) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r2.xyz = r1.xyz * float3(18.8515625,18.8515625,18.8515625) + float3(0.8359375,0.8359375,0.8359375);
    r1.xyz = r1.xyz * float3(18.6875,18.6875,18.6875) + float3(1,1,1);
    r1.xyz = r2.xyz / r1.xyz;
    r1.xyz = log2(r1.xyz);
    r1.xyz = float3(78.84375,78.84375,78.84375) * r1.xyz;
    r0.xyz = exp2(r1.xyz);
  } else {
    float3 preLUT = renodx::color::srgb::DecodeSafe(r0.rgb);
    r1.xyz = r0.xyz * cb5[0].xyz + cb5[1].xyz;
    r1.xyz = t1.Sample(s12_s, r1.xyz).xyz;
    r1.w = cmp(cb1[136].w < 0);
    r2.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r1.xyz);
    r2.xyz = log2(r2.xyz);
    r2.xyz = float3(0.495867789,0.495867789,0.495867789) * r2.xyz;
    r2.xyz = exp2(r2.xyz);
    //r0.xyz = r1.www ? r2.xyz : r1.xyz;
    r0.xyz = r1.www ? r2.xyz : applyUserTonemapSteep(preLUT, t1, s12_s);
    r0.rgb = PostToneMapScale(r0.rgb);
  }
  o0.xyzw = r0.xyzw;
  return;
}