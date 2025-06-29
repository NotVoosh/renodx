Texture2D<float4> t15 : register(t15);
TextureCube<float4> t13 : register(t13);
Texture2D<float4> t5 : register(t5);
Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s15_s : register(s15);
SamplerState s13_s : register(s13);
SamplerState s5_s : register(s5);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[48];
}

#define cmp -

void main(
  float2 v0 : TEXCOORD0,
  float w0 : TEXCOORD1,
  float4 v1 : TEXCOORD2,
  float4 v2 : TEXCOORD3,
  float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[19].xy * cb0[1].xx;
  r0.xy = cb0[19].ww * r0.xy;
  r0.zw = v5.xy * float2(0.0299999993,-0.0299999993) + r0.xy;
  r1.xyzw = v5.yzxz * float4(0.0299999993,0.0299999993,0.0299999993,0.0299999993) + r0.xyxy;
  r0.xy = t3.Sample(s3_s, r0.zw).zw;
  r0.zw = t3.Sample(s3_s, r1.xy).zw;
  r1.xy = t3.Sample(s3_s, r1.zw).zw;
  r2.xyz = float3(-0.200000003,-0.200000003,-0.200000003) + abs(v6.xyz);
  r2.xyz = float3(7,7,7) * r2.xyz;
  r2.xyz = max(float3(9.99999991e-38,9.99999991e-38,9.99999991e-38), r2.xyz);
  r1.z = r2.x + r2.y;
  r1.z = r1.z + r2.z;
  r2.xyz = r2.xyz / r1.zzz;
  r1.xy = r2.yy * r1.xy;
  r0.zw = r0.zw * r2.xx + r1.xy;
  r0.xy = r0.xy * r2.zz + r0.zw;
  r0.zw = cb0[1].xx * cb0[20].xy + cb0[20].zz;
  r0.zw = cb0[20].ww * r0.zw;
  r1.xyzw = v5.yzxz * float4(0.0299999993,0.0299999993,0.0299999993,0.0299999993) + r0.zwzw;
  r0.zw = v5.xy * float2(0.0299999993,-0.0299999993) + r0.zw;
  r0.zw = t3.Sample(s3_s, r0.zw).zw;
  r1.zw = t3.Sample(s3_s, r1.zw).zw;
  r1.xy = t3.Sample(s3_s, r1.xy).zw;
  r1.zw = r1.zw * r2.yy;
  r1.xy = r1.xy * r2.xx + r1.zw;
  r0.zw = r0.zw * r2.zz + r1.xy;
  r0.x = r0.x + r0.w;
  r0.z = dot(r0.ww, r0.zz);
  r1.xyz = t0.Sample(s0_s, cb0[23].xy).xyz;
  r1.xyz = -cb0[22].xyz + r1.xyz;
  r1.xyz = cb0[17].xxx * r1.xyz + cb0[22].xyz;
  r0.w = dot(r1.xyz, float3(0.300000012,0.589999974,0.109999999));
  r1.xyz = r1.xyz + -r0.www;
  r1.xyz = cb0[24].xxx * r1.xyz + r0.www;
  r2.xyz = r1.xyz * r0.xxx;
  r0.w = saturate(1 + -r0.x);
  r3.xyz = t0.Sample(s0_s, cb0[16].xy).xyz;
  r4.xyz = -cb0[15].xyz + r3.xyz;
  r4.xyz = cb0[17].xxx * r4.xyz + cb0[15].xyz;
  r1.w = dot(r4.xyz, float3(0.300000012,0.589999974,0.109999999));
  r3.xyz = r3.xyz + -r1.www;
  r3.xyz = cb0[18].xxx * r3.xyz + r1.www;
  r5.xyz = r3.xyz * r0.www;
  r5.xyz = r5.xyz + r5.xyz;
  r6.xyz = r3.xyz * r0.zzz + -r5.xyz;
  r5.xyz = r0.zzz * r6.xyz + r5.xyz;
  r5.xyz = cb0[21].xxx * r5.xyz;
  r2.xyz = r2.xyz * cb0[25].xxx + -r5.xyz;
  r0.y = r0.z + r0.y;
  r6.xy = t1.Sample(s1_s, v0.xy).xy;
  r6.xy = r6.xy * float2(2,2) + float2(-1,-1);
  r0.w = dot(r6.xy, r6.xy);
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r6.z = sqrt(r0.w);
  r0.w = dot(r6.xyz, r6.xyz);
  r0.w = rsqrt(r0.w);
  r6.xyz = r6.xyz * r0.www;
  r7.xyz = v3.xyz * r6.yyy;
  r6.xyw = r6.xxx * v4.xyz + r7.xyz;
  r6.xyz = r6.zzz * v6.xyz + r6.xyw;
  r0.w = dot(r6.xyz, r6.xyz);
  r0.w = sqrt(r0.w);
  r7.xy = cmp(float2(9.99999991e-38,0) < r0.ww);
  r1.w = (int)-r7.y;
  r2.w = cmp(r1.w != 0.000000);
  r1.w = 9.99999991e-38 * r1.w;
  r1.w = r2.w ? r1.w : 9.99999991e-38;
  r0.w = r7.x ? r0.w : r1.w;
  r6.xyz = r6.xyz / r0.www;
  r0.w = dot(r6.xyz, r6.xyz);
  r0.w = sqrt(r0.w);
  r7.xy = cmp(float2(9.99999991e-38,0) < r0.ww);
  r1.w = (int)-r7.y;
  r2.w = cmp(r1.w != 0.000000);
  r1.w = 9.99999991e-38 * r1.w;
  r1.w = r2.w ? r1.w : 9.99999991e-38;
  r0.w = r7.x ? r0.w : r1.w;
  r7.xyz = r6.xyz / r0.www;
  r8.x = v4.w;
  r8.y = v3.w;
  r8.z = v6.w;
  r0.w = dot(r8.xyz, r8.xyz);
  r0.w = rsqrt(r0.w);
  r9.xyz = r8.xyz * r0.www;
  r1.w = dot(r7.xyz, r9.xyz);
  r2.w = saturate(r1.w);
  r1.w = cb0[31].x * r1.w;
  r2.w = 1 + -r2.w;
  r7.xy = cmp(float2(9.99999991e-38,0) < r2.ww);
  r3.w = (int)-r7.y;
  r4.w = cmp(r3.w != 0.000000);
  r3.w = 9.99999991e-38 * r3.w;
  r3.w = r4.w ? r3.w : 9.99999991e-38;
  r2.w = r7.x ? r2.w : r3.w;
  r7.xy = cmp(float2(9.99999991e-38,0) < abs(r2.ww));
  r3.w = (int)-r7.y;
  r4.w = cmp(r3.w != 0.000000);
  r3.w = 9.99999991e-38 * r3.w;
  r3.w = r4.w ? r3.w : 9.99999991e-38;
  r2.w = r7.x ? abs(r2.w) : r3.w;
  r3.w = rsqrt(r2.w);
  r2.w = log2(r2.w);
  r2.w = cb0[36].x * r2.w;
  r2.w = exp2(r2.w);
  r3.w = 1 / r3.w;
  r3.w = saturate(r3.w * r0.y);
  r0.y = saturate(r0.y);
  r2.xyz = r3.www * r2.xyz + r5.xyz;
  r5.xyz = t0.Sample(s0_s, cb0[27].xy).xyz;
  r5.xyz = -cb0[26].xyz + r5.xyz;
  r5.xyz = cb0[17].xxx * r5.xyz + cb0[26].xyz;
  r3.w = dot(r5.xyz, float3(0.300000012,0.589999974,0.109999999));
  r5.xyz = r5.xyz + -r3.www;
  r5.xyz = cb0[28].xxx * r5.xyz + r3.www;
  r5.xyz = cb0[29].xxx + r5.xyz;
  r3.w = saturate(1 + -cb0[1].z);
  r3.w = 1 + -r3.w;
  r3.w = r3.w + -r0.z;
  r7.xyz = r3.xyz * r0.zzz;
  r0.z = 1 + -abs(r3.w);
  r10.xy = cb0[30].zz * v2.xy;
  r10.xy = cb0[1].xx * cb0[30].xy + r10.xy;
  r10.xy = r10.xy * cb0[20].ww + -r1.ww;
  r10.xy = t3.Sample(s3_s, r10.xy).xy;
  r10.zw = cb0[32].zz * v2.xy;
  r10.zw = cb0[1].xx * cb0[32].xy + r10.zw;
  r10.zw = r10.zw * cb0[32].ww + -r1.ww;
  r10.zw = t3.Sample(s3_s, r10.zw).xy;
  r10.xyz = r10.yxy + r10.zzw;
  r1.w = r10.y + -r10.x;
  r0.z = r0.z * r1.w + r10.x;
  r10.xyz = r10.zzz * r7.xyz;
  r7.xyz = r10.xyz * float3(2,2,2) + r7.xyz;
  r4.xyz = r7.xyz + r4.xyz;
  r0.z = -cb0[33].x + r0.z;
  r1.w = cb0[34].x + -cb0[33].x;
  r1.w = 1 / r1.w;
  r0.z = saturate(r1.w * r0.z);
  r1.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r1.w * r0.z;
  r0.z = cb0[35].x * r0.z;
  r5.xyz = r5.xyz * r0.zzz;
  r2.xyz = r5.xyz * float3(2,2,2) + r2.xyz;
  r5.xyz = r5.xyz + r5.xyz;
  r1.xyz = r1.xyz * r0.xxx + -r4.xyz;
  r0.xyz = r0.yyy * r1.xyz + r4.xyz;
  r1.xyz = r0.xyz + -r2.xyz;
  r1.xyz = r2.www * r1.xyz + r2.xyz;
  r1.w = cb0[37].x * r2.w;
  r0.xyz = r1.www * r0.xyz;
  r0.xyz = r0.xyz * float3(2,2,2) + r1.xyz;
  r1.xyz = t4.Sample(s4_s, v0.xy).xyz;
  r0.xyz = saturate(r1.xyz * r0.xyz);
  r2.xyz = t0.Sample(s0_s, cb0[13].xy).xyz;
  r4.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r2.xyz = -r4.xyz + r2.xyz;
  r2.xyz = cb0[14].xxx * r2.xyz + r4.xyz;
  r0.xyz = -r2.xyz + r0.xyz;
  r0.xyz = saturate(r1.xxx * r0.xyz + r2.xyz);
  r2.xy = t15.SampleLevel(s15_s, v1.xy, 0).xy;
  r1.w = -r2.x * r2.x + r2.y;
  r1.w = max(0, r1.w);
  r1.w = 4.99999987e-06 + r1.w;
  r1.w = min(1, r1.w);
  r2.y = -v1.z + r2.x;
  r2.x = cmp(v1.z < r2.x);
  r2.x = r2.x ? 1.000000 : 0;
  r2.y = r2.y * r2.y + r1.w;
  r1.w = r1.w / r2.y;
  r1.w = -0.400000006 + r1.w;
  r1.w = saturate(1.66666663 * r1.w);
  r1.w = max(r2.x, r1.w);
  r2.x = 1 + -r1.w;
  r2.y = saturate(v1.w * cb0[2].x + cb0[2].y);
  r1.w = r2.y * r2.x + r1.w;
  r2.x = 1 + -r1.w;
  r2.y = 1 + cb0[8].w;
  r2.x = -r2.x * r2.y + 1;
  r2.y = 1 + -cb0[8].w;
  r1.w = r2.y * r1.w;
  r2.y = cmp(cb0[8].w >= 0);
  r1.w = r2.y ? r1.w : r2.x;
  r6.w = 1;
  r2.x = dot(r6.xyzw, cb0[3].xyzw);
  r2.y = dot(r6.xyzw, cb0[4].xyzw);
  r2.z = dot(r6.xyzw, cb0[5].xyzw);
  r2.w = saturate(dot(r6.xyzw, cb0[6].xyzw));
  r7.xyz = cb0[7].xyz * r2.www;
  r2.xyz = v7.xyz + r2.xyz;
  r2.xyz = r7.xyz * r1.www + r2.xyz;
  r0.xyz = r2.xyz * r0.xyz;
  r2.xyz = -v6.xyz + r6.xyz;
  r7.xyz = cb0[45].xxx * r2.xyz + v6.xyz;
  r2.xyz = cb0[43].xxx * r2.xyz + v6.xyz;
  r2.x = dot(r9.xyz, r2.xyz);
  r2.x = 1 + -abs(r2.x);
  r2.x = max(0, r2.x);
  r2.y = dot(-r9.xyz, r7.xyz);
  r2.y = r2.y + r2.y;
  r2.yzw = r7.xyz * -r2.yyy + -r9.xyz;
  r3.w = -2000 + w0.x;
  r3.w = saturate(-0.000500000024 * r3.w);
  r5.w = r3.w * -2 + 3;
  r3.w = r3.w * r3.w;
  r3.w = r5.w * r3.w;
  r4.w = -0.5 + r4.w;
  r4.w = saturate(r4.w + r4.w);
  r5.w = -r3.w * r4.w + 1;
  r3.w = r3.w * -3 + 6;
  r7.xyz = t13.SampleLevel(s13_s, r6.xyz, r3.w).xyz;
  r7.xyz = float3(0.800000012,0.800000012,0.800000012) * r7.xyz;
  r3.w = max(0, r5.w);
  r3.w = 4 * r3.w;
  r9.xyzw = t13.SampleLevel(s13_s, r2.yzw, r3.w).xyzw;
  r2.yzw = r9.xyz / r9.www;
  r2.yzw = r2.yzw * r2.yzw;
  r2.yzw = cb0[46].xyz * r2.yzw;
  r9.xyz = r4.xyz * float3(0.199999988,0.199999988,0.199999988) + float3(0.300000012,0.300000012,0.300000012);
  r9.xyz = r1.xxx * -r9.xyz + r9.xyz;
  r1.xyz = r5.xyz * r1.xyz;
  r2.yzw = r9.xyz * r2.yzw;
  r2.yzw = r2.yzw * float3(2,2,2) + -r0.xyz;
  r5.xyzw = t5.Sample(s5_s, v0.xy).xyzw;
  r3.w = r5.x * r4.w;
  r4.w = r4.w * 0.350000024 + 0.649999976;
  r3.w = cb0[46].w * r3.w;
  r0.xyz = r3.www * r2.yzw + r0.xyz;
  r2.yzw = t0.Sample(s0_s, cb0[39].xy).xyz;
  r2.yzw = -cb0[38].xyz + r2.yzw;
  r2.yzw = cb0[17].xxx * r2.yzw + cb0[38].xyz;
  r3.w = dot(r2.yzw, float3(0.300000012,0.589999974,0.109999999));
  r2.yzw = -r3.www + r2.yzw;
  r2.yzw = cb0[40].xxx * r2.yzw + r3.www;
  r3.w = t2.Sample(s2_s, v0.xy).x;
  r6.w = dot(r3.ww, cb0[41].xx);
  r2.yzw = r2.yzw * r6.www + -r1.xyz;
  r1.xyz = r3.www * r2.yzw + r1.xyz;
  r2.yz = cmp(float2(9.99999991e-38,0) < r2.xx);
  r2.z = (int)-r2.z;
  r2.w = cmp(r2.z != 0.000000);
  r2.z = 9.99999991e-38 * r2.z;
  r2.z = r2.w ? r2.z : 9.99999991e-38;
  r2.x = r2.y ? r2.x : r2.z;
  r2.x = log2(r2.x);
  r2.x = cb0[36].x * r2.x;
  r2.x = exp2(r2.x);
  r2.x = cb0[42].x * r2.x;
  r1.xyz = r3.xyz * r2.xxx + r1.xyz;
  r0.xyz = r1.xyz + r0.xyz;
  r1.x = max(0.5, r1.w);
  r2.xyz = cb0[7].xyz * r5.www;
  r2.xyz = float3(0.5,0.5,0.5) * r2.xyz;
  r1.yzw = r1.www * r2.xyz + r2.xyz;
  r1.yzw = r9.xyz * r1.yzw;
  r1.yzw = r1.yzw * r3.xyz;
  r1.yzw = r1.yzw + r1.yzw;
  r1.yzw = cb0[7].xyz * r1.yzw;
  r2.xyz = r8.xyz * r0.www + cb0[8].xyz;
  r3.xyz = r8.xyz * r0.www + cb0[10].xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(r6.xyz, r2.xyz);
  r0.w = max(9.99999975e-05, r0.w);
  r0.w = log2(r0.w);
  r2.x = cb0[44].x * r5.x;
  r2.yzw = cb0[7].xyz * r5.xyz;
  r2.yzw = cb0[47].xxx * r2.yzw;
  r2.x = max(1, r2.x);
  r0.w = r2.x * r0.w;
  r0.w = exp2(r0.w);
  r0.w = 0.5 * r0.w;
  r1.yzw = r1.yzw * r0.www;
  r0.xyz = r1.yzw * r1.xxx + r0.xyz;
  r1.xyz = r7.xyz * r4.www;
  r1.xyz = r4.xyz * r1.xyz;
  r4.xyz = r7.xyz * r4.www + -r1.xyz;
  r1.xyz = r4.xyz * float3(0.25,0.25,0.25) + r1.xyz;
  r1.xyz = cb0[47].xxx * r1.xyz;
  r0.w = saturate(dot(r6.xyz, cb0[10].xyz));
  r4.xyz = cb0[9].xyz * r0.www;
  r0.xyz = r4.xyz * r1.xyz + r0.xyz;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = r3.xyz * r0.www;
  r0.w = dot(r6.xyz, r1.xyz);
  r0.w = max(9.99999975e-05, r0.w);
  r0.w = log2(r0.w);
  r0.w = r2.x * r0.w;
  r0.w = exp2(r0.w);
  r0.w = 0.5 * r0.w;
  r1.xyz = cb0[9].xyz * r0.www;
  r0.xyz = r1.xyz * r2.yzw + r0.xyz;
  r0.w = 1 + -v8.w;
  o0.xyz = r0.xyz * r0.www + v8.xyz;
  o0.w = cb0[0].x;
  o0 = saturate(o0);
  return;
}