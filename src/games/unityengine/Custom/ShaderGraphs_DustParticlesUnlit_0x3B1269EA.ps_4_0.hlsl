Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb2 : register(b2){
  float4 cb2[3];
}
cbuffer cb1 : register(b1){
  float4 cb1[8];
}
cbuffer cb0 : register(b0){
  float4 cb0[20];
}

#define cmp -

float HashNoise(int2 cell)
{
  uint2 cellBits = asuint(cell);
  uint hash = cellBits.y ^ 0x41c64e6du;
  hash *= hash + cellBits.x;
  hash ^= hash >> 5;
  hash *= 0x27d4eb2du;
  return (float)hash * 2.3283064365386963e-10;
}

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : INTERP0,
  float4 v2 : INTERP1,
  float3 v3 : INTERP2,
  out float4 o0 : SV_TARGET0)
{
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = cb1[5].xyxy * v3.yyyy;
  r0.xyzw = cb1[4].xyxy * v3.xxxx + r0.xyzw;
  r0.xyzw = cb1[6].xyxy * v3.zzzz + r0.xyzw;
  r0.xyzw = cb1[7].xyxy + r0.xyzw;
  r1.xyzw = t0.SampleBias(s0_s, v1.xy, cb0[5].x).xyzw;
  r2.xy = cb2[2].xy * cb0[19].xx + r0.zw;
  r2.z = cb2[1].y * cb0[19].x;
  r2.z = 0.5 * r2.z;
  r3.xy = float2(0.100000001,0.5) * cb2[1].xz;
  r2.xy = r3.xx * r2.xy;
  r3.xz = floor(r2.xy);
  r2.xy = frac(r2.xy);
  r4.xy = float2(0,8);
  r2.w = -1;
  while (true) {
    r3.w = cmp(1 < (int)r2.w);
    if (r3.w != 0) break;
    r5.y = (int)r2.w;
    r4.zw = r4.xy;
    r3.w = -1;
    while (true) {
      r5.z = cmp(1 < (int)r3.w);
      if (r5.z != 0) break;
      r5.x = (int)r3.w;
      r5.zw = r5.xy + r3.xz;
      r6.x = dot(r5.zw, float2(15.2700005,99.4100037));
      r5.z = dot(r5.zw, float2(47.6300011,89.9800034));
      r6.y = sin(r6.x);
      r6.x = sin(r5.z);
      r5.zw = frac(r6.xy);
      r5.zw = r5.zw * r2.zz;
      r6.x = sin(r5.z);
      r6.y = cos(r5.w);
      r5.xz = r6.xy * float2(0.5,0.5) + r5.xy;
      r5.xz = r5.xz + -r2.xy;
      r5.xz = float2(0.5,0.5) + r5.xz;
      r5.x = dot(r5.xz, r5.xz);
      r5.x = sqrt(r5.x);
      r5.z = cmp(r5.x < r4.w);
      r4.zw = r5.zz ? r5.xx : r4.zw;
      r3.w = (int)r3.w + 1;
    }
    r4.xy = r4.zw;
    r2.w = (int)r2.w + 1;
  }
  r2.x = log2(r4.x);
  r2.x = r3.y * r2.x;
  r2.x = exp2(r2.x);
  r2.x = -r2.x * 5 + 1;
  r0.xyzw = cb0[19].yyyy + r0.xyzw;
  r2.yz = cb2[2].zz * r0.zw;
  r3.xy = floor(r2.yz);
  r2.yz = frac(r2.yz);
  r3.zw = r2.yz * r2.yz;
  r2.yz = -r2.yz * float2(2,2) + float2(3,3);
  r2.yz = r3.zw * r2.yz;
  int2 hashCell = (int2)r3.xy;
  float hash00 = HashNoise(hashCell);
  float hash10 = HashNoise(hashCell + int2(1,0));
  float hash01 = HashNoise(hashCell + int2(0,1));
  float hash11 = HashNoise(hashCell + int2(1,1));
  r2.w = hash00 + r2.y * (hash10 - hash00);
  r2.y = hash01 + r2.y * (hash11 - hash01);
  r2.y = r2.w + r2.z * (r2.y - r2.w);
  r3.xyzw = float4(0.5,0.5,0.25,0.25) * cb2[2].zzzz;
  r0.xyzw = r3.xyzw * r0.xyzw;
  r3.xyzw = floor(r0.xyzw);
  r0.xyzw = frac(r0.xyzw);
  r4.xyzw = r0.xyzw * r0.xyzw;
  r0.xyzw = -r0.xyzw * float4(2,2,2,2) + float4(3,3,3,3);
  r0.xyzw = r4.xyzw * r0.xyzw;
  float lowFrequencyNoise = r2.y;
  int4 hashCell4 = (int4)r3.xyzw;
  float2 hash00_4 = float2(HashNoise(hashCell4.xy), HashNoise(hashCell4.zw));
  float2 hash10_4 = float2(
      HashNoise(hashCell4.xy + int2(1,0)),
      HashNoise(hashCell4.zw + int2(1,0)));
  float2 hash01_4 = float2(
      HashNoise(hashCell4.xy + int2(0,1)),
      HashNoise(hashCell4.zw + int2(0,1)));
  float2 hash11_4 = float2(
      HashNoise(hashCell4.xy + int2(1,1)),
      HashNoise(hashCell4.zw + int2(1,1)));
  float noiseXY0 = hash00_4.x + r0.x * (hash10_4.x - hash00_4.x);
  float noiseXY1 = hash01_4.x + r0.x * (hash11_4.x - hash01_4.x);
  float noiseXY = noiseXY0 + r0.y * (noiseXY1 - noiseXY0);
  float noiseZW0 = hash00_4.y + r0.z * (hash10_4.y - hash00_4.y);
  float noiseZW1 = hash01_4.y + r0.z * (hash11_4.y - hash01_4.y);
  float noiseZW = noiseZW0 + r0.w * (noiseZW1 - noiseZW0);
  r0.x = 0.25 * noiseXY;
  r0.x = lowFrequencyNoise * 0.125 + r0.x;
  r0.x = noiseZW * 0.5 + r0.x;
  r0.y = r0.x * r0.x;
  r0.y = r0.y * r0.y;
  r0.x = r0.x * r0.y;
  r0.x = r2.x * r0.x;
  r0.x = r0.x * r1.w;
  r0.y = cmp(r0.x == 0.000000);
  if (r0.y != 0) discard;
  r1.w = 20 * r0.x;
  o0.xyzw = v2.xyzw * r1.xyzw;
  o0.w = saturate(o0.w);
  return;
}