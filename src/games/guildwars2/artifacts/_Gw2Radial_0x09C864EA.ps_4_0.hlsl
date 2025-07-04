cbuffer Wheel : register(b0){
  float3 wipeMaskData : packoffset(c0);
  float wheelFadeIn : packoffset(c0.w);
  float animationTimer : packoffset(c1);
  float centerScale : packoffset(c1.y);
  int elementCount : packoffset(c1.z);
  float globalOpacity : packoffset(c1.w);
  float4 hoverFadeIns_[3] : packoffset(c2);
  float timeLeft : packoffset(c5);
  bool showIcon : packoffset(c5.y);
}
SamplerState MainSampler_s : register(s0);
Texture2D<float4> BackgroundTexture : register(t0);

#define cmp -

void main(
  float4 v0 : SV_Position0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(-0.5,-0.5) + v1.yx;
  r0.zw = float2(-3,-3) * r0.xy;
  r0.x = dot(r0.xy, r0.xy);
  r0.y = max(abs(r0.z), abs(r0.w));
  r0.y = 1 / r0.y;
  r1.x = min(abs(r0.z), abs(r0.w));
  r0.y = r1.x * r0.y;
  r1.x = r0.y * r0.y;
  r1.y = r1.x * 0.0208350997 + -0.0851330012;
  r1.y = r1.x * r1.y + 0.180141002;
  r1.y = r1.x * r1.y + -0.330299497;
  r1.x = r1.x * r1.y + 0.999866009;
  r1.y = r1.x * r0.y;
  r1.y = r1.y * -2 + 1.57079637;
  r1.z = cmp(abs(r0.w) < abs(r0.z));
  r1.y = r1.z ? r1.y : 0;
  r0.y = r0.y * r1.x + r1.y;
  r1.x = cmp(r0.w < -r0.w);
  r1.x = r1.x ? -3.141593 : 0;
  r0.y = r1.x + r0.y;
  r1.x = min(r0.z, r0.w);
  r1.x = cmp(r1.x < -r1.x);
  r1.y = max(r0.z, r0.w);
  r0.z = dot(r0.zw, r0.zw);
  r0.xz = sqrt(r0.xz);
  r0.w = cmp(r1.y >= -r1.y);
  r0.w = r0.w ? r1.x : 0;
  r0.y = r0.w ? -r0.y : r0.y;
  r0.y = 4.71238518 + r0.y;
  r0.w = elementCount;
  r0.w = 6.28318024 / r0.w;
  r1.x = r0.w * 0.5 + r0.y;
  r0.y = r0.y / r0.w;
  r0.y = round(r0.y);
  r0.y = (int)r0.y;
  r1.x = r1.x / r0.w;
  r1.y = cmp(r1.x >= -r1.x);
  r1.x = frac(abs(r1.x));
  r1.x = r1.y ? r1.x : -r1.x;
  r1.x = r1.x * r0.w;
  r0.w = r1.x / r0.w;
  r1.x = 0.001 + r0.z;
  r1.xy = float2(0.006,0.004) / r1.xx;
  r1.z = -r1.y + r0.w;
  r1.w = r1.x + -r1.y;
  r1.xy = float2(1,1) + -r1.xy;
  r1.w = 1 / r1.w;
  r1.z = saturate(r1.z * r1.w);
  r1.w = r1.z * -2 + 3;
  r1.z = r1.z * r1.z;
  r1.z = -r1.w * r1.z + 2;
  r0.w = -r1.x + r0.w;
  r1.x = r1.y + -r1.x;
  r1.x = 1 / r1.x;
  r0.w = saturate(r1.x * r0.w);
  r1.x = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r1.x * r0.w + 1;
  r0.w = r1.z * r0.w + -1;
  r1.xyzw = float4(3,3,5,5) * v1.xyxy;
  r2.xyzw = float4(0.1,0.370000005,0.129999995,0.479999989) * animationTimer;
  r2.x = cos(r2.x);
  r3.yz = r1.xy * r2.xx + r2.yy;
  r3.xw = float2(0.001,0.001) + r3.zz;
  r1.x = r3.x * 0.5 + r3.y;
  r1.y = frac(r1.x);
  r1.x = floor(r1.x);
  r2.x = frac(r3.x);
  r1.y = cmp(r2.x < r1.y);
  r4.xyz = r1.yyy ? float3(1,0,-0) : float3(0,1,-0.5);
  r3.z = floor(r3.x);
  r3.x = -r3.z * 0.5 + r1.x;
  r1.x = r3.x + r4.x;
  r5.x = r1.x + r4.z;
  r5.y = r3.z + r4.y;
  r4.y = r5.x;
  r1.xy = -r5.xy + r3.yw;
  r4.xz = float2(0,0.5) + r3.xx;
  r5.zw = float2(0,1) + r3.zz;
  r4.xyz = r5.zyw * float3(0.5,0.5,0.5) + r4.xyz;
  r6.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r4.xyz;
  r6.xyz = floor(r6.xyz);
  r4.xyz = -r6.xyz * float3(289,289,289) + r4.xyz;
  r6.xyz = r4.xyz * float3(34,34,34) + float3(1,1,1);
  r4.xyz = r6.xyz * r4.xyz;
  r6.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r4.xyz;
  r6.xyz = floor(r6.xyz);
  r4.xyz = -r6.xyz * float3(289,289,289) + r4.xyz;
  r6.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r5.zyw;
  r6.xyz = floor(r6.xyz);
  r5.xyz = -r6.xyz * float3(289,289,289) + r5.zyw;
  r4.xyz = r5.xyz + r4.xyz;
  r5.xyz = r4.xyz * float3(34,34,34) + float3(1,1,1);
  r4.xyz = r5.xyz * r4.xyz;
  r5.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r4.xyz;
  r5.xyz = floor(r5.xyz);
  r4.xyz = -r5.xyz * float3(289,289,289) + r4.xyz;
  r4.xyz = float3(0.024390243,0.024390243,0.024390243) * r4.xyz;
  r4.xyz = frac(r4.xyz);
  r4.xyz = float3(6.28318548,6.28318548,6.28318548) * r4.xyz;
  sincos(r4.z, r2.x, r5.x);
  r5.y = r2.x;
  r2.xy = float2(0.5,1) + r3.xz;
  r3.xz = r3.yw + -r3.xz;
  r2.xy = r3.yw + -r2.xy;
  r5.z = dot(r5.xy, r2.xy);
  r6.z = dot(r2.xy, r2.xy);
  sincos(r4.x, r2.x, r7.x);
  sincos(r4.y, r4.x, r8.x);
  r7.y = r2.x;
  r5.x = dot(r7.xy, r3.xz);
  r6.x = dot(r3.xz, r3.xz);
  r8.y = r4.x;
  r5.y = dot(r8.xy, r1.xy);
  r6.y = dot(r1.xy, r1.xy);
  r3.xyz = float3(0.8,0.8,0.8) + -r6.xyz;
  r3.xyz = max(float3(0,0,0), r3.xyz);
  r3.xyz = r3.xyz * r3.xyz;
  r3.xyz = r3.xyz * r3.xyz;
  r1.x = dot(r3.xyz, r5.xyz);
  r1.x = 11 * r1.x;
  r1.y = sin(r2.z);
  r2.yz = r1.zw * r1.yy + r2.ww;
  r2.xw = float2(0.001,0.001) + r2.zz;
  r1.y = r2.x * 0.5 + r2.y;
  r1.z = frac(r1.y);
  r1.y = floor(r1.y);
  r1.w = frac(r2.x);
  r1.z = cmp(r1.w < r1.z);
  r3.xyz = r1.zzz ? float3(1,0,-0) : float3(0,1,-0.5);
  r2.z = floor(r2.x);
  r2.x = -r2.z * 0.5 + r1.y;
  r1.y = r2.x + r3.x;
  r4.x = r1.y + r3.z;
  r4.y = r2.z + r3.y;
  r3.y = r4.x;
  r1.yz = -r4.xy + r2.yw;
  r3.xz = float2(0,0.5) + r2.xx;
  r4.zw = float2(0,1) + r2.zz;
  r3.xyz = r4.zyw * float3(0.5,0.5,0.5) + r3.xyz;
  r5.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r3.xyz;
  r5.xyz = floor(r5.xyz);
  r3.xyz = -r5.xyz * float3(289,289,289) + r3.xyz;
  r5.xyz = r3.xyz * float3(34,34,34) + float3(1,1,1);
  r3.xyz = r5.xyz * r3.xyz;
  r5.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r3.xyz;
  r5.xyz = floor(r5.xyz);
  r3.xyz = -r5.xyz * float3(289,289,289) + r3.xyz;
  r5.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r4.zyw;
  r5.xyz = floor(r5.xyz);
  r4.xyz = -r5.xyz * float3(289,289,289) + r4.zyw;
  r3.xyz = r4.xyz + r3.xyz;
  r4.xyz = r3.xyz * float3(34,34,34) + float3(1,1,1);
  r3.xyz = r4.xyz * r3.xyz;
  r4.xyz = float3(0.00346020772,0.00346020772,0.00346020772) * r3.xyz;
  r4.xyz = floor(r4.xyz);
  r3.xyz = -r4.xyz * float3(289,289,289) + r3.xyz;
  r3.xyz = float3(0.024390243,0.024390243,0.024390243) * r3.xyz;
  r3.xyz = frac(r3.xyz);
  r3.xyz = float3(6.28318548,6.28318548,6.28318548) * r3.xyz;
  sincos(r3.z, r4.x, r5.x);
  r5.y = r4.x;
  r3.zw = float2(0.5,1) + r2.xz;
  r2.xz = r2.yw + -r2.xz;
  r2.yw = -r3.zw + r2.yw;
  r4.z = dot(r5.xy, r2.yw);
  r5.z = dot(r2.yw, r2.yw);
  sincos(r3.x, r3.x, r6.x);
  sincos(r3.y, r7.x, r8.x);
  r6.y = r3.x;
  r4.x = dot(r6.xy, r2.xz);
  r5.x = dot(r2.xz, r2.xz);
  r8.y = r7.x;
  r4.y = dot(r8.xy, r1.yz);
  r5.y = dot(r1.yz, r1.yz);
  r1.yzw = float3(0.8,0.8,0.8) + -r5.xyz;
  r1.yzw = max(float3(0,0,0), r1.yzw);
  r1.yzw = r1.yzw * r1.yzw;
  r1.yzw = r1.yzw * r1.yzw;
  r1.y = dot(r1.yzw, r4.xyz);
  r1.x = r1.y * 11 + r1.x;
  r1.x = 4 + r1.x;
  r1.x = saturate(0.125 * r1.x);
  r1.x = r1.x * 0.399999976 + 0.899999976;
  r1.x = r1.x + r1.x;
  r2.xyzw = BackgroundTexture.Sample(MainSampler_s, v1.xy).xyzw;
  r1.xyz = r2.xyz * r1.xxx;
  r1.w = dot(r1.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r2.x = -r1.w * 0.2 + 1;
  r1.w = max(0.8, r1.w);
  r1.w = min(1.2, r1.w);
  r2.yz = float2(-0.00999999978,0.00999999978) + centerScale;
  r2.y = r0.z * r2.x + -r2.y;
  r2.z = -r2.z + r0.z;
  r0.z = r0.z * r2.x + -0.5;
  r0.z = saturate(r0.z + r0.z);
  r2.yz = saturate(float2(50,11.1111107) * r2.yz);
  r2.w = r2.y * -2 + 3;
  r2.y = r2.y * r2.y;
  r3.w = r2.w * r2.y;
  r2.x = -r2.w * r2.y + r2.x;
  r0.w = r3.w * r0.w + 1;
  r2.y = cmp(1 < elementCount);
  r0.w = r2.y ? r0.w : 1;
  r2.y = cmp((int)r0.y >= elementCount);
  r2.w = (int)r0.y + -elementCount;
  r0.y = r2.y ? r2.w : r0.y;
  r2.y = (int)r0.y & 3;
  r0.y = (uint)r0.y >> 2;
  r0.y = dot(hoverFadeIns_[r0.y].xyzw, icb[r2.y+0].xyzw);
  r2.y = min(wheelFadeIn, r0.y);
  r0.y = cmp(0 < r0.y);
  r2.w = cmp(r2.y < 1);
  r0.w = r2.w ? r0.w : 1;
  r0.y = r0.y ? r2.w : 0;
  r2.w = 1 + -r0.w;
  r2.w = r2.y * r2.w + r0.w;
  r0.y = r0.y ? r2.w : r0.w;
  r0.w = r2.y * r3.w;
  r0.w = r0.w * 0.5 + 1;
  r3.xyz = r1.xyz * r0.www;
  r0.w = r2.z * -2 + 3;
  r1.x = r2.z * r2.z;
  r0.w = -r0.w * r1.x + 2;
  r0.y = r0.y * r0.w;
  r0.y = max(1, r0.y);
  r0.y = min(2, r0.y);
  r0.w = elementCount & 3;
  r1.x = elementCount >> 2;
  r0.w = dot(hoverFadeIns_[r1.x].xyzw, icb[r0.w+0].xyzw);
  r2.w = r0.w * r2.x + r3.w;
  r1.x = r0.w * 0.5 + 1;
  r0.w = cmp(0 < r0.w);
  r1.y = 1 + -r1.x;
  r1.x = r3.w * r1.y + r1.x;
  r2.xyz = r3.xyz * r1.xxx;
  r2.xyzw = r0.wwww ? r2.xyzw : r3.xyzw;
  r0.w = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = -r0.w * r0.z + 1;
  r0.z = saturate(r0.z * r2.w);
  r2.w = 1;
  r2.xyzw = r2.xyzw * r0.zzzz;
  r2.xyzw = r2.xyzw * r0.yyyy;
  r1.xyzw = r2.xyzw * r1.wwww;
  r0.y = 1 + wheelFadeIn;
  r0.x = saturate(-r0.x * 2 + r0.y);
  r0.xyzw = r1.xyzw * r0.xxxx;
  r1.x = 1;
  r1.w = globalOpacity;
  r0.xyzw = r1.xxxw * r0.xyzw;
  r1.x = globalOpacity;
  r1.w = 1.2;
  o0.xyzw = r1.xxxw * r0.xyzw;
	o0.a = saturate(o0.a);
  return;
}