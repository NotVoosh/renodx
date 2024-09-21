// ---- Created with 3Dmigoto v1.3.16 on Wed Sep 18 22:04:09 2024
Texture2D<float4> t12 : register(t12);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s12_s : register(s12);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[14];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  float w0 : TEXCOORD1,
  float4 v1 : TEXCOORD2,
  float4 v2 : TEXCOORD3,
  float4 v3 : SV_POSITION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[7].xx * v0.xy;
  r0.x = cb0[1].x * cb0[8].x + r0.x;
  r0.y = cb0[1].x * cb0[10].x + r0.y;
  r1.y = cb0[11].x + r0.y;
  r1.x = cb0[9].x + r0.x;
  r0.xy = t1.Sample(s1_s, r1.xy).xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = cb0[12].x * v1.z;
  r0.xy = r0.xy * r0.zz;
  r0.zw = t3.Sample(s3_s, v0.xy).xy;
  r0.xy = r0.zw * r0.xy + v0.xy;
  r1.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.xyz = t2.Sample(s2_s, r0.xy).xyz;		
  r0.w = cb0[13].x * v1.w;
  r0.w = r1.w * cb0[13].x + r0.w;
  r0.w = -cb0[13].x + r0.w;
  r1.w = 1 + -cb0[13].x;
  r1.w = 1 / r1.w;
  r0.w = saturate(r1.w * r0.w);
  r1.w = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r1.w * r0.w;
  r0.w = v1.x * r0.w;
  r2.xy = cb0[3].xx + v3.xy;
  r2.xy = cb0[0].xy * r2.xy;
  r1.w = t12.Sample(s12_s, r2.xy).x;
  r1.w = r1.w * cb0[0].w + -cb0[0].z;
  r1.w = -w0.x + r1.w;
  r1.w = saturate(0.0588235296 * r1.w);
  r2.x = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r1.w = r2.x * r1.w;
  r2.x = r0.w * r1.w + -cb0[2].x;
  r0.w = r1.w * r0.w;
  o0.w = r0.w;
  r0.w = cmp(r2.x < 0);
  if (r0.w != 0) discard;
  r2.xyz = cb0[6].xyz + -cb0[5].xyz;
  r2.xyz = v1.yyy * r2.xyz + cb0[5].xyz;
  r0.xyz = r2.xyz * r0.xyz;
  r0.xyz = r0.xyz * float3(2,2,2) + float3(0.00100000005,0.00100000005,0.00100000005);
  r2.xyz = cb0[5].www * r0.xyz;
  r0.xyz = r0.xyz * cb0[6].www + -r2.xyz;
  r0.xyz = v1.yyy * r0.xyz + r2.xyz;
  r0.xyz = r0.xyz + r1.xyz;
  //r0.w = 1 + -v2.w;
	r0.w = 1 + -v2.w * 0.33;
		v2.rgb = pow(v2.rgb, 2.2f);
		v2.rgb *= 0.66;
		v2.rgb = pow(v2.rgb, 1 / 2.2f);
  o0.xyz = r0.xyz * r0.www + v2.xyz;
  return;
}