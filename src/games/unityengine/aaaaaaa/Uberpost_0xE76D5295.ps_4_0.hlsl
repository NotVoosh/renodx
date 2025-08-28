#include "../common.hlsl"

Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[146];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.xy;
  r0.zw = r0.xy * cb0[139].zz + float2(0.5,0.5);
  r0.xy = r0.xy * cb0[139].zz + -cb0[138].xy;
  r0.xy = cb0[138].zw * r0.xy;
  r1.x = dot(r0.xy, r0.xy);
  r1.x = sqrt(r1.x);
  if (cb0[139].w > 0) {
    r1.yz = cb0[139].xy * r1.xx;
    sincos(r1.y, r2.x, r3.x);
    r1.y = r2.x / r3.x;
    r1.z = 1 / r1.z;
    r1.y = r1.y * r1.z + -1;
    r1.yz = r0.xy * r1.yy + r0.zw;
  } else {
    r1.w = 1 / r1.x;
    r1.w = cb0[139].x * r1.w;
    r1.x = cb0[139].y * r1.x;
    r2.x = min(1, abs(r1.x));
    r2.y = max(1, abs(r1.x));
    r2.y = 1 / r2.y;
    r2.x = r2.x * r2.y;
    r2.y = r2.x * r2.x;
    r2.z = r2.y * 0.0208350997 + -0.0851330012;
    r2.z = r2.y * r2.z + 0.180141002;
    r2.z = r2.y * r2.z + -0.330299497;
    r2.y = r2.y * r2.z + 0.999866009;
    r2.z = r2.x * r2.y;
    r2.z = r2.z * -2 + 1.57079637;
    r2.z = abs(r1.x) > 1 ? r2.z : 0;
    r2.x = r2.x * r2.y + r2.z;
    r1.x = min(1, r1.x);
    r1.x = (r1.x < -r1.x) ? -r2.x : r2.x;
    r1.x = r1.w * r1.x + -1;
    r1.yz = r0.xy * r1.xx + r0.zw;
  }
  r0.xyzw = t0.SampleBias(s0_s, r1.yz, cb0[5].x).xyzw;
  r1.xw = r1.yz * cb0[145].zw + float2(0.5,0.5);
  r2.xy = floor(r1.xw);
  r1.xw = frac(r1.xw);
  r3.xyzw = -r1.xwxw * float4(0.5,0.5,0.166666672,0.166666672) + float4(0.5,0.5,0.5,0.5);
  r3.xyzw = r1.xwxw * r3.xyzw + float4(0.5,0.5,-0.5,-0.5);
  r2.zw = r1.xw * float2(0.5,0.5) + float2(-1,-1);
  r4.xy = r1.xw * r1.xw;
  r2.zw = r4.xy * r2.zw + float2(0.666666687,0.666666687);
  r3.xyzw = r1.xwxw * r3.xyzw + float4(0.166666672,0.166666672,0.166666672,0.166666672);
  r1.xw = float2(1,1) + -r2.zw;
  r1.xw = r1.xw + -r3.xy;
  r1.xw = r1.xw + -r3.zw;
  r3.zw = r3.zw + r2.zw;
  r3.xy = r3.xy + r1.xw;
  r4.xy = float2(1,1) / r3.zw;
  r4.zw = r2.zw * r4.xy + float2(-1,-1);
  r2.zw = float2(1,1) / r3.xy;
  r4.xy = r1.xw * r2.zw + float2(1,1);
  r5.xyzw = r4.zwxw + r2.xyxy;
  r5.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r5.xyzw;
  r5.xyzw = cb0[145].xyxy * r5.xyzw;
  r5.xyzw = min(float4(1,1,1,1), r5.xyzw);
  r6.xyzw = t1.SampleLevel(s0_s, r5.xy, 0).xyzw;
  r5.xyzw = t1.SampleLevel(s0_s, r5.zw, 0).xyzw;
  r5.xyzw = r5.xyzw * r3.xxxx;
  r5.xyzw = r3.zzzz * r6.xyzw + r5.xyzw;
  r2.xyzw = r4.zyxy + r2.xyxy;
  r2.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r2.xyzw;
  r2.xyzw = cb0[145].xyxy * r2.xyzw;
  r2.xyzw = min(float4(1,1,1,1), r2.xyzw);
  r4.xyzw = t1.SampleLevel(s0_s, r2.xy, 0).xyzw;
  r2.xyzw = t1.SampleLevel(s0_s, r2.zw, 0).xyzw;
  r2.xyzw = r3.xxxx * r2.xyzw;
  r2.xyzw = r3.zzzz * r4.xyzw + r2.xyzw;
  r2.xyzw = r3.yyyy * r2.xyzw;
  r2.xyzw = r3.wwww * r5.xyzw + r2.xyzw;
  if (cb0[135].x > 0) {
    r3.xyz = r2.xyz * r2.www;
    r2.xyz = float3(8,8,8) * r3.xyz;
  }
  r2.xyz = cb0[134].xxx * r2.xyz * injectedData.fxBloom;
  r0.xyz = r2.xyz * cb0[134].yzw + r0.xyz;
  if (cb0[142].z > 0) {
    r1.xy = -cb0[142].xy + r1.yz;
    r1.yz = cb0[142].zz * abs(r1.xy) * min(1.f, injectedData.fxVignette);
    r1.x = cb0[141].w * r1.y;
    r0.w = dot(r1.xz, r1.xz);
    r0.w = 1 + -r0.w;
    r0.w = max(0, r0.w);
    r0.w = log2(r0.w);
    r0.w = cb0[142].w * r0.w * max(1.f, injectedData.fxVignette);
    r0.w = exp2(r0.w);
    r1.xyz = float3(1,1,1) + -cb0[141].xyz;
    r1.xyz = r0.www * r1.xyz + cb0[141].xyz;
    r0.xyz = r1.xyz * r0.xyz;
  }
  r0.xyz = cb0[132].www * r0.zxy;
  r0.yzx = lutShaper(r0.yzx);
  if(injectedData.colorGradeLUTSampling == 0.f){
  r0.yzw = cb0[132].zzz * r0.xyz;
  r0.y = floor(r0.y);
  r1.xy = float2(0.5,0.5) * cb0[132].xy;
  r1.yz = r0.zw * cb0[132].xy + r1.xy;
  r1.x = r0.y * cb0[132].y + r1.y;
  r2.xyzw = t3.SampleLevel(s0_s, r1.xz, 0).xyzw;
  r3.x = cb0[132].y;
  r3.y = 0;
  r0.zw = r3.xy + r1.xz;
  r1.xyzw = t3.SampleLevel(s0_s, r0.zw, 0).xyzw;
  r0.x = r0.x * cb0[132].z + -r0.y;
  r0.yzw = r1.xyz + -r2.xyz;
  r0.xyz = r0.xxx * r0.yzw + r2.xyz;
  } else {
    r0.xyz = renodx::lut::SampleTetrahedral(t3, r0.yzx, cb0[132].z + 1u);
  }
  if (cb0[133].w > 0) {
    r1.xyz = fastSrgbEncodeSafe(r0.xyz);
    r2.xyz = handleUserLUT(r0.xyz, t4, s0_s, cb0[133].xyz, 1);
    r2.xyz = r2.xyz + -r1.xyz;
    r1.xyz = cb0[133].www * r2.xyz + r1.xyz;
    r0.xyz = fastSrgbDecodeSafe(r1.xyz);
  }
  if(injectedData.fxFilmGrainType == 0.f){
  r1.xy = v1.xy * cb0[144].xy + cb0[144].zw;
  r1.xyzw = t2.SampleBias(s1_s, r1.xy, cb0[5].x).xyzw;
  r0.w = -0.5 + r1.w;
  r0.w = r0.w + r0.w;
  r1.x = renodx::color::y::from::BT709(saturate(r0.xyz));
  r1.x = sqrt(r1.x);
  r1.x = cb0[143].y * -r1.x + 1;
  r1.yzw = r0.xyz * r0.www;
  r1.yzw = cb0[143].xxx * r1.yzw * injectedData.fxFilmGrain;
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