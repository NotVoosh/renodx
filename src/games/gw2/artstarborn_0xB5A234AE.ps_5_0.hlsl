// ---- Created with 3Dmigoto v1.3.16 on Mon Sep 30 02:38:19 2024
Texture2D<float4> t15 : register(t15);

TextureCube<float4> t13 : register(t13);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s15_s : register(s15);

SamplerState s13_s : register(s13);

SamplerState s8_s : register(s8);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[52];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float2 v1 : TEXCOORD1,
  float w1 : TEXCOORD3,
  float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[0].xx * cb0[32].xy + v1.xy;
  r0.xy = t8.Sample(s8_s, r0.xy).xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = t7.Sample(s7_s, v0.xy).y;
  r0.z = cb0[31].x * r0.z;
  r0.xy = r0.zz * r0.xy + v1.xy;
  r0.x = t7.Sample(s7_s, r0.xy).x;
  r0.x = -cb0[33].x + r0.x;
  r0.y = cb0[34].x + -cb0[33].x;
  r0.y = 1 / r0.y;
  r0.x = saturate(r0.x * r0.y);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.z = cb0[29].x + -cb0[28].x;
  r0.z = 1 / r0.z;
  r1.xy = t1.Sample(s1_s, v0.xy).xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r0.w = dot(r1.xy, r1.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r1.z = sqrt(r0.w);
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r1.xyz * r0.www;
  r2.xyz = v4.xyz * r1.yyy;
  r1.xyw = r1.xxx * v5.xyz + r2.xyz;
  r1.xyz = r1.zzz * v6.xyz + r1.xyw;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r2.xy = cmp(float2(9.99999991e-38,0) < r0.ww);
  r1.w = (int)-r2.y;
  r2.y = cmp(r1.w != 0.000000);
  r1.w = 9.99999991e-38 * r1.w;
  r1.w = r2.y ? r1.w : 9.99999991e-38;
  r0.w = r2.x ? r0.w : r1.w;
  r1.xyz = r1.xyz / r0.www;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r2.xy = cmp(float2(9.99999991e-38,0) < r0.ww);
  r2.y = (int)-r2.y;
  r2.z = cmp(r2.y != 0.000000);
  r2.y = 9.99999991e-38 * r2.y;
  r2.y = r2.z ? r2.y : 9.99999991e-38;
  r0.w = r2.x ? r0.w : r2.y;
  r2.xyz = r1.xyz / r0.www;
  r3.x = v5.w;
  r3.y = v4.w;
  r3.z = v6.w;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r4.xyz = r3.xyz * r0.www;
  r3.xyz = r3.xyz * r0.www + cb0[7].xyz;
  r0.w = dot(r2.xyz, r4.xyz);
  r2.x = cb0[26].x * r0.w;
  r2.yz = float2(0.5,0.5) * cb0[25].zw;
  r2.yw = v0.zw * r2.yy;
  r2.yw = cb0[0].xx * cb0[25].xy + r2.yw;
  r2.yz = r2.yw * r2.zz + -r2.xx;
  r2.zw = t4.Sample(s4_s, r2.yz).zw;
  r5.xy = float2(0.5,0.5) * cb0[27].zw;
  r5.xz = v0.zw * r5.xx;
  r5.xz = cb0[0].xx * cb0[27].xy + r5.xz;
  r5.xz = r5.xz * r5.yy + -r2.xx;
  r5.xz = t4.Sample(s4_s, r5.xz).zw;
  r2.y = r5.z + r2.z;
  r3.w = dot(r5.zz, r5.xx);
  r2.w = r3.w + r2.w;
  r2.yz = -cb0[28].xx + r2.yz;
  r2.yz = saturate(r2.yz * r0.zz);
  r5.xz = r2.yz * float2(-2,-2) + float2(3,3);
  r2.yz = r2.yz * r2.yz;
  r2.yz = r5.xz * r2.yz;
  r0.z = min(1, r2.z);
  r0.z = r0.y * r0.x + r0.z;
  r2.z = r0.y * r0.x;
  r0.x = -r0.y * r0.x + 1;
  r0.x = max(0, r0.x);
  r0.y = r0.z * r2.z + -cb0[8].x;
  r0.z = r2.z * r0.z;
  o0.w = r0.z;
  r0.y = cmp(r0.y < 0);
  if (r0.y != 0) discard;
  r5.xzw = cb0[24].xyz + -cb0[23].xyz;
  r6.xyz = r2.yyy * r5.xzw + cb0[23].xyz;
  r7.xyzw = t6.Sample(s6_s, v0.xy).xyzw;
  r0.y = dot(r7.xyzw, float4(1,1,1,1));
  r0.z = cmp(0 < r0.y);
  r2.y = cmp(r0.y < 0);
  r0.z = (int)-r0.z + (int)r2.y;
  r0.z = (int)r0.z;
  r2.y = cmp(r0.z != 0.000000);
  r0.z = 9.99999991e-38 * r0.z;
  r0.z = r2.y ? r0.z : 9.99999991e-38;
  r2.y = cmp(9.99999991e-38 < abs(r0.y));
  r0.z = r2.y ? r0.y : r0.z;
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r7.xyzw = r7.xyzw / r0.zzzz;
  r6.w = 1;
  r8.x = dot(cb0[11].xyzw, r6.xyzw);
  r8.y = dot(cb0[12].xyzw, r6.xyzw);
  r8.z = dot(cb0[13].xyzw, r6.xyzw);
  r8.w = dot(cb0[14].xyzw, r6.xyzw);
  r8.x = dot(r8.xyzw, r7.xyzw);
  r9.x = dot(cb0[15].xyzw, r6.xyzw);
  r9.y = dot(cb0[16].xyzw, r6.xyzw);
  r9.z = dot(cb0[17].xyzw, r6.xyzw);
  r9.w = dot(cb0[18].xyzw, r6.xyzw);
  r8.y = dot(r9.xyzw, r7.xyzw);
  r9.x = dot(cb0[19].xyzw, r6.xyzw);
  r9.y = dot(cb0[20].xyzw, r6.xyzw);
  r9.z = dot(cb0[21].xyzw, r6.xyzw);
  r9.w = dot(cb0[22].xyzw, r6.xyzw);
  r8.z = dot(r9.xyzw, r7.xyzw);
  r5.xzw = -r8.xyz + r6.xyz;
  r5.xzw = saturate(r0.yyy * r5.xzw + r8.xyz);
  r6.xyz = cb0[30].xxx * r5.xzw;
  r0.yz = cb0[37].zz * v3.xy;
  r0.yz = cb0[0].xx * cb0[37].xy + r0.yz;
  r0.yz = r0.yz * r5.yy + -r2.xx;
  r0.yz = t4.Sample(s4_s, r0.yz).xy;
  r2.yz = cb0[36].zz * v3.xy;
  r2.yz = cb0[0].xx * cb0[36].xy + r2.yz;
  r2.xy = r2.yz * cb0[36].ww + -r2.xx;
  r2.xy = t4.Sample(s4_s, r2.xy).xy;
  r0.yz = r2.yx + r0.zy;
  r0.yz = -cb0[38].xx + r0.yz;
  r2.x = cb0[39].x + -cb0[38].x;
  r2.x = 1 / r2.x;
  r0.yz = saturate(r2.xx * r0.yz);
  r2.xy = r0.yz * float2(-2,-2) + float2(3,3);
  r0.yz = r0.yz * r0.yz;
  r0.yz = r2.xy * r0.yz;
  r0.y = cb0[40].x * r0.y;
  r0.z = cb0[42].x * r0.z;
  r2.xyz = t5.Sample(s5_s, v0.xy).xyz;
  r0.y = r2.x * r0.y;
  r7.xyzw = t2.Sample(s2_s, v0.xy).xyzw;
  r4.w = dot(r7.xyzw, float4(1,1,1,1));
  r5.y = cmp(0 < r4.w);
  r6.w = cmp(r4.w < 0);
  r5.y = (int)-r5.y + (int)r6.w;
  r5.y = (int)r5.y;
  r6.w = cmp(r5.y != 0.000000);
  r5.y = 9.99999991e-38 * r5.y;
  r5.y = r6.w ? r5.y : 9.99999991e-38;
  r6.w = cmp(9.99999991e-38 < abs(r4.w));
  r5.y = r6.w ? r4.w : r5.y;
  r4.w = min(1, r4.w);
  r4.w = 1 + -r4.w;
  r7.xyzw = r7.xyzw / r5.yyyy;
  r8.xyz = cb0[35].xyz;
  r8.w = 1;
  r9.x = dot(cb0[11].xyzw, r8.xyzw);
  r9.y = dot(cb0[12].xyzw, r8.xyzw);
  r9.z = dot(cb0[13].xyzw, r8.xyzw);
  r9.w = dot(cb0[14].xyzw, r8.xyzw);
  r9.x = dot(r9.xyzw, r7.xyzw);
  r10.x = dot(cb0[15].xyzw, r8.xyzw);
  r10.y = dot(cb0[16].xyzw, r8.xyzw);
  r10.z = dot(cb0[17].xyzw, r8.xyzw);
  r10.w = dot(cb0[18].xyzw, r8.xyzw);
  r9.y = dot(r10.xyzw, r7.xyzw);
  r10.x = dot(cb0[19].xyzw, r8.xyzw);
  r10.y = dot(cb0[20].xyzw, r8.xyzw);
  r10.z = dot(cb0[21].xyzw, r8.xyzw);
  r10.w = dot(cb0[22].xyzw, r8.xyzw);
  r9.z = dot(r10.xyzw, r7.xyzw);
  r8.xyz = cb0[35].xyz + -r9.xyz;
  r8.xyz = r4.www * r8.xyz + r9.xyz;
  r9.xyz = r8.xyz * r0.yyy;
  r8.xyz = cb0[41].xxx + r8.xyz;
  r9.xyz = r9.xyz + r9.xyz;
  r0.y = r3.w * r2.y;
  r10.xyz = r6.xyz * r0.yyy + -r9.xyz;
  r9.xyz = r3.www * r10.xyz + r9.xyz;
  r10.xyz = r5.xzw * cb0[30].xxx + -r9.xyz;
  r0.y = saturate(r0.w);
  r0.y = 1 + -r0.y;
  r11.xy = cmp(float2(9.99999991e-38,0) < r0.yy);
  r2.y = (int)-r11.y;
  r3.w = cmp(r2.y != 0.000000);
  r2.y = 9.99999991e-38 * r2.y;
  r2.y = r3.w ? r2.y : 9.99999991e-38;
  r0.y = r11.x ? r0.y : r2.y;
  r11.xy = cmp(float2(9.99999991e-38,0) < abs(r0.yy));
  r2.y = (int)-r11.y;
  r3.w = cmp(r2.y != 0.000000);
  r2.y = 9.99999991e-38 * r2.y;
  r2.y = r3.w ? r2.y : 9.99999991e-38;
  r0.y = r11.x ? abs(r0.y) : r2.y;
  r2.y = rsqrt(r0.y);
  r0.y = log2(r0.y);
  r0.y = cb0[45].x * r0.y;
  r0.y = exp2(r0.y);
  r2.y = 1 / r2.y;
  r2.y = saturate(r2.w * r2.y);
  r2.w = -cb0[43].x + r2.w;
  r9.xyz = r2.yyy * r10.xyz + r9.xyz;
  r5.xyz = -r5.xzw * cb0[30].xxx + r9.xyz;
  r2.y = cb0[44].x + -cb0[43].x;
  r2.y = 1 / r2.y;
  r2.y = saturate(r2.w * r2.y);
  r2.w = r2.y * -2 + 3;
  r2.y = r2.y * r2.y;
  r2.y = r2.w * r2.y;
  r2.y = min(1, r2.y);
  r2.y = 1 + -r2.y;
  r5.xyz = r2.yyy * r5.xyz + r6.xyz;
  r2.y = cb0[46].x * r0.y;
  r10.xyz = r5.xyz * r2.yyy;
  r11.xyz = r2.yyy * r6.xyz;
  r6.xyz = r6.xyz * r0.xxx;
  r10.xyz = r10.xyz * r2.zzz;
  r10.xyz = r10.xyz + r10.xyz;
  r11.xyz = r11.xyz * r2.zzz + -r10.xyz;
  r10.xyz = cb0[47].xxx * r11.xyz + r10.xyz;
  r0.x = r0.y + r0.w;
  r10.xyz = saturate(r10.xyz * r0.xxx);
  r2.yzw = r10.xyz * r2.zzz;
  r0.x = r2.x * r0.z;
  r0.xzw = r8.xyz * r0.xxx;
  r0.xzw = r0.xzw * float3(2,2,2) + r9.xyz;
  r5.xyz = r5.xyz + -r0.xzw;
  r0.xyz = r0.yyy * r5.xyz + r0.xzw;
  r0.xyz = r0.xyz * r2.xxx + r2.yzw;
  r2.xyz = t3.Sample(s3_s, v0.xy).xyz;
  r5.xyz = r2.xyz * cb0[48].xxx + -r0.xyz;
  r0.w = max(r2.x, r2.y);
  r0.w = saturate(max(r0.w, r2.z));
  r0.w = cb0[48].x * r0.w;
  r0.xyz = r0.www * r5.xyz + r0.xyz;
  r0.xyz = r6.xyz * float3(2,2,2) + r0.xyz;
  r2.xy = t15.SampleLevel(s15_s, v2.xy, 0).xy;
  r0.w = -r2.x * r2.x + r2.y;
  r0.w = max(0, r0.w);
  r0.w = 4.99999987e-06 + r0.w;
  r0.w = min(1, r0.w);
  r2.y = -v2.z + r2.x;
  r2.x = cmp(v2.z < r2.x);
  r2.x = r2.x ? 1.000000 : 0;
  r2.y = r2.y * r2.y + r0.w;
  r0.w = r0.w / r2.y;
  r0.w = -0.400000006 + r0.w;
  r0.w = saturate(1.66666663 * r0.w);
  r0.w = max(r2.x, r0.w);
  r2.x = 1 + -r0.w;
  r2.y = saturate(v2.w * cb0[1].x + cb0[1].y);
  r0.w = r2.y * r2.x + r0.w;
  r2.x = 1 + -r0.w;
  r2.y = 1 + cb0[7].w;
  r2.x = -r2.x * r2.y + 1;
  r2.y = 1 + -cb0[7].w;
  r0.w = r2.y * r0.w;
  r2.y = cmp(cb0[7].w >= 0);
  r0.w = r2.y ? r0.w : r2.x;
  r1.w = 1;
  r2.x = dot(r1.xyzw, cb0[2].xyzw);
  r2.y = dot(r1.xyzw, cb0[3].xyzw);
  r2.z = dot(r1.xyzw, cb0[4].xyzw);
  r1.w = saturate(dot(r1.xyzw, cb0[5].xyzw));
  r5.xyz = cb0[6].xyz * r1.www;
  r2.xyz = v7.xyz + r2.xyz;
  r2.xyz = r5.xyz * r0.www + r2.xyz;
  r0.w = max(0.5, r0.w);
  r5.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r6.xyz = r5.xyz;
  r6.w = 1;
  r8.x = dot(cb0[11].xyzw, r6.xyzw);
  r8.y = dot(cb0[12].xyzw, r6.xyzw);
  r8.z = dot(cb0[13].xyzw, r6.xyzw);
  r8.w = dot(cb0[14].xyzw, r6.xyzw);
  r5.x = dot(r8.xyzw, r7.xyzw);
  r8.x = dot(cb0[15].xyzw, r6.xyzw);
  r8.y = dot(cb0[16].xyzw, r6.xyzw);
  r8.z = dot(cb0[17].xyzw, r6.xyzw);
  r8.w = dot(cb0[18].xyzw, r6.xyzw);
  r5.y = dot(r8.xyzw, r7.xyzw);
  r8.x = dot(cb0[19].xyzw, r6.xyzw);
  r8.y = dot(cb0[20].xyzw, r6.xyzw);
  r8.z = dot(cb0[21].xyzw, r6.xyzw);
  r8.w = dot(cb0[22].xyzw, r6.xyzw);
  r5.z = dot(r8.xyzw, r7.xyzw);
  r6.xyz = r6.xyz + -r5.xyz;
  r5.xyz = r4.www * r6.xyz + r5.xyz;
  r1.w = -0.5 + r5.w;
  r1.w = saturate(r1.w + r1.w);
  r2.xyz = r5.xyz * r2.xyz;
  r5.xyz = r5.xyz * float3(0.600000024,0.600000024,0.600000024) + float3(-0.300000012,-0.300000012,-0.300000012);
  r5.xyz = cb0[49].xxx * r5.xyz + float3(0.5,0.5,0.5);
  r2.w = dot(-r4.xyz, r1.xyz);
  r2.w = r2.w + r2.w;
  r4.xyz = r1.xyz * -r2.www + -r4.xyz;
  r2.w = -2000 + w1.x;
  r2.w = saturate(-0.000500000024 * r2.w);
  r3.w = r2.w * -2 + 3;
  r2.w = r2.w * r2.w;
  r2.w = r3.w * r2.w;
  r2.w = -r2.w * r1.w + 1;
  r2.w = max(0, r2.w);
  r2.w = 4 * r2.w;
  r6.xyzw = t13.SampleLevel(s13_s, r4.xyz, r2.w).xyzw;
  r4.xyz = r6.xyz / r6.www;
  r4.xyz = r4.xyz * r4.xyz;
  r4.xyz = cb0[51].xyz * r4.xyz;
  r4.xyz = r4.xyz * r5.xyz;
  r4.xyz = r4.xyz * float3(2,2,2) + -r2.xyz;
  r2.w = cb0[51].w * r1.w;
  r6.xyz = cb0[50].xyz * r1.www;
  r5.xyz = r6.xyz * r5.xyz;
  r2.xyz = r2.www * r4.xyz + r2.xyz;
  r0.xyz = r2.xyz + r0.xyz;
  r2.xyz = r5.xyz + r5.xyz;
  r2.w = 1;
  r6.x = dot(cb0[11].xyzw, r2.xyzw);
  r6.y = dot(cb0[12].xyzw, r2.xyzw);
  r6.z = dot(cb0[13].xyzw, r2.xyzw);
  r6.w = dot(cb0[14].xyzw, r2.xyzw);
  r4.x = dot(r6.xyzw, r7.xyzw);
  r6.x = dot(cb0[15].xyzw, r2.xyzw);
  r6.y = dot(cb0[16].xyzw, r2.xyzw);
  r6.z = dot(cb0[17].xyzw, r2.xyzw);
  r6.w = dot(cb0[18].xyzw, r2.xyzw);
  r4.y = dot(r6.xyzw, r7.xyzw);
  r6.x = dot(cb0[19].xyzw, r2.xyzw);
  r6.y = dot(cb0[20].xyzw, r2.xyzw);
  r6.z = dot(cb0[21].xyzw, r2.xyzw);
  r6.w = dot(cb0[22].xyzw, r2.xyzw);
  r4.z = dot(r6.xyzw, r7.xyzw);
  r2.xyz = r5.xyz * float3(2,2,2) + -r4.xyz;
  r2.xyz = r4.www * r2.xyz + r4.xyz;
  r2.xyz = cb0[6].xyz * r2.xyz;
  r1.w = dot(r3.xyz, r3.xyz);
  r1.w = rsqrt(r1.w);
  r3.xyz = r3.xyz * r1.www;
  r1.x = dot(r1.xyz, r3.xyz);
  r1.x = max(9.99999975e-05, r1.x);
  r1.x = log2(r1.x);
  r1.x = cb0[50].w * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 0.5 * r1.x;
  r1.xyz = r2.xyz * r1.xxx;
  o0.xyz = r1.xyz * r0.www + r0.xyz;
		o0.a = saturate(o0.a);
  return;
}