Texture2D<float4> t5 : register(t5);
Texture2D<float4> t4 : register(t4);
Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s5_s : register(s5);
SamplerState s4_s : register(s4);
SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[12];
}

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb0[3].xy * v0.xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.y = cb0[1].z * r0.y;
  r0.xy = float2(1,-1) * r0.xy;
  r1.xy = cb0[1].xx + v0.xy;
  r1.xy = cb0[3].xy * r1.xy;
  r0.z = t1.Sample(s1_s, r1.xy).x;
  r1.xyz = t0.Sample(s0_s, r1.xy).xyz;
  r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r0.w = 1;
  r2.x = dot(r0.xyzw, cb0[4].xyzw);
  r2.y = dot(r0.xyzw, cb0[5].xyzw);
  r2.z = dot(r0.xyzw, cb0[6].xyzw);
  r0.x = dot(r0.xyzw, cb0[7].xyzw);
  r0.xyz = r2.xyz / r0.xxx;
  r0.xyz = -cb0[8].xyz + r0.xyz;
  r0.xyz = r0.xyz / cb0[9].www;
  r2.xy = frac(r0.xy);
  r0.w = -0.75 + r0.z;
  r3.xyz = floor(r0.xyw);
  r0.w = frac(r0.w);
  r3.xyz = (int3)r3.xyz;
  r1.w = trunc(cb0[11].z);
  r2.z = cb0[11].x / r1.w;
  r4.xyz = r1.www * cb0[9].xyz + float3(-2,-2,-2);
  r4.xyz = -r4.xyz + r0.xyz;
  r4.xyz = saturate(-r4.xyz * float3(0.5,0.5,0.5) + float3(1,1,1));
  r1.w = (int)r2.z;
  r2.z = (int)r1.w ^ (int)r3.z;
  r2.z = (int)r2.z & 0x80000000;
  r2.w = max((int)-r3.z, (int)r3.z);
  r3.w = max((int)-r1.w, (int)r1.w);
  uiDest.x = (uint)r2.w / (uint)r3.w;
  r6.x = (uint)r2.w % (uint)r3.w;
  r5.x = uiDest.x;
  r2.w = -(int)r5.x;
  r2.z = r2.z ? r2.w : r5.x;
  r2.w = (int)cb0[11].z;
  r2.z = mad((int)r2.z, (int)r2.w, (int)r3.y);
  r5.y = (int)r2.z;
  r2.z = (int)r3.z & 0x80000000;
  r4.w = -(int)r6.x;
  r2.z = r2.z ? r4.w : r6.x;
  r2.z = mad((int)r2.z, (int)r2.w, (int)r3.x);
  r5.x = (int)r2.z;
  r5.xy = r5.xy + r2.xy;
  r5.xy = float2(0.5,0.5) + r5.xy;
  r5.xy = float2(0.142857149,0.142857149) * r5.xy;
  r5.zw = floor(r5.xy);
  r5.zw = float2(0.5,0.5) + r5.zw;
  r2.z = 6 + cb0[11].x;
  r2.z = 0.142857149 * r2.z;
  r6.x = trunc(r2.z);
  r6.y = trunc(cb0[10].z);
  r5.zw = r5.zw / r6.xy;
  r2.z = t5.Sample(s5_s, r5.zw).x;
  r2.z = cmp(0.5 >= r2.z);
  r3.z = (int)r3.z + 1;
  r1.w = (int)r1.w ^ (int)r3.z;
  r1.w = (int)r1.w & 0x80000000;
  r4.w = max((int)-r3.z, (int)r3.z);
  r3.z = (int)r3.z & 0x80000000;
  uiDest.x = (uint)r4.w / (uint)r3.w;
  r8.x = (uint)r4.w % (uint)r3.w;
  r7.x = uiDest.x;
  r3.w = -(int)r7.x;
  r1.w = r1.w ? r3.w : r7.x;
  r1.w = mad((int)r1.w, (int)r2.w, (int)r3.y);
  r7.y = (int)r1.w;
  r1.w = -(int)r8.x;
  r1.w = r3.z ? r1.w : r8.x;
  r1.w = mad((int)r1.w, (int)r2.w, (int)r3.x);
  r7.x = (int)r1.w;
  r2.xy = r7.xy + r2.xy;
  r2.xy = float2(0.5,0.5) + r2.xy;
  r2.xy = float2(0.142857149,0.142857149) * r2.xy;
  r3.xy = floor(r2.xy);
  r3.xy = float2(0.5,0.5) + r3.xy;
  r3.xy = r3.xy / r6.xy;
  r1.w = t5.Sample(s5_s, r3.xy).x;
  r1.w = cmp(0.5 >= r1.w);
  r1.w = (int)r1.w | (int)r2.z;
  if (r1.w != 0) discard;
  r0.y = min(r0.y, r0.z);
  r0.x = min(r0.x, r0.y);
  r0.x = 0.5 * r0.x;
  r0.x = min(1, r0.x);
  r0.x = min(r0.x, r4.x);
  r0.y = min(r4.y, r4.z);
  r0.x = min(r0.x, r0.y);
  r0.y = dot(r1.xyz, r1.xyz);
  r0.y = rsqrt(r0.y);
  r1.xyz = r1.xyz * r0.yyy;
  r0.yz = r2.xy / cb0[10].yy;
  r0.yz = t4.Sample(s4_s, r0.yz).xy;
  r0.yz = r0.yz * float2(255,255) + r2.xy;
  r2.xy = floor(r0.yz);
  r0.yz = frac(r0.yz);
  r0.yz = float2(7,7) * r0.yz;
  r0.yz = r2.xy * float2(8,8) + r0.yz;
  r0.yz = float2(0.5,0.5) + r0.yz;
  r0.yz = r0.yz / cb0[10].xx;
  r2.xyzw = t3.Sample(s3_s, r0.yz).xyzw;
  r3.xyzw = t2.Sample(s2_s, r0.yz).xyzw;
  r0.yz = r5.xy / cb0[10].yy;
  r0.yz = t4.Sample(s4_s, r0.yz).xy;
  r0.yz = r0.yz * float2(255,255) + r5.xy;
  r4.xy = floor(r0.yz);
  r0.yz = frac(r0.yz);
  r0.yz = float2(7,7) * r0.yz;
  r0.yz = r4.xy * float2(8,8) + r0.yz;
  r0.yz = float2(0.5,0.5) + r0.yz;
  r0.yz = r0.yz / cb0[10].xx;
  r4.xyzw = t3.Sample(s3_s, r0.yz).xyzw;
  r5.xyzw = t2.Sample(s2_s, r0.yz).xyzw;
  r2.xyzw = -r4.xyzw + r2.xyzw;
  r2.xyzw = r0.wwww * r2.xyzw + r4.xyzw;
  r2.xyzw = r2.xyzw * float4(2,2,2,1) + float4(-1,-1,-1,0);
  r1.w = 1;
  r0.y = dot(r2.xyzw, r1.xyzw);
  r0.y = max(0, r0.y);
  r1.xyzw = -r5.xyzw + r3.xyzw;
  r1.xyzw = r0.wwww * r1.xyzw + r5.xyzw;
  r0.z = 4 * r1.w;
  r1.xyz = r1.xyz * r0.zzz;
  r0.yzw = r1.xyz * r0.yyy;
  r0.yzw = cb0[10].www * r0.yzw;
  r0.yzw = cb0[0].xxx * r0.yzw;
  o0.xyz = r0.yzw * r0.xxx;
  o0.w = 0;
  o0.rgb = max(0, o0.rgb);
  return;
}