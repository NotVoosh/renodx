Texture2D<float4> t32 : register(t32);
Texture2D<float4> t17 : register(t17);
SamplerState s12_s : register(s12);
cbuffer cb3 : register(b3){
  float4 cb3[19];
}
cbuffer cb2 : register(b2){
  float4 cb2[36];
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
  uint v7 : InstanceID0,
  uint v8 : SV_IsFrontFace0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v0.xy * cb2[32].xy + -v1.xy;
  r0.zw = cb3[9].xx * r0.xy + v1.xy;
  r1.xy = cb3[12].xx * r0.xy + v1.xy;
  r0.xy = r0.zw * float2(-2,-2) + float2(1,1);
  r0.x = cb3[7].x * r0.x + r0.z;
  r0.y = cb3[8].x * r0.y + r0.w;
  r0.y = -cb3[5].x + r0.y;
  r0.y = saturate(r0.y / cb3[11].x);
  r0.x = -cb3[6].x + r0.x;
  r0.x = saturate(r0.x / cb3[10].x);
  r0.x = r0.x * r0.y;
  r1.z = 1;
  r2.x = dot(r1.xyz, cb3[17].xyz);
  r2.y = dot(r1.xyz, cb3[18].xyz);
  r1.xyzw = t32.Sample(s12_s, r2.xy).xyzw;
  r0.x = r1.w * r0.x;
  r0.yzw = cb3[4].xxx * r1.xyz;
  r0.yzw = cb3[16].xyz * r0.yzw;
  r1.x = -1 + v2.w;
  r1.x = cb3[13].x * r1.x + 1;
  r0.x = r1.x * r0.x;
  r0.x = cb3[3].x * r0.x;
  r1.x = r0.x * cb3[15].x + -cb3[0].z;
  r1.x = cmp(r1.x < 0);
  if (r1.x != 0) discard;
  r1.xyz = r0.yzw * r0.xxx + -r0.yzw;
  r0.x = cb3[15].x * r0.x;
  o0.w = r0.x;
  r0.xyz = cb3[14].xxx * r1.xyz + r0.yzw;
  r0.w = t17.Load(int3(0,0,0)).x;
  r0.xyz = r0.xyz / r0.www;
  o0.xyz = cb2[35].xxx * r0.xyz;
  return;
}