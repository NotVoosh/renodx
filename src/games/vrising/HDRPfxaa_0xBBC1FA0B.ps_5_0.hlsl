#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Tue Sep 24 02:07:15 2024
Texture2DArray<float4> t1 : register(t1);

Texture2DArray<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[52];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[9];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[48].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r1.xyzw = float4(-1,-1,-1,-1) + cb1[48].xyxy;
  r0.zw = cb0[6].zw * r1.zw;
  r0.xy = r0.xy * cb0[6].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r2.xyzw = (int4)r0.xyxy + int4(-1,-1,1,-1);
  r2.xyzw = (int4)r2.xyzw;
  r2.xyzw = min(r2.xyzw, r1.xyzw);
  r2.xyzw = (int4)r2.zwxy;
  r3.xy = r2.zw;
  r3.zw = float2(0,0);
  r3.xyz = t0.Load(r3.xyzw).xyz;
  //r3.xyz = saturate(r3.xyz);
  r3.x = dot(r3.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r4.xyzw = (int4)r0.xyxy + int4(-1,1,1,1);
  r4.xyzw = (int4)r4.xyzw;
  r1.xyzw = min(r4.xyzw, r1.xyzw);
  r1.xyzw = (int4)r1.zwxy;
  r4.xy = r1.zw;
  r4.zw = float2(0,0);
  r3.yzw = t0.Load(r4.xyzw).xyz;
  //r3.yzw = saturate(r3.yzw);
  r3.y = dot(r3.yzw, float3(0.212672904,0.715152204,0.0721750036));
  r3.z = r3.x + r3.y;
  r2.zw = float2(0,0);
  r2.xyz = t0.Load(r2.xyzw).xyz;
  //r2.xyz = saturate(r2.xyz);
  r2.x = dot(r2.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.zw = float2(0,0);
  r1.xyz = t0.Load(r1.xyzw).xyz;
  //r1.xyz = saturate(r1.xyz);
  r1.x = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.y = r2.x + r1.x;
  r4.yw = r3.zz + -r1.yy;
  r1.y = r3.x + r2.x;
  r1.z = r3.y + r1.x;
  r1.z = r1.y + -r1.z;
  r1.y = r1.y + r3.y;
  r1.y = r1.y + r1.x;
  r1.y = 0.03125 * r1.y;
  r1.y = max(0.0078125, r1.y);
  r1.w = min(abs(r1.z), abs(r4.w));
  r4.xz = -r1.zz;
  r1.y = r1.w + r1.y;
  r1.y = rcp(r1.y);
  r4.xyzw = r4.xyzw * r1.yyyy;
  r4.xyzw = max(float4(-8,-8,-8,-8), r4.xyzw);
  r4.xyzw = min(float4(8,8,8,8), r4.xyzw);
  r4.xyzw = cb1[48].zwzw * r4.xyzw;
  r5.xyzw = v1.xyxy * cb0[6].xyxy + cb0[6].zwzw;
  //r6.xyzw = saturate(r4.zwzw * float4(-0.5,-0.5,-0.166666672,-0.166666672) + r5.zwzw);
    r6.xyzw = r4.zwzw * float4(-0.5, -0.5, -0.166666672, -0.166666672) + r5.zwzw;
  //r4.xyzw = saturate(r4.xyzw * float4(0.166666672,0.166666672,0.5,0.5) + r5.xyzw);
    r4.xyzw = r4.xyzw * float4(0.166666672, 0.166666672, 0.5, 0.5) + r5.xyzw;
  r4.xyzw = cb1[51].xyxy * r4.xyzw;
  r5.xyzw = cb1[51].xyxy * r6.zwxy;
  r6.xy = r5.zw;
  r6.z = 0;
  r1.yzw = t0.SampleLevel(s0_s, r6.xyz, 0).xyz;
  //r1.yzw = saturate(r1.yzw);
  r6.xy = r4.zw;
  r6.z = 0;
  r2.yzw = t0.SampleLevel(s0_s, r6.xyz, 0).xyz;
  //r2.yzw = saturate(r2.yzw);
  r1.yzw = r2.yzw + r1.yzw;
  r1.yzw = float3(0.25,0.25,0.25) * r1.yzw;
  r5.z = 0;
  r2.yzw = t0.SampleLevel(s0_s, r5.xyz, 0).xyz;
  //r2.yzw = saturate(r2.yzw);
  r4.z = 0;
  r4.xyz = t0.SampleLevel(s0_s, r4.xyz, 0).xyz;
  //r4.xyz = saturate(r4.xyz);
  r2.yzw = r4.xyz + r2.yzw;
  r1.yzw = r2.yzw * float3(0.25,0.25,0.25) + r1.yzw;
  r2.yzw = float3(0.5,0.5,0.5) * r2.yzw;
  r3.z = dot(r1.yzw, float3(0.212672904,0.715152204,0.0721750036));
  r3.w = min(r2.x, r3.y);
  r2.x = max(r2.x, r3.y);
  r2.x = max(r2.x, r1.x);
  r1.x = min(r3.w, r1.x);
  r0.zw = float2(0,0);
  r4.xyz = t0.Load(r0.xyww).xyz;
  r0.x = t1.Load(r0.xyzw).x;
  //r4.xyz = saturate(r4.xyz);
  r0.y = dot(r4.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r0.z = min(r0.y, r3.x);
  r0.y = max(r0.y, r3.x);
  r0.y = max(r0.y, r2.x);
  r0.y = cmp(r0.y < r3.z);
  r0.z = min(r0.z, r1.x);
  r0.z = cmp(r3.z < r0.z);
  r0.y = (int)r0.y | (int)r0.z;
  r0.yzw = r0.yyy ? r2.yzw : r1.yzw;
  //r1.xyz = log2(r0.yzw);                                              //
  //r1.xyz = float3(0.416666657,0.416666657,0.416666657) * r1.xyz;      // pow(r0.yzw, 1 / 2.4f);
  //r1.xyz = exp2(r1.xyz);                                              //
  //r1.xyz = r1.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r2.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r0.yzw);
  //r0.yzw = float3(12.9232101,12.9232101,12.9232101) * r0.yzw;
  //r0.yzw = r2.xyz ? r0.yzw : r1.xyz;
  //r0.yzw = log2(r0.yzw);                                              //
  //r0.yzw = cb0[8].yyy * r0.yzw;                                       // pow(r0.yzw, cb0[8].y) => 2.2
  //o0.xyz = exp2(r0.yzw);                                              //
    o0.xyz = renodx::color::grade::Saturation(r0.gba, injectedData.colorGradeSaturation);
        o0.rgb = applyFilmGrain(o0.rgb, v1.xy);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    
  r0.y = cmp(cb0[8].x == 1.000000);
  o0.w = r0.y ? r0.x : 1;
  return;
}