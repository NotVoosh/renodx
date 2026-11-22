Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);
cbuffer cb1 : register(b1){
  float4 cb1[4];
}
cbuffer cb0 : register(b0){
  float4 cb0[135];
}

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float4 v3 : INTERP2,
  float3 v4 : INTERP3,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.SampleBias(s0_s, v1.xy, cb0[5].x).xyzw;
  r1.x = cb1[2].w * cb0[19].x;
  r1.x = 0.100000001 * r1.x;
  r1.x = v1.x * cb1[2].y + r1.x;
  r1.x = 2.27272725 * r1.x;
  r1.x = r1.x >= -r1.x ? frac(abs(r1.x)) : -frac(abs(r1.x));
  r1.xy = float2(0.439999998,1.5927999) * r1.xx;
  r1.y = cos(r1.y);
  r1.x = r1.x * r1.y;
  r1.x = cb1[2].x * r1.x;
  r1.x = cos(r1.x);
  r1.x = v1.y * r1.x;
  r1.y = cb0[19].y * 0.0199999996 + 1;
  r2.x = 0;
  r2.y = max(-1.5, cb1[2].z);
  r1.zw = min(float2(0,0), r2.xy);
  r2.x = v1.x;
  r2.y = r1.x * r1.y;
  r1.xy = r2.xy + r1.zw;
  r1.z = 0.0174532924 * cb1[3].x;
  r1.xy = float2(-0.5,-0.219999999) + r1.xy;
  sincos(r1.z, r2.x, r3.x);
  r3.yz = r2.xx;
  r2.xyz = r3.xyz * float3(0.5,-0.5,0.5) + float3(0.5,0.5,0.5);
  r2.xyz = r2.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.x = dot(r1.xy, r2.xz);
  r3.y = dot(r1.yx, r2.xy);
  r1.xy = float2(0.5,0.219999999) + r3.xy;
  r1.xz = r1.xy * float2(2,2) + float2(-1,-1);
  r1.xz = float2(-5.21999979,-1.03999996) + abs(r1.xz);
  r2.xy = ddx(r1.xz);
  r2.zw = ddy(r1.xz);
  r2.xy = abs(r2.xy) + abs(r2.zw);
  r1.xz = r1.xz / r2.xy;
  r1.xz = saturate(float2(1,1) + -r1.xz);
  r1.x = min(r1.x, r1.z);
  r1.z = 1 + -r1.x;
  r2.xyz = r1.yyy * float3(2.42000008,136.929993,-5.88999987) + float3(0.579999983,3.76999998,-1.41999996);
  r1.yw = float2(1,1) + -r2.xy;
  r1.y = r1.z / abs(r1.y);
  r2.xyw = cb1[1].xyz * r1.yyy;
  r3.xyz = r0.xyz + r0.xyz;
  r4.xyz = r0.xyz * r0.xyz;
  r5.xyz = -r2.xyw * float3(2,2,2) + float3(1,1,1);
  r4.xyz = r5.xyz * r4.xyz;
  r4.xyz = r3.xyz * r2.xyw + r4.xyz;
  r5.xyz = sqrt(r0.xyz);
  r6.xyz = r2.xyw * float3(2,2,2) + float3(-1,-1,-1);
  r7.xyz = -cb1[1].xyz * r1.yyy + float3(1,1,1);
  r3.xyz = r7.xyz * r3.xyz;
  r3.xyz = r5.xyz * r6.xyz + r3.xyz;
  r5.xyz = r2.xyw >= float3(0.5,0.5,0.5) ? float3(1,1,1) : 0;
  r2.xyw = r2.xyw >= float3(0.5,0.5,0.5) ? float3(0,0,0) : float3(1,1,1);
  r2.xyw = r2.xyw * r4.xyz;
  r2.xyw = r3.xyz * r5.xyz + r2.xyw;
  r2.xyw = r2.xyw + -r0.xyz;
  r0.xyz = r1.yyy * r2.xyw + r0.xyz;
  r1.y = 1 / abs(r1.w);
  r1.y = 0.0199999996 + r1.y;
  r1.y = saturate(0.75757581 * r1.y);
  r1.z = r1.y * -2 + 3;
  r1.y = r1.y * r1.y;
  r1.y = r1.z * r1.y;
  r2.xyw = cb1[1].xyz * r1.yyy;
  r2.xyw = max(float3(9.99999997e-007,9.99999997e-007,9.99999997e-007), r2.xyw);
  r2.xyw = min(float3(0.999998987,0.999998987,0.999998987), r2.xyw);
  r2.xyw = float3(1,1,1) + -r2.xyw;
  r2.xyw = r0.xyz / r2.xyw;
  r2.xyw = r2.xyw + -r0.xyz;
  r3.xyz = r1.yyy * r2.xyw + r0.xyz;
  r0.x = -r2.z + r1.x;
  r0.x = r0.x * r0.w;
  r3.w = 1.20000005 * r0.x;
  r0.xyzw = v2.xyzw * r3.xyzw;
  if (r0.w == 0.0) discard;
  r1.xy = v3.xy / v3.ww;
  r2.xyzw = t1.SampleBias(s1_s, r1.xy, cb0[5].x).xyzw;
  r1.z = dot(cb0[129].xyzw, cb0[129].xyzw);
  r4.xyzw = float4(1,1,1,1) + -cb0[130].xyzw;
  r1.w = dot(r4.xyzw, cb0[129].xyzw);
  r4.xyz = r2.xyz * r1.www;
  r2.xyz = r1.z != 0.0 ? r4.xyz : r2.xyz;
  r1.xyzw = t2.SampleBias(s2_s, r1.xy, cb0[5].x).xyzw;
  r1.w = dot(cb0[132].xyzw, cb0[132].xyzw);
  r4.xyzw = float4(1,1,1,1) + -cb0[133].xyzw;
  r2.w = dot(r4.xyzw, cb0[132].xyzw);
  r4.xyz = r2.www * r1.xyz;
  r1.xyz = r1.w != 0.0 ? r4.xyz : r1.xyz;
  r4.xyz = cb0[131].xxx * r1.xyz;
  r1.xyz = cb0[131].yyy * r1.xyz;
  r4.xyz = r2.xyz * cb0[128].xxx + r4.xyz;
  r1.xyz = r2.xyz * cb0[128].yyy + r1.xyz;
  r2.xyz = cb0[134].xxx * r0.xyz;
  r1.xyz = r2.xyz * r4.xyz + r1.xyz;
  r1.xyz = -r3.xyz * v2.xyz + r1.xyz;
  r1.w = 0;
  r0.xyzw = cb0[134].yyyy * r1.xyzw + r0.xyzw;
  o0.xyzw = max(float4(0,0,0,0), r0.xyzw);
  o0.w = saturate(o0.w);
  return;
}