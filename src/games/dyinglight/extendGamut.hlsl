#include "./shared.h"

// from Musa
float3 extendGamut(float3 color, float extendGamutAmount)
{
  if (extendGamutAmount == 0) {
    return color;
  }

  float3 colorOKLab = renodx::color::oklab::from::BT709(color);

  // Extract L, C, h from OKLab
  float L = colorOKLab[0];
  float a = colorOKLab[1];
  float b = colorOKLab[2];
  float C = sqrt(a * a + b * b);
  float h = atan2(b, a);

  // Calculate the exponential weighting factor based on luminance and chroma
  float chromaWeight = 1.0f - exp(-4.0f * C);
  float luminanceWeight = 1.0f - exp(-4.0f * L * L);
  float weight = chromaWeight * luminanceWeight * extendGamutAmount;

  // Apply the expansion factor
  C *= (1.0f + weight);

  // Convert back to OKLab with adjusted chroma
  a = C * cos(h);
  b = C * sin(h);
  float3 adjustedOKLab = float3(L, a, b);

  float3 adjustedColor = renodx::color::bt709::from::OkLab(adjustedOKLab);
  float3 colorAP1 = renodx::color::ap1::from::BT709(adjustedColor);
  colorAP1 = max(0, colorAP1); // Clamp to AP1
  return renodx::color::bt709::from::AP1(colorAP1);
}