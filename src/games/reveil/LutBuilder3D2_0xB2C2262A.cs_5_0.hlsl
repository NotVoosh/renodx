#include "./shared.h"

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture3D<float4> t0 : register(t0);

SamplerState s1_s : register(s1);

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
    r1.xyz = r0.xyz * cb0[0].yyy;
    r1.rgb = renodx::color::pq::Decode(r1.rgb, 100.f);
    r2.x = dot(float3(0.390404999,0.549941003,0.00892631989), r1.xyz);
    r2.y = dot(float3(0.070841603,0.963172019,0.00135775004), r1.xyz);
    r2.z = dot(float3(0.0231081992,0.128021002,0.936245024), r1.xyz);
    r1.xyz = cb0[2].xyz * r2.xyz;
    r2.x = dot(float3(2.85846996,-1.62879002,-0.0248910002), r1.xyz);
    r2.y = dot(float3(-0.210181996,1.15820003,0.000324280991), r1.xyz);
    r2.z = dot(float3(-0.0418119989,-0.118169002,1.06867003), r1.xyz);
    r1.x = dot(float3(0.439700991,0.382977992,0.177334994), r2.xyz);
    r1.y = dot(float3(0.0897922963,0.813422978,0.0967615992), r2.xyz);
    r1.z = dot(float3(0.0175439995,0.111543998,0.870703995), r2.xyz);
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
    r1.xyz = float3(-0.413588405,-0.413588405,-0.413588405) + r1.xyz;
    r1.xyz = r1.xyz * cb0[7].zzz + float3(0.413588405,0.413588405,0.413588405);
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
    r1.x = dot(float3(1.45143926,-0.236510754,-0.214928567), r4.xyz);
    r1.y = dot(float3(-0.0765537769,1.17622972,-0.0996759236), r4.xyz);
    r1.z = dot(float3(0.00831614807,-0.00603244966,0.997716308), r4.xyz);
    r1.xyz = cb0[3].xyz * r1.xyz;
    r1.xyz = max(float3(0,0,0), r1.xyz);
    r1.xyz = log2(r1.xyz);
    r1.xyz = float3(0.454545468,0.454545468,0.454545468) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
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
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = float3(2.20000005,2.20000005,2.20000005) * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r2.x = dot(r1.xyz, cb0[4].xyz);
    r2.y = dot(r1.xyz, cb0[5].xyz);
    r2.z = dot(r1.xyz, cb0[6].xyz);
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
    r1.xyz = r1.xyz * cb0[10].xyz + cb0[8].xyz;
    r2.xyz = cmp(float3(0,0,0) < r1.xyz);
    r3.xyz = cmp(r1.xyz < float3(0,0,0));
    r2.xyz = (int3)-r2.xyz + (int3)r3.xyz;
    r2.xyz = (int3)r2.xyz;
    r1.xyz = log2(abs(r1.xyz));
    r1.xyz = cb0[9].xyz * r1.xyz;
    r1.xyz = exp2(r1.xyz);
    r3.xyz = r2.xyz * r1.xyz;
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
    r0.w = t6.SampleLevel(s1_s, r2.xy, 0).x;
    r0.w = saturate(r0.w);
    r0.w = r0.w + r0.w;
    r1.y = t7.SampleLevel(s1_s, r2.zw, 0).x;
    r1.y = saturate(r1.y);
    r1.y = r1.y + r1.y;
    r0.w = r1.y * r0.w;
    r3.x = dot(r3.xyz, float3(0.212672904,0.715152204,0.0721750036));
    r3.yw = float2(0,0);
    r1.y = t8.SampleLevel(s1_s, r3.xy, 0).x;
    r1.y = saturate(r1.y);
    r1.y = r1.y + r1.y;
    r0.w = r1.y * r0.w;
    r3.z = cb0[7].x + r2.x;
    r1.y = t5.SampleLevel(s1_s, r3.zw, 0).x;
    r1.y = saturate(r1.y);
    r1.y = r1.y + r3.z;
    r1.yzw = float3(-0.5,0.5,-1.5) + r1.yyy;
    r2.x = cmp(r1.y < 0);
    r2.y = cmp(1 < r1.y);
    r1.y = r2.y ? r1.w : r1.y;
    r1.y = r2.x ? r1.z : r1.y;
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
    r0.w = max(r1.x, r1.y);
    r0.w = max(r0.w, r1.z);
    r0.w = 1 + r0.w;
    r0.w = rcp(r0.w);
    r1.xyz = r1.xyz * r0.www + float3(0.00390625,0.00390625,0.00390625);
    r1.w = 0;
    r2.x = t1.SampleLevel(s1_s, r1.xw, 0).x;
    r2.x = saturate(r2.x);
    r2.y = t1.SampleLevel(s1_s, r1.yw, 0).x;
    r2.y = saturate(r2.y);
    r2.z = t1.SampleLevel(s1_s, r1.zw, 0).x;
    r2.z = saturate(r2.z);
    r1.xyz = float3(0.00390625,0.00390625,0.00390625) + r2.xyz;
    r1.w = 0;
    r2.x = t2.SampleLevel(s1_s, r1.xw, 0).x;
    r2.x = saturate(r2.x);
    r2.y = t3.SampleLevel(s1_s, r1.yw, 0).x;
    r2.y = saturate(r2.y);
    r2.z = t4.SampleLevel(s1_s, r1.zw, 0).x;
    r2.z = saturate(r2.z);
    r0.w = max(r2.x, r2.y);
    r0.w = max(r0.w, r2.z);
    r0.w = 1 + -r0.w;
    r0.w = rcp(r0.w);
    r1.xyz = r2.xyz * r0.www;
    r1.xyz = max(float3(0,0,0), r1.xyz);
    r2.x = dot(float3(1.70504999,-0.621789992,-0.0832599998), r1.xyz);
    r2.y = dot(float3(-0.130260006,1.1408,-0.0105499998), r1.xyz);
    r2.z = dot(float3(-0.0240000002,-0.128969997,1.15296996), r1.xyz);
  } else {
    r0.xyz = r0.xyz * cb0[0].yyy;
    r0.rgb = renodx::color::pq::Decode(r0.rgb, 100.f);
    r2.x = dot(float3(1.70504999,-0.621789992,-0.0832599998), r0.xyz);
    r2.y = dot(float3(-0.130260006,1.1408,-0.0105499998), r0.xyz);
    r2.z = dot(float3(-0.0240000002,-0.128969997,1.15296996), r0.xyz);
  }
  r0.xyz = max(float3(0,0,0), r2.xyz);
  /*r1.xyz = r0.xyz * float3(5.55555582,5.55555582,5.55555582) + float3(0.0479959995,0.0479959995,0.0479959995);
  r1.xyz = log2(r1.xyz);
  r1.xyz = r1.xyz * float3(0.0734997839,0.0734997839,0.0734997839) + float3(0.386036009,0.386036009,0.386036009);
  r1.xyz = min(float3(1,1,1), r1.xyz);
  r1.xyz = cb0[1].yyy * r1.xyz;
  r0.w = 0.5 * cb0[1].x;
  r1.xyz = r1.xyz * cb0[1].xxx + r0.www;
  r1.xyz = t0.SampleLevel(s0_s, r1.xyz, 0).xyz;
  r1.xyz = r1.xyz + -r0.xyz;
  r0.xyz = cb0[1].zzz * r1.xyz + r0.xyz;
  r0.xyz = max(float3(0,0,0), r0.xyz);*/
      float3 lutInput = renodx::color::arri::logc::c1000::Encode(r0.rgb, false);
      float3 lutColor = min(1.f, renodx::lut::Sample(t0, s0_s, lutInput, 32.f));
    r0.rgb = renodx::tonemap::UpgradeToneMap(r0.rgb, saturate(r0.rgb), lutColor, cb0[1].z);
  r0.w = 1;
// No code for instruction (needs manual fix):
//store_uav_typed u0.xyzw, vThreadID.xyzz, r0.xyzw
  u0[vThreadID.xyz] = r0.rgba;
  return;
}