TextureCube<float4> t13 : register(t13);
Texture2D<float4> t5 : register(t5);
Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s13_s : register(s13);
SamplerState s5_s : register(s5);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[16];
}

#define cmp -

void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v0.xy).xyzw;
  r0.x = r0.x + r0.y;
  r0.x = r0.x + r0.z;
  r0.x = r0.x + r0.w;
  r0.yzw = t1.Sample(s1_s, v0.xy).xyz;
  r0.y = r0.y + r0.z;
  r0.x = r0.x * r0.w + r0.y;
  r0.y = -0.1 + cb0[10].x;
  r0.x = r0.x + -r0.y;
  r0.z = 0.2 + cb0[11].x;
  r0.y = r0.z + -r0.y;
  r0.y = 1 / r0.y;
  r0.x = saturate(r0.x * r0.y);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.z = saturate(1 + -cb0[12].x);
  r0.x = r0.y * r0.x + -r0.z;
  r0.y = 1 + -r0.z;
  r0.zw = cmp(float2(9.99999991e-38,0) < r0.yy);
  r0.w = (int)-r0.w;
  r1.x = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.x ? r0.w : 9.99999991e-38;
  r0.y = r0.z ? r0.y : r0.w;
  r0.x = saturate(r0.x / r0.y);
  r0.y = cb0[13].x * v2.w;
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
  r1.xy = float2(-0.05,-0.00999999978) * cb0[5].xx;
  r1.xy = cb0[0].xx * r1.xy + v0.yy;
  r1.z = v0.x;
  r1.xyzw = r1.zxzy + r1.zxzy;
  r1.xy = cb0[4].xx * r1.xy;
  r1.xy = t4.Sample(s4_s, r1.xy).xy;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xy = r1.xy * float2(0.8,0.8) + r1.zw;
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
  r0.yzw = r0.yzw * cb0[14].xxx + r1.yyy;
  r0.xyz = r0.xxx * r0.yzw;
  r1.yz = t5.Sample(s5_s, v0.xy).xy;
  r1.yz = r1.yz * float2(2,2) + float2(-1,-1);
  r2.xyzw = cmp(float4(9.99999991e-38,0,9.99999991e-38,0) < abs(r1.yyzz));
  r2.yw = (int2)-r2.yw;
  r3.xy = cmp(r2.yw != float2(0,0));
  r2.yw = float2(9.99999991e-38,9.99999991e-38) * r2.yw;
  r2.yw = r3.xy ? r2.yw : float2(9.99999991e-38,9.99999991e-38);
  r1.yz = r2.xz ? abs(r1.yz) : r2.yw;
  r1.yz = r1.yz * r1.yz;
  r0.w = r1.y + r1.z;
  r0.w = 1 + -r0.w;
  r0.w = max(0, r0.w);
  r1.yz = cmp(float2(9.99999991e-38,0) < r0.ww);
  r1.z = (int)-r1.z;
  r1.w = cmp(r1.z != 0.000000);
  r1.z = 9.99999991e-38 * r1.z;
  r1.z = r1.w ? r1.z : 9.99999991e-38;
  r0.w = r1.y ? r0.w : r1.z;
  r0.w = log2(r0.w);
  r0.w = cb0[15].x * r0.w;
  r0.w = exp2(r0.w);
  r1.y = r0.x * r0.w + -cb0[1].x;
  r0.w = r0.x * r0.w;
  o0.w = r0.w;
  r0.w = cmp(r1.y < 0);
  if (r0.w != 0) discard;
  r1.yz = cmp(float2(9.99999991e-38,0) < abs(r1.xx));
  r0.w = (int)-r1.z;
  r1.z = cmp(r0.w != 0.000000);
  r0.w = 9.99999991e-38 * r0.w;
  r0.w = r1.z ? r0.w : 9.99999991e-38;
  r0.w = r1.y ? abs(r1.x) : r0.w;
  r0.w = 1.1178329 * r0.w;
  r0.w = cos(r0.w);
  r1.x = 1 + -r0.w;
  r0.w = r1.x * 1.73205078 + r0.w;
  r0.w = 0.898088992 + r0.w;
  r1.x = dot(float3(0.211999997,-0.523000002,0.31099999), v2.xyz);
  r1.y = dot(float3(0.596000016,-0.275000006,-0.32100001), v2.xyz);
  r1.z = max(abs(r1.x), abs(r1.y));
  r1.z = 1 / r1.z;
  r1.w = min(abs(r1.x), abs(r1.y));
  r1.z = r1.w * r1.z;
  r1.w = r1.z * r1.z;
  r2.x = r1.w * 0.0208350997 + -0.0851330012;
  r2.x = r1.w * r2.x + 0.180141002;
  r2.x = r1.w * r2.x + -0.330299497;
  r1.w = r1.w * r2.x + 0.999866009;
  r2.x = r1.z * r1.w;
  r2.x = r2.x * -2 + 1.57079637;
  r2.y = cmp(abs(r1.y) < abs(r1.x));
  r2.x = r2.y ? r2.x : 0;
  r1.z = r1.z * r1.w + r2.x;
  r1.w = cmp(r1.y < -r1.y);
  r1.w = r1.w ? -3.141593 : 0;
  r1.z = r1.z + r1.w;
  r1.w = min(r1.x, r1.y);
  r1.w = cmp(r1.w < -r1.w);
  r2.x = max(r1.x, r1.y);
  r1.x = r1.x * r1.x;
  r1.x = r1.y * r1.y + r1.x;
  r1.x = sqrt(r1.x);
  r1.x = cb0[6].x * r1.x;
  r1.y = cmp(r2.x >= -r2.x);
  r1.y = r1.y ? r1.w : 0;
  r1.y = r1.y ? -r1.z : r1.z;
  r0.w = r0.w * 6.28310013 + r1.y;
  sincos(r0.w, r2.x, r3.x);
  r3.y = r3.x * r1.x;
  r3.z = r2.x * r1.x;
  r3.x = dot(float3(0.298999995,0.587000012,0.114), v2.xyz);
  r1.x = dot(float3(1,0.95599997,0.620999992), r3.xyz);
  r1.y = dot(float3(1,-0.272000015,-0.647000015), r3.xyz);
  r1.z = dot(float3(1,-1.10500002,1.70000005), r3.xyz);
  r1.xyz = -v2.xyz + r1.xyz;
  r1.xyz = cb0[7].xxx * r1.xyz + v2.xyz;
  r2.xyzw = t13.SampleLevel(s13_s, v1.xyz, cb0[9].x).xyzw;
  r3.xyz = r2.xyz / r2.www;
  r3.xyz = r3.xyz * r3.xyz;
  r2.xyz = r3.xyz * r1.xyz;
  r1.xyz = saturate(r1.xyz);
  r2.xyzw = saturate(cb0[8].xxxx * r2.xyzw);
  r2.xyz = r2.xyz + -r1.xyz;
  r1.xyz = r2.www * r2.xyz + r1.xyz;
  r0.xyz = r1.xyz * r0.xyz;
  r0.w = 1 + -v3.w;
  o0.xyz = r0.xyz * r0.www + v3.xyz;
  o0.a = saturate(o0.a);
  return;
}