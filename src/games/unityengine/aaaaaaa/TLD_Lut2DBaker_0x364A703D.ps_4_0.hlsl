#include "../tonemap.hlsl"

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
cbuffer cb0 : register(b0){
  float4 cb0[50];
}

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.yz = -cb0[28].yz + v1.xy;
  r1.x = cb0[28].x * r0.y;
  r0.x = frac(r1.x);
  r1.x = r0.x / cb0[28].x;
  r0.w = -r1.x + r0.y;
  r0.xyz = r0.xzw * cb0[28].www;
  float3 preCG;
  if (injectedData.colorGradeInternalLUTShaper == 0.f) {
    preCG = arriDecode(r0.xyz);
    r0.xyz = r0.xyz + float3(-0.4135884,-0.4135884,-0.4135884);
    r0.xyz = r0.xyz * cb0[32].zzz + float3(0.4135884,0.4135884,0.4135884);
    r0.xyz = arriDecode(r0.xyz);
    } else {
    r0.xyz = lutShaper(r0.xyz, true);
    preCG = r0.xyz;
    r0.xyz = renodx::color::arri::logc::c1000::Encode(r0.rgb, true);
    r0.xyz = r0.xyz + float3(-0.4135884,-0.4135884,-0.4135884);
    r0.xyz = r0.xyz * cb0[32].zzz + float3(0.4135884,0.4135884,0.4135884);
    r0.xyz = renodx::color::arri::logc::c1000::Decode(r0.xyz, true);
    }
  r1.x = dot(float3(0.390405,0.549941,0.00892632), r0.xyz);
  r1.y = dot(float3(0.0708416,0.963172,0.00135775), r0.xyz);
  r1.z = dot(float3(0.0231082,0.128021,0.936245), r0.xyz);
  r0.xyz = cb0[30].xyz * r1.xyz;
  r1.x = dot(float3(2.858470,-1.628790,-0.024891), r0.xyz);
  r1.y = dot(float3(-0.210182,1.158200,0.000324281), r0.xyz);
  r1.z = dot(float3(-0.041812,-0.118169,1.068670), r0.xyz);
  r0.xyz = cb0[31].xyz * r1.xyz;
  r1.x = dot(r0.xyz, cb0[33].yzw);
  r1.y = dot(r0.xyz, cb0[34].xyz);
  r1.z = dot(r0.xyz, cb0[35].xyz);
  float3 preLGG = r1.xyz;
  r0.xyz = r1.xyz * cb0[38].xyz + cb0[36].xyz;
  r1.xyz = log2(abs(r0.xyz));
  r0.xyz = saturate(r0.xyz * renodx::math::FLT_MAX + float3(0.5,0.5,0.5));
  r0.xyz = r0.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r1.xyz = cb0[37].xyz * r1.xyz;
  r1.xyz = exp2(r1.xyz);
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = liftGammaGainScaling(r0.xyz, preLGG, cb0[36].xyz, cb0[37].xyz, cb0[38].xyz);
  r0.xyz = max(float3(0,0,0), r0.xyz);
  r0.w = step(r0.z, r0.y);
  r1.xy = r0.zy;
  r2.xy = -r1.xy + r0.yz;
  r1.zw = float2(-1.0, 2.0 / 3.0);
  r2.zw = float2(1,-1);
  r1.xyzw = r0.wwww * r2.xywz + r1.xywz;
  r0.w = step(r1.x, r0.x);
  r2.z = r1.w;
  r1.w = r0.x;
  r3.x = dot(r0.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r2.xyw = r1.wyx;
  r2.xyzw = r2.xyzw + -r1.xyzw;
  r0.xyzw = r0.wwww * r2.xyzw + r1.xyzw;
  r1.x = min(r0.w, r0.y);
  r1.x = -r1.x + r0.x;
  r1.y = r1.x * 6.0 + 0.0001;
  r0.y = r0.w + -r0.y;
  r0.y = r0.y / r1.y;
  r0.y = r0.z + r0.y;
  r2.x = abs(r0.y);
  r2.yw = float2(0.25,0.25);
  r4.xyzw = t0.SampleLevel(s0_s, r2.xy, 0).yxzw;
  r3.z = cb0[32].x + r2.x;
  r4.x = saturate(r4.x);
  r0.y = r4.x + r4.x;
  r0.z = 0.0001 + r0.x;
  r0.x = log2(r0.x);
  r0.x = cb0[49].y * r0.x;
  r0.x = exp2(r0.x);
  r0.x = cb0[49].w * r0.x;
  r2.z = r1.x / r0.z;
  r1.xyzw = t0.SampleLevel(s0_s, r2.zw, 0).zxyw;
  r1.x = saturate(r1.x);
  r0.y = dot(r1.xx, r0.yy);
  r3.yw = float2(0.25,0.25);
  r1.xyzw = t0.SampleLevel(s0_s, r3.xy, 0).wxyz;
  r4.xyzw = t0.SampleLevel(s0_s, r3.zw, 0).xyzw;
  r4.x = saturate(r4.x);
  r0.z = r4.x + r3.z;
  r1.yzw = float3(-0.5,0.5,-1.5) + r0.zzz;
  r1.x = saturate(r1.x);
  r0.y = r1.x * r0.y;
  r0.y = dot(cb0[32].yy, r0.yy);
  r0.z = (r1.y > 1) ? r1.w : r1.y;
  r0.z = (r1.y < 0) ? r1.z : r0.z;
  r1.xyz = float3(1.0, 2.0 / 3.0, 1.0 / 3.0) + r0.zzz;
  r1.xyz = frac(r1.xyz);
  r1.xyz = r1.xyz * float3(6,6,6) + float3(-3,-3,-3);
  r1.xyz = saturate(float3(-1,-1,-1) + abs(r1.xyz));
  r1.xyz = float3(-1,-1,-1) + r1.xyz;
  r1.xyz = r2.zzz * r1.xyz + float3(1,1,1);
  r2.xyz = r1.xyz * r0.xxx;
  r0.z = dot(r2.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r1.xyz = r0.xxx * r1.xyz + -r0.zzz;
  r0.xyz = r0.yyy * r1.xyz + r0.zzz;
  r0.xyz = cb0[33].xxx * r0.xyz;
  r0.xyz = lerp(preCG, r0.xyz, injectedData.colorGradeInternalLUTStrength);
  o0.xyz = r0.xyz;
  o0.w = 1;
  return;
}