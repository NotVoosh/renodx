#include "../common.hlsl"

groupshared struct { float val[1]; } g1[128];
groupshared struct { float val[1]; } g0[128];
struct t2_t {
  float val[1];
};
StructuredBuffer<t2_t> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
RWTexture2D<float4> u0 : register(u0);
cbuffer cb1 : register(b1){
  float4 cb1[7];
}
cbuffer cb0 : register(b0){
  float4 cb0[80];
}

#define cmp -

[numthreads(128, 1, 1)]
void main(uint3 vThreadID: SV_DispatchThreadID) {
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t2[vThreadID.x].val[0/4];
  r0.x = (uint)r0.x;
  r0.x = rcp(2048.f) * r0.x;
  g1[vThreadID.x].val[0/4] = r0.x;
  g0[vThreadID.x].val[0/4] = r0.x;
  GroupMemoryBarrierWithGroupSync();
  r0.x = 64;
  while (true) {
    r0.y = cmp(0 >= (uint)r0.x);
    if (r0.y != 0) break;
    r0.y = cmp((uint)vThreadID.x < (uint)r0.x);
    if (r0.y != 0) {
      r0.y = g0[vThreadID.x].val[0/4];
      r0.z = (int)r0.x + (int)vThreadID.x;
      r0.z = g0[r0.z].val[0/4];
      r0.y = r0.y + r0.z;
      g0[vThreadID.x].val[0/4] = r0.y;
    }
    GroupMemoryBarrierWithGroupSync();
    r0.x = (uint)r0.x >> 1;
  }
  if (vThreadID.x == 0) {
    r0.x = g0[0].val[0/4];
    r0.xy = cb1[4].zw * r0.xx;
    r1.xy = r0.xy;
    r0.zw = float2(0,0);
    r1.w = 0;
    while (true) {
      r2.x = cmp((int)r1.w >= 128);
      if (r2.x != 0) break;
      r2.x = g1[r1.w].val[0/4];
      r2.y = (uint)r1.w;
      r2.y = r2.y * 0.00787401572 + -cb1[4].y;
      r2.y = r2.y / cb1[4].x;
      r2.z = min(r2.x, r1.x);
      r1.xz = -r2.zz + r1.xy;
      r2.x = r2.x + -r2.z;
      r2.x = min(r2.x, r1.z);
      r1.y = -r2.x + r1.z;
      r0.z = r2.x * r2.y + r0.z;
      r0.w = r2.x + r0.w;
      r1.w = (int)r1.w + 1;
    }
    r0.x = max(9.99999975e-05, r0.w);
    r0.x = rcp(r0.x);
    r1.x = r0.z * r0.x;
    r0.yw = cmp(asint(cb1[6].wz) == int2(2,1));
    if (r0.y != 0) {
      r0.x = r0.z * r0.x + -cb1[1].x;
      r0.y = cb1[1].y + -cb1[1].x;
      r0.x = saturate(r0.x / r0.y);
      r0.y = 0;
      r1.xyz = t1.SampleLevel(s0_s, r0.xy, 0).xyz;
    } else {
      r1.yz = cb1[0].yz;
    }
    r0.x = -cb1[0].x + r1.x;
    if (r0.w != 0) {
      r0.y = t0.Load(int3(0,0,0)).y;
      r0.z = r0.x + -r0.y;
      r0.w = cmp(0 < r0.z);
      r0.w = r0.w ? cb1[5].y : cb1[5].x;
      r0.w = -cb0[79].x * r0.w;
      r0.w = exp2(r0.w);
      r0.w = 1 + -r0.w;
      r0.x = r0.z * r0.w + r0.y;
    }
    r0.x = max(r0.x, r1.y);
    r0.y = min(r0.x, r1.z);
    r1.x = exp2(r0.y);
    r1.x = cb1[1].z * r1.x;
    r0.xzw = float3(1,1,1) / r1.xxx;
    // No code for instruction (needs manual fix):
    // store_uav_typed u0.xyzw, l(0,0,0,0), r0.xyzw
    u0[uint2(0,0)] = r0.x;
  }
  return;
}