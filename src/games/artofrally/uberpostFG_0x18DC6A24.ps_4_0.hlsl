#include "./shared.h"
#include "./tonemapper.hlsl"

// ---- Created with 3Dmigoto v1.3.16 on Mon Oct  7 16:03:42 2024
Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture3D<float4> t3 : register(t3);

Texture2D<float4> t2 : register(t2);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s2_s : register(s2);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[42];
}




// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float2 w1 : TEXCOORD1,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t2.Sample(s2_s, v1.xy).xyzw;
  r1.xyzw = t1.Sample(s1_s, w1.xy).xyzw;
  r0.xyz = r1.xyz * r0.xxx;
  r0.w = cmp(cb0[40].y < 0.5);
  if (r0.w != 0) {
    r1.xy = -cb0[38].xy + v1.xy;
    r1.yz = cb0[39].xx * abs(r1.yx);
    r0.w = cb0[22].x / cb0[22].y;
    r0.w = -1 + r0.w;
    r0.w = cb0[39].w * r0.w + 1;
    r1.x = r1.z * r0.w;
    r1.xy = saturate(r1.xy);
    r1.xy = log2(r1.xy);
    r1.xy = cb0[39].zz * r1.xy;
    r1.xy = exp2(r1.xy);
    r0.w = dot(r1.xy, r1.xy);
    r0.w = 1 + -r0.w;
    r0.w = max(0, r0.w);
    r0.w = log2(r0.w);
    r0.w = cb0[39].y * r0.w * injectedData.fxVignette;         // vignette
    r0.w = exp2(r0.w);
    r1.xyz = float3(1,1,1) + -cb0[37].xyz;
    r1.xyz = r0.www * r1.xyz + cb0[37].xyz;
    r1.xyz = r1.xyz * r0.xyz;
    r2.x = -1 + r1.w;
    r2.w = r0.w * r2.x + 1;
  } else {
    r3.xyzw = t4.Sample(s4_s, v1.xy).xyzw;
    r0.w = 0.0773993805 * r3.w;
    r3.x = 0.0549999997 + r3.w;
    r3.x = 0.947867334 * r3.x;
    r3.x = max(1.1920929e-07, abs(r3.x));
    r3.x = log2(r3.x);
    r3.x = 2.4000001 * r3.x;
    r3.x = exp2(r3.x);
    r3.y = cmp(0.0404499993 >= r3.w);
    r0.w = r3.y ? r0.w : r3.x;
    r3.xyz = float3(1,1,1) + -cb0[37].xyz;
    r3.xyz = r0.www * r3.xyz + cb0[37].xyz;
    r3.xyz = r0.xyz * r3.xyz + -r0.xyz;
    r1.xyz = cb0[40].xxx * r3.xyz + r0.xyz;
    r0.x = -1 + r1.w;
    r2.w = r0.w * r0.x + 1;
  }
  r0.xy = w1.xy * cb0[41].xy + cb0[41].zw;
  r0.xyzw = t5.Sample(s5_s, r0.xy).xyzw;
  r3.xyz = saturate(r1.xyz);
  r0.w = dot(r3.xyz, float3(0.212672904,0.715152204,0.0721750036));
  r0.w = sqrt(r0.w);
  r0.w = cb0[40].z * -r0.w + 1;
  r0.xyz = r1.xyz * r0.xyz;
  r0.xyz = cb0[40].www * r0.xyz;
  r2.xyz = r0.xyz * r0.www * injectedData.fxFilmGrain + r1.xyz;     // noise
    
    float3 untonemapped = r2.rgb;
    r2.rgb = float3(0.18f, 0.18f, 0.18f);
  r0.xyzw = cb0[36].zzzz * r2.xyzw;
  r0.xyz = r0.xyz * float3(5.55555582,5.55555582,5.55555582) + float3(0.0479959995,0.0479959995,0.0479959995);
  r0.xyz = log2(r0.xyz);
  r0.xyz = saturate(r0.xyz * float3(0.0734997839,0.0734997839,0.0734997839) + float3(0.386036009,0.386036009,0.386036009));
  r0.xyz = cb0[36].yyy * r0.xyz;
  r1.x = 0.5 * cb0[36].x;
  r0.xyz = r0.xyz * cb0[36].xxx + r1.xxx;
  r1.xyzw = t3.Sample(s3_s, r0.xyz).xyzw;
    
    float vanillaGray = renodx::color::y::from::BT709(r1.rgb);
    r1.rgb = applyUserTonemap(untonemapped, t3, s3_s, vanillaGray);
    
  r0.xy = v1.xy * cb0[30].xy + cb0[30].zw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.x = r2.w * 2 + -1;
  r0.y = saturate(r0.x * 3.40282347e+38 + 0.5);
  r0.y = r0.y * 2 + -1;
  r0.x = 1 + -abs(r0.x);
  r0.x = sqrt(r0.x);
  r0.x = 1 + -r0.x;
  r0.x = r0.y * r0.x;
  //r2.xyz = float3(12.9200001,12.9200001,12.9200001) * r1.xyz;
  //r3.xyz = max(float3(1.1920929e-07,1.1920929e-07,1.1920929e-07), abs(r1.xyz));
  //r3.xyz = log2(r3.xyz);
  //r3.xyz = float3(0.416666657,0.416666657,0.416666657) * r3.xyz;
  //r3.xyz = exp2(r3.xyz);
  //r3.xyz = r3.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r1.xyz = cmp(float3(0.00313080009,0.00313080009,0.00313080009) >= r1.xyz);
  //r1.xyz = r1.xyz ? r2.xyz : r3.xyz;
  //r0.xyz = r0.xxx * float3(0.00392156886,0.00392156886,0.00392156886) + r1.xyz;
  //r1.xyz = float3(0.0773993805,0.0773993805,0.0773993805) * r0.xyz;
  //r2.xyz = float3(0.0549999997,0.0549999997,0.0549999997) + r0.xyz;
  //r2.xyz = float3(0.947867334,0.947867334,0.947867334) * r2.xyz;
  //r2.xyz = max(float3(1.1920929e-07,1.1920929e-07,1.1920929e-07), abs(r2.xyz));
  //r2.xyz = log2(r2.xyz);
  //r2.xyz = float3(2.4000001,2.4000001,2.4000001) * r2.xyz;
  //r2.xyz = exp2(r2.xyz);
  //r0.xyz = cmp(float3(0.0404499993,0.0404499993,0.0404499993) >= r0.xyz);
  //o0.xyz = r0.xyz ? r1.xyz : r2.xyz;
        if (injectedData.toneMapType == 0){
    r1.rgb = renodx::color::srgb::EncodeSafe(r1.rgb);
    r1.rgb = r0.rrr * float3(0.00392156886, 0.00392156886, 0.00392156886) + r1.rgb;
    r1.rgb = renodx::color::srgb::DecodeSafe(r1.rgb);
    }
		if (injectedData.toneMapGammaCorrection == 1){
    r1.rgb = renodx::color::correct::GammaSafe(r1.rgb);
    r1.rgb *= injectedData.toneMapGameNits / 80.f;
    r1.rgb = renodx::color::correct::GammaSafe(r1.rgb, true);
    } else {
    r1.rgb *= injectedData.toneMapGameNits / 80.f;
    }
    o0.rgb = r1.rgb;
  o0.w = r0.w;
  return;
}