// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 31 17:05:34 2024
Texture2D<float4> t14 : register(t14);

TextureCube<float4> t13 : register(t13);

Texture2D<float4> t12 : register(t12);

Texture2D<float4> t10 : register(t10);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s13_s : register(s13);

SamplerState s12_s : register(s12);

SamplerState s10_s : register(s10);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[32];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : SV_POSITION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[6].xx + v2.xy;
  r0.xy = cb0[0].xy * r0.xy;
  r0.z = t14.Sample(s14_s, r0.xy).w;
  r0.z = 127.811859 * r0.z;
  r0.w = cmp(r0.z >= -r0.z);
  r0.z = frac(abs(r0.z));
  r0.z = r0.w ? r0.z : -r0.z;
  r0.z = cmp(0.5 < r0.z);
  if (r0.z != 0) discard;
  r0.z = t12.Sample(s12_s, r0.xy).x;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r1.xy = t10.Sample(s10_s, float2(0.0625,0.5)).xy;
  r0.w = cb0[0].w * r0.z + -r1.y;
  r0.w = r1.x * r0.w;
  r1.x = cb0[0].w * r0.z;
  r0.w = r0.w / r1.x;
  r1.x = r0.x * 1 + -r0.w;
  r0.x = -1 * r0.y;
  r1.y = cb0[6].z * r0.x;
  r2.x = cb0[2].y;
  r2.y = cb0[3].y;
  r2.z = cb0[4].y;
  r2.w = cb0[5].y;
  r0.x = cb0[0].z + -cb0[0].w;
  r0.x = r0.x * r0.z;
  r0.y = -cb0[0].w * r0.z + cb0[0].z;
  r1.z = r0.y / r0.x;
  r1.w = 1;
  r0.x = dot(r1.xyzw, r2.xyzw);
  r0.y = -r0.x;
  r2.x = cb0[2].w;
  r2.y = cb0[3].w;
  r2.z = cb0[4].w;
  r2.w = cb0[5].w;
  r0.w = dot(r1.xyzw, r2.xyzw);
  r0.w = r0.w + r0.w;
  r2.x = cb0[2].x;
  r2.y = cb0[3].x;
  r2.z = cb0[4].x;
  r2.w = cb0[5].x;
  r0.x = dot(r1.xyzw, r2.xyzw);
  r2.x = cb0[2].z;
  r2.y = cb0[3].z;
  r2.z = cb0[4].z;
  r2.w = cb0[5].z;
  r0.z = dot(r1.xyzw, r2.xyzw);
  r0.xyz = r0.xyz / r0.www;
  r0.xyz = r0.xyz / cb0[11].xxx;
  r0.z = max(abs(r0.y), abs(r0.z));
  r0.z = max(abs(r0.x), r0.z);
  r1.xy = saturate(float2(0.5,0.5) + r0.xy);
  r0.x = r0.z + r0.z;
  r0.x = floor(r0.x);
  r0.x = 1 + -r0.x;
  r2.x = 0.00999999978 + r1.x;
  r2.yzw = cb0[1].xxx * float3(0.00499999989,-0.0799999982,-0.00499999989) + r1.yyy;
  r0.yz = float2(0.5,0.5) * r2.xy;
  r3.xyzw = t3.Sample(s3_s, r0.yz).xyzw;
  r0.yzw = r3.xyz * r3.www;
  r2.y = r1.x;
  r3.xyzw = float4(0.5,0.5,0.5,0.5) * r2.yzyw;
  r4.xyzw = t3.Sample(s3_s, r3.zw).xyzw;
  r2.z = t3.Sample(s3_s, r3.xy).z;
  r3.xyz = r4.xyz * r4.www;
  r3.xyz = float3(8,8,8) * r3.xyz;
  r0.yzw = r3.xyz * r0.yzw;
  r0.yzw = r0.yzw * float3(8,8,8) + float3(0.00784313958,0.00784313958,0.00784313958);
  r3.xy = cmp(float2(9.99999991e-38,0) < abs(r2.zz));
  r2.w = (int)-r3.y;
  r3.y = cmp(r2.w != 0.000000);
  r2.w = 9.99999991e-38 * r2.w;
  r2.w = r3.y ? r2.w : 9.99999991e-38;
  r2.z = r3.x ? abs(r2.z) : r2.w;
  r2.z = log2(r2.z);
  r2.z = 7 * r2.z;
  r2.z = exp2(r2.z);
  r0.yzw = r2.zzz * r0.yzw;
  r2.zw = float2(-0.0500000007,-0.00999999978) * cb0[12].xx;
  r1.zw = cb0[1].xx * r2.zw + r1.yy;
  r3.xyzw = r1.xzxw + r1.xzxw;
  r1.zw = cb0[10].xx * r3.xy;
  r1.zw = t4.Sample(s4_s, r1.zw).xy;
  r1.zw = r1.zw * float2(2,2) + float2(-1,-1);
  r1.zw = r1.zw * float2(0.800000012,0.800000012) + r3.zw;
  r1.zw = cb0[10].xx * r1.zw;
  r1.z = t2.Sample(s2_s, r1.zw).z;
  r1.z = saturate(r1.z);
  r0.yzw = r1.zzz * r0.yzw;
  r1.w = cb0[9].x * r1.z + 1;
  r1.z = cb0[9].x * r1.z;
  r1.w = saturate(0.333333343 * r1.w);
  r2.z = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r1.w = r2.z * r1.w;
  r0.yzw = r0.yzw * cb0[30].xxx + r1.www;
  r1.w = -0.0500000007 * cb0[19].x;
  r2.x = cb0[1].x * r1.w + r1.y;
  r2.xy = cb0[20].xx * r2.yx;
  r2.xy = t4.Sample(s4_s, r2.xy).xy;
  r2.xyzw = r2.yyxx * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r2.xyzw = cb0[18].xxxx * r2.xyzw + r1.yyxx;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r2.xyzw = cb0[17].wwzz * r2.xyzw + cb0[17].yyxx;
  r2.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r2.xyzw;
  r3.xyzw = cb0[22].xyzw * cb0[1].xxxx + cb0[21].xyzw;
  sincos(r3.xyzw, r3.xyzw, r4.xyzw);
  r5.xyzw = r3.xyzw * r2.yyyy;
  r5.xyzw = r2.wwww * r4.xyzw + -r5.xyzw;
  r5.xyzw = float4(0.5,0.5,0.5,0.5) + r5.zxwy;
  r6.xz = r5.yw;
  r4.xyzw = r4.xyzw * r2.yyyy;
  r3.xyzw = r2.wwww * r3.xyzw + r4.xyzw;
  r3.xyzw = float4(0.5,0.5,0.5,0.5) + r3.xyzw;
  r6.yw = r3.xy;
  r5.yw = r3.zw;
  r1.w = t0.Sample(s0_s, r6.xy).x;
  r3.x = t0.Sample(s0_s, r6.zw).y;
  r1.w = r3.x + r1.w;
  r3.x = t0.Sample(s0_s, r5.xy).z;
  r3.y = t0.Sample(s0_s, r5.zw).w;
  r1.w = r3.x + r1.w;
  r1.w = r1.w + r3.y;
  r3.x = cb0[1].x * cb0[23].x + cb0[24].x;
  r3.y = cb0[25].x * cb0[1].x + cb0[24].y;
  sincos(r3.xy, r3.xy, r4.xy);
  r3.xyzw = r3.xyxy * r2.xyzw;
  r2.xz = r2.ww * r4.xy + -r3.xy;
  r2.yw = r2.yy * r4.xy + r3.zw;
  r3.xyzw = float4(0.5,0.5,0.5,0.5) + r2.xzyw;
  r2.x = t1.Sample(s1_s, r3.yw).x;
  r2.yz = t1.Sample(s1_s, r3.xz).yz;
  r2.x = r2.x + r2.y;
  r1.w = r1.w * r2.z + r2.x;
  r2.x = -0.100000001 + cb0[26].x;
  r1.w = -r2.x + r1.w;
  r2.y = 0.200000003 + cb0[27].x;
  r2.x = r2.y + -r2.x;
  r2.x = 1 / r2.x;
  r1.w = saturate(r2.x * r1.w);
  r2.x = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r2.y = saturate(1 + -cb0[28].x);
  r1.w = r2.x * r1.w + -r2.y;
  r2.x = 1 + -r2.y;
  r2.yz = cmp(float2(9.99999991e-38,0) < r2.xx);
  r2.z = (int)-r2.z;
  r2.w = cmp(r2.z != 0.000000);
  r2.z = 9.99999991e-38 * r2.z;
  r2.z = r2.w ? r2.z : 9.99999991e-38;
  r2.x = r2.y ? r2.x : r2.z;
  r1.w = saturate(r1.w / r2.x);
  r1.w = cb0[29].x * r1.w;
  r2.xyw = r1.www * r0.zwy;
  r0.yz = cmp(float2(9.99999991e-38,0) < abs(r1.zz));
  r0.z = (int)-r0.z;
  r0.w = cmp(r0.z != 0.000000);
  r0.z = 9.99999991e-38 * r0.z;
  r0.z = r0.w ? r0.z : 9.99999991e-38;
  r0.y = r0.y ? abs(r1.z) : r0.z;
  r0.y = 1.1178329 * r0.y;
  r0.y = cos(r0.y);
  r0.z = 1 + -r0.y;
  r0.y = r0.z * 1.73205078 + r0.y;
  r0.y = 0.898088992 + r0.y;
  r0.z = dot(float3(0.211999997,-0.523000002,0.31099999), cb0[8].xyz);
  r0.w = dot(float3(0.596000016,-0.275000006,-0.32100001), cb0[8].xyz);
  r1.z = max(abs(r0.z), abs(r0.w));
  r1.z = 1 / r1.z;
  r1.w = min(abs(r0.z), abs(r0.w));
  r1.z = r1.w * r1.z;
  r1.w = r1.z * r1.z;
  r3.x = r1.w * 0.0208350997 + -0.0851330012;
  r3.x = r1.w * r3.x + 0.180141002;
  r3.x = r1.w * r3.x + -0.330299497;
  r1.w = r1.w * r3.x + 0.999866009;
  r3.x = r1.z * r1.w;
  r3.x = r3.x * -2 + 1.57079637;
  r3.y = cmp(abs(r0.w) < abs(r0.z));
  r3.x = r3.y ? r3.x : 0;
  r1.z = r1.z * r1.w + r3.x;
  r1.w = cmp(r0.w < -r0.w);
  r1.w = r1.w ? -3.141593 : 0;
  r1.z = r1.z + r1.w;
  r1.w = min(r0.z, r0.w);
  r1.w = cmp(r1.w < -r1.w);
  r3.x = max(r0.z, r0.w);
  r0.z = r0.z * r0.z;
  r0.z = r0.w * r0.w + r0.z;
  r0.z = sqrt(r0.z);
  r0.z = cb0[13].x * r0.z;
  r0.w = cmp(r3.x >= -r3.x);
  r0.w = r0.w ? r1.w : 0;
  r0.w = r0.w ? -r1.z : r1.z;
  r0.y = r0.y * 6.28310013 + r0.w;
  sincos(r0.y, r3.x, r4.x);
  r4.y = r4.x * r0.z;
  r4.z = r3.x * r0.z;
  r4.x = dot(float3(0.298999995,0.587000012,0.114), cb0[8].xyz);
  r3.x = dot(float3(1,0.95599997,0.620999992), r4.xyz);
  r3.y = dot(float3(1,-0.272000015,-0.647000015), r4.xyz);
  r3.z = dot(float3(1,-1.10500002,1.70000005), r4.xyz);
  r0.yzw = -cb0[8].xyz + r3.xyz;
  r0.yzw = cb0[14].xxx * r0.yzw + cb0[8].xyz;
  r3.xyzw = t13.SampleLevel(s13_s, v0.xyz, cb0[16].x).xyzw;
  r4.xyz = r3.xyz / r3.www;
  r4.xyz = r4.xyz * r4.xyz;
  r3.xyz = r4.xyz * r0.yzw;
  r0.yzw = saturate(r0.yzw);
  r3.xyzw = saturate(cb0[15].xxxx * r3.xyzw);
  r3.xyz = r3.xyz + -r0.yzw;
  r0.yzw = r3.www * r3.xyz + r0.yzw;
  r2.xyz = r0.yzw * r2.wxy;
  r3.xyzw = cmp(float4(9.99999991e-38,0,9.99999991e-38,0) < abs(r1.xxyy));
  r0.yz = (int2)-r3.yw;
  r1.zw = cmp(r0.yz != float2(0,0));
  r0.yz = float2(9.99999991e-38,9.99999991e-38) * r0.yz;
  r0.yz = r1.zw ? r0.yz : float2(9.99999991e-38,9.99999991e-38);
  r0.yz = r3.xz ? abs(r1.xy) : r0.yz;
  r0.yz = r0.yz * r0.yz;
  r0.y = r0.y + r0.z;
  r0.y = 1 + -r0.y;
  r0.xy = max(float2(0,0), r0.xy);
  r0.zw = cmp(float2(9.99999991e-38,0) < r0.yy);
  r0.w = (int)-r0.w;
  r1.x = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.x ? r0.w : 9.99999991e-38;
  r0.y = r0.z ? r0.y : r0.w;
  r0.y = log2(r0.y);
  r0.y = cb0[31].x * r0.y;
  r0.y = exp2(r0.y);
  r1.xyzw = r2.xyzw * r0.yyyy;
  r1.w = r1.w * r0.x;
  r0.x = 1 + -v1.w;
  o0.xyzw = r1.xyzw * r0.xxxx;
  
	o0.a = saturate(o0.a);
  return;
}