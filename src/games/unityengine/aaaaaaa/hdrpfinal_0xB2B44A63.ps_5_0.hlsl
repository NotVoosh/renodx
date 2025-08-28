#include "../common.hlsl"

Texture2DArray<float4> t4 : register(t4);
Texture2DArray<float4> t3 : register(t3);
Texture2DArray<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[44];
}
cbuffer cb0 : register(b0){
  float4 cb0[5];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb1[42].xy * v1.xy;
  r0.xy = (uint2)r0.xy;
  r0.xy = (uint2)r0.xy;
  r1.xyzw = float4(-1,-1,-1,-1) + cb1[42].xyxy;
  r0.zw = cb0[3].zw * r1.zw;
  r0.xy = r0.xy * cb0[3].xy + r0.zw;
  r0.xy = (uint2)r0.xy;
  r2.xyzw = (int4)r0.xyxy + int4(-1,-1,1,-1);
  r2.xyzw = (int4)r2.xyzw;
  r2.xyzw = min(r2.xyzw, r1.xyzw);
  r2.xyzw = (int4)r2.zwxy;
  r3.xy = r2.zw;
  r3.zw = float2(0,0);
  r3.xyz = t0.Load(r3.xyzw).xyz;
  r3.x = renodx::color::y::from::BT709(saturate(r3.xyz));
  r4.xyzw = (int4)r0.xyxy + int4(-1,1,1,1);
  r4.xyzw = (int4)r4.xyzw;
  r1.xyzw = min(r4.xyzw, r1.xyzw);
  r1.xyzw = (int4)r1.zwxy;
  r4.xy = r1.zw;
  r4.zw = float2(0,0);
  r3.yzw = t0.Load(r4.xyzw).xyz;
  r3.y = renodx::color::y::from::BT709(saturate(r3.yzw));
  r3.z = r3.x + r3.y;
  r2.zw = float2(0,0);
  r2.xyz = t0.Load(r2.xyzw).xyz;
  r2.x = renodx::color::y::from::BT709(saturate(r2.xyz));
  r1.zw = float2(0,0);
  r1.xyz = t0.Load(r1.xyzw).xyz;
  r1.x = renodx::color::y::from::BT709(saturate(r1.xyz));
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
  r4.xyzw = cb1[42].zwzw * r4.xyzw;
  r1.yz = v1.xy * cb0[3].xy + cb0[3].zw;
  r5.xyzw = saturate(r4.zwzw * float4(-0.5,-0.5,-0.166666672,-0.166666672) + r1.yzyz);
  r4.xyzw = saturate(r4.xyzw * float4(0.166666672,0.166666672,0.5,0.5) + r1.yzyz);
  r4.xyzw = cb1[43].xyxy * r4.xyzw;
  r5.xyzw = cb1[43].xyxy * r5.zwxy;
  r6.xy = r5.zw;
  r6.z = 0;
  r2.yzw = t0.SampleLevel(s2_s, r6.xyz, 0).xyz;
  r6.xy = r4.zw;
  r6.z = 0;
  r6.xyz = t0.SampleLevel(s2_s, r6.xyz, 0).xyz;
  r2.yzw = r6.xyz + r2.yzw;
  r2.yzw = float3(0.25,0.25,0.25) * r2.yzw;
  r5.z = 0;
  r5.xyz = t0.SampleLevel(s2_s, r5.xyz, 0).xyz;
  r4.z = 0;
  r4.xyz = t0.SampleLevel(s2_s, r4.xyz, 0).xyz;
  r4.xyz = r5.xyz + r4.xyz;
  r2.yzw = r4.xyz * float3(0.25,0.25,0.25) + r2.yzw;
  r4.xyz = float3(0.5,0.5,0.5) * r4.xyz;
  r1.w = renodx::color::y::from::BT709(saturate(r2.yzw));
  r3.z = min(r2.x, r3.y);
  r2.x = max(r2.x, r3.y);
  r2.x = max(r2.x, r1.x);
  r1.x = min(r3.z, r1.x);
  r0.zw = float2(0,0);
  r3.yzw = t0.Load(r0.xyww).xyz;
  r0.x = t4.Load(r0.xyzw).x;
  r0.y = renodx::color::y::from::BT709(saturate(r3.yzw));
  r0.z = min(r0.y, r3.x);
  r0.y = max(r0.y, r3.x);
  r0.y = max(r0.y, r2.x);
  r0.z = min(r0.z, r1.x);
  r0.yzw = (r1.w > r0.y) || (r1.w < r0.z) ? r4.xyz : r2.yzw;
  if (injectedData.fxFilmGrainType == 0.f) {
  r1.xw = r1.yz * cb0[1].xy + cb0[1].zw;
  r1.x = t1.Sample(s1_s, r1.xw).w;
  r1.x = -0.5 + r1.x;
  r1.x = r1.x + r1.x;
  r2.xyz = r1.xxx * r0.yzw;
  r2.xyz = cb0[0].xxx * r2.xyz * injectedData.fxFilmGrain;
  r1.x = renodx::color::y::from::BT709(saturate(r0.yzw));
  r1.x = sqrt(r1.x);
  r1.x = cb0[0].y * -r1.x + 1;
  r0.yzw = r2.xyz * r1.xxx + r0.yzw;
  } else {
    r0.yzw = applyFilmGrain(r0.yzw, v1);
  }
  r0.yzw = renodx::color::srgb::EncodeSafe(r0.yzw);
  r2.xy = cb0[2].xy * r1.yz;
  r1.xy = cb1[43].xy * r1.yz;
  r2.z = cb0[2].z;
  r1.w = t3.Sample(s1_s, r2.xyz).w;
  r1.w = r1.w * 2 + -1;
  r2.x = 1 + -abs(r1.w);
  r1.w = (r1.w >= 0) ? 1 : -1;
  r2.x = sqrt(r2.x);
  r2.x = 1 + -r2.x;
  r1.w = r2.x * r1.w;
  r0.yzw = r1.www * (1.0 / 255.0) * injectedData.fxNoise + r0.yzw;
  r0.yzw = renodx::color::srgb::DecodeSafe(r0.yzw);
  r1.z = 0;
  r1.xyzw = t2.SampleLevel(s0_s, r1.xyz, 0).xyzw;
  o0.xyz = r1.www * r0.yzw + r1.xyz;
  o0.xyz = PostToneMapScale(o0.xyz);
  o0.w = cb0[4].x == 1.0 ? r0.x : 1;
  return;
}