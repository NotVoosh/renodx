#include "./common.hlsl"

// https://github.com/Unity-Technologies/Graphics/blob/e42df452b62857a60944aed34f02efa1bda50018/com.unity.postprocessing/PostProcessing/Shaders/Builtins/Lut3DBaker.compute
// KGenLUT3D_AcesTonemap

Texture2D<float4> t0 : register(t0);
SamplerState s0_s : register(s0);
RWTexture3D<float4> u0 : register(u0);
cbuffer cb0 : register(b0) {
  float4 cb0[10];
}

#define cmp -

[numthreads(4, 4, 4)]
void main(uint3 vThreadID: SV_DispatchThreadID) {
  float4 r0, r1, r2, r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.rgb = (uint3)vThreadID.rgb;
  r1.rgb = cmp(r0.rgb < cb0[0].rrr);
  r0.a = r1.g ? r1.r : 0;
  r0.a = r1.b ? r0.a : 0;
  if (r0.a != 0) {
    // (start) ColorGrade
    r0.rgb = r0.rgb * cb0[0].ggg;
    r0.rgb = lutShaper(r0.rgb, true);
    // unity_to_ACES(r0.rgb)
    r1.r = dot(float3(0.439701, 0.382978, 0.177335), r0.rgb);
    r1.g = dot(float3(0.0897923, 0.813423, 0.0967616), r0.rgb);
    r1.b = dot(float3(0.017544, 0.111544, 0.870704), r0.rgb);
    float3 preCG = r1.rgb;
    // ACEScc (log) space
    // ACES_to_ACEScc(r1.rgb)
    r0.rgb = max(0, r1.rgb);
    r0.rgb = min(r0.rgb, 65504);
    r1.rgb = cmp(r0.rgb < float3(0.0000305175708, 0.0000305175708, 0.0000305175708));
    r2.rgb = r0.rgb * float3(0.5, 0.5, 0.5) + float3(0.0000152587800, 0.0000152587800, 0.0000152587800);
    r2.rgb = log2(r2.rgb);
    r2.rgb = r2.rgb + float3(9.72, 9.72, 9.72);
    r2.rgb = r2.rgb * float3(0.0570776239, 0.0570776239, 0.0570776239);
    r0.rgb = log2(r0.rgb);
    r0.rgb = r0.rgb + float3(9.72, 9.72, 9.72);
    r0.rgb = r0.rgb * float3(0.0570776239, 0.0570776239, 0.0570776239);
    r0.rgb = r1.rgb ? r2.rgb : r0.rgb;
    // (start) LogGrade
    // Contrast(r0.rgb, ACEScc_MIDGRAY, cb0[3].b)
    r0.rgb = r0.rgb + float3(-0.413588405, -0.413588405, -0.413588405);
    r0.rgb = r0.rgb * cb0[3].bbb + float3(0.413588405, 0.413588405, 0.413588405);
    // ACEScc_to_ACES(r0.rgb)
    r1.rgb = r0.rgb * float3(17.52, 17.52, 17.52) + float3(-9.72, -9.72, -9.72);
    r1.rgb = exp2(r1.rgb);
    r2.rgb = r1.rgb + float3(-0.0000152587891, -0.0000152587891, -0.0000152587891);
    r2.rgb = r2.rgb + r2.rgb;
    r3.rgba = cmp(r0.rrgg < float4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
    r0.rg = r3.ga ? r1.rg : float2(65504, 65504);
    r3.rg = r3.rb ? r2.rg : r0.rg;
    r0.rg = cmp(r0.bb < float2(-0.301369876, 1.46799636));
    r0.g = r0.g ? r1.b : 65504;
    r3.b = r0.r ? r2.b : r0.g;
    // ACES_to_ACEScg
    r0.r = dot(float3(1.4514393161, -0.2365107469, -0.2149285693), r3.rgb);
    r0.g = dot(float3(-0.0765537734, 1.1762296998, -0.0996759264), r3.rgb);
    r0.b = dot(float3(0.0083161484, -0.0060324498, 0.9977163014), r3.rgb);
    // (start) LinearGrade
    // WhiteBalance(r0.rgb, cb0[1].rgb)
    r1.r = dot(float3(0.390405, 0.549941, 0.00892632), r0.rgb);
    r1.g = dot(float3(0.0708416, 0.963172, 0.00135775), r0.rgb);
    r1.b = dot(float3(0.0231082, 0.128021, 0.936245), r0.rgb);
    r0.rgb = r1.rgb * cb0[1].rgb;
    r1.r = dot(float3(2.858470, -1.628790, -0.024891), r0.rgb);
    r1.g = dot(float3(-0.210182, 1.158200, 0.000324281), r0.rgb);
    r1.b = dot(float3(-0.041812, -0.118169, 1.068670), r0.rgb);
    // ColorFilter
    r0.rgb = r1.rgb * cb0[2].rgb;
    // ChannelMixer(r0.rgb, cb0[4].rgb, cb0[5].rgb, cb0[6].rgb)
    r1.r = dot(r0.rgb, cb0[4].rgb);
    r1.g = dot(r0.rgb, cb0[5].rgb);
    r1.b = dot(r0.rgb, cb0[6].rgb);
    // LiftGammaGainHDR(r1.rgb, cb0[7].rgb, cb0[8].rgb, cb0[9].rgb)
    r0.rgb = r1.rgb * cb0[9].rgb + cb0[7].rgb;
    r1.rgb = saturate(r1.rgb * renodx::math::FLT_MAX + 0.5) * 2.0 - 1.0;
    r0.rgb = pow(abs(r0.rgb), cb0[8].rgb);
    r0.rgb = r0.rgb * r1.rgb;
    // Do NOT feed negative values to RgbToHsv or they'll wrap around
    r0.rgb = max(0, r0.rgb);
    // RgbToHsv
    r0.a = cmp(r0.g >= r0.b);
    r0.a = r0.a ? 1.00000 : 0;
    r1.rg = r0.bg;
    r1.ba = float2(-1, 0.666666687);
    r2.rg = r0.gb + -r1.rg;
    r2.ba = float2(1, -1);
    r1.rgba = r0.aaaa * r2.rgba + r1.rgba;
    r0.a = cmp(r0.r >= r1.r);
    r0.a = r0.a ? 1.00000 : 0;
    r2.rgb = r1.rga;
    r2.a = r0.r;
    r1.rga = r2.agr;
    r1.rgba = -r2.rgba + r1.rgba;
    r1.rgba = r0.aaaa * r1.rgba + r2.rgba;
    r0.a = min(r1.g, r1.a);
    r0.a = -r0.a + r1.r;
    r1.g = -r1.g + r1.a;
    r1.a = r0.a * 6 + 0.0001;
    r1.g = r1.g / r1.a;
    r1.g = r1.g + r1.b;
    r2.r = abs(r1.g);
    r1.g = r1.r + 0.0001;
    r2.b = r0.a / r1.g;
    // Hue Vs Sat
    r2.ga = float2(0.25, 0.25);
    r0.a = t0.SampleLevel(s0_s, r2.rg, 0).g;
    r0.a = saturate(r0.a);
    r0.a = r0.a + r0.a;
    // Sat Vs Sat
    r1.g = t0.SampleLevel(s0_s, r2.ba, 0).b;
    r1.g = saturate(r1.g);
    r0.a = dot(r1.gg, r0.aa);
    // Lum Vs Sat
    r3.r = dot(r0.rgb, float3(0.2126729, 0.7151522, 0.0721750));
    r3.ga = float2(0.25, 0.25);
    r0.r = t0.SampleLevel(s0_s, r3.rg, 0).a;
    r0.r = saturate(r0.r);
    r0.r = r0.a * r0.r;
    // Hue Vs Hue
    r3.b = r2.r + cb0[3].r;
    r0.g = t0.SampleLevel(s0_s, r3.ba, 0).r;
    r0.g = saturate(r0.g);
    r0.g = r3.b + r0.g;
    r0.gba = r0.ggg + float3(-0.5, 0.5, -1.5);
    r1.g = cmp(r0.g < 0);
    r1.b = cmp(1 < r0.g);
    r0.g = r1.b ? r0.a : r0.g;
    r0.g = r1.g ? r0.b : r0.g;
    // HsvToRgb(r0.gba)
    r0.gba = r0.ggg + float3(1, 0.666666687, 0.333333343);
    r0.gba = frac(r0.gba);
    r0.gba = r0.gba * float3(6, 6, 6) + float3(-3, -3, -3);
    r0.gba = saturate(abs(r0.gba) + float3(-1, -1, -1));
    r0.gba = r0.gba + float3(-1, -1, -1);
    r0.gba = r2.bbb * r0.gba + float3(1, 1, 1);
    // Saturation(r0.gba, cb0[3].g * r0.r)
    r1.gba = r0.gba * r1.rrr;
    r0.r = dot(cb0[3].gg, r0.rr);
    r1.g = dot(r1.gba, float3(0.2126729, 0.7151522, 0.0721750));
    r0.gba = r1.rrr * r0.gba + -r1.ggg;
    r0.rgb = r0.rrr * r0.gba + r1.ggg;
    // (end) LinearGrade
    // ACEScg_to_ACES
    r1.y = dot(float3(0.6954522414, 0.1406786965, 0.1638690622), r0.rgb);
    r1.z = dot(float3(0.0447945634, 0.8596711185, 0.0955343182), r0.rgb);
    r1.w = dot(float3(-0.0055258826, 0.0040252103, 1.0015006723), r0.rgb);
    r1.gba = lerp(preCG, r1.gba, RENODX_COLOR_GRADE_STRENGTH);
    float3 untonemapped = r1.gba;
    r0.x = min(r1.y, r1.z);
    r0.x = min(r0.x, r1.w);
    r0.y = max(r1.y, r1.z);
    r0.y = max(r0.y, r1.w);
    r0.xyz = max(float3(9.99999975e-05, 9.99999975e-05, 0.00999999978), r0.xyy);
    r0.x = r0.y + -r0.x;
    r0.x = r0.x / r0.z;
    r0.yzw = r1.wzy + -r1.zyw;
    r0.yz = r1.wz * r0.yz;
    r0.y = r0.y + r0.z;
    r0.y = r1.y * r0.w + r0.y;
    r0.y = max(0, r0.y);
    r0.y = sqrt(r0.y);
    r0.z = r1.w + r1.z;
    r0.z = r0.z + r1.y;
    r0.y = r0.y * 1.75 + r0.z;
    r0.w = -0.400000006 + r0.x;
    r1.x = 2.5 * r0.w;
    r1.x = 1 + -abs(r1.x);
    r1.x = max(0, r1.x);
    r0.w = cmp(r0.w >= 0);
    r0.w = r0.w ? 1 : -1;
    r1.x = -r1.x * r1.x + 1;
    r0.w = r0.w * r1.x + 1;
    r0.zw = float2(0.333333343, 0.0250000004) * r0.yw;
    r1.x = cmp(0.159999996 >= r0.y);
    r0.y = cmp(r0.y >= 0.479999989);
    r0.z = 0.0799999982 / r0.z;
    r0.z = -0.5 + r0.z;
    r0.z = r0.w * r0.z;
    r0.y = r0.y ? 0 : r0.z;
    r0.y = r1.x ? r0.w : r0.y;
    r0.y = 1 + r0.y;
    r2.yzw = r1.yzw * r0.yyy;
    r0.zw = cmp(r2.zw == r2.yz);
    r0.z = r0.w ? r0.z : 0;
    r0.w = r1.z * r0.y + -r2.w;
    r0.w = 1.73205078 * r0.w;
    r1.x = r2.y * 2 + -r2.z;
    r1.x = -r1.w * r0.y + r1.x;
    r1.z = min(abs(r1.x), abs(r0.w));
    r1.w = max(abs(r1.x), abs(r0.w));
    r1.w = 1 / r1.w;
    r1.z = r1.z * r1.w;
    r1.w = r1.z * r1.z;
    r3.x = r1.w * 0.0208350997 + -0.0851330012;
    r3.x = r1.w * r3.x + 0.180141002;
    r3.x = r1.w * r3.x + -0.330299497;
    r1.w = r1.w * r3.x + 0.999866009;
    r3.x = r1.z * r1.w;
    r3.y = cmp(abs(r1.x) < abs(r0.w));
    r3.x = r3.x * -2 + 1.57079637;
    r3.x = r3.y ? r3.x : 0;
    r1.z = r1.z * r1.w + r3.x;
    r1.w = cmp(r1.x < -r1.x);
    r1.w = r1.w ? -3.141593 : 0;
    r1.z = r1.z + r1.w;
    r1.w = min(r1.x, r0.w);
    r0.w = max(r1.x, r0.w);
    r1.x = cmp(r1.w < -r1.w);
    r0.w = cmp(r0.w >= -r0.w);
    r0.w = r0.w ? r1.x : 0;
    r0.w = r0.w ? -r1.z : r1.z;
    r0.w = 57.2957802 * r0.w;
    r0.z = r0.z ? 0 : r0.w;
    r0.w = cmp(r0.z < 0);
    r1.x = 360 + r0.z;
    r0.z = r0.w ? r1.x : r0.z;
    r0.w = cmp(r0.z < -180);
    r1.x = cmp(180 < r0.z);
    r1.zw = float2(360, -360) + r0.zz;
    r0.z = r1.x ? r1.w : r0.z;
    r0.z = r0.w ? r1.z : r0.z;
    r0.z = 0.0148148146 * r0.z;
    r0.z = 1 + -abs(r0.z);
    r0.z = max(0, r0.z);
    r0.w = r0.z * -2 + 3;
    r0.z = r0.z * r0.z;
    r0.z = r0.w * r0.z;
    r0.z = r0.z * r0.z;
    r0.x = r0.z * r0.x;
    r0.y = -r1.y * r0.y + 0.0299999993;
    r0.x = r0.x * r0.y;
    r2.x = r0.x * 0.180000007 + r2.y;
    r0.x = dot(float3(1.45143926, -0.236510754, -0.214928567), r2.xzw);
    r0.y = dot(float3(-0.0765537769, 1.17622972, -0.0996759236), r2.xzw);
    r0.z = dot(float3(0.00831614807, -0.00603244966, 0.997716308), r2.xzw);
    r0.xyz = max(float3(0, 0, 0), r0.xyz);
    r0.w = dot(r0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    r0.xyz = r0.xyz + -r0.www;
    r0.xyz = r0.xyz * float3(0.959999979, 0.959999979, 0.959999979) + r0.www;
    r1.xyz = float3(278.5085, 278.5085, 278.5085) * r0.xyz + float3(10.7772, 10.7772, 10.7772);
    r1.xyz = r0.xyz * r1.xyz;
    r2.xyz = r0.xyz * float3(293.6045, 293.6045, 293.6045) + float3(88.7122, 88.7122, 88.7122);
    r0.xyz = r0.xyz * r2.xyz + float3(80.6889, 80.6889, 80.6889);
    r0.xyz = r1.xyz / r0.xyz;
    r1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), r0.xyz);
    r1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), r0.xyz);
    r1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), r0.xyz);
    r0.x = dot(r1.xyz, float3(1, 1, 1));
    r0.x = max(9.99999975e-05, r0.x);
    r0.xy = r1.xy / r0.xx;
    r0.w = max(0, r1.y);
    r0.w = min(65504, r0.w);
    r0.w = log2(r0.w);
    r0.w = 0.981100023 * r0.w;
    r1.y = exp2(r0.w);
    r0.w = max(9.99999975e-05, r0.y);
    r0.w = r1.y / r0.w;
    r1.w = 1 + -r0.x;
    r0.z = r1.w + -r0.y;
    r1.xz = r0.xz * r0.ww;
    r0.x = dot(float3(1.6410234, -0.324803293, -0.236424699), r1.xyz);
    r0.y = dot(float3(-0.663662851, 1.61533165, 0.0167563483), r1.xyz);
    r0.z = dot(float3(0.0117218941, -0.00828444213, 0.988394856), r1.xyz);
    r0.w = dot(r0.xyz, float3(0.272228986, 0.674081981, 0.0536894985));
    r0.xyz = r0.xyz + -r0.www;
    r0.xyz = r0.xyz * float3(0.930000007, 0.930000007, 0.930000007) + r0.www;
    r1.x = dot(float3(0.662454188, 0.134004205, 0.156187683), r0.xyz);
    r1.y = dot(float3(0.272228718, 0.674081743, 0.0536895171), r0.xyz);
    r1.z = dot(float3(-0.00557464967, 0.0040607336, 1.01033914), r0.xyz);
    r0.x = dot(float3(0.987223983, -0.00611326983, 0.0159533005), r1.xyz);
    r0.y = dot(float3(-0.00759836007, 1.00186002, 0.00533019984), r1.xyz);
    r0.z = dot(float3(0.00307257008, -0.00509594986, 1.08168006), r1.xyz);
    r1.x = dot(float3(3.2409699, -1.5373832, -0.498610765), r0.xyz);
    r1.y = dot(float3(-0.969243646, 1.8759675, 0.0415550582), r0.xyz);
    r1.z = dot(float3(0.0556300804, -0.203976959, 1.05697155), r0.xyz);
    r0.xyz = max(float3(0,0,0), r1.xyz);
    r0.rgb = renodx::draw::ToneMapPass(untonemapped, r0.rgb);
    r0.a = 1;
    u0[vThreadID.xyz] = r0.rgba;
  }
  return;
}
