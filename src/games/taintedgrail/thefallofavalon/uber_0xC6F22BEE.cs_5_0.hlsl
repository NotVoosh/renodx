#include "../common.hlsl"

Texture2D<float4> t4 : register(t4);
Texture3D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2DArray<float4> t1 : register(t1);
Texture2DArray<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
RWTexture2DArray<float4> u0 : register(u0);
cbuffer cb1 : register(b1){
  float4 cb1[13];
}
cbuffer cb0 : register(b0){
  float4 cb0[55];
}

#define cmp -

[numthreads(8, 8, 1)]
void main(uint3 vThreadID: SV_DispatchThreadID) {
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = (uint3)vThreadID.xyz;
  r1.xy = float2(0.5,0.5) + r0.xy;
  r1.xy = r1.xy * cb0[51].zw + float2(-0.5,-0.5);
  r1.zw = r1.xy * cb1[5].zz + float2(0.5,0.5);
  r1.xy = r1.xy * cb1[5].zz + -cb1[4].xy;
  r1.xy = cb1[4].zw * r1.xy;
  r0.w = dot(r1.xy, r1.xy);
  r0.w = sqrt(r0.w);
  if (cb1[5].w > 0) {
    r2.xy = cb1[5].xy * r0.ww;
    sincos(r2.x, r2.x, r3.x);
    r2.x = r2.x / r3.x;
    r2.y = rcp(r2.y);
    r2.x = r2.x * r2.y + -1;
    r2.xy = r1.xy * r2.xx + r1.zw;
  } else {
    r2.z = rcp(r0.w);
    r2.z = cb1[5].x * r2.z;
    r0.w = cb1[5].y * r0.w;
    r2.w = min(1, abs(r0.w));
    r3.x = max(1, abs(r0.w));
    r3.x = 1 / r3.x;
    r2.w = r3.x * r2.w;
    r3.x = r2.w * r2.w;
    r3.y = r3.x * 0.0208350997 + -0.0851330012;
    r3.y = r3.x * r3.y + 0.180141002;
    r3.y = r3.x * r3.y + -0.330299497;
    r3.x = r3.x * r3.y + 0.999866009;
    r3.y = r3.x * r2.w;
    r3.z = cmp(1 < abs(r0.w));
    r3.y = r3.y * -2 + 1.57079637;
    r3.y = r3.z ? r3.y : 0;
    r2.w = r2.w * r3.x + r3.y;
    r0.w = min(1, r0.w);
    r0.w = cmp(r0.w < -r0.w);
    r0.w = r0.w ? -r2.w : r2.w;
    r0.w = r2.z * r0.w + -1;
    r2.xy = r1.xy * r0.ww + r1.zw;
  }
  r1.xy = -cb0[51].zw * float2(0.5,0.5) + float2(1,1);
  r1.xy = min(r2.xy, r1.xy);
  r0.xy = cb0[54].xy * r1.xy;
  r1.xyz = t0.SampleLevel(s0_s, r0.xyz, 0).xyz;
  if (cb1[7].z != 0) {
    r2.zw = cb0[54].xy * r2.xy;
    r2.zw = r2.zw * cb1[11].xy + float2(0.5,0.5);
    r3.xy = floor(r2.zw);
    r2.zw = frac(r2.zw);
    r4.xyzw = -r2.zwzw * float4(0.5,0.5,0.166666672,0.166666672) + float4(0.5,0.5,0.5,0.5);
    r4.xyzw = r2.zwzw * r4.xyzw + float4(0.5,0.5,-0.5,-0.5);
    r3.zw = r2.zw * float2(0.5,0.5) + float2(-1,-1);
    r5.xy = r2.zw * r2.zw;
    r3.zw = r5.xy * r3.zw + float2(0.666666687,0.666666687);
    r4.xyzw = r2.zwzw * r4.xyzw + float4(0.166666672,0.166666672,0.166666672,0.166666672);
    r2.zw = float2(1,1) + -r3.zw;
    r2.zw = r2.zw + -r4.xy;
    r2.zw = r2.zw + -r4.zw;
    r4.zw = r4.zw + r3.zw;
    r4.xy = r4.xy + r2.zw;
    r5.xy = rcp(r4.zw);
    r5.zw = r3.zw * r5.xy + float2(-1,-1);
    r3.zw = rcp(r4.xy);
    r5.xy = r2.zw * r3.zw + float2(1,1);
    r6.xyzw = r5.zwxw + r3.xyxy;
    r6.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r6.xyzw;
    r6.xyzw = cb1[11].zwzw * r6.xyzw;
    r0.xy = min(cb0[54].xy, r6.xy);
    r7.xyz = t1.SampleLevel(s0_s, r0.xyz, 0).xyz;
    r0.xy = min(cb0[54].xy, r6.zw);
    r6.xyz = t1.SampleLevel(s0_s, r0.xyz, 0).xyz;
    r6.xyz = r6.xyz * r4.xxx;
    r6.xyz = r4.zzz * r7.xyz + r6.xyz;
    r3.xyzw = r5.zyxy + r3.xyxy;
    r3.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r3.xyzw;
    r3.xyzw = cb1[11].zwzw * r3.xyzw;
    r0.xy = min(cb0[54].xy, r3.xy);
    r5.xyz = t1.SampleLevel(s0_s, r0.xyz, 0).xyz;
    r0.xy = min(cb0[54].xy, r3.zw);
    r0.xyz = t1.SampleLevel(s0_s, r0.xyz, 0).xyz;
    r0.xyz = r4.xxx * r0.xyz;
    r0.xyz = r4.zzz * r5.xyz + r0.xyz;
    r0.xyz = r4.yyy * r0.xyz;
    r0.xyz = r4.www * r6.xyz + r0.xyz;
    r0.w = max(r1.x, r1.y);
    r0.w = max(r0.w, r1.z);
    r2.zw = -cb1[8].yx + r0.ww;
    r1.w = max(0, r2.z);
    r1.w = min(cb1[8].z, r1.w);
    r1.w = r1.w * r1.w;
    r1.w = cb1[8].w * r1.w;
    r1.w = max(r1.w, r2.w);
    r0.w = max(9.99999975e-05, r0.w);
    r0.w = r1.w / r0.w;
    r3.xyz = -r1.xyz * r0.www + r1.xyz;
    r3.xyz = r0.xyz * cb1[9].xyz + r3.xyz;
    r3.xyz = r3.xyz + -r1.xyz;
    r1.xyz = cb1[7].xxx * r3.xyz * injectedData.fxBloom + r1.xyz;
    if (cb1[7].w != 0) {
      r2.zw = r2.xy * cb1[10].xy + cb1[10].zw;
      r3.xyz = t2.SampleLevel(s0_s, r2.zw, 0).xyz;
      r0.xyz = r3.xyz * r0.xyz;
      r1.xyz = r0.xyz * cb1[7].yyy + r1.xyz;
    }
  }
  if ((uint)cb1[1].z == 0) {
    r0.xy = -cb1[1].xy + r2.xy;
    r0.yz = cb1[2].xx * abs(r0.yx) * min(1, injectedData.fxVignette);
    r0.w = cb0[51].x / cb0[51].y;
    r0.w = -1 + r0.w;
    r0.w = cb1[2].w * r0.w + 1;
    r0.x = r0.z * r0.w;
    r0.xy = saturate(r0.xy);
    r0.xy = log2(r0.xy);
    r0.xy = cb1[2].zz * r0.xy;
    r0.xy = exp2(r0.xy);
    r0.x = dot(r0.xy, r0.xy);
    r0.x = 1 + -r0.x;
    r0.x = max(0, r0.x);
    r0.x = log2(r0.x);
    r0.x = cb1[2].y * r0.x * max(1, injectedData.fxVignette);
    r0.x = exp2(r0.x);
    r0.yzw = float3(1,1,1) + -cb1[3].xyz;
    r0.xyz = r0.xxx * r0.yzw + cb1[3].xyz;
    r0.xyz = r1.xyz * r0.xyz;
  } else {
    r0.w = t4.SampleLevel(s2_s, r2.xy, 0).w;
    r1.w = r0.w * 0.305306017 + 0.682171106;
    r1.w = r0.w * r1.w + 0.0125228781;
    r0.w = r1.w * r0.w;
    r2.xyz = float3(1,1,1) + -cb1[3].xyz;
    r2.xyz = r0.www * r2.xyz + cb1[3].xyz;
    r2.xyz = r1.xyz * r2.xyz + -r1.xyz;
    r0.xyz = cb1[3].www * r2.xyz + r1.xyz;
  }
  if (cb1[12].x != 0) {
    r0.rgb = lutShaper(r0.rgb);
  } else {
    if (cb1[6].w != 0) {
      r1.xyz = cb1[6].zzz * r0.xyz;
      r1.rgb = lutShaper(r1.rgb);
      if (injectedData.colorGradeLUTSampling == 0.f) {
      r1.xyz = cb1[6].yyy * r1.xyz;
      r0.w = 0.5 * cb1[6].x;
      r1.xyz = r1.xyz * cb1[6].xxx + r0.www;
      r0.xyz = t3.SampleLevel(s1_s, r1.xyz, 0).xyz;
      } else {
        r0.rgb = renodx::lut::SampleTetrahedral(t3, r1.rgb, 1 / cb1[6].x);
      }
    }
  }
  u0[vThreadID] = r0.xyzx;
  return;
}