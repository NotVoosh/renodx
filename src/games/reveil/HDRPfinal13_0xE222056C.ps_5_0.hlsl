#include "./shared.h"

Texture2DArray<float4> t2 : register(t2);

Texture2DArray<float4> t1 : register(t1);

Texture2DArray<float4> t0 : register(t0);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[80];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[46].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r0.zw = float2(-1,-1) + cb1[46].xy;
  r0.zw = cb0[3].zw * r0.zw;
  r0.xy = r0.xy * cb0[3].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r1.xyzw = (int4)r0.xyxy + int4(-1,-1,1,-1);
  r1.xyzw = (int4)r1.xyzw;
  r2.xyzw = float4(-1,-1,-1,-1) + cb1[47].xyxy;
  r1.xyzw = min(r2.xyzw, r1.xyzw);
  r1.xyzw = (int4)r1.zwxy;
  r3.xy = r1.zw;
  r3.zw = float2(0,0);
  r3.xyzw = t0.Load(r3.xyzw).xyzw;
  r4.xyzw = (int4)r0.xyxy + int4(-1,1,1,1);
  r4.xyzw = (int4)r4.xyzw;
  r2.xyzw = min(r4.xyzw, r2.xyzw);
  r2.xyzw = (int4)r2.zwxy;
  r4.xy = r2.zw;
  r4.zw = float2(0,0);
  r4.xyzw = t0.Load(r4.xyzw).xyzw;
  r5.x = r4.w + r3.w;
  r1.zw = float2(0,0);
  r1.xyzw = t0.Load(r1.xyzw).xyzw;
  r2.zw = float2(0,0);
  r2.xyzw = t0.Load(r2.xyzw).xyzw;
  r5.y = r2.w + r1.w;
  r5.yw = r5.xx + -r5.yy;
  r6.x = r3.w + r1.w;
  r6.y = r4.w + r2.w;
  r6.y = r6.x + -r6.y;
  r6.x = r6.x + r4.w;
  r6.x = r6.x + r2.w;
  r6.x = 0.03125 * r6.x;
  r6.x = max(0.0078125, r6.x);
  r6.z = min(abs(r6.y), abs(r5.w));
  r5.xz = -r6.yy;
  r6.x = r6.z + r6.x;
  r6.x = rcp(r6.x);
  r5.xyzw = r6.xxxx * r5.xyzw;
  r5.xyzw = max(float4(-8,-8,-8,-8), r5.xyzw);
  r5.xyzw = min(float4(8,8,8,8), r5.xyzw);
  r5.xyzw = cb1[46].zwzw * r5.xyzw;
  r6.xy = v1.xy * cb0[3].xy + cb0[3].zw;
  r7.xyzw = saturate(r5.zwzw * float4(-0.5,-0.5,-0.166666672,-0.166666672) + r6.xyxy);
  r5.xyzw = saturate(r5.xyzw * float4(0.166666672,0.166666672,0.5,0.5) + r6.xyxy);
  r5.xyzw = cb1[48].xyxy * r5.xyzw;
  r7.xyzw = cb1[48].xyxy * r7.zwxy;
  r8.xy = r7.zw;
  r8.z = 0;
  r6.z = t0.SampleLevel(s2_s, r8.xyz, 0).w;
  r6.z = saturate(r6.z);
  r8.xy = r5.zw;
  r8.z = 0;
  r5.w = t0.SampleLevel(s2_s, r8.xyz, 0).w;
  r5.w = saturate(r5.w);
  r5.w = r6.z + r5.w;
  r7.z = 0;
  r6.z = t0.SampleLevel(s2_s, r7.xyz, 0).w;
  r6.z = saturate(r6.z);
  r5.z = 0;
  r5.x = t0.SampleLevel(s2_s, r5.xyz, 0).w;
  r5.x = saturate(r5.x);
  r5.x = r6.z + r5.x;
  r5.xy = float2(0.5,0.25) * r5.xx;
  r5.y = r5.w * 0.25 + r5.y;
  r5.z = min(r1.w, r4.w);
  r5.z = min(r5.z, r2.w);
  r0.zw = float2(0,0);
  r0.xyzw = t0.Load(r0.xyzw).xyzw;
  r5.w = min(r0.w, r3.w);
  r5.z = min(r5.w, r5.z);
  //r3.xyz = saturate(r3.xyz);
  r0.w = max(r0.w, r3.w);
  r3.x = dot(r3.xyz, float3(0.212672904,0.715152204,0.0721750036));
  //r4.xyz = saturate(r4.xyz);
  r1.w = max(r1.w, r4.w);
  //r1.xyz = saturate(r1.xyz);
  r1.x = dot(r1.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.y = max(r1.w, r2.w);
  //r2.xyz = saturate(r2.xyz);
  r1.z = dot(r2.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r0.w = max(r1.y, r0.w);
  r1.y = dot(r4.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.w = r3.x + r1.y;
  r2.x = r1.x + r1.z;
  r2.yw = -r2.xx + r1.ww;
  r1.w = r3.x + r1.x;
  r3.y = r1.y + r1.z;
  r3.y = -r3.y + r1.w;
  r1.w = r1.w + r1.y;
  r1.w = r1.w + r1.z;
  r1.w = 0.03125 * r1.w;
  r1.w = max(0.0078125, r1.w);
  r3.z = min(abs(r3.y), abs(r2.w));
  r2.xz = -r3.yy;
  r1.w = r3.z + r1.w;
  r1.w = rcp(r1.w);
  r2.xyzw = r2.xyzw * r1.wwww;
  r2.xyzw = max(float4(-8,-8,-8,-8), r2.xyzw);
  r2.xyzw = min(float4(8,8,8,8), r2.xyzw);
  r2.xyzw = cb1[46].zwzw * r2.xyzw;
  r4.xyzw = saturate(r2.zwzw * float4(-0.5,-0.5,-0.166666672,-0.166666672) + r6.xyxy);
  r2.xyzw = saturate(r2.xyzw * float4(0.166666672,0.166666672,0.5,0.5) + r6.xyxy);
  r2.xyzw = cb1[50].xyxy * r2.xyzw;
  r4.xyzw = cb1[50].xyxy * r4.zwxy;
  r7.xy = r4.zw;
  r7.z = 0;
  r3.yzw = t0.SampleLevel(s2_s, r7.xyz, 0).xyz;
  //r3.yzw = saturate(r3.yzw);
  r7.xy = r2.zw;
  r7.z = 0;
  r7.xyz = t0.SampleLevel(s2_s, r7.xyz, 0).xyz;
  //r7.xyz = saturate(r7.xyz);
  r3.yzw = r7.xyz + r3.yzw;
  r3.yzw = float3(0.25,0.25,0.25) * r3.yzw;
  r4.z = 0;
  r4.xyz = t0.SampleLevel(s2_s, r4.xyz, 0).xyz;
  //r4.xyz = saturate(r4.xyz);
  r2.z = 0;
  r2.xyz = t0.SampleLevel(s2_s, r2.xyz, 0).xyz;
  //r2.xyz = saturate(r2.xyz);
  r2.xyz = r4.xyz + r2.xyz;
  r3.yzw = r2.xyz * float3(0.25,0.25,0.25) + r3.yzw;
  r2.xyz = float3(0.5,0.5,0.5) * r2.xyz;
  r1.w = dot(r3.yzw, float3(0.212672904,0.715152204,0.0721750036));
  r2.w = cmp(r1.w < r5.z);
  r0.w = cmp(r0.w < r1.w);
  r0.w = (int)r0.w | (int)r2.w;
  r4.w = r0.w ? r5.x : r5.y;
  r0.w = cmp(0 < r4.w);
  r2.w = min(r1.x, r1.y);
  r1.x = max(r1.x, r1.y);
  r1.x = max(r1.x, r1.z);
  r1.y = min(r2.w, r1.z);
  //r5.xyz = saturate(r0.xyz);
    r5.rgb = r0.rgb;
  r1.z = dot(r5.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r2.w = min(r1.z, r3.x);
  r1.z = max(r1.z, r3.x);
  r1.x = max(r1.z, r1.x);
  r1.y = min(r2.w, r1.y);
  r1.xy = cmp(r1.xw < r1.wy);
  r1.x = (int)r1.x | (int)r1.y;
  r1.xyz = r1.xxx ? r2.xyz : r3.yzw;
  r4.xyz = r0.www ? r1.xyz : r0.xyz;
  //r4.xyzw = saturate(r4.xyzw);
  //r0.xyz = log2(r4.xyz);
  //r0.xyz = float3(0.416666657,0.416666657,0.416666657) * r0.xyz;
  //r0.xyz = exp2(r0.xyz);
  //r0.xyz = r0.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r1.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r4.xyz);
  //r2.xyz = float3(12.9232101,12.9232101,12.9232101) * r4.xyz;
  o0.w = r4.w;
  //r0.xyz = r1.xyz ? r2.xyz : r0.xyz;
    r0.rgb = renodx::color::srgb::EncodeSafe(r4.rgb);
  r1.xy = cb0[2].xy * r6.xy;
  r2.xy = cb1[48].xy * r6.xy;
  r1.z = cb0[2].z;
  r0.w = t2.SampleBias(s1_s, r1.xyz, cb1[79].y).w;
  r0.w = r0.w * 2 + -1;
  r1.x = 1 + -abs(r0.w);
  r0.w = cmp(r0.w >= 0);
  r0.w = r0.w ? 1 : -1;
  r1.x = sqrt(r1.x);
  r1.x = 1 + -r1.x;
  r0.w = r1.x * r0.w;
  r0.xyz = r0.www * float3(0.00392156886,0.00392156886,0.00392156886) * injectedData.fxNoise + r0.xyz;
  //r1.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  //r1.xyz = float3(0.947867334,0.947867334,0.947867334) * r1.xyz;
  //r1.xyz = log2(abs(r1.xyz));
  //r1.xyz = float3(2.4000001,2.4000001,2.4000001) * r1.xyz;
  //r1.xyz = exp2(r1.xyz);
  //r3.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  //r0.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r0.xyz);
  //r0.xyz = r0.xyz ? r3.xyz : r1.xyz;
    r0.rgb = renodx::color::srgb::DecodeSafe(r0.rgb);
  r2.z = 0;
  r1.xyzw = t1.SampleLevel(s0_s, r2.xyz, 0).xyzw;
  o0.xyz = r1.www * r0.xyz + r1.xyz;
		  	if(injectedData.toneMapGammaCorrection == 1) {
		o0.rgb = renodx::color::correct::GammaSafe(o0.rgb);
		o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
    o0.rgb = renodx::color::correct::GammaSafe(o0.rgb, true);
        } else {
    o0.rgb *= injectedData.toneMapGameNits / injectedData.toneMapUINits;
        }
  return;
}