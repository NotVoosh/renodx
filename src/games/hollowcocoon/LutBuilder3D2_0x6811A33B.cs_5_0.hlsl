#include "./shared.h"

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

RWTexture3D<float4> u0 : register(u0);

cbuffer cb0 : register(b0)
{
  float4 cb0[18];
}




// 3Dmigoto declarations
#define cmp -


[numthreads(4, 4, 4)] void main(uint3 vThreadID : SV_DispatchThreadID) {
// Needs manual fix for instruction:
// unknown dcl_: dcl_uav_typed_texture3d (float,float,float,float) u0
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

// Needs manual fix for instruction:
// unknown dcl_: dcl_thread_group 4, 4, 4
  r0.xyz = (uint3)vThreadID.xyz;
  r0.w = cmp(0 < cb0[17].x);
  if (r0.w != 0) {
    // LogCtoLinear
    r1.xyz = r0.xyz * cb0[0].yyy + float3(-0.386036009,-0.386036009,-0.386036009);
    r1.xyz = float3(13.6054821,13.6054821,13.6054821) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r1.xyz = float3(-0.0479959995,-0.0479959995,-0.0479959995) + r1.xyz;
    r1.xyz = float3(0.179999992,0.179999992,0.179999992) * r1.xyz;
    // WhiteBalance
    r2.x = dot(float3(0.390404999,0.549941003,0.00892631989), r1.xyz);
    r2.y = dot(float3(0.070841603,0.963172019,0.00135775004), r1.xyz);
    r2.z = dot(float3(0.0231081992,0.128021002,0.936245024), r1.xyz);
    r1.xyz = cb0[2].xyz * r2.xyz;
    r2.x = dot(float3(2.85846996,-1.62879002,-0.0248910002), r1.xyz);
    r2.y = dot(float3(-0.210181996,1.15820003,0.000324280991), r1.xyz);
    r2.z = dot(float3(-0.0418119989,-0.118169002,1.06867003), r1.xyz);
    // unity_to_ACES
    r1.x = dot(float3(0.439700991,0.382977992,0.177334994), r2.xyz);
    r1.y = dot(float3(0.0897922963,0.813422978,0.0967615992), r2.xyz);
    r1.z = dot(float3(0.0175439995,0.111543998,0.870703995), r2.xyz);
    // ACES_to_ACEScc
    r1.xyz = max(float3(0,0,0), r1.xyz);
    r1.xyz = min(float3(65504,65504,65504), r1.xyz);
    r2.xyz = cmp(r1.xyz < float3(3.05175708e-05,3.05175708e-05,3.05175708e-05));
    r3.xyz = r1.xyz * float3(0.5,0.5,0.5) + float3(1.525878e-05,1.525878e-05,1.525878e-05);
    r3.xyz = log2(r3.xyz);
    r3.xyz = float3(9.72000027,9.72000027,9.72000027) + r3.xyz;
    r3.xyz = float3(0.0570776239,0.0570776239,0.0570776239) * r3.xyz;
    r1.xyz = log2(r1.xyz);
    r1.xyz = float3(9.72000027,9.72000027,9.72000027) + r1.xyz;
    r1.xyz = float3(0.0570776239,0.0570776239,0.0570776239) * r1.xyz;
    r1.xyz = r2.xyz ? r3.xyz : r1.xyz;
    // Contrast
    r1.xyz = float3(-0.413588405,-0.413588405,-0.413588405) + r1.xyz;
    r1.xyz = r1.xyz * cb0[7].zzz + float3(0.413588405,0.413588405,0.413588405);
    // ACEScc_to_ACES
    r2.xyz = r1.xyz * float3(17.5200005,17.5200005,17.5200005) + float3(-9.72000027,-9.72000027,-9.72000027);
    r2.xyz = exp2(r2.xyz);
    r3.xyz = float3(-1.52587891e-05,-1.52587891e-05,-1.52587891e-05) + r2.xyz;
    r3.xyz = r3.xyz + r3.xyz;
    r4.xyzw = cmp(r1.xxyy < float4(-0.301369876,1.46799636,-0.301369876,1.46799636));
    r1.xy = r4.yw ? r2.xy : float2(65504,65504);
    r4.xy = r4.xz ? r3.xy : r1.xy;
    r1.xy = cmp(r1.zz < float2(-0.301369876,1.46799636));
    r0.w = r1.y ? r2.z : 65504;
    r4.z = r1.x ? r3.z : r0.w;
    // ACES_to_ACEScg
    r1.x = dot(float3(1.45143926,-0.236510754,-0.214928567), r4.xyz);
    r1.y = dot(float3(-0.0765537769,1.17622972,-0.0996759236), r4.xyz);
    r1.z = dot(float3(0.00831614807,-0.00603244966,0.997716308), r4.xyz);
    // ColorFilter
    r1.xyz = cb0[3].xyz * r1.xyz;
    // Do not feed negative bla bla
    r1.xyz = max(float3(0,0,0), r1.xyz);
    // Gamma space
    r1.xyz = log2(r1.xyz);
    r1.xyz = float3(0.454545468,0.454545468,0.454545468) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    // Split toning
    r2.xyz = min(float3(1,1,1), r1.xyz);
    r0.w = dot(r2.xyz, float3(0.272228986,0.674081981,0.0536894985));
    r0.w = saturate(cb0[15].w + r0.w);
    r1.w = 1 + -r0.w;
    r2.xyz = float3(-0.5,-0.5,-0.5) + cb0[15].xyz;
    r2.xyz = r1.www * r2.xyz + float3(0.5,0.5,0.5);
    r3.xyz = float3(-0.5,-0.5,-0.5) + cb0[16].xyz;
    r3.xyz = r0.www * r3.xyz + float3(0.5,0.5,0.5);
    r4.xyz = r1.xyz + r1.xyz;
    r5.xyz = r1.xyz * r1.xyz;
    r6.xyz = -r2.xyz * float3(2,2,2) + float3(1,1,1);
    r5.xyz = r6.xyz * r5.xyz;
    r5.xyz = r4.xyz * r2.xyz + r5.xyz;
    r1.xyz = sqrt(r1.xyz);
    r6.xyz = r2.xyz * float3(2,2,2) + float3(-1,-1,-1);
    r7.xyz = float3(1,1,1) + -r2.xyz;
    r4.xyz = r7.xyz * r4.xyz;
    r1.xyz = r1.xyz * r6.xyz + r4.xyz;
    r2.xyz = cmp(r2.xyz >= float3(0.5,0.5,0.5));
    r4.xyz = r2.xyz ? float3(1,1,1) : 0;
    r2.xyz = r2.xyz ? float3(0,0,0) : float3(1,1,1);
    r2.xyz = r2.xyz * r5.xyz;
    r1.xyz = r1.xyz * r4.xyz + r2.xyz;
    r2.xyz = r1.xyz + r1.xyz;
    r4.xyz = r1.xyz * r1.xyz;
    r5.xyz = -r3.xyz * float3(2,2,2) + float3(1,1,1);
    r4.xyz = r5.xyz * r4.xyz;
    r4.xyz = r2.xyz * r3.xyz + r4.xyz;
    r1.xyz = sqrt(r1.xyz);
    r5.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
    r6.xyz = float3(1,1,1) + -r3.xyz;
    r2.xyz = r6.xyz * r2.xyz;
    r1.xyz = r1.xyz * r5.xyz + r2.xyz;
    r2.xyz = cmp(r3.xyz >= float3(0.5,0.5,0.5));
    r3.xyz = r2.xyz ? float3(1,1,1) : 0;
    r2.xyz = r2.xyz ? float3(0,0,0) : float3(1,1,1);
    r2.xyz = r2.xyz * r4.xyz;
    r1.xyz = r1.xyz * r3.xyz + r2.xyz;
    // Linear Space
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = float3(2.20000005,2.20000005,2.20000005) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    // Channel mixing
    r2.x = dot(r1.xyz, cb0[4].xyz);
    r2.y = dot(r1.xyz, cb0[5].xyz);
    r2.z = dot(r1.xyz, cb0[6].xyz);
    // Shadows, midtones, highlights
    r0.w = dot(r2.xyz, float3(0.272228986,0.674081981,0.0536894985));
    r1.xy = cb0[14].yw + -cb0[14].xz;
    r1.zw = -cb0[14].xz + r0.ww;
    r1.xy = float2(1,1) / r1.xy;
    r1.xy = saturate(r1.zw * r1.xy);
    r1.zw = r1.xy * float2(-2,-2) + float2(3,3);
    r1.xy = r1.xy * r1.xy;
    r0.w = r1.w * r1.y;
    r1.x = -r1.z * r1.x + 1;
    r1.z = 1 + -r1.x;
    r1.y = -r1.w * r1.y + r1.z;
    r3.xyz = cb0[11].xyz * r2.xyz;
    r4.xyz = cb0[12].xyz * r2.xyz;
    r1.yzw = r4.xyz * r1.yyy;
    r1.xyz = r3.xyz * r1.xxx + r1.yzw;
    r2.xyz = cb0[13].xyz * r2.xyz;
    r1.xyz = r2.xyz * r0.www + r1.xyz;
    // Lift, gamma, gain
    r1.xyz = r1.xyz * cb0[10].xyz + cb0[8].xyz;
    r2.xyz = cmp(float3(0,0,0) < r1.xyz);
    r3.xyz = cmp(r1.xyz < float3(0,0,0));
    r2.xyz = (int3)-r2.xyz + (int3)r3.xyz;
    r2.xyz = (int3)r2.xyz;
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = cb0[9].xyz * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r3.xyz = r2.xyz * r1.xyz;
    // HSV stuff
    r0.w = cmp(r3.y >= r3.z);
    r0.w = r0.w ? 1.000000 : 0;
    r4.xy = r3.zy;
    r4.zw = float2(-1,0.666666687);
    r1.xy = r2.yz * r1.yz + -r4.xy;
    r1.zw = float2(1,-1);
    r1.xyzw = r0.wwww * r1.xyzw + r4.xyzw;
    r0.w = cmp(r3.x >= r1.x);
    r0.w = r0.w ? 1.000000 : 0;
    r2.xyz = r1.xyw;
    r2.w = r3.x;
    r1.xyw = r2.wyx;
    r1.xyzw = r1.xyzw + -r2.xyzw;
    r1.xyzw = r0.wwww * r1.xyzw + r2.xyzw;
    r0.w = min(r1.w, r1.y);
    r0.w = r1.x + -r0.w;
    r1.y = r1.w + -r1.y;
    r1.w = r0.w * 6 + 9.99999975e-05;
    r1.y = r1.y / r1.w;
    r1.y = r1.z + r1.y;
    r2.x = abs(r1.y);
    r1.y = 9.99999975e-05 + r1.x;
    r2.z = r0.w / r1.y;
    r2.yw = float2(0,0);
    r0.w = t5.SampleLevel(s0_s, r2.xy, 0).x;
    r0.w = saturate(r0.w);
    r0.w = r0.w + r0.w;
    r1.y = t6.SampleLevel(s0_s, r2.zw, 0).x;
    r1.y = saturate(r1.y);
    r1.y = r1.y + r1.y;
    r0.w = r1.y * r0.w;
    r3.x = dot(r3.xyz, float3(0.212672904,0.715152204,0.0721750036));
    r3.yw = float2(0,0);
    r1.y = t7.SampleLevel(s0_s, r3.xy, 0).x;
    r1.y = saturate(r1.y);
    r1.y = r1.y + r1.y;
    r0.w = r1.y * r0.w;
    r3.z = cb0[7].x + r2.x;
    r1.y = t4.SampleLevel(s0_s, r3.zw, 0).x;
    r1.y = saturate(r1.y);
    r1.y = -0.5 + r1.y;
    r1.y = r3.z + r1.y;
    r1.z = cmp(r1.y < 0);
    r1.w = cmp(1 < r1.y);
    r2.xy = float2(1,-1) + r1.yy;
    r1.y = r1.w ? r2.y : r1.y;
    r1.y = r1.z ? r2.x : r1.y;
    r1.yzw = float3(1,0.666666687,0.333333343) + r1.yyy;
    r1.yzw = frac(r1.yzw);
    r1.yzw = r1.yzw * float3(6,6,6) + float3(-3,-3,-3);
    r1.yzw = saturate(float3(-1,-1,-1) + abs(r1.yzw));
    r1.yzw = float3(-1,-1,-1) + r1.yzw;
    r1.yzw = r2.zzz * r1.yzw + float3(1,1,1);
    r2.xyz = r1.xxx * r1.yzw;
    r2.x = dot(r2.xyz, float3(0.272228986,0.674081981,0.0536894985));
    r0.w = cb0[7].y * r0.w;
    r1.xyz = r1.xxx * r1.yzw + -r2.xxx;
    r1.xyz = r0.www * r1.xyz + r2.xxx;
    // FastTonemap
    r0.w = max(r1.x, r1.y);
    r0.w = max(r0.w, r1.z);
    r0.w = 1 + r0.w;
    r0.w = rcp(r0.w);
    // Y (master)
    r1.xyz = r1.xyz * r0.www + float3(0.00390625,0.00390625,0.00390625);
    r1.w = 0;
    r2.x = t0.SampleLevel(s0_s, r1.xw, 0).x;
    r2.x = saturate(r2.x);
    r2.y = t0.SampleLevel(s0_s, r1.yw, 0).x;
    r2.y = saturate(r2.y);
    r2.z = t0.SampleLevel(s0_s, r1.zw, 0).x;
    r2.z = saturate(r2.z);
    // RGB
    r1.xyz = float3(0.00390625,0.00390625,0.00390625) + r2.xyz;
    r1.w = 0;
    r2.x = t1.SampleLevel(s0_s, r1.xw, 0).x;
    r2.x = saturate(r2.x);
    r2.y = t2.SampleLevel(s0_s, r1.yw, 0).x;
    r2.y = saturate(r2.y);
    r2.z = t3.SampleLevel(s0_s, r1.zw, 0).x;
    r2.z = saturate(r2.z);
    // FastTonemapInvert
    r0.w = max(r2.x, r2.y);
    r0.w = max(r0.w, r2.z);
    r0.w = 1 + -r0.w;
    r0.w = rcp(r0.w);
    r1.xyz = r2.xyz * r0.www;
    r1.xyz = max(float3(0,0,0), r1.xyz);
  } else {
    // LogCtoLinear
    r0.xyz = r0.xyz * cb0[0].yyy + float3(-0.386036009,-0.386036009,-0.386036009);
    r0.xyz = float3(13.6054821,13.6054821,13.6054821) * r0.xyz;
    r0.xyz = exp2(r0.xyz);
    r0.xyz = float3(-0.0479959995,-0.0479959995,-0.0479959995) + r0.xyz;
    r0.xyz = float3(0.179999992,0.179999992,0.179999992) * r0.xyz;
    // unity_to_ACES
    r2.x = dot(float3(0.439700991,0.382977992,0.177334994), r0.xyz);
    r2.y = dot(float3(0.0897922963,0.813422978,0.0967615992), r0.xyz);
    r2.z = dot(float3(0.0175439995,0.111543998,0.870703995), r0.xyz);
    // ACES_to_ACEScg
    r1.x = dot(float3(1.45143926,-0.236510754,-0.214928567), r2.xyz);
    r1.y = dot(float3(-0.0765537769,1.17622972,-0.0996759236), r2.xyz);
    r1.z = dot(float3(0.00831614807,-0.00603244966,0.997716308), r2.xyz);
  }
      if(injectedData.toneMapType == 0.f){
  // ACEScg_to_ACES
  r0.y = dot(float3(0.695452213,0.140678704,0.163869068), r1.xyz);
  r0.z = dot(float3(0.0447945632,0.859671116,0.0955343172), r1.xyz);
  r0.w = dot(float3(-0.00552588282,0.00402521016,1.00150073), r1.xyz);
  // start tonemap
  r0.x = min(r0.y, r0.z);
  r0.x = min(r0.x, r0.w);
  r1.x = max(r0.y, r0.z);
  r1.x = max(r1.x, r0.w);
  r1.xy = max(float2(9.99999975e-05,0.00999999978), r1.xx);
  r0.x = max(9.99999975e-05, r0.x);
  r0.x = r1.x + -r0.x;
  r0.x = r0.x / r1.y;
  r1.xyz = r0.wzy + -r0.zyw;
  r1.xy = r1.xy * r0.wz;
  r1.x = r1.x + r1.y;
  r1.x = r0.y * r1.z + r1.x;
  r1.x = max(0, r1.x);
  r1.x = sqrt(r1.x);
  r1.y = r0.w + r0.z;
  r1.y = r1.y + r0.y;
  r1.x = r1.x * 1.75 + r1.y;
  r1.z = -0.400000006 + r0.x;
  r1.yw = float2(0.333333343,2.5) * r1.xz;
  r1.w = 1 + -abs(r1.w);
  r1.w = max(0, r1.w);
  r1.z = cmp(r1.z >= 0);
  r1.z = r1.z ? 1 : -1;
  r1.w = -r1.w * r1.w + 1;
  r1.z = r1.z * r1.w + 1;
  r1.z = 0.0250000004 * r1.z;
  r1.w = cmp(0.159999996 >= r1.x);
  r1.x = cmp(r1.x >= 0.479999989);
  r1.y = 0.0799999982 / r1.y;
  r1.y = -0.5 + r1.y;
  r1.y = r1.z * r1.y;
  r1.x = r1.x ? 0 : r1.y;
  r1.x = r1.w ? r1.z : r1.x;
  r1.x = 1 + r1.x;
  r2.yzw = r1.xxx * r0.yzw;
  r1.yz = cmp(r2.zw == r2.yz);
  r1.y = r1.z ? r1.y : 0;
  r0.z = r0.z * r1.x + -r2.w;
  r0.z = 1.73205078 * r0.z;
  r1.z = r2.y * 2 + -r2.z;
  r0.w = -r0.w * r1.x + r1.z;
  r1.z = min(abs(r0.z), abs(r0.w));
  r1.w = max(abs(r0.z), abs(r0.w));
  r1.w = 1 / r1.w;
  r1.z = r1.z * r1.w;
  r1.w = r1.z * r1.z;
  r3.x = r1.w * 0.0208350997 + -0.0851330012;
  r3.x = r1.w * r3.x + 0.180141002;
  r3.x = r1.w * r3.x + -0.330299497;
  r1.w = r1.w * r3.x + 0.999866009;
  r3.x = r1.z * r1.w;
  r3.y = cmp(abs(r0.w) < abs(r0.z));
  r3.x = r3.x * -2 + 1.57079637;
  r3.x = r3.y ? r3.x : 0;
  r1.z = r1.z * r1.w + r3.x;
  r1.w = cmp(r0.w < -r0.w);
  r1.w = r1.w ? -3.141593 : 0;
  r1.z = r1.z + r1.w;
  r1.w = min(r0.z, r0.w);
  r0.z = max(r0.z, r0.w);
  r0.w = cmp(r1.w < -r1.w);
  r0.z = cmp(r0.z >= -r0.z);
  r0.z = r0.z ? r0.w : 0;
  r0.z = r0.z ? -r1.z : r1.z;
  r0.z = 57.2957802 * r0.z;
  r0.z = r1.y ? 0 : r0.z;
  r0.w = cmp(r0.z < 0);
  r1.y = 360 + r0.z;
  r0.z = r0.w ? r1.y : r0.z;
  r0.w = cmp(r0.z < -180);
  r1.y = cmp(180 < r0.z);
  r1.zw = float2(360,-360) + r0.zz;
  r0.z = r1.y ? r1.w : r0.z;
  r0.z = r0.w ? r1.z : r0.z;
  r0.z = 0.0148148146 * r0.z;
  r0.z = 1 + -abs(r0.z);
  r0.z = max(0, r0.z);
  r0.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r0.w * r0.z;
  r0.z = r0.z * r0.z;
  r0.x = r0.z * r0.x;
  r0.y = -r0.y * r1.x + 0.0299999993;
  r0.x = r0.x * r0.y;
  r2.x = r0.x * 0.180000007 + r2.y;
  r0.x = dot(float3(1.45143926,-0.236510754,-0.214928567), r2.xzw);
  r0.y = dot(float3(-0.0765537769,1.17622972,-0.0996759236), r2.xzw);
  r0.z = dot(float3(0.00831614807,-0.00603244966,0.997716308), r2.xzw);
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.w = dot(r0.xyz, float3(0.272228986,0.674081981,0.0536894985));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = r0.xyz * float3(0.959999979,0.959999979,0.959999979) + r0.www;
  r1.xyz = r0.xyz * float3(2.78508496,2.78508496,2.78508496) + float3(0.107772,0.107772,0.107772);
  r1.xyz = r1.xyz * r0.xyz;
  r2.xyz = r0.xyz * float3(2.93604493,2.93604493,2.93604493) + float3(0.887121975,0.887121975,0.887121975);
  r0.xyz = r0.xyz * r2.xyz + float3(0.806888998,0.806888998,0.806888998);
  r0.xyz = r1.xyz / r0.xyz;
  r1.x = dot(float3(0.662454188,0.134004205,0.156187683), r0.xyz);
  r1.y = dot(float3(0.272228718,0.674081743,0.0536895171), r0.xyz);
  r1.z = dot(float3(-0.00557464967,0.0040607336,1.01033914), r0.xyz);
  r0.x = dot(r1.xyz, float3(1,1,1));
  r0.x = max(9.99999975e-05, r0.x);
  r0.xy = r1.xy / r0.xx;
  r0.w = max(0, r1.y);
  r0.w = min(65504, r0.w);
  r0.w = log2(r0.w);
  r0.w = 0.981100023 * r0.w;
  r1.y = exp2(r0.w);
  r0.w = max(9.99999975e-05, r0.y);
  r0.w = r1.y / r0.w;
  r1.w = 1 + -r0.x;
  r0.z = r1.w + -r0.y;
  r1.xz = r0.xz * r0.ww;
  r0.x = dot(float3(1.6410234,-0.324803293,-0.236424699), r1.xyz);
  r0.y = dot(float3(-0.663662851,1.61533165,0.0167563483), r1.xyz);
  r0.z = dot(float3(0.0117218941,-0.00828444213,0.988394856), r1.xyz);
  r0.w = dot(r0.xyz, float3(0.272228986,0.674081981,0.0536894985));
  r0.xyz = r0.xyz + -r0.www;
  r0.xyz = r0.xyz * float3(0.930000007,0.930000007,0.930000007) + r0.www;
  // AP1 to XYZ
  r1.x = dot(float3(0.662454188,0.134004205,0.156187683), r0.xyz);
  r1.y = dot(float3(0.272228718,0.674081743,0.0536895171), r0.xyz);
  r1.z = dot(float3(-0.00557464967,0.0040607336,1.01033914), r0.xyz);
  // CAT
  r0.x = dot(float3(0.987223983,-0.00611326983,0.0159533005), r1.xyz);
  r0.y = dot(float3(-0.00759836007,1.00186002,0.00533019984), r1.xyz);
  r0.z = dot(float3(0.00307257008,-0.00509594986,1.08168006), r1.xyz);
  // XYZ to BT709
  r1.x = dot(float3(3.2409699,-1.5373832,-0.498610765), r0.xyz);
  r1.y = dot(float3(-0.969243646,1.8759675,0.0415550582), r0.xyz);
  r1.z = dot(float3(0.0556300804,-0.203976959,1.05697155), r0.xyz);
  } else {
    r0.r = dot(float3(0.662454188,0.134004205,0.156187683), r1.rgb);
    r0.g = dot(float3(0.272228718,0.674081743,0.0536895171), r1.rgb);
    r0.b = dot(float3(-0.00557464967,0.0040607336,1.01033914), r1.rgb);
    r1.r = dot(float3(3.2409699,-1.5373832,-0.498610765), r0.rgb);
    r1.g = dot(float3(-0.969243646,1.8759675,0.0415550582), r0.rgb);
    r1.b = dot(float3(0.0556300804,-0.203976959,1.05697155), r0.rgb);
  }
  r0.xyz = max(float3(0,0,0), r1.xyz);
  r0.w = 1;
// No code for instruction (needs manual fix):
//store_uav_typed u0.xyzw, vThreadID.xyzz, r0.xyzw
  u0[vThreadID.xyz] = r0.xyzw;
  return;
}