// ---- Created with 3Dmigoto v1.3.16 on Sat Aug 31 16:38:25 2024
TextureCube<float4> t13 : register(t13);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s13_s : register(s13);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[25];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = -0.0500000007 * cb0[12].x;
  r0.y = cb0[0].x * r0.x + v0.y;
  r0.x = v0.x;
  r0.xy = cb0[13].xx * r0.xy;
  r0.xy = t4.Sample(s4_s, r0.xy).xy;
  r0.xyzw = r0.yyxx * float4(2,2,2,2) + float4(-1,-1,-1,-1);
  r0.xyzw = cb0[11].xxxx * r0.xyzw + v0.yyxx;
  r0.xyzw = cb0[10].wwzz * r0.xyzw + cb0[10].yyxx;
  r0.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r0.xyzw;
  r1.xyzw = cb0[15].xyzw * cb0[0].xxxx + cb0[14].xyzw;
  sincos(r1.xyzw, r1.xyzw, r2.xyzw);
  r3.xyzw = r1.xyzw * r0.yyyy;
  r3.xyzw = r0.wwww * r2.xyzw + -r3.xyzw;
  r3.xyzw = float4(0.5,0.5,0.5,0.5) + r3.zxwy;
  r4.xz = r3.yw;
  r2.xyzw = r2.xyzw * r0.yyyy;
  r1.xyzw = r0.wwww * r1.xyzw + r2.xyzw;
  r1.xyzw = float4(0.5,0.5,0.5,0.5) + r1.xyzw;
  r4.yw = r1.xy;
  r3.yw = r1.zw;
  r1.x = t0.Sample(s0_s, r4.xy).x;
  r1.y = t0.Sample(s0_s, r4.zw).y;
  r1.x = r1.x + r1.y;
  r1.y = t0.Sample(s0_s, r3.xy).z;
  r1.z = t0.Sample(s0_s, r3.zw).w;
  r1.x = r1.x + r1.y;
  r1.x = r1.x + r1.z;
  r2.x = cb0[0].x * cb0[16].x + cb0[17].x;
  r2.y = cb0[18].x * cb0[0].x + cb0[17].y;
  sincos(r2.xy, r2.xy, r3.xy);
  r2.xyzw = r2.xyxy * r0.xyzw;
  r0.xz = r0.ww * r3.xy + -r2.xy;
  r0.yw = r0.yy * r3.xy + r2.zw;
  r2.xyzw = float4(0.5,0.5,0.5,0.5) + r0.xzyw;
  r0.x = t1.Sample(s1_s, r2.yw).x;
  r0.yz = t1.Sample(s1_s, r2.xz).yz;
  r0.x = r0.x + r0.y;
  r0.x = r1.x * r0.z + r0.x;
  r0.y = -0.100000001 + cb0[19].x;
  r0.x = r0.x + -r0.y;
  r0.z = 0.200000003 + cb0[20].x;
  r0.y = r0.z + -r0.y;
  r0.y = 1 / r0.y;
  r0.x = saturate(r0.x * r0.y);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.z = saturate(1 + -cb0[21].x);
  r0.x = r0.y * r0.x + -r0.z;
  r0.y = 1 + -r0.z;
  r0.zw = cmp(float2(9.99999991e-38,0) < r0.yy);
  r0.w = (int)-r0.w;
  r1.x = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.x ? r0.w : 9.99999991e-38;
  r0.y = r0.z ? r0.y : r0.w;
  r0.x = saturate(r0.x / r0.y);
  r0.x = cb0[22].x * r0.x;
  r0.yz = v0.xy * float2(2,2) + float2(-1,-1);
  r1.xyzw = cmp(float4(9.99999991e-38,0,9.99999991e-38,0) < abs(r0.yyzz));
  r1.yw = (int2)-r1.yw;
  r2.xy = cmp(r1.yw != float2(0,0));
  r1.yw = float2(9.99999991e-38,9.99999991e-38) * r1.yw;
  r1.yw = r2.xy ? r1.yw : float2(9.99999991e-38,9.99999991e-38);
  r0.yz = r1.xz ? abs(r0.yz) : r1.yw;
  r0.yz = r0.yz * r0.yz;
  r0.y = r0.y + r0.z;
  r0.y = 1 + -r0.y;
  r0.y = max(0, r0.y);
  r0.zw = cmp(float2(9.99999991e-38,0) < r0.yy);
  r0.w = (int)-r0.w;
  r1.x = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.x ? r0.w : 9.99999991e-38;
  r0.y = r0.z ? r0.y : r0.w;
  r0.y = log2(r0.y);
  r0.y = cb0[23].x * r0.y;
  r0.y = exp2(r0.y);
  r0.x = r0.x * r0.y;
  r1.x = 0.00999999978 + v0.x;
  r2.xyz = cb0[0].xxx * float3(-0.0799999982,-0.00499999989,0.00499999989) + v0.yyy;
  r1.y = r2.z;
  r0.yz = float2(0.5,0.5) * r1.xy;
  r1.xyzw = t3.Sample(s3_s, r0.yz).xyzw;
  r0.yzw = r1.xyz * r1.www;
  r2.w = v0.x;
  r1.xyzw = float4(0.5,0.5,0.5,0.5) * r2.wxwy;
  r2.xyzw = t3.Sample(s3_s, r1.zw).xyzw;
  r1.x = t3.Sample(s3_s, r1.xy).z;
  r1.yzw = r2.xyz * r2.www;
  r1.yzw = float3(8,8,8) * r1.yzw;
  r0.yzw = r1.yzw * r0.yzw;
  r0.yzw = r0.yzw * float3(8,8,8) + float3(0.00784313958,0.00784313958,0.00784313958);
  r1.yz = cmp(float2(9.99999991e-38,0) < abs(r1.xx));
  r1.z = (int)-r1.z;
  r1.w = cmp(r1.z != 0.000000);
  r1.z = 9.99999991e-38 * r1.z;
  r1.z = r1.w ? r1.z : 9.99999991e-38;
  r1.x = r1.y ? abs(r1.x) : r1.z;
  r1.x = log2(r1.x);
  r1.x = 7 * r1.x;
  r1.x = exp2(r1.x);
  r0.yzw = r1.xxx * r0.yzw;
  r1.xy = float2(-0.0500000007,-0.00999999978) * cb0[5].xx;
  r1.xy = cb0[0].xx * r1.xy + v0.yy;
  r1.z = v0.x;
  r1.xyzw = r1.zxzy + r1.zxzy;
  r1.xy = cb0[4].xx * r1.xy;
  r1.xy = t4.Sample(s4_s, r1.xy).xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xy = r1.xy * float2(0.800000012,0.800000012) + r1.zw;
  r1.xy = cb0[4].xx * r1.xy;
  r1.x = t2.Sample(s2_s, r1.xy).z;
  r1.x = saturate(r1.x);
  r0.yzw = r1.xxx * r0.yzw;
  r1.y = cb0[3].x * r1.x + 1;
  r1.x = cb0[3].x * r1.x;
  r1.y = saturate(0.333333343 * r1.y);
  r1.z = r1.y * -2 + 3;
  r1.y = r1.y * r1.y;
  r1.y = r1.z * r1.y;
  r0.yzw = r0.yzw * cb0[24].xxx + r1.yyy;
  r0.xyw = r0.xxx * r0.zwy;
  r1.yz = cmp(float2(9.99999991e-38,0) < abs(r1.xx));
  r1.z = (int)-r1.z;
  r1.w = cmp(r1.z != 0.000000);
  r1.z = 9.99999991e-38 * r1.z;
  r1.z = r1.w ? r1.z : 9.99999991e-38;
  r1.x = r1.y ? abs(r1.x) : r1.z;
  r1.x = 1.1178329 * r1.x;
  r1.x = cos(r1.x);
  r1.y = 1 + -r1.x;
  r1.x = r1.y * 1.73205078 + r1.x;
  r1.x = 0.898088992 + r1.x;
  r1.y = dot(float3(0.211999997,-0.523000002,0.31099999), cb0[2].xyz);
  r1.z = dot(float3(0.596000016,-0.275000006,-0.32100001), cb0[2].xyz);
  r1.w = max(abs(r1.y), abs(r1.z));
  r1.w = 1 / r1.w;
  r2.x = min(abs(r1.y), abs(r1.z));
  r1.w = r2.x * r1.w;
  r2.x = r1.w * r1.w;
  r2.y = r2.x * 0.0208350997 + -0.0851330012;
  r2.y = r2.x * r2.y + 0.180141002;
  r2.y = r2.x * r2.y + -0.330299497;
  r2.x = r2.x * r2.y + 0.999866009;
  r2.y = r2.x * r1.w;
  r2.y = r2.y * -2 + 1.57079637;
  r2.z = cmp(abs(r1.z) < abs(r1.y));
  r2.y = r2.z ? r2.y : 0;
  r1.w = r1.w * r2.x + r2.y;
  r2.x = cmp(r1.z < -r1.z);
  r2.x = r2.x ? -3.141593 : 0;
  r1.w = r2.x + r1.w;
  r2.x = min(r1.y, r1.z);
  r2.x = cmp(r2.x < -r2.x);
  r2.y = max(r1.y, r1.z);
  r2.y = cmp(r2.y >= -r2.y);
  r2.x = r2.y ? r2.x : 0;
  r1.w = r2.x ? -r1.w : r1.w;
  r2.x = cmp(r1.y != 0.000000);
  r1.y = r1.y * r1.y;
  r1.y = r1.z * r1.z + r1.y;
  r1.z = cmp(r1.z != 0.000000);
  r1.z = (int)r1.z | (int)r2.x;
  r1.z = r1.z ? r1.w : 0;
  r1.x = r1.x * 6.28310013 + r1.z;
  sincos(r1.x, r1.x, r2.x);
  r1.y = sqrt(r1.y);
  r1.y = cb0[6].x * r1.y;
  r2.y = r2.x * r1.y;
  r2.z = r1.x * r1.y;
  r2.x = dot(float3(0.298999995,0.587000012,0.114), cb0[2].xyz);
  r1.x = dot(float3(1,0.95599997,0.620999992), r2.xyz);
  r1.y = dot(float3(1,-0.272000015,-0.647000015), r2.xyz);
  r1.z = dot(float3(1,-1.10500002,1.70000005), r2.xyz);
  r1.xyz = -cb0[2].xyz + r1.xyz;
  r1.xyz = cb0[7].xxx * r1.xyz + cb0[2].xyz;
  r2.x = v2.w;
  r2.y = v1.w;
  r2.z = v3.w;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r1.w = dot(-r2.xyz, v3.xyz);
  r1.w = r1.w + r1.w;
  r2.xyz = v3.xyz * -r1.www + -r2.xyz;
  r2.xyzw = t13.SampleLevel(s13_s, r2.xyz, cb0[9].x).xyzw;
  r3.xyz = r2.xyz / r2.www;
  r3.xyz = r3.xyz * r3.xyz;
  r2.xyz = r3.xyz * r1.xyz;
  r1.xyz = saturate(r1.xyz);
  r2.xyzw = saturate(cb0[8].xxxx * r2.xyzw);
  r2.xyz = r2.xyz + -r1.xyz;
  r1.xyz = r2.www * r2.xyz + r1.xyz;
  r0.xyz = r1.xyz * r0.wxy;
  r1.x = 1 + -v5.w;
  o0.xyzw = r1.xxxx * r0.xyzw;
  
	o0.a = saturate(o0.a);
  return;
}