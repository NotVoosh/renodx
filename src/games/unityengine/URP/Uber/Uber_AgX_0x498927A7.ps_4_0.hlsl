#include "../../common.hlsli"

Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[145];
}

#define cmp -

static const float3x3 linearBT709_to_something = float3x3(
    0.84247905, 0.0423282422, 0.042375654,
    0.078433603, 0.878468633, 0.078433603,
    0.0792237446, 0.0791661292, 0.879143);

static const float3x3 something_to_linearBT709 = float3x3(
    1.19687903, -0.0528968535, -0.052971635,
    -0.0980208814, 1.15190315, -0.0980434492,
    -0.0990297422, -0.0989611745, 1.15107369);

float3 curve(float3 x) {
  float3 log = min(max(log2(x), -12.47393), 4.026069) - -12.47393;
  float3 scaled_log = log / (4.026069 + 12.47393);
  float3 x2 = scaled_log * scaled_log;
  float3 x3 = scaled_log * scaled_log * scaled_log;
  float3 x4 = scaled_log * scaled_log * scaled_log * scaled_log;
  float3 x5 = scaled_log * scaled_log * scaled_log * scaled_log * scaled_log;
  float3 x6 = scaled_log * scaled_log * scaled_log * scaled_log * scaled_log * scaled_log;
  return log * 0.00721818209 + x2 * 0.4298 + 31.96 * x4 + 15.5 * x6 - 40.14 * x5 - x3 * 6.868 - 0.00232;
}

float3 AgX(float3 input) {
  float3 some_color_space = mul(linearBT709_to_something, input);
  float3 curved = curve(some_color_space);
  float curved_y = renodx::color::y::from::BT709(curved);
  float3 result = lerp(curved_y, curved * float3(0.95, 1.03, 1.03) + 0.04, 0.9);
  return mul(something_to_linearBT709, result);
}

float3 AgXtended(float3 input) {
  float3 some_color_space = mul(linearBT709_to_something, input);
  float3 curved = curve(some_color_space);
  float3 extended = some_color_space > 0.4029 ?
  some_color_space * 0.432307771115 + 0.46662147075 :
  curved;
  float extended_y = renodx::color::y::from::BT709(extended);
  float3 result = lerp(extended_y, extended * float3(0.95, 1.03, 1.03) + 0.04, 0.9);
  return mul(something_to_linearBT709, result);
}

float3 AgXTonemap(float3 color) {
  bool extended = RENODX_TONE_MAP_TYPE != 0.f;
  float3 sdr_color = AgX(color);
  float3 output_color;
  [branch]
  if (!extended) {
    output_color = sdr_color;
  } else {
    float compression_scale;
    GamutCompression(color, compression_scale);
    float3 hdr_color = AgXtended(color);
    GamutDecompression(hdr_color, compression_scale);
    output_color = CorrectHueAndChrominanceOKLAB(hdr_color, sdr_color, RENODX_TONE_MAP_SDRHUE, RENODX_TONE_MAP_SDRCHROMINANCE);
  }
  return output_color;
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.SampleBias(s0_s, v1.xy, cb0[19].x).xyzw;
  r1.xy = v1.xy * cb0[144].zw + float2(0.5,0.5);
  r1.zw = floor(r1.xy);
  r1.xy = frac(r1.xy);
  r2.xyzw = -r1.xyxy * float4(0.5,0.5,0.166666672,0.166666672) + float4(0.5,0.5,0.5,0.5);
  r2.xyzw = r1.xyxy * r2.xyzw + float4(0.5,0.5,-0.5,-0.5);
  r3.xy = r1.xy * float2(0.5,0.5) + float2(-1,-1);
  r3.zw = r1.xy * r1.xy;
  r3.xy = r3.zw * r3.xy + float2(0.666666687,0.666666687);
  r2.xyzw = r1.xyxy * r2.xyzw + float4(0.166666672,0.166666672,0.166666672,0.166666672);
  r1.xy = float2(1,1) + -r3.xy;
  r1.xy = r1.xy + -r2.xy;
  r1.xy = r1.xy + -r2.zw;
  r2.zw = r2.zw + r3.xy;
  r2.xy = r2.xy + r1.xy;
  r3.zw = float2(1,1) / r2.zw;
  r3.zw = r3.xy * r3.zw + float2(-1,-1);
  r4.xy = float2(1,1) / r2.xy;
  r3.xy = r1.xy * r4.xy + float2(1,1);
  r4.xyzw = r3.zwxw + r1.zwzw;
  r4.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r4.xyzw;
  r4.xyzw = cb0[144].xyxy * r4.xyzw;
  r4.xyzw = min(float4(1,1,1,1), r4.xyzw);
  r5.xyzw = t1.SampleLevel(s0_s, r4.xy, 0).xyzw;
  r4.xyzw = t1.SampleLevel(s0_s, r4.zw, 0).xyzw;
  r4.xyzw = r4.xyzw * r2.xxxx;
  r4.xyzw = r2.zzzz * r5.xyzw + r4.xyzw;
  r1.xyzw = r3.zyxy + r1.zwzw;
  r1.xyzw = float4(-0.5,-0.5,-0.5,-0.5) + r1.xyzw;
  r1.xyzw = cb0[144].xyxy * r1.xyzw;
  r1.xyzw = min(float4(1,1,1,1), r1.xyzw);
  r3.xyzw = t1.SampleLevel(s0_s, r1.xy, 0).xyzw;
  r1.xyzw = t1.SampleLevel(s0_s, r1.zw, 0).xyzw;
  r1.xyzw = r2.xxxx * r1.xyzw;
  r1.xyzw = r2.zzzz * r3.xyzw + r1.xyzw;
  r1.xyzw = r2.yyyy * r1.xyzw;
  r1.xyzw = r2.wwww * r4.xyzw + r1.xyzw;
  if (cb0[133].x > 0) {
    r2.xyz = r1.xyz * r1.www;
    r1.xyz = float3(8,8,8) * r2.xyz;
  }
  r0.xyz = r1.xyz * cb0[134].www * CUSTOM_BLOOM + r0.xyz;
  if (cb0[141].z > 0) {
    r1.xy = -cb0[141].xy + v1.xy;
    r1.yz = cb0[141].zz * abs(r1.xy) * min(1.f, CUSTOM_VIGNETTE);
    r1.x = cb0[140].w * r1.y;
    r0.w = dot(r1.xz, r1.xz);
    r0.w = 1 + -r0.w;
    r0.w = max(0, r0.w);
    r0.w = log2(r0.w);
    r0.w = cb0[141].w * r0.w * max(1.f, CUSTOM_VIGNETTE);
    r0.w = exp2(r0.w);
    r1.xyz = float3(1,1,1) + -cb0[140].xyz;
    r1.xyz = r0.www * r1.xyz + cb0[140].xyz;
    r0.xyz = r1.xyz * r0.xyz;
  }
  r0.xyz = cb0[128].www * r0.xyz;
  float3 untonemapped = renodx::color::srgb::EncodeSafe(r0.xyz);
  float3 tonemapped = AgXTonemap(r0.xyz);
  if (RENODX_TONE_MAP_TYPE == 1.f) {
    r0.w = untonemapped.x;
    r1.x = untonemapped.y;
    r0.x = untonemapped.z;
  } else {
    r0.w = tonemapped.x;
    r1.x = tonemapped.y;
    r0.x = tonemapped.z;
  }
  float compression_scale;
  float max_channel_scale;
  GamutCompression(float3(r0.w, r1.x, r0.x), compression_scale);
  NeutwoMaxCh(float3(r0.w, r1.x, r0.x), max_channel_scale);
  r0.y = cb0[130].x + -cb0[130].z;
  r0.z = cb0[130].w * r0.y;
  r0.z = r0.z / cb0[130].y;
  r1.y = -cb0[130].z + r0.w;
  r1.y = cb0[130].y * r1.y + cb0[130].z;
  r1.z = r0.w / cb0[130].z;
  r1.w = pow(r1.z, cb0[131].x);
  r1.w = cb0[130].z * r1.w + cb0[131].y;
  r0.z = cb0[130].z + r0.z;
  r0.y = r0.y * cb0[130].w + cb0[130].z;
  r2.x = cb0[130].y * cb0[130].x;
  r0.y = cb0[130].x + -r0.y;
  r2.x = r2.x / r0.y;
  r2.y = r0.w + -r0.z;
  r2.z = r2.x * r2.y;
  r2.z = r2.z / cb0[130].x;
  r2.yz = float2(1,-1.44269502) * r2.yz;
  r2.z = exp2(r2.z);
  r2.z = -r0.y * r2.z + cb0[130].x;
  r2.w = cmp(0 < r0.w);
  r3.x = cmp(r0.w >= cb0[130].z);
  r3.y = r1.z * r1.z;
  r1.z = -r1.z * 2 + 3;
  r1.z = r3.y * r1.z;
  r1.z = r3.x ? 1 : r1.z;
  r1.z = r2.w ? r1.z : 0;
  r1.z = 1 + -r1.z;
  r2.w = cmp(r0.z < r0.w);
  r0.w = cmp(r0.w >= r0.z);
  r0.w = r0.w ? 1 : r2.y;
  r0.w = r2.w ? r0.w : 0;
  r2.y = 1 + -r1.z;
  r2.y = r2.y + -r0.w;
  r1.y = r2.y * r1.y;
  r1.y = r1.w * r1.z + r1.y;
  r3.y = r2.z * r0.w + r1.y;
  r0.w = -cb0[130].z + r1.x;
  r0.w = cb0[130].y * r0.w + cb0[130].z;
  r1.y = r1.x / cb0[130].z;
  r1.z = pow(r1.y, cb0[131].x);
  r1.z = cb0[130].z * r1.z + cb0[131].y;
  r1.w = r1.x + -r0.z;
  r2.y = r2.x * r1.w;
  r2.y = r2.y / cb0[130].x;
  r2.y = -1.44269502 * r2.y;
  r2.y = exp2(r2.y);
  r2.y = -r0.y * r2.y + cb0[130].x;
  r2.z = cmp(0 < r1.x);
  r2.w = cmp(r1.x >= cb0[130].z);
  r3.w = r1.y * r1.y;
  r1.y = -r1.y * 2 + 3;
  r1.y = r3.w * r1.y;
  r1.y = r2.w ? 1 : r1.y;
  r1.y = r2.z ? r1.y : 0;
  r1.y = 1 + -r1.y;
  r2.z = cmp(r0.z < r1.x);
  r1.x = cmp(r1.x >= r0.z);
  r1.w = 1 * r1.w;
  r1.x = r1.x ? 1 : r1.w;
  r1.x = r2.z ? r1.x : 0;
  r1.w = 1 + -r1.y;
  r1.w = r1.w + -r1.x;
  r0.w = r1.w * r0.w;
  r0.w = r1.z * r1.y + r0.w;
  r3.z = r2.y * r1.x + r0.w;
  r0.w = -cb0[130].z + r0.x;
  r0.w = cb0[130].y * r0.w + cb0[130].z;
  r1.x = r0.x / cb0[130].z;
  r1.y = pow(r1.x, cb0[131].x);
  r1.y = cb0[130].z * r1.y + cb0[131].y;
  r1.z = r0.x + -r0.z;
  r1.w = r2.x * r1.z;
  r1.w = r1.w / cb0[130].x;
  r1.w = -1.44269502 * r1.w;
  r1.w = exp2(r1.w);
  r0.y = -r0.y * r1.w + cb0[130].x;
  r1.w = cmp(0 < r0.x);
  r2.x = cmp(r0.x >= cb0[130].z);
  r2.y = r1.x * r1.x;
  r1.x = -r1.x * 2 + 3;
  r1.x = r2.y * r1.x;
  r1.x = r2.x ? 1 : r1.x;
  r1.x = r1.w ? r1.x : 0;
  r1.x = 1 + -r1.x;
  r1.w = cmp(r0.z < r0.x);
  r0.x = cmp(r0.x >= r0.z);
  r0.z = 1 * r1.z;
  r0.x = r0.x ? 1 : r0.z;
  r0.x = r1.w ? r0.x : 0;
  r0.z = 1 + -r1.x;
  r0.z = r0.z + -r0.x;
  r0.z = r0.w * r0.z;
  r0.z = r1.y * r1.x + r0.z;
  r3.x = r0.y * r0.x + r0.z;
  NeutwoMaxChInverse(r3.yzx, max_channel_scale);
  GamutDecompression(r3.yzx, compression_scale);
  if (RENODX_TONE_MAP_TYPE == 0.f) {
    r3.yzx = saturate(r3.yzx);
    r0.xyz = r3.xyz * float3(-2,-2,-2) + float3(3,3,3);
    r1.xyz = r3.xyz * r3.xyz;
    r0.xyz = r0.xyz * r1.xyz + -r3.xyz;
    r0.xyz = cb0[131].zzz * r0.xyz + r3.xyz;
  } else {
    float3 x = saturate(r3.xyz);
    float3 smoothstepValue = x * x * (3.0 - 2.0 * x);
    r0.xyz = r3.xyz + cb0[131].z * (smoothstepValue - x);
  }
  r0.xyz = renodx::color::srgb::DecodeSafe(r0.xyz);
  r0.yzx = lutShaper(r0.yzx, false, 1);
  if (CUSTOM_LUT_SAMPLE == 0.f) {
  r0.yzw = cb0[128].zzz * r0.xyz;
  r0.y = floor(r0.y);
  r1.xy = float2(0.5,0.5) * cb0[128].xy;
  r1.yz = r0.zw * cb0[128].xy + r1.xy;
  r1.x = r0.y * cb0[128].y + r1.y;
  r2.xyzw = t2.SampleLevel(s0_s, r1.xz, 0).xyzw;
  r3.x = cb0[128].y;
  r3.y = 0;
  r0.zw = r3.xy + r1.xz;
  r1.xyzw = t2.SampleLevel(s0_s, r0.zw, 0).xyzw;
  r0.x = r0.x * cb0[128].z + -r0.y;
  r0.yzw = r1.xyz + -r2.xyz;
  r0.xyz = r0.xxx * r0.yzw + r2.xyz;
  } else {
    r0.xyz = renodx::lut::SampleTetrahedral(t2, r0.yzx, cb0[128].z + 1u);
  }
  if (CUSTOM_COUNT_OLD_2 == CUSTOM_COUNT_NEW_2) {
    r0.xyz = GradeAndDisplayMap(r0.xyz);
  }
  if (CUSTOM_COUNT_OLD == CUSTOM_COUNT_NEW) {
    r0.xyz = PostToneMapScale(r0.xyz, true);
  } else {
    r0.xyz = renodx::color::gamma::EncodeSafe(r0.xyz, 2.2f);
  }
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}