Texture2D<float4> t32 : register(t32);
SamplerState s12_s : register(s12);
cbuffer cb3 : register(b3){
  float4 cb3[9];
}
cbuffer cb2 : register(b2){
  float4 cb2[36];
}
cbuffer cb1 : register(b1){
  float4 cb1[137];
}

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD2,
  float4 v5 : TEXCOORD3,
  float4 v6 : TEXCOORD4,
  uint v7 : TEXCOORD5,
  uint v8 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = -0.5 + v1.x;
  r0.x = abs(r0.x) + abs(r0.x);
  r0.x = min(1, r0.x);
  r0.x = 1 + -r0.x;
  r0.yzw = cb2[0].xyz + -v3.xyz;
  r0.y = dot(r0.yzw, r0.yzw);
  r0.y = sqrt(r0.y);
  r0.z = cmp(r0.y >= 25);
  r0.y = -25 + r0.y;
  r0.y = saturate(0.00210526306 * r0.y);
  r0.y = r0.y * -30 + 50;
  r0.z = r0.z ? -1 : -0;
  r0.x = r0.x + r0.z;
  r0.x = 1 + r0.x;
  r0.x = saturate(r0.x * r0.y + cb3[6].x);
  r0.yz = cb2[35].xy * v0.xy;
  r0.y = r0.y * -0.699999988 + r0.z;
  r0.y = cb1[0].x * cb3[5].x + r0.y;
  r0.y = frac(r0.y);
  r0.y = -1 + r0.y;
  r0.y = log2(-r0.y);
  r0.y = 10 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = cb3[2].x * r0.y;
  r0.z = 0.5 * r0.y;
  r1.xy = v1.xy;
  r1.z = 1;
  r2.x = dot(r1.xyz, cb3[7].xyz);
  r2.y = dot(r1.xyz, cb3[8].xyz);
  r1.xyzw = t32.Sample(s12_s, r2.xy).xyzw;
  r0.w = cb3[1].x * r1.w;
  r0.z = r0.z * r1.w + r0.w;
  r0.x = saturate(r0.z * r0.x);
  r0.z = cb3[3].x * r0.x + -cb3[0].z;
  r0.x = cb3[3].x * r0.x;
  o0.w = r0.x;
  r0.x = cmp(r0.z < 0);
  if (r0.x != 0) discard;
  r0.xzw = cb3[4].xyz * v2.xyz;
  r0.xyz = r1.xyz * r0.xzw + r0.yyy;
  r1.xyz = max(float3(9.99999975e-06,9.99999975e-06,9.99999975e-06), r0.xyz);
  r1.xyz = log2(r1.xyz);
  r1.xyz = float3(2.20000005,2.20000005,2.20000005) * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r2.x = dot(float3(0.627403975,0.329281986,0.0433136001), r1.xyz);
  r2.y = dot(float3(0.0690969974,0.919539988,0.0113612004), r1.xyz);
  r2.z = dot(float3(0.0163915996,0.088013202,0.895595014), r1.xyz);
  r1.xyz = float3(0.100000001,0.100000001,0.100000001) * r2.xyz;
  r1.xyz = log2(r1.xyz);
  r1.xyz = float3(0.159301758,0.159301758,0.159301758) * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r2.xyz = r1.xyz * float3(18.8515625,18.8515625,18.8515625) + float3(0.8359375,0.8359375,0.8359375);
  r1.xyz = r1.xyz * float3(18.6875,18.6875,18.6875) + float3(1,1,1);
  r1.xyz = r2.xyz / r1.xyz;
  r1.xyz = log2(r1.xyz);
  r1.xyz = float3(78.84375,78.84375,78.84375) * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r0.w = cmp(0 < cb1[136].w);
  o0.xyz = r0.www ? r1.xyz : r0.xyz;
  return;
}