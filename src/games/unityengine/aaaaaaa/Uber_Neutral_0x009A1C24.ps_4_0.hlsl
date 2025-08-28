#include "../tonemap.hlsl"

Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[131];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.zw = r0.xy * cb0[124].zz + float2(0.5,0.5);
  r0.xy = r0.xy * cb0[124].zz + -cb0[123].xy;
  r0.xy = cb0[123].zw * r0.xy;
  r1.x = dot(r0.xy, r0.xy);
  r1.x = sqrt(r1.x);
  if (cb0[124].w > 0) {
    r1.zw = cb0[124].xy * r1.xx;
    sincos(r1.z, r2.x, r3.x);
    r1.z = r2.x / r3.x;
    r1.w = 1 / r1.w;
    r1.z = r1.z * r1.w + -1;
    r1.zw = r0.xy * r1.zz + r0.zw;
  } else {
    r2.x = 1 / r1.x;
    r2.x = cb0[124].x * r2.x;
    r1.x = cb0[124].y * r1.x;
    r2.y = min(1, abs(r1.x));
    r2.z = max(1, abs(r1.x));
    r2.z = 1 / r2.z;
    r2.y = r2.y * r2.z;
    r2.z = r2.y * r2.y;
    r2.w = r2.z * 0.0208350997 + -0.0851330012;
    r2.w = r2.z * r2.w + 0.180141002;
    r2.w = r2.z * r2.w + -0.330299497;
    r2.z = r2.z * r2.w + 0.999866009;
    r2.w = r2.y * r2.z;
    r2.w = r2.w * -2 + 1.57079637;
    r2.w = abs(r1.x) > 1 ? r2.w : 0;
    r2.y = r2.y * r2.z + r2.w;
    r1.x = min(1, r1.x);
    r1.x = (r1.x < -r1.x) ? -r2.y : r2.y;
    r1.x = r2.x * r1.x + -1;
    r1.zw = r0.xy * r1.xx + r0.zw;
  }
  r0.xyzw = v1.xyxy * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r1.x = dot(r0.zw, r0.zw);
  r0.xyzw = r1.xxxx * r0.xyzw;
  r0.xyzw = cb0[125].xxxx * r0.xyzw * injectedData.fxCA;
  r2.xyzw = t0.Sample(s0_s, r1.zw).xyzw;
  r0.xyzw = r0.xyzw * float4(-0.333333343,-0.333333343,-0.666666687,-0.666666687) + v1.xyxy;
  r0.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r0.xyzw;
  r3.xyzw = r0.xyzw * cb0[124].zzzz + float4(0.5,0.5,0.5,0.5);
  r0.xyzw = r0.xyzw * cb0[124].zzzz + -cb0[123].xyxy;
  r0.xyzw = cb0[123].zwzw * r0.xyzw;
  r1.x = dot(r0.xy, r0.xy);
  r1.x = sqrt(r1.x);
  if (cb0[124].w > 0) {
    r2.yz = cb0[124].xy * r1.xx;
    sincos(r2.y, r4.x, r5.x);
    r2.y = r4.x / r5.x;
    r2.z = 1 / r2.z;
    r2.y = r2.y * r2.z + -1;
    r2.yz = r0.xy * r2.yy + r3.xy;
  } else {
    r2.w = 1 / r1.x;
    r2.w = cb0[124].x * r2.w;
    r1.x = cb0[124].y * r1.x;
    r4.x = min(1, abs(r1.x));
    r4.y = max(1, abs(r1.x));
    r4.y = 1 / r4.y;
    r4.x = r4.x * r4.y;
    r4.y = r4.x * r4.x;
    r4.z = r4.y * 0.0208350997 + -0.0851330012;
    r4.z = r4.y * r4.z + 0.180141002;
    r4.z = r4.y * r4.z + -0.330299497;
    r4.y = r4.y * r4.z + 0.999866009;
    r4.z = r4.x * r4.y;
    r4.z = r4.z * -2 + 1.57079637;
    r4.z = abs(r1.x) > 1 ? r4.z : 0;
    r4.x = r4.x * r4.y + r4.z;
    r1.x = min(1, r1.x);
    r1.x = (r1.x < -r1.x) ? -r4.x : r4.x;
    r1.x = r2.w * r1.x + -1;
    r2.yz = r0.xy * r1.xx + r3.xy;
  }
  r4.xyzw = t0.Sample(s0_s, r2.yz).xyzw;
  r0.x = dot(r0.zw, r0.zw);
  r0.x = sqrt(r0.x);
  if (cb0[124].w > 0) {
    r1.xy = cb0[124].xy * r0.xx;
    sincos(r1.x, r1.x, r3.x);
    r0.y = r1.x / r3.x;
    r1.x = 1 / r1.y;
    r0.y = r0.y * r1.x + -1;
    r1.xy = r0.zw * r0.yy + r3.zw;
  } else {
    r0.y = 1 / r0.x;
    r0.y = cb0[124].x * r0.y;
    r0.x = cb0[124].y * r0.x;
    r2.y = min(1, abs(r0.x));
    r2.z = max(1, abs(r0.x));
    r2.z = 1 / r2.z;
    r2.y = r2.y * r2.z;
    r2.z = r2.y * r2.y;
    r2.w = r2.z * 0.0208350997 + -0.0851330012;
    r2.w = r2.z * r2.w + 0.180141002;
    r2.w = r2.z * r2.w + -0.330299497;
    r2.z = r2.z * r2.w + 0.999866009;
    r2.w = r2.y * r2.z;
    r2.w = r2.w * -2 + 1.57079637;
    r2.w = abs(r0.x) > 1 ? r2.w : 0;
    r2.y = r2.y * r2.z + r2.w;
    r0.x = min(1, r0.x);
    r0.x = (r0.x < -r0.x) ? -r2.y : r2.y;
    r0.x = r0.y * r0.x + -1;
    r1.xy = r0.zw * r0.xx + r3.zw;
  }
  r0.xyzw = t0.Sample(s0_s, r1.xy).xyzw;
  r1.xy = r1.zw * cb0[130].zw + float2(0.5,0.5);
  r2.yz = floor(r1.xy);
  r1.xy = frac(r1.xy);
  r3.xyzw = -r1.xyxy * float4(0.5,0.5,0.166666672,0.166666672) + float4(0.5,0.5,0.5,0.5);
  r3.xyzw = r1.xyxy * r3.xyzw + float4(0.5,0.5,-0.5,-0.5);
  r4.xz = r1.xy * float2(0.5,0.5) + float2(-1,-1);
  r5.xy = r1.xy * r1.xy;
  r4.xz = r5.xy * r4.xz + float2(0.666666687,0.666666687);
  r3.xyzw = r1.xyxy * r3.xyzw + float4(0.166666672,0.166666672,0.166666672,0.166666672);
  r1.xy = float2(1,1) + -r4.xz;
  r1.xy = r1.xy + -r3.xy;
  r1.xy = r1.xy + -r3.zw;
  r3.zw = r3.zw + r4.xz;
  r3.xy = r3.xy + r1.xy;
  r5.xy = float2(1,1) / r3.zw;
  r5.zw = r4.xz * r5.xy + float2(-1,-1);
  r4.xz = float2(1,1) / r3.xy;
  r5.xy = r1.xy * r4.xz + float2(1,1);
  r6.xyzw = r5.zwxw + r2.yzyz;
  r6.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r6.xyzw;
  r6.xyzw = cb0[130].xyxy * r6.xyzw;
  r6.xyzw = min(float4(1,1,1,1), r6.xyzw);
  r7.xyzw = t1.SampleLevel(s0_s, r6.xy, 0).xyzw;
  r6.xyzw = t1.SampleLevel(s0_s, r6.zw, 0).xyzw;
  r6.xyzw = r6.xyzw * r3.xxxx;
  r6.xyzw = r3.zzzz * r7.xyzw + r6.xyzw;
  r5.xyzw = r5.zyxy + r2.yzyz;
  r5.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r5.xyzw;
  r5.xyzw = cb0[130].xyxy * r5.xyzw;
  r5.xyzw = min(float4(1,1,1,1), r5.xyzw);
  r7.xyzw = t1.SampleLevel(s0_s, r5.xy, 0).xyzw;
  r5.xyzw = t1.SampleLevel(s0_s, r5.zw, 0).xyzw;
  r5.xyzw = r5.xyzw * r3.xxxx;
  r5.xyzw = r3.zzzz * r7.xyzw + r5.xyzw;
  r5.xyzw = r5.xyzw * r3.yyyy;
  r3.xyzw = r3.wwww * r6.xyzw + r5.xyzw;
  if (cb0[120].x > 0) {
    r2.yzw = r3.xyz * r3.www;
    r3.xyz = float3(8,8,8) * r2.yzw;
  }
  r2.yzw = cb0[119].xxx * r3.xyz * injectedData.fxBloom;
  r0.x = r2.x;
  r0.y = r4.y;
  r0.xyz = r2.yzw * cb0[119].yzw + r0.xyz;
  if (cb0[127].z > 0) {
    r1.xy = -cb0[127].xy + r1.zw;
    r1.yz = cb0[127].zz * abs(r1.xy) * min(1.f, injectedData.fxVignette);
    r1.x = cb0[126].w * r1.y;
    r0.w = dot(r1.xz, r1.xz);
    r0.w = 1 + -r0.w;
    r0.w = max(0, r0.w);
    r0.w = log2(r0.w);
    r0.w = cb0[127].w * r0.w * max(1.f, injectedData.fxVignette);
    r0.w = exp2(r0.w);
    r1.xyz = float3(1,1,1) + -cb0[126].xyz;
    r1.xyz = r0.www * r1.xyz + cb0[126].xyz;
    r0.xyz = r1.xyz * r0.xyz;
  }
  r0.xyz = cb0[117].www * r0.xyz;
  r0.xyz = applyUserTonemapNeutral(r0.xyz, false);
  float3 tonemapped = r0.xyz;
  if (cb0[118].w > 0) {
    r1.xyz = renodx::color::srgb::EncodeSafe(r0.xyz);
    r2.xyz = handleUserLUT(r0.xyz, t4, s0_s, cb0[118].xyz);
    r2.xyz = r2.xyz + -r1.xyz;
    r1.xyz = cb0[118].www * r2.xyz + r1.xyz;
    r0.xyz = renodx::color::srgb::DecodeSafe(r1.xyz);
    tonemapped = r0.xyz;
  }
  r0.xyz = lutShaper(r0.xyz, false, 1);
  if(injectedData.colorGradeLUTSampling == 0.f){
  r0.xyw = cb0[117].zzz * r0.xyz;
  r0.w = floor(r0.w);
  r1.xy = float2(0.5,0.5) * cb0[117].xy;
  r1.yz = r0.xy * cb0[117].xy + r1.xy;
  r1.x = r0.w * cb0[117].y + r1.y;
  r2.xyzw = t3.SampleLevel(s0_s, r1.xz, 0).xyzw;
  r0.x = cb0[117].y;
  r0.y = 0;
  r0.xy = r1.xz + r0.xy;
  r1.xyzw = t3.SampleLevel(s0_s, r0.xy, 0).xyzw;
  r0.x = r0.z * cb0[117].z + -r0.w;
  r0.yzw = r1.xyz + -r2.xyz;
  r0.xyz = r0.xxx * r0.yzw + r2.xyz;
  } else {
    r0.xyz = renodx::lut::SampleTetrahedral(t3, r0.xyz, cb0[117].z + 1u);
  }
  r0.xyz = rolloff(r0.xyz);
  r0.xyz = RestoreSaturationLoss(tonemapped, r0.xyz);
  r0.xyz = grading(r0.xyz);
  if(injectedData.fxFilmGrainType == 0.f){
  r1.xy = v1.xy * cb0[129].xy + cb0[129].zw;
  r1.xyzw = t2.Sample(s1_s, r1.xy).xyzw;
  r0.w = -0.5 + r1.w;
  r0.w = r0.w + r0.w;
  r1.x = renodx::color::y::from::BT709(r0.xyz);
  r1.x = sqrt(r1.x);
  r1.x = cb0[128].y * -r1.x + 1;
  r1.yzw = r0.xyz * r0.www;
  r1.yzw = cb0[128].xxx * r1.yzw * injectedData.fxFilmGrain;
  r0.xyz = r1.yzw * r1.xxx + r0.xyz;
  } else {
    r0.xyz = applyFilmGrain(r0.xyz, v1);
  }
  if (injectedData.countOld == injectedData.countNew) {
    r0.xyz = PostToneMapScale(r0.xyz);
  }
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}