Texture2D<float4> t15 : register(t15);
Texture2D<float4> t14 : register(t14);
TextureCube<float4> t13 : register(t13);
Texture2D<float4> t12 : register(t12);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s15_s : register(s15);
SamplerState s14_s : register(s14);
SamplerState s13_s : register(s13);
SamplerState s12_s : register(s12);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[17];
}

#define cmp -

void main(
  float4 v0 : TEXCOORD0,
  float3 v1 : TEXCOORD1,
  float w1 : TEXCOORD2,
  float4 v2 : TEXCOORD3,
  float4 v3 : TEXCOORD4,
  float4 v4 : TEXCOORD5,
  float4 v5 : TEXCOORD6,
  float4 v6 : TEXCOORD7,
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  float4 v9 : SV_POSITION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = (1.0 / 25.0) * cb0[9].x;
  r1.xyzw = v5.yzxz * r0.xxxx;
  r0.yz = t0.Sample(s0_s, r1.zw).xy;
  r2.xy = r0.yz * float2(2,2) + float2(-1,-1);
  r0.y = dot(r2.xy, r2.xy);
  r0.y = 1 + -r0.y;
  r0.y = max(0, r0.y);
  r2.z = sqrt(r0.y);
  r0.yzw = float3(-0.2,-0.2,-0.2) + abs(v6.xyz);
  r0.yzw = float3(7,7,7) * r0.yzw;
  r0.yzw = max(float3(9.99999991e-38,9.99999991e-38,9.99999991e-38), r0.yzw);
  r2.w = r0.y + r0.z;
  r2.w = r2.w + r0.w;
  r0.yzw = r0.yzw / r2.www;
  r2.xyz = r2.xyz * r0.zzz;
  r3.xy = t0.Sample(s0_s, r1.xy).xy;
  r3.xy = r3.xy * float2(2,2) + float2(-1,-1);
  r2.w = dot(r3.xy, r3.xy);
  r2.w = 1 + -r2.w;
  r2.w = max(0, r2.w);
  r3.z = sqrt(r2.w);
  r2.xyz = r3.xyz * r0.yyy + r2.xyz;
  r3.xy = float2(1,-1) * v5.xy;
  r3.xy = r3.xy * r0.xx;
  r3.zw = t0.Sample(s0_s, r3.xy).xy;
  r4.xyzw = t1.Sample(s1_s, r3.xy).xyzw;
  r3.xy = r3.zw * float2(2,2) + float2(-1,-1);
  r0.x = dot(r3.xy, r3.xy);
  r0.x = 1 + -r0.x;
  r0.x = max(0, r0.x);
  r3.z = sqrt(r0.x);
  r2.xyz = r3.xyz * r0.www + r2.xyz;
  r3.xy = cb0[8].xx * r2.xy;
  r0.x = dot(r2.xyz, r2.xyz);
  r0.x = rsqrt(r0.x);
  r2.xyz = r2.xyz * r0.xxx;
  r5.xyz = v2.xyz * r2.yyy;
  r2.xyw = r2.xxx * v3.xyz + r5.xyz;
  r2.xyz = r2.zzz * v4.xyz + r2.xyw;
  r0.x = dot(r2.xyz, r2.xyz);
  r0.x = sqrt(r0.x);
  r3.zw = cmp(float2(9.99999991e-38,0) < r0.xx);
  r2.w = (int)-r3.w;
  r3.w = cmp(r2.w != 0.000000);
  r2.w = 9.99999991e-38 * r2.w;
  r2.w = r3.w ? r2.w : 9.99999991e-38;
  r0.x = r3.z ? r0.x : r2.w;
  r2.xyz = r2.xyz / r0.xxx;
  r5.x = v3.w;
  r5.y = v2.w;
  r5.z = v4.w;
  r0.x = dot(r5.xyz, r5.xyz);
  r0.x = rsqrt(r0.x);
  r5.xyz = r5.xyz * r0.xxx;
  r0.x = dot(r5.xyz, r5.xyz);
  r0.x = sqrt(r0.x);
  r3.zw = cmp(float2(9.99999991e-38,0) < r0.xx);
  r2.w = (int)-r3.w;
  r3.w = cmp(r2.w != 0.000000);
  r2.w = 9.99999991e-38 * r2.w;
  r2.w = r3.w ? r2.w : 9.99999991e-38;
  r0.x = r3.z ? r0.x : r2.w;
  r6.xyz = r5.xyz / r0.xxx;
  r0.x = saturate(dot(r6.xyz, r2.xyz));
  r0.x = 1 + -r0.x;
  r3.zw = cmp(float2(9.99999991e-38,0) < r0.xx);
  r2.w = (int)-r3.w;
  r3.w = cmp(r2.w != 0.000000);
  r2.w = 9.99999991e-38 * r2.w;
  r2.w = r3.w ? r2.w : 9.99999991e-38;
  r7.w = r3.z ? r0.x : r2.w;
  r0.x = log2(r7.w);
  r0.x = 1.5 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = r0.x * 0.8 + 0.2;
  r3.xy = r0.xx * r3.xy + cb0[8].xx;
  r3.xy = v7.xy * r3.xy;
  r3.zw = float2(0,1) + v9.xy;
  r3.zw = r3.zw * cb0[0].xy + r3.xy;
  r8.w = t12.Sample(s12_s, r3.zw).x;
  r3.zw = v9.xy * cb0[0].xy + r3.xy;
  r8.x = t12.Sample(s12_s, r3.zw).x;
  r9.xyzw = float4(1,0,1,1) + v9.xyxy;
  r9.xyzw = r9.xyzw * cb0[0].xyxy + r3.xyxy;
  r8.y = t12.Sample(s12_s, r9.xy).x;
  r8.z = t12.Sample(s12_s, r9.zw).x;
  r8.xyzw = r8.xyzw * cb0[0].wwww + -cb0[0].zzzz;
  r8.xyzw = cmp(w1.xxxx >= r8.xyzw);
  r3.zw = (int2)r8.zw | (int2)r8.xy;
  r2.w = (int)r3.w | (int)r3.z;
  r3.xy = r2.ww ? float2(0,0) : r3.xy;
  r3.zw = cb0[5].xx + v9.xy;
  r3.xy = saturate(r3.zw * cb0[0].xy + r3.xy);
  r3.xyzw = t14.Sample(s14_s, r3.xy).xyzw;
  r8.xyz = cb0[10].xyz * r3.xyz;
  r8.xyz = r8.xyz + r8.xyz;
  r9.xy = cmp(float2(9.99999991e-38,0) < r0.xx);
  r2.w = (int)-r9.y;
  r5.w = cmp(r2.w != 0.000000);
  r2.w = 9.99999991e-38 * r2.w;
  r2.w = r5.w ? r2.w : 9.99999991e-38;
  r2.w = r9.x ? r0.x : r2.w;
  r2.w = r2.w * r2.w;
  r2.w = r2.w * r2.w;
  r2.w = -r2.w * 0.3 + 1;
  r9.xyz = r8.xyz * r2.www;
  r3.xyz = cb0[2].xyz * r8.xyz;
  r8.xyzw = saturate(r3.xyzw);
  r9.w = r3.w;
  r3.xyzw = -r9.xyzw + r8.xyzw;
  r2.w = dot(-cb0[3].xyz, -cb0[3].xyz);
  r2.w = sqrt(r2.w);
  r8.xy = cmp(float2(9.99999991e-38,0) < r2.ww);
  r5.w = (int)-r8.y;
  r6.w = cmp(r5.w != 0.000000);
  r5.w = 9.99999991e-38 * r5.w;
  r5.w = r6.w ? r5.w : 9.99999991e-38;
  r2.w = r8.x ? r2.w : r5.w;
  r8.xyz = -cb0[3].xyz / r2.www;
  r2.w = dot(r8.xyz, r6.xyz);
  r5.w = dot(r2.xyz, r8.xyz);
  r5.w = 1 + r5.w;
  r5.w = 0.5 * r5.w;
  r2.w = 1 + r2.w;
  r2.w = r2.w * r5.w;
  r2.w = saturate(0.5 * r2.w);
  r3.xyzw = r2.wwww * r3.xyzw + r9.xyzw;
  r2.w = dot(-r5.xyz, r2.xyz);
  r2.w = r2.w + r2.w;
  r5.xyz = r2.xyz * -r2.www + -r5.xyz;
  r5.xyzw = t13.Sample(s13_s, r5.xyz).xyzw;
  r6.xyz = r5.xyz / r5.www;
  r5.xyz = r6.xyz * r6.xyz;
  r5.xyzw = cb0[11].xxxx * r5.xyzw + -r3.xyzw;
  r6.xyzw = t1.Sample(s1_s, r1.zw).xyzw;
  r1.xyzw = t1.Sample(s1_s, r1.xy).xyzw;
  r6.xyzw = r6.xyzw * r0.zzzz;
  r1.xyzw = r1.xyzw * r0.yyyy + r6.xyzw;
  r1.xyzw = r4.xyzw * r0.wwww + r1.xyzw;
  r0.y = saturate(r1.w + r1.w);
  r0.zw = float2(-0.5,0.5) + r1.ww;
  r0.z = saturate(r0.z + r0.z);
  r0.w = saturate(0.285714298 * r0.w);
  r0.y = r0.z + -r0.y;
  r0.y = 1 + r0.y;
  r0.y = min(1, r0.y);
  r0.x = r0.x * r0.y;
  r3.xyzw = r0.xxxx * r5.xyzw + r3.xyzw;
  r0.x = dot(v1.xyz, v1.xyz);
  r0.x = sqrt(r0.x);
  r4.xy = cmp(float2(9.99999991e-38,0) < r0.xx);
  r0.z = (int)-r4.y;
  r1.w = cmp(r0.z != 0.000000);
  r0.z = 9.99999991e-38 * r0.z;
  r0.z = r1.w ? r0.z : 9.99999991e-38;
  r0.x = r4.x ? r0.x : r0.z;
  r4.xyz = v1.xyz / r0.xxx;
  r0.x = saturate(dot(r2.xyz, r4.xyz));
  r4.xy = cmp(float2(9.99999991e-38,0) < r0.xx);
  r0.z = (int)-r4.y;
  r1.w = cmp(r0.z != 0.000000);
  r0.z = 9.99999991e-38 * r0.z;
  r0.z = r1.w ? r0.z : 9.99999991e-38;
  r0.x = r4.x ? r0.x : r0.z;
  r0.x = log2(r0.x);
  r0.x = cb0[12].x * r0.x;
  r0.x = exp2(r0.x);
  r4.xyz = cb0[2].xyz * r0.xxx;
  r0.xz = t15.SampleLevel(s15_s, v0.xy, 0).xy;
  r0.z = -r0.x * r0.x + r0.z;
  r0.z = max(0, r0.z);
  r0.z = 4.99999987e-06 + r0.z;
  r0.z = min(1, r0.z);
  r1.w = -v0.z + r0.x;
  r0.x = cmp(v0.z < r0.x);
  r0.x = r0.x ? 1.000000 : 0;
  r1.w = r1.w * r1.w + r0.z;
  r0.z = r0.z / r1.w;
  r0.z = -0.4 + r0.z;
  r0.z = saturate((1.0 / 0.6) * r0.z);
  r0.x = max(r0.x, r0.z);
  r0.z = 1 + -r0.x;
  r1.w = saturate(v0.w * cb0[1].x + cb0[1].y);
  r0.x = r1.w * r0.z + r0.x;
  r0.z = 1 + -r0.x;
  r1.w = 1 + cb0[3].w;
  r0.z = -r0.z * r1.w + 1;
  r1.w = 1 + -cb0[3].w;
  r0.x = r1.w * r0.x;
  r1.w = cmp(cb0[3].w >= 0);
  r0.x = r1.w ? r0.x : r0.z;
  r4.xyz = r4.xyz * r0.xxx;
  r4.xyz = r4.xyz * r0.yyy;
  r4.xyz = cb0[13].xxx * r4.xyz;
  r4.w = cb0[13].x * cb0[2].w;
  r3.xyzw = r4.xyzw + r3.xyzw;
  r0.y = -cb0[4].x + r3.w;
  r0.y = cmp(r0.y < 0);
  if (r0.y != 0) discard;
  r0.y = r0.w * -2 + 3;
  r0.z = r0.w * r0.w;
  r0.y = r0.y * r0.z;
  r0.y = cb0[14].x * r0.y;
  r0.z = dot(cb0[3].xyz, cb0[3].xyz);
  r0.z = sqrt(r0.z);
  r4.xy = cmp(float2(9.99999991e-38,0) < r0.zz);
  r0.w = (int)-r4.y;
  r1.w = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.w ? r0.w : 9.99999991e-38;
  r0.z = r4.x ? r0.z : r0.w;
  r4.xyz = cb0[3].xyz / r0.zzz;
  r0.z = saturate(dot(r2.xyz, r4.xyz));
  r2.xy = cmp(float2(9.99999991e-38,0) < r0.zz);
  r0.w = (int)-r2.y;
  r1.w = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.w ? r0.w : 9.99999991e-38;
  r0.z = r2.x ? r0.z : r0.w;
  r2.xyz = cb0[2].xyz * r0.zzz;
  r2.xyz = r2.xyz * r0.xxx;
  r0.x = r7.w * r0.x;
  r7.xyz = cb0[15].xyz * r0.xxx;
  r0.xzw = r2.xyz * r1.xyz;
  r0.x = dot(r0.xzw, float3(0.300000012,0.589999974,0.109999999));
  r0.xzw = cb0[14].xxx * r0.xxx + -r3.xyz;
  r0.xyz = r0.yyy * r0.xzw + r3.xyz;
  o0.w = r3.w;
  r1.xyzw = cmp(float4(9.99999991e-38,0,9.99999991e-38,0) < abs(r7.zzww));
  r1.yw = (int2)-r1.yw;
  r2.xy = cmp(r1.yw != float2(0,0));
  r1.yw = float2(9.99999991e-38,9.99999991e-38) * r1.yw;
  r1.yw = r2.xy ? r1.yw : float2(9.99999991e-38,9.99999991e-38);
  r1.xy = r1.xz ? abs(r7.zw) : r1.yw;
  r1.zw = log2(r1.xy);
  r2.xyzw = cmp(float4(9.99999991e-38,0,9.99999991e-38,0) < abs(r7.xxyy));
  r2.yw = (int2)-r2.yw;
  r3.xy = cmp(r2.yw != float2(0,0));
  r2.yw = float2(9.99999991e-38,9.99999991e-38) * r2.yw;
  r2.yw = r3.xy ? r2.yw : float2(9.99999991e-38,9.99999991e-38);
  r2.xy = r2.xz ? abs(r7.xy) : r2.yw;
  r1.xy = log2(r2.xy);
  r1.xyzw = cb0[15].wwww * r1.xyzw;
  r1.xyzw = exp2(r1.xyzw);
  r1.xyz = r1.xyz * cb0[16].xxx + -r0.xyz;
  r0.w = cb0[16].x * r1.w;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  r0.w = 1 + -v8.w;
  o0.xyz = r0.xyz * r0.www + v8.xyz;
  o0.a = saturate(o0.a);
  return;
}