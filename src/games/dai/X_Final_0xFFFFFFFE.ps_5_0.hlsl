#include "./shared.h"

SamplerState sourceSampler_s : register(s0);
Texture2D<float4> sourceTexture : register(t0);

void main(
        float4 vpos : SV_Position,
        float2 texcoord : TEXCOORD,
    out float4 output : SV_Target0)
{
    float4 color = sourceTexture.Sample(sourceSampler_s, texcoord.xy);

    //Below is Ersh's FF14 code
    //if (injectedData.toneMapType == 0) {
    //    color = saturate(color);
    //}

    color.rgb = sign(color.rgb) * pow(abs(color.rgb), 2.2f);

    if (injectedData.toneMapType == 0) {
      color.rgb *= injectedData.toneMapGameNits / 80.f;
    } else {
      color.rgb *= injectedData.toneMapUINits / 80.f;
    }
    output.rgba = color;
}