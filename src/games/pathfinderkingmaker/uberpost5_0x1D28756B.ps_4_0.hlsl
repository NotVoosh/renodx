#include "./shared.h"
#include "./tonemapper.hlsl"

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[16];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  float2 v2 : TEXCOORD2,
  float2 w2 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(1,1,-1,0) * cb0[7].xyxy;
  r1.xyzw = -r0.xywy * cb0[8].xxxx + w2.xyxy;
  r2.xyzw = t3.Sample(s2_s, r1.xy).xyzw;
  r1.xyzw = t3.Sample(s2_s, r1.zw).xyzw;
  r1.xyz = r1.zxy * float3(2,2,2) + r2.zxy;
  r2.xy = -r0.zy * cb0[8].xx + w2.xy;
  r2.xyzw = t3.Sample(s2_s, r2.xy).xyzw;
  r1.xyz = r2.zxy + r1.xyz;
  r2.xyzw = r0.zwxw * cb0[8].xxxx + w2.xyxy;
  r3.xyzw = t3.Sample(s2_s, r2.xy).xyzw;
  r2.xyzw = t3.Sample(s2_s, r2.zw).xyzw;
  r1.xyz = r3.zxy * float3(2,2,2) + r1.xyz;
  r3.xyzw = t3.Sample(s2_s, w2.xy).xyzw;
  r1.xyz = r3.zxy * float3(4,4,4) + r1.xyz;
  r1.xyz = r2.zxy * float3(2,2,2) + r1.xyz;
  r2.xyzw = r0.zywy * cb0[8].xxxx + w2.xyxy;
  r0.xy = r0.xy * cb0[8].xx + w2.xy;
  r0.xyzw = t3.Sample(s2_s, r0.xy).xyzw;
  r3.xyzw = t3.Sample(s2_s, r2.xy).xyzw;
  r2.xyzw = t3.Sample(s2_s, r2.zw).xyzw;
  r1.xyz = r3.zxy + r1.xyz;
  r1.xyz = r2.zxy * float3(2,2,2) + r1.xyz;
  r0.xyz = r1.xyz + r0.zxy;
  r0.xyz = cb0[8].yyy * r0.xyz * injectedData.fxBloom;      // bloom
  r1.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
  //r2.xyz = r1.zxy * float3(0.305306017,0.305306017,0.305306017) + float3(0.682171106,0.682171106,0.682171106);
  //r2.xyz = r1.zxy * r2.xyz + float3(0.0125228781,0.0125228781,0.0125228781);
  //r1.xyz = r2.xyz * r1.zxy;
    r1.rgb = renodx::color::srgb::DecodeSafe(r1.brg);

  r2.xyzw = t1.Sample(s1_s, w2.xy).xyzw;
  r1.xyz = r1.xyz * r2.www + r2.zxy;
  r2.xyzw = t2.Sample(s5_s, w1.xy).xyzw;
  //r3.xyz = r2.zxy * float3(0.305306017,0.305306017,0.305306017) + float3(0.682171106,0.682171106,0.682171106);
  //r3.xyz = r2.zxy * r3.xyz + float3(0.0125228781,0.0125228781,0.0125228781);
  //r2.xyz = r2.zxy * r3.xyz + -r1.xyz;
    r2.rgb = renodx::color::srgb::DecodeSafe(r2.brg) + -r1.rgb;

  r1.xyz = r2.www * r2.xyz + r1.xyz;
  r0.xyz = r0.xyz * float3(0.0625,0.0625,0.0625) + r1.xyz;
  r1.xy = -cb0[14].xy + v1.xy;
  r1.xy = cb0[15].xx * abs(r1.xy) * injectedData.fxVignette;
  r1.xy = log2(r1.xy);
  r1.xy = cb0[15].zz * r1.xy;
  r1.xy = exp2(r1.xy);
  r0.w = dot(r1.xy, r1.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r0.w = log2(r0.w);
  r0.w = cb0[15].y * r0.w;
  r0.w = exp2(r0.w);
  r1.xyz = float3(1,1,1) + -cb0[13].zxy;
  r1.xyz = r0.www * r1.xyz + cb0[13].zxy;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = cb0[9].www * r0.xyz;
  
      float3 untonemapped = r0.gbr;
  r0.xyz = r0.xyz * float3(5.55555582,5.55555582,5.55555582) + float3(0.0479959995,0.0479959995,0.0479959995);
  r0.xyz = log2(r0.xyz);
  r0.xyz = saturate(r0.xyz * float3(0.0734997839,0.0734997839,0.0734997839) + float3(0.386036009,0.386036009,0.386036009));
  r0.yzw = cb0[9].zzz * r0.xyz;
  r0.y = floor(r0.y);
  r0.x = r0.x * cb0[9].z + -r0.y;
  r1.xy = float2(0.5,0.5) * cb0[9].xy;
  r1.yz = r0.zw * cb0[9].xy + r1.xy;
  r1.x = r0.y * cb0[9].y + r1.y;
  r2.x = cb0[9].y;
  r2.y = 0;
  r0.yz = r2.xy + r1.xz;
  r1.xyzw = t4.Sample(s3_s, r1.xz).xyzw;
  r2.xyzw = t4.Sample(s3_s, r0.yz).xyzw;
  r0.yzw = r2.xyz + -r1.xyz;
  r0.xyz = saturate(r0.xxx * r0.yzw + r1.xyz);
      r0.rgb = applyUserTonemap(untonemapped, t4, s3_s, cb0[9].xyz);

  r1.xy = v1.xy * cb0[12].xy + cb0[12].zw;
  r1.xyzw = t5.Sample(s4_s, r1.xy).xyzw;
  r1.xyz = r1.xyz * r0.xyz;
  r1.xyz = cb0[11].yyy * r1.xyz;
  r0.w = dot(r0.xyz, float3(0.212599993,0.715200007,0.0722000003));
  //r0.w = sqrt(r0.w);
    r0.a = sign(r0.a) * sqrt(abs(r0.a));
  r0.w = cb0[11].x * -r0.w + 1;
  r0.xyz = injectedData.fxFilmGrainType ? applyFilmGrain(r0.rgb, w1.xy) : r1.xyz * r0.www * injectedData.fxFilmGrain + r0.xyz;
  //r0.xyz = max(float3(0,0,0), r0.xyz);
  //r0.xyz = log2(r0.xyz);
  //r0.xyz = float3(0.416666657,0.416666657,0.416666657) * r0.xyz;
  //r0.xyz = exp2(r0.xyz);
  //r0.xyz = r0.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //o0.xyz = max(float3(0,0,0), r0.xyz);
    o0.rgb = renodx::color::srgb::EncodeSafe(r0.rgb);
  o0.w = 1;
  return;
}