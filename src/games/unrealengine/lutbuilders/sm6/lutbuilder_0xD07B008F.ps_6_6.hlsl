// Marvel Rivals

#include "../../common.hlsl"

cbuffer cb0 : register(b0) {
  float cb0_013x : packoffset(c013.x);
  float cb0_013y : packoffset(c013.y);
  float cb0_013z : packoffset(c013.z);
  float cb0_013w : packoffset(c013.w);
  float cb0_014x : packoffset(c014.x);
  float cb0_014y : packoffset(c014.y);
  float cb0_014z : packoffset(c014.z);
  float cb0_015x : packoffset(c015.x);
  float cb0_015y : packoffset(c015.y);
  float cb0_015z : packoffset(c015.z);
  float cb0_015w : packoffset(c015.w);
  float cb0_016x : packoffset(c016.x);
  float cb0_016y : packoffset(c016.y);
  float cb0_016z : packoffset(c016.z);
  float cb0_016w : packoffset(c016.w);
  float cb0_017x : packoffset(c017.x);
  float cb0_017y : packoffset(c017.y);
  float cb0_017z : packoffset(c017.z);
  float cb0_017w : packoffset(c017.w);
  float cb0_018x : packoffset(c018.x);
  float cb0_018y : packoffset(c018.y);
  float cb0_018z : packoffset(c018.z);
  float cb0_018w : packoffset(c018.w);
  float cb0_019x : packoffset(c019.x);
  float cb0_019y : packoffset(c019.y);
  float cb0_019z : packoffset(c019.z);
  float cb0_019w : packoffset(c019.w);
  float cb0_020x : packoffset(c020.x);
  float cb0_020y : packoffset(c020.y);
  float cb0_020z : packoffset(c020.z);
  float cb0_020w : packoffset(c020.w);
  float cb0_021x : packoffset(c021.x);
  float cb0_021y : packoffset(c021.y);
  float cb0_021z : packoffset(c021.z);
  float cb0_021w : packoffset(c021.w);
  float cb0_022x : packoffset(c022.x);
  float cb0_022y : packoffset(c022.y);
  float cb0_022z : packoffset(c022.z);
  float cb0_022w : packoffset(c022.w);
  float cb0_023x : packoffset(c023.x);
  float cb0_023y : packoffset(c023.y);
  float cb0_023z : packoffset(c023.z);
  float cb0_023w : packoffset(c023.w);
  float cb0_024x : packoffset(c024.x);
  float cb0_024y : packoffset(c024.y);
  float cb0_024z : packoffset(c024.z);
  float cb0_024w : packoffset(c024.w);
  float cb0_025x : packoffset(c025.x);
  float cb0_025y : packoffset(c025.y);
  float cb0_025z : packoffset(c025.z);
  float cb0_025w : packoffset(c025.w);
  float cb0_026x : packoffset(c026.x);
  float cb0_026y : packoffset(c026.y);
  float cb0_026z : packoffset(c026.z);
  float cb0_026w : packoffset(c026.w);
  float cb0_027x : packoffset(c027.x);
  float cb0_027y : packoffset(c027.y);
  float cb0_027z : packoffset(c027.z);
  float cb0_027w : packoffset(c027.w);
  float cb0_028x : packoffset(c028.x);
  float cb0_028y : packoffset(c028.y);
  float cb0_028z : packoffset(c028.z);
  float cb0_028w : packoffset(c028.w);
  float cb0_029x : packoffset(c029.x);
  float cb0_029y : packoffset(c029.y);
  float cb0_029z : packoffset(c029.z);
  float cb0_029w : packoffset(c029.w);
  float cb0_030x : packoffset(c030.x);
  float cb0_030y : packoffset(c030.y);
  float cb0_030z : packoffset(c030.z);
  float cb0_030w : packoffset(c030.w);
  float cb0_031x : packoffset(c031.x);
  float cb0_031y : packoffset(c031.y);
  float cb0_031z : packoffset(c031.z);
  float cb0_031w : packoffset(c031.w);
  float cb0_032x : packoffset(c032.x);
  float cb0_032y : packoffset(c032.y);
  float cb0_032z : packoffset(c032.z);
  float cb0_032w : packoffset(c032.w);
  float cb0_033x : packoffset(c033.x);
  float cb0_033y : packoffset(c033.y);
  float cb0_033z : packoffset(c033.z);
  float cb0_033w : packoffset(c033.w);
  float cb0_034x : packoffset(c034.x);
  float cb0_034y : packoffset(c034.y);
  float cb0_034z : packoffset(c034.z);
  float cb0_034w : packoffset(c034.w);
  float cb0_035x : packoffset(c035.x);
  float cb0_035w : packoffset(c035.w);
  float cb0_036x : packoffset(c036.x);
  float cb0_036y : packoffset(c036.y);
  float cb0_036z : packoffset(c036.z);
  float cb0_036w : packoffset(c036.w);
  float cb0_037x : packoffset(c037.x);
  float cb0_040y : packoffset(c040.y);
  float cb0_040z : packoffset(c040.z);
  float cb0_040w : packoffset(c040.w);
  float cb0_041x : packoffset(c041.x);
  float cb0_041y : packoffset(c041.y);
  float cb0_042x : packoffset(c042.x);
  float cb0_042y : packoffset(c042.y);
  float cb0_042z : packoffset(c042.z);
  float cb0_043y : packoffset(c043.y);
  int cb0_044x : packoffset(c044.x);
};

cbuffer cb1 : register(b1) {
  float4 UniformBufferConstants_WorkingColorSpace_000[4] : packoffset(c000.x);
  float4 UniformBufferConstants_WorkingColorSpace_064[4] : packoffset(c004.x);
  float4 UniformBufferConstants_WorkingColorSpace_128[4] : packoffset(c008.x);
  float4 UniformBufferConstants_WorkingColorSpace_192[4] : packoffset(c012.x);
  float4 UniformBufferConstants_WorkingColorSpace_256[4] : packoffset(c016.x);
  int UniformBufferConstants_WorkingColorSpace_320 : packoffset(c020.x);
};

float4 main(
  noperspective float2 TEXCOORD : TEXCOORD,
  noperspective float4 SV_Position : SV_Position,
  nointerpolation uint SV_RenderTargetArrayIndex : SV_RenderTargetArrayIndex
) : SV_Target {
  float4 SV_Target;
  float _10 = 0.5f / cb0_035x;
  float _15 = cb0_035x + -1.0f;
  float _39;
  float _40;
  float _41;
  float _42;
  float _43;
  float _44;
  float _45;
  float _46;
  float _47;
  float _564;
  float _597;
  float _611;
  float _675;
  float _928;
  float _929;
  float _930;
  float _941;
  float _952;
  float _963;
  if (!(cb0_044x == 1)) {
    if (!(cb0_044x == 2)) {
      if (!(cb0_044x == 3)) {
        bool _28 = (cb0_044x == 4);
        _39 = select(_28, 1.0f, 1.705051064491272f);
        _40 = select(_28, 0.0f, -0.6217921376228333f);
        _41 = select(_28, 0.0f, -0.0832589864730835f);
        _42 = select(_28, 0.0f, -0.13025647401809692f);
        _43 = select(_28, 1.0f, 1.140804648399353f);
        _44 = select(_28, 0.0f, -0.010548308491706848f);
        _45 = select(_28, 0.0f, -0.024003351107239723f);
        _46 = select(_28, 0.0f, -0.1289689838886261f);
        _47 = select(_28, 1.0f, 1.1529725790023804f);
      } else {
        _39 = 0.6954522132873535f;
        _40 = 0.14067870378494263f;
        _41 = 0.16386906802654266f;
        _42 = 0.044794563204050064f;
        _43 = 0.8596711158752441f;
        _44 = 0.0955343171954155f;
        _45 = -0.005525882821530104f;
        _46 = 0.004025210160762072f;
        _47 = 1.0015007257461548f;
      }
    } else {
      _39 = 1.0258246660232544f;
      _40 = -0.020053181797266006f;
      _41 = -0.005771636962890625f;
      _42 = -0.002234415616840124f;
      _43 = 1.0045864582061768f;
      _44 = -0.002352118492126465f;
      _45 = -0.005013350863009691f;
      _46 = -0.025290070101618767f;
      _47 = 1.0303035974502563f;
    }
  } else {
    _39 = 1.3792141675949097f;
    _40 = -0.30886411666870117f;
    _41 = -0.0703500509262085f;
    _42 = -0.06933490186929703f;
    _43 = 1.08229660987854f;
    _44 = -0.012961871922016144f;
    _45 = -0.0021590073592960835f;
    _46 = -0.0454593189060688f;
    _47 = 1.0476183891296387f;
  }
  float _60 = (exp2((((cb0_035x * (TEXCOORD.x - _10)) / _15) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _61 = (exp2((((cb0_035x * (TEXCOORD.y - _10)) / _15) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _62 = (exp2(((float((uint)(int)(SV_RenderTargetArrayIndex)) / _15) + -0.4340175986289978f) * 14.0f) * 0.18000000715255737f) + -0.002667719265446067f;
  float _77 = mad((UniformBufferConstants_WorkingColorSpace_128[0].z), _62, mad((UniformBufferConstants_WorkingColorSpace_128[0].y), _61, ((UniformBufferConstants_WorkingColorSpace_128[0].x) * _60)));
  float _80 = mad((UniformBufferConstants_WorkingColorSpace_128[1].z), _62, mad((UniformBufferConstants_WorkingColorSpace_128[1].y), _61, ((UniformBufferConstants_WorkingColorSpace_128[1].x) * _60)));
  float _83 = mad((UniformBufferConstants_WorkingColorSpace_128[2].z), _62, mad((UniformBufferConstants_WorkingColorSpace_128[2].y), _61, ((UniformBufferConstants_WorkingColorSpace_128[2].x) * _60)));
  float _84 = dot(float3(_77, _80, _83), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));

  SetUngradedAP1(float3(_77, _80, _83));

  float _88 = (_77 / _84) + -1.0f;
  float _89 = (_80 / _84) + -1.0f;
  float _90 = (_83 / _84) + -1.0f;
  float _102 = (1.0f - exp2(((_84 * _84) * -4.0f) * cb0_036w)) * (1.0f - exp2(dot(float3(_88, _89, _90), float3(_88, _89, _90)) * -4.0f));
  float _118 = ((mad(-0.06368321925401688f, _83, mad(-0.3292922377586365f, _80, (_77 * 1.3704125881195068f))) - _77) * _102) + _77;
  float _119 = ((mad(-0.010861365124583244f, _83, mad(1.0970927476882935f, _80, (_77 * -0.08343357592821121f))) - _80) * _102) + _80;
  float _120 = ((mad(1.2036951780319214f, _83, mad(-0.09862580895423889f, _80, (_77 * -0.02579331398010254f))) - _83) * _102) + _83;
  float _121 = dot(float3(_118, _119, _120), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _135 = cb0_019w + cb0_024w;
  float _149 = cb0_018w * cb0_023w;
  float _163 = cb0_017w * cb0_022w;
  float _177 = cb0_016w * cb0_021w;
  float _191 = cb0_015w * cb0_020w;
  float _195 = _118 - _121;
  float _196 = _119 - _121;
  float _197 = _120 - _121;
  float _254 = saturate(_121 / cb0_035w);
  float _258 = (_254 * _254) * (3.0f - (_254 * 2.0f));
  float _259 = 1.0f - _258;
  float _268 = cb0_019w + cb0_034w;
  float _277 = cb0_018w * cb0_033w;
  float _286 = cb0_017w * cb0_032w;
  float _295 = cb0_016w * cb0_031w;
  float _304 = cb0_015w * cb0_030w;
  float _367 = saturate((_121 - cb0_036x) / (cb0_036y - cb0_036x));
  float _371 = (_367 * _367) * (3.0f - (_367 * 2.0f));
  float _380 = cb0_019w + cb0_029w;
  float _389 = cb0_018w * cb0_028w;
  float _398 = cb0_017w * cb0_027w;
  float _407 = cb0_016w * cb0_026w;
  float _416 = cb0_015w * cb0_025w;
  float _474 = _258 - _371;
  float _485 = ((_371 * (((cb0_019x + cb0_034x) + _268) + (((cb0_018x * cb0_033x) * _277) * exp2(log2(exp2(((cb0_016x * cb0_031x) * _295) * log2(max(0.0f, ((((cb0_015x * cb0_030x) * _304) * _195) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017x * cb0_032x) * _286)))))) + (_259 * (((cb0_019x + cb0_024x) + _135) + (((cb0_018x * cb0_023x) * _149) * exp2(log2(exp2(((cb0_016x * cb0_021x) * _177) * log2(max(0.0f, ((((cb0_015x * cb0_020x) * _191) * _195) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017x * cb0_022x) * _163))))))) + ((((cb0_019x + cb0_029x) + _380) + (((cb0_018x * cb0_028x) * _389) * exp2(log2(exp2(((cb0_016x * cb0_026x) * _407) * log2(max(0.0f, ((((cb0_015x * cb0_025x) * _416) * _195) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017x * cb0_027x) * _398))))) * _474);
  float _487 = ((_371 * (((cb0_019y + cb0_034y) + _268) + (((cb0_018y * cb0_033y) * _277) * exp2(log2(exp2(((cb0_016y * cb0_031y) * _295) * log2(max(0.0f, ((((cb0_015y * cb0_030y) * _304) * _196) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017y * cb0_032y) * _286)))))) + (_259 * (((cb0_019y + cb0_024y) + _135) + (((cb0_018y * cb0_023y) * _149) * exp2(log2(exp2(((cb0_016y * cb0_021y) * _177) * log2(max(0.0f, ((((cb0_015y * cb0_020y) * _191) * _196) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017y * cb0_022y) * _163))))))) + ((((cb0_019y + cb0_029y) + _380) + (((cb0_018y * cb0_028y) * _389) * exp2(log2(exp2(((cb0_016y * cb0_026y) * _407) * log2(max(0.0f, ((((cb0_015y * cb0_025y) * _416) * _196) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017y * cb0_027y) * _398))))) * _474);
  float _489 = ((_371 * (((cb0_019z + cb0_034z) + _268) + (((cb0_018z * cb0_033z) * _277) * exp2(log2(exp2(((cb0_016z * cb0_031z) * _295) * log2(max(0.0f, ((((cb0_015z * cb0_030z) * _304) * _197) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017z * cb0_032z) * _286)))))) + (_259 * (((cb0_019z + cb0_024z) + _135) + (((cb0_018z * cb0_023z) * _149) * exp2(log2(exp2(((cb0_016z * cb0_021z) * _177) * log2(max(0.0f, ((((cb0_015z * cb0_020z) * _191) * _197) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017z * cb0_022z) * _163))))))) + ((((cb0_019z + cb0_029z) + _380) + (((cb0_018z * cb0_028z) * _389) * exp2(log2(exp2(((cb0_016z * cb0_026z) * _407) * log2(max(0.0f, ((((cb0_015z * cb0_025z) * _416) * _197) + _121)) * 5.55555534362793f)) * 0.18000000715255737f) * (1.0f / ((cb0_017z * cb0_027z) * _398))))) * _474);

  SetUntonemappedAP1(float3(_485, _487, _489));

  float _504 = ((mad(0.061360642313957214f, _489, mad(-4.540197551250458e-09f, _487, (_485 * 0.9386394023895264f))) - _485) * cb0_036z) + _485;
  float _505 = ((mad(0.169205904006958f, _489, mad(0.8307942152023315f, _487, (_485 * 6.775371730327606e-08f))) - _487) * cb0_036z) + _487;
  float _506 = (mad(-2.3283064365386963e-10f, _487, (_485 * -9.313225746154785e-10f)) * cb0_036z) + _489;
  float _509 = mad(0.16386905312538147f, _506, mad(0.14067868888378143f, _505, (_504 * 0.6954522132873535f)));
  float _512 = mad(0.0955343246459961f, _506, mad(0.8596711158752441f, _505, (_504 * 0.044794581830501556f)));
  float _515 = mad(1.0015007257461548f, _506, mad(0.004025210160762072f, _505, (_504 * -0.005525882821530104f)));
  float _519 = max(max(_509, _512), _515);
  float _524 = (max(_519, 1.000000013351432e-10f) - max(min(min(_509, _512), _515), 1.000000013351432e-10f)) / max(_519, 0.009999999776482582f);
  float _537 = ((_512 + _509) + _515) + (sqrt((((_515 - _512) * _515) + ((_512 - _509) * _512)) + ((_509 - _515) * _509)) * 1.75f);
  float _538 = _537 * 0.3333333432674408f;
  float _539 = _524 + -0.4000000059604645f;
  float _540 = _539 * 5.0f;
  float _544 = max((1.0f - abs(_539 * 2.5f)), 0.0f);
  float _555 = ((float(((int)(uint)((bool)(_540 > 0.0f))) - ((int)(uint)((bool)(_540 < 0.0f)))) * (1.0f - (_544 * _544))) + 1.0f) * 0.02500000037252903f;
  if (!(_538 <= 0.0533333346247673f)) {
    if (!(_538 >= 0.1599999964237213f)) {
      _564 = (((0.23999999463558197f / _537) + -0.5f) * _555);
    } else {
      _564 = 0.0f;
    }
  } else {
    _564 = _555;
  }
  float _565 = _564 + 1.0f;
  float _566 = _565 * _509;
  float _567 = _565 * _512;
  float _568 = _565 * _515;
  if (!((bool)(_566 == _567) && (bool)(_567 == _568))) {
    float _575 = ((_566 * 2.0f) - _567) - _568;
    float _578 = ((_512 - _515) * 1.7320507764816284f) * _565;
    float _580 = atan(_578 / _575);
    bool _583 = (_575 < 0.0f);
    bool _584 = (_575 == 0.0f);
    bool _585 = (_578 >= 0.0f);
    bool _586 = (_578 < 0.0f);
    _597 = select((_585 && _584), 90.0f, select((_586 && _584), -90.0f, (select((_586 && _583), (_580 + -3.1415927410125732f), select((_585 && _583), (_580 + 3.1415927410125732f), _580)) * 57.2957763671875f)));
  } else {
    _597 = 0.0f;
  }
  float _602 = min(max(select((_597 < 0.0f), (_597 + 360.0f), _597), 0.0f), 360.0f);
  if (_602 < -180.0f) {
    _611 = (_602 + 360.0f);
  } else {
    if (_602 > 180.0f) {
      _611 = (_602 + -360.0f);
    } else {
      _611 = _602;
    }
  }
  float _615 = saturate(1.0f - abs(_611 * 0.014814814552664757f));
  float _619 = (_615 * _615) * (3.0f - (_615 * 2.0f));
  float _625 = ((_619 * _619) * ((_524 * 0.18000000715255737f) * (0.029999999329447746f - _566))) + _566;
  float _635 = max(0.0f, mad(-0.21492856740951538f, _568, mad(-0.2365107536315918f, _567, (_625 * 1.4514392614364624f))));
  float _636 = max(0.0f, mad(-0.09967592358589172f, _568, mad(1.17622971534729f, _567, (_625 * -0.07655377686023712f))));
  float _637 = max(0.0f, mad(0.9977163076400757f, _568, mad(-0.006032449658960104f, _567, (_625 * 0.008316148072481155f))));
  float _638 = dot(float3(_635, _636, _637), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _653 = (cb0_041x + 1.0f) - cb0_040z;
  float _655 = cb0_041y + 1.0f;
  float _657 = _655 - cb0_040w;
  if (cb0_040z > 0.800000011920929f) {
    _675 = (((0.8199999928474426f - cb0_040z) / cb0_040y) + -0.7447274923324585f);
  } else {
    float _666 = (cb0_041x + 0.18000000715255737f) / _653;
    _675 = (-0.7447274923324585f - ((log2(_666 / (2.0f - _666)) * 0.3465735912322998f) * (_653 / cb0_040y)));
  }
  float _678 = ((1.0f - cb0_040z) / cb0_040y) - _675;
  float _680 = (cb0_040w / cb0_040y) - _678;
  float _684 = log2(lerp(_638, _635, 0.9599999785423279f)) * 0.3010300099849701f;
  float _685 = log2(lerp(_638, _636, 0.9599999785423279f)) * 0.3010300099849701f;
  float _686 = log2(lerp(_638, _637, 0.9599999785423279f)) * 0.3010300099849701f;
  float _690 = cb0_040y * (_684 + _678);
  float _691 = cb0_040y * (_685 + _678);
  float _692 = cb0_040y * (_686 + _678);
  float _693 = _653 * 2.0f;
  float _695 = (cb0_040y * -2.0f) / _653;
  float _696 = _684 - _675;
  float _697 = _685 - _675;
  float _698 = _686 - _675;
  float _717 = _657 * 2.0f;
  float _719 = (cb0_040y * 2.0f) / _657;
  float _744 = select((_684 < _675), ((_693 / (exp2((_696 * 1.4426950216293335f) * _695) + 1.0f)) - cb0_041x), _690);
  float _745 = select((_685 < _675), ((_693 / (exp2((_697 * 1.4426950216293335f) * _695) + 1.0f)) - cb0_041x), _691);
  float _746 = select((_686 < _675), ((_693 / (exp2((_698 * 1.4426950216293335f) * _695) + 1.0f)) - cb0_041x), _692);
  float _753 = _680 - _675;
  float _757 = saturate(_696 / _753);
  float _758 = saturate(_697 / _753);
  float _759 = saturate(_698 / _753);
  bool _760 = (_680 < _675);
  float _764 = select(_760, (1.0f - _757), _757);
  float _765 = select(_760, (1.0f - _758), _758);
  float _766 = select(_760, (1.0f - _759), _759);
  float _785 = (((_764 * _764) * (select((_684 > _680), (_655 - (_717 / (exp2(((_684 - _680) * 1.4426950216293335f) * _719) + 1.0f))), _690) - _744)) * (3.0f - (_764 * 2.0f))) + _744;
  float _786 = (((_765 * _765) * (select((_685 > _680), (_655 - (_717 / (exp2(((_685 - _680) * 1.4426950216293335f) * _719) + 1.0f))), _691) - _745)) * (3.0f - (_765 * 2.0f))) + _745;
  float _787 = (((_766 * _766) * (select((_686 > _680), (_655 - (_717 / (exp2(((_686 - _680) * 1.4426950216293335f) * _719) + 1.0f))), _692) - _746)) * (3.0f - (_766 * 2.0f))) + _746;
  float _788 = dot(float3(_785, _786, _787), float3(0.2722287178039551f, 0.6740817427635193f, 0.053689517080783844f));
  float _809 = (cb0_037x * (max(0.0f, (lerp(_788, _785, 0.9300000071525574f))) - _504)) + _504;
  float _810 = (cb0_037x * (max(0.0f, (lerp(_788, _786, 0.9300000071525574f))) - _505)) + _505;
  float _811 = (cb0_037x * (max(0.0f, (lerp(_788, _787, 0.9300000071525574f))) - _506)) + _506;
  float _827 = ((mad(-0.06537103652954102f, _811, mad(1.451815478503704e-06f, _810, (_809 * 1.065374732017517f))) - _809) * cb0_036z) + _809;
  float _828 = ((mad(-0.20366770029067993f, _811, mad(1.2036634683609009f, _810, (_809 * -2.57161445915699e-07f))) - _810) * cb0_036z) + _810;
  float _829 = ((mad(0.9999996423721313f, _811, mad(2.0954757928848267e-08f, _810, (_809 * 1.862645149230957e-08f))) - _811) * cb0_036z) + _811;

  SetTonemappedAP1(_827, _828, _829);

  float _851 = max(0.0f, mad((UniformBufferConstants_WorkingColorSpace_192[0].z), _829, mad((UniformBufferConstants_WorkingColorSpace_192[0].y), _828, ((UniformBufferConstants_WorkingColorSpace_192[0].x) * _827))));
  float _852 = max(0.0f, mad((UniformBufferConstants_WorkingColorSpace_192[1].z), _829, mad((UniformBufferConstants_WorkingColorSpace_192[1].y), _828, ((UniformBufferConstants_WorkingColorSpace_192[1].x) * _827))));
  float _853 = max(0.0f, mad((UniformBufferConstants_WorkingColorSpace_192[2].z), _829, mad((UniformBufferConstants_WorkingColorSpace_192[2].y), _828, ((UniformBufferConstants_WorkingColorSpace_192[2].x) * _827))));
  float _879 = cb0_014x * (((cb0_042y + (cb0_042x * _851)) * _851) + cb0_042z);
  float _880 = cb0_014y * (((cb0_042y + (cb0_042x * _852)) * _852) + cb0_042z);
  float _881 = cb0_014z * (((cb0_042y + (cb0_042x * _853)) * _853) + cb0_042z);
  float _902 = exp2(log2(max(0.0f, (lerp(_879, cb0_013x, cb0_013w)))) * cb0_043y);
  float _903 = exp2(log2(max(0.0f, (lerp(_880, cb0_013y, cb0_013w)))) * cb0_043y);
  float _904 = exp2(log2(max(0.0f, (lerp(_881, cb0_013z, cb0_013w)))) * cb0_043y);

  if (RENODX_TONE_MAP_TYPE != 0) {
    return GenerateOutput(float3(_902, _903, _904));
  }

  if (UniformBufferConstants_WorkingColorSpace_320 == 0) {
    float _911 = mad((UniformBufferConstants_WorkingColorSpace_128[0].z), _904, mad((UniformBufferConstants_WorkingColorSpace_128[0].y), _903, ((UniformBufferConstants_WorkingColorSpace_128[0].x) * _902)));
    float _914 = mad((UniformBufferConstants_WorkingColorSpace_128[1].z), _904, mad((UniformBufferConstants_WorkingColorSpace_128[1].y), _903, ((UniformBufferConstants_WorkingColorSpace_128[1].x) * _902)));
    float _917 = mad((UniformBufferConstants_WorkingColorSpace_128[2].z), _904, mad((UniformBufferConstants_WorkingColorSpace_128[2].y), _903, ((UniformBufferConstants_WorkingColorSpace_128[2].x) * _902)));
    _928 = mad(_41, _917, mad(_40, _914, (_911 * _39)));
    _929 = mad(_44, _917, mad(_43, _914, (_911 * _42)));
    _930 = mad(_47, _917, mad(_46, _914, (_911 * _45)));
  } else {
    _928 = _902;
    _929 = _903;
    _930 = _904;
  }
  if (_928 < 0.0031306699384003878f) {
    _941 = (_928 * 12.920000076293945f);
  } else {
    _941 = (((pow(_928, 0.4166666567325592f)) * 1.0549999475479126f) + -0.054999999701976776f);
  }
  if (_929 < 0.0031306699384003878f) {
    _952 = (_929 * 12.920000076293945f);
  } else {
    _952 = (((pow(_929, 0.4166666567325592f)) * 1.0549999475479126f) + -0.054999999701976776f);
  }
  if (_930 < 0.0031306699384003878f) {
    _963 = (_930 * 12.920000076293945f);
  } else {
    _963 = (((pow(_930, 0.4166666567325592f)) * 1.0549999475479126f) + -0.054999999701976776f);
  }
  SV_Target.x = (_941 * 0.9523810148239136f);
  SV_Target.y = (_952 * 0.9523810148239136f);
  SV_Target.z = (_963 * 0.9523810148239136f);
  SV_Target.w = 0.0f;

  SV_Target = saturate(SV_Target);

  return SV_Target;
}
