#include "./common.hlsl"

Texture2D<float4> t3 : register(t3);
Texture2D<float4> t2 : register(t2);
Texture2D<float4> t1 : register(t1);
Texture2D<float4> t0 : register(t0);

SamplerState s3_s : register(s3);
SamplerState s2_s : register(s2);
SamplerState s1_s : register(s1);
SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0){
  float4 cb0[16];
}

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  float2 v2 : TEXCOORD2,
  float2 w2 : TEXCOORD3,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = -cb0[14].xy + v1.xy;

  r0.xy = cb0[15].xx * abs(r0.xy) * min(1, injectedData.fxVignette);

  r0.xy = log2(r0.xy);
  r0.xy = cb0[15].zz * r0.xy;
  r0.xy = exp2(r0.xy);
  r0.x = dot(r0.xy, r0.xy);
  r0.x = 1 + -r0.x;
  r0.x = max(0, r0.x);

  r0.x = log2(r0.x);
  r0.x = cb0[15].y * r0.x * max(1, injectedData.fxVignette);
  r0.x = exp2(r0.x);

  r0.yzw = float3(1,1,1) + -cb0[13].zxy;
  r0.xyz = r0.xxx * r0.yzw + cb0[13].zxy;
  r1.xyzw = t0.Sample(s0_s, w1.xy).xyzw;
    r1.rgb = renodx::color::srgb::DecodeSafe(r1.brg);
  r2.xyzw = t1.Sample(s1_s, w2.xy).xyzw;
  r1.xyz = r1.xyz * r2.www + r2.zxy;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = cb0[9].www * r0.xyz;
  
    float3 preLUT = r0.gbr;
    r0.rgb = lutShaper(r0.rgb);
    
  r0.yzw = cb0[9].zzz * r0.xyz;
  r0.y = floor(r0.y);
  r0.x = r0.x * cb0[9].z + -r0.y;
  r1.xy = float2(0.5,0.5) * cb0[9].xy;
  r1.yz = r0.zw * cb0[9].xy + r1.xy;
  r1.x = r0.y * cb0[9].y + r1.y;
  r2.x = cb0[9].y;
  r2.y = 0;
  r0.yz = r2.xy + r1.xz;
  r1.xyzw = t2.Sample(s2_s, r1.xz).xyzw;
  r2.xyzw = t2.Sample(s2_s, r0.yz).xyzw;
  r0.yzw = r2.xyz + -r1.xyz;
  //r0.xyz = saturate(r0.xxx * r0.yzw + r1.xyz);
    r0.rgb = r0.xxx * r0.yzw + r1.xyz;
    r0.rgb = lerp(preLUT, r0.rgb, injectedData.colorGradeLUTStrength);
    r0.rgb = applyUserTonemap(r0.rgb);

  r1.xy = v1.xy * cb0[12].xy + cb0[12].zw;
  r1.xyzw = t3.Sample(s3_s, r1.xy).xyzw;
  r1.xyz = r1.xyz * r0.xyz;
  r1.xyz = cb0[11].yyy * r1.xyz * injectedData.fxFilmGrain;
  r0.w = renodx::color::y::from::BT709(r0.rgb);
    r0.a = renodx::math::SqrtSafe(r0.a);
  r0.w = cb0[11].x * -r0.w + 1;
    if(injectedData.fxFilmGrainType == 0.f){
  r0.xyz = r1.xyz * r0.www + r0.xyz;
  } else {
    r0.rgb = applyFilmGrain(r0.rgb, w1);
  }
    o0.rgb = renodx::color::srgb::EncodeSafe(r0.rgb);
  o0.w = 1;
  return;
}