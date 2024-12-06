Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[4];
}

#define cmp -

void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  out float4 o0 : SV_Target0)
{
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = 9.99999975e-05 * cb0[3].x;
  r1.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  //r2.x = dot(float3(0.627402008,0.329291999,0.0433060005), r1.xyz);
  //r2.y = dot(float3(0.0690950006,0.919543982,0.0113599999), r1.xyz);
  //r2.z = dot(float3(0.0163940005,0.0880279988,0.895578027), r1.xyz);
  //r0.xyz = r2.xyz * r0.xxx;
  //r0.xyz = log2(abs(r0.xyz));
  //r0.xyz = float3(0.159301758,0.159301758,0.159301758) * r0.xyz;
  //r0.xyz = exp2(r0.xyz);
  //r2.xyz = r0.xyz * float3(18.8515625,18.8515625,18.8515625) + float3(0.8359375,0.8359375,0.8359375);
  //r0.xyz = r0.xyz * float3(18.6875,18.6875,18.6875) + float3(1,1,1);
  //r0.xyz = r2.xyz / r0.xyz;
  //r0.xyz = log2(r0.xyz);
  //r0.xyz = float3(78.84375,78.84375,78.84375) * r0.xyz;
  //r0.xyz = exp2(r0.xyz);
  //r0.w = cmp(asint(cb0[3].y) == 4);
  //r0.xyz = r0.www ? r0.xyz : r1.xyz;
  //r2.xyz = log2(abs(r1.xyz));
  //r2.xyz = float3(0.416666657,0.416666657,0.416666657) * r2.xyz;
  //r2.xyz = exp2(r2.xyz);
  //r2.xyz = r2.xyz * float3(1.05499995,1.05499995,1.05499995) + float3(-0.0549999997,-0.0549999997,-0.0549999997);
  //r3.xyz = cmp(r1.xyz < float3(0.00313080009,0.00313080009,0.00313080009));
  //r1.xyz = float3(12.9200001,12.9200001,12.9200001) * r1.xyz;
  //o0.w = r1.w;
  //r1.xyz = r3.xyz ? r1.xyz : r2.xyz;
  //o0.xyz = cb0[3].yyy ? r0.xyz : r1.xyz;
    o0.rgba = r1.rgba;
  return;
}