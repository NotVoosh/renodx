// ---- Created with 3Dmigoto v1.3.16 on Fri Sep 27 05:56:08 2024
Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb1 : register(b1)
{
  float4 cb1[8];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[7];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  float4 x1[4];
  r0.xyzw = t0.Sample(s2_s, v1.xy).xyzw;
  r0.x = cb1[7].x * r0.x + cb1[7].y;
  r0.x = 1 / r0.x;
  x0[0].xy = -cb0[2].xy;
  r1.xyzw = float4(1,-1,-1,1) * cb0[2].xyxy;
  x0[1].xy = r1.xy;
  x0[2].xy = r1.zw;
  x0[3].xy = cb0[2].xy;
  r1.xyzw = -cb0[2].xyxy + v1.xyxy;
  r2.xyzw = t0.Sample(s2_s, r1.xy).xyzw;
  r0.y = cb1[7].x * r2.x + cb1[7].y;
  r0.y = 1 / r0.y;
  r0.xy = float2(1,1) + -r0.xy;
  x1[0].x = r0.y;
  r2.xyzw = cb0[2].xyxy * float4(1,-1,-1,1) + v1.xyxy;
  r3.xyzw = t0.Sample(s2_s, r2.xy).xyzw;
  r0.z = cb1[7].x * r3.x + cb1[7].y;
  r0.z = 1 / r0.z;
  r0.z = 1 + -r0.z;
  x1[1].x = r0.z;
  r3.xyzw = t0.Sample(s2_s, r2.zw).xyzw;
  r0.w = cb1[7].x * r3.x + cb1[7].y;
  r0.w = 1 / r0.w;
  r0.w = 1 + -r0.w;
  x1[2].x = r0.w;
  r1.xy = cb0[2].xy + v1.xy;
  r3.xyzw = t0.Sample(s2_s, r1.xy).xyzw;
  r3.x = cb1[7].x * r3.x + cb1[7].y;
  r3.x = 1 / r3.x;
  r3.x = 1 + -r3.x;
  x1[3].x = r3.x;
  r0.y = cmp(r0.z < r0.y);
  r0.z = cmp(r3.x < r0.w);
  r0.yz = r0.yz ? float2(0,2.80259693e-45) : float2(1.40129846e-45,4.20389539e-45);
  r0.w = x1[r0.y+0].x;
  r3.x = x1[r0.z+0].x;
  r0.w = cmp(r3.x < r0.w);
  r0.y = r0.w ? r0.y : r0.z;
  r0.z = x1[r0.y+0].x;
  r0.x = cmp(r0.x < r0.z);
  if (r0.x != 0) {
    r0.xy = x0[r0.y+0].xy;
  } else {
    r0.xy = float2(0,0);
  }
  r0.xy = v1.xy + r0.xy;
  r0.xyzw = t1.Sample(s3_s, r0.xy).xyzw;
  r0.z = abs(r0.x) + abs(r0.y);
  r0.z = min(1, r0.z);
  r3.xyzw = t2.Sample(s0_s, r1.zw).xyzw;
  r4.xw = float2(0,0);
  r4.yz = -cb0[2].yx;
  r4.xyzw = v1.xyxy + r4.xyzw;
  r5.xyzw = t2.Sample(s0_s, r4.xy).xyzw;
  r6.xyzw = t2.Sample(s0_s, r2.xy).xyzw;
  r4.xyzw = t2.Sample(s0_s, r4.zw).xyzw;
  r7.xyzw = t2.Sample(s0_s, v1.xy).xyzw;
  r8.xw = cb0[2].xy;
  r8.yz = float2(0,0);
  r8.xyzw = v1.xyxy + r8.xyzw;
  r9.xyzw = t2.Sample(s0_s, r8.xy).xyzw;
  r2.xyzw = t2.Sample(s0_s, r2.zw).xyzw;
  r8.xyzw = t2.Sample(s0_s, r8.zw).xyzw;
  r1.xyzw = t2.Sample(s0_s, r1.xy).xyzw;
  r10.xy = r3.yx + r3.yz;
  r0.w = r10.x + r10.y;
  r0.w = r0.w * cb0[4].z + 4;
  r0.w = 1 / r0.w;
  r3.xyz = r3.xyz * r0.www;
  r10.xy = r5.yx + r5.yz;
  r0.w = r10.x + r10.y;
  r0.w = r0.w * cb0[4].z + 4;
  r0.w = 1 / r0.w;
  r5.xyz = r5.xyz * r0.www;
  r10.xy = r6.yx + r6.yz;
  r0.w = r10.x + r10.y;
  r0.w = r0.w * cb0[4].z + 4;
  r0.w = 1 / r0.w;
  r6.xyz = r6.xyz * r0.www;
  r10.xy = r4.yx + r4.yz;
  r0.w = r10.x + r10.y;
  r0.w = r0.w * cb0[4].z + 4;
  r0.w = 1 / r0.w;
  r4.xyz = r4.xyz * r0.www;
  r10.xy = r7.yx + r7.yz;
  r0.w = r10.x + r10.y;
  r0.w = r0.w * cb0[4].z + 4;
  r0.w = 1 / r0.w;
  r10.xyz = r7.xyz * r0.www;
  r11.xy = r9.yx + r9.yz;
  r11.x = r11.x + r11.y;
  r11.x = r11.x * cb0[4].z + 4;
  r11.x = 1 / r11.x;
  r9.xyz = r11.xxx * r9.xyz;
  r11.xy = r2.yx + r2.yz;
  r11.x = r11.x + r11.y;
  r11.x = r11.x * cb0[4].z + 4;
  r11.x = 1 / r11.x;
  r2.xyz = r11.xxx * r2.xyz;
  r11.xy = r8.yx + r8.yz;
  r11.x = r11.x + r11.y;
  r11.x = r11.x * cb0[4].z + 4;
  r11.x = 1 / r11.x;
  r8.xyz = r11.xxx * r8.xyz;
  r11.xy = r1.yx + r1.yz;
  r11.x = r11.x + r11.y;
  r11.x = r11.x * cb0[4].z + 4;
  r11.x = 1 / r11.x;
  r1.xyz = r11.xxx * r1.xyz;
  r11.xyzw = float4(0.125,0.125,0.125,0.125) * r5.xyzw;
  r11.xyzw = r3.xyzw * float4(0.0625,0.0625,0.0625,0.0625) + r11.xyzw;
  r11.xyzw = r6.xyzw * float4(0.0625,0.0625,0.0625,0.0625) + r11.xyzw;
  r11.xyzw = r4.xyzw * float4(0.125,0.125,0.125,0.125) + r11.xyzw;
  r10.w = r7.w;
  r11.xyzw = r10.xyzw * float4(0.25,0.25,0.25,0.25) + r11.xyzw;
  r11.xyzw = r9.xyzw * float4(0.125,0.125,0.125,0.125) + r11.xyzw;
  r11.xyzw = r2.xyzw * float4(0.0625,0.0625,0.0625,0.0625) + r11.xyzw;
  r11.xyzw = r8.xyzw * float4(0.125,0.125,0.125,0.125) + r11.xyzw;
  r11.xyzw = r1.xyzw * float4(0.0625,0.0625,0.0625,0.0625) + r11.xyzw;
  r12.xyz = min(r6.xyz, r3.xyz);
  r13.xyz = min(r2.xyz, r1.xyz);
  r12.xyz = min(r13.xyz, r12.xyz);
  r3.xyz = max(r6.xyz, r3.xyz);
  r1.xyz = max(r2.xyz, r1.xyz);
  r1.xyz = max(r3.xyz, r1.xyz);
  r2.xyz = min(r5.xyz, r4.xyz);
  r3.xyz = min(r10.xyz, r9.xyz);
  r2.xyz = min(r3.xyz, r2.xyz);
  r2.xyz = min(r2.xyz, r8.xyz);
  r3.xyz = max(r5.xyz, r4.xyz);
  r4.xyz = max(r10.xyz, r9.xyz);
  r3.xyz = max(r4.xyz, r3.xyz);
  r3.xyz = max(r3.xyz, r8.xyz);
  r4.xyz = min(r12.xyz, r2.xyz);
  r1.xyz = max(r3.xyz, r1.xyz);
  r4.xyz = float3(0.5,0.5,0.5) * r4.xyz;
  r2.xyz = r2.xyz * float3(0.5,0.5,0.5) + r4.xyz;
  r1.xyz = float3(0.5,0.5,0.5) * r1.xyz;
  r1.xyz = r3.xyz * float3(0.5,0.5,0.5) + r1.xyz;
  r3.xy = v1.xy + -r0.xy;
  r3.xyzw = t3.Sample(s1_s, r3.xy).xyzw;
  r4.xy = r3.yx + r3.yz;
  r1.w = r4.x + r4.y;
  r1.w = r1.w * cb0[4].z + 4;
  r1.w = 1 / r1.w;
  r4.xyz = r3.xyz * r1.www;
  r5.xy = r2.yx + r2.yz;
  r2.w = r5.x + r5.y;
  r5.xy = r1.yx + r1.yz;
  r4.w = r5.x + r5.y;
  r5.xy = r4.yx + r4.yz;
  r5.x = r5.x + r5.y;
  r2.w = r4.w + -r2.w;
  r4.w = dot(r0.xy, r0.xy);
  r4.w = sqrt(r4.w);
  r5.y = 1000000 * r4.w;
  r5.y = min(1, r5.y);
  r5.zw = cb0[6].zw + -cb0[6].xy;
  r5.yz = r5.yy * r5.zw + cb0[6].xy;
  r5.w = cmp(cb0[5].x < 0.5);
  r5.yz = r5.ww ? float2(0.5,1) : r5.yz;
  r5.z = cb0[4].y * r5.z;
  r6.xyz = min(r2.xyz, r1.xyz);
  r6.xyz = min(r11.xyz, r6.xyz);
  r1.xyz = max(r2.xyz, r1.xyz);
  r1.xyz = max(r11.xyz, r1.xyz);
  r2.xyz = r1.xyz + r6.xyz;
  r6.xyz = -r3.xyz * r1.www + r11.xyz;
  r8.xyz = -r2.xyz * float3(0.5,0.5,0.5) + r4.xyz;
  r1.xyz = -r2.xyz * r5.yyy + r1.xyz;
  r1.w = min(abs(r6.x), abs(r6.y));
  r1.w = min(r1.w, abs(r6.z));
  r1.w = cmp(r1.w >= 1.52587891e-05);
  r2.xyz = float3(1,1,1) / r6.xyz;
  r9.xyz = r1.xyz + -r8.xyz;
  r9.xyz = r9.xyz * r2.xyz;
  r1.xyz = -r1.xyz + -r8.xyz;
  r1.xyz = r1.xyz * r2.xyz;
  r1.xyz = min(r9.xyz, r1.xyz);
  r1.x = max(r1.x, r1.y);
  r1.x = saturate(max(r1.x, r1.z));
  r1.x = r1.w ? r1.x : 1;
  r3.xyz = r1.xxx * r6.xyz + r4.xyz;
  r1.x = r2.w * cb0[4].w + 1;
  r1.x = 1 / r1.x;
  r1.x = saturate(r0.z * 0.5 + r1.x);
  r1.yzw = r7.xyz * r0.www + -r11.xyz;
  r11.xyz = r1.xxx * r1.yzw + r11.xyz;
  r0.xy = r0.xy * r0.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.x = sqrt(r0.x);
  r0.x = saturate(-r0.x * 90 + 2);
  r0.x = r5.z * r0.x;
  r0.x = 1 / r0.x;
  r0.x = r0.z * r0.x + r0.x;
  r0.y = r5.x * r0.x;
  r0.x = r0.z * r0.x;
  r0.x = r0.x * 4 + 1;
  r0.x = r0.y * r0.x;
  r0.y = r5.x + r2.w;
  r0.y = 1 / r0.y;
  r0.x = saturate(r0.x * r0.y);
  r0.y = sqrt(r0.x);
  r0.z = saturate(cb0[3].w * r4.w);
  r0.y = r0.y + -r0.x;
  r0.x = r0.z * r0.y + r0.x;
  r1.xyzw = r11.xyzw + -r3.xyzw;
  r0.xyzw = r0.xxxx * r1.xyzw + r3.xyzw;
  r1.xy = r0.yx + r0.yz;
  r1.x = r1.x + r1.y;
  r1.x = r1.x * -cb0[4].z + 1;
  r1.x = 1 / r1.x;
  r1.x = 4 * r1.x;
  r0.xyz = r1.xxx * r0.xyz;
  //r0.xyz = min(float3(0,0,0), -r0.xyz);
  //o0.xyz = -r0.xyz;
    o0.xyz = r0.xyz;
  o0.w = r0.w;
  return;
}