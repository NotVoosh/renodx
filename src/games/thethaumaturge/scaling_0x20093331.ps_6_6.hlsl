Texture2D<float4> t0 : register(t0);
Texture2D<float4> t1 : register(t1);

cbuffer _cb0 : register(b0) {
  float4 cb0[46] : packoffset(c0);
};
cbuffer _cb1 : register(b1) {
  float4 cb1[331] : packoffset(c0);
};
cbuffer _cb2 : register(b2) {
  float4 cb2[11] : packoffset(c0);
};
cbuffer _cb3 : register(b3) {
  float4 cb3[10] : packoffset(c0);
};

SamplerState s0 : register(s0);
SamplerState s1 : register(s1);

float4 main(
  noperspective float4 SV_Position : SV_Position,
  linear float4 TEXCOORD : TEXCOORD
) : SV_Target {
  float4 SV_Target;
  // texture _1 = t1;
  // texture _2 = t0;
  // SamplerState _3 = s1;
  // SamplerState _4 = s0;
  // cbuffer _5 = cb3; // index=3
  // cbuffer _6 = cb2; // index=2
  // cbuffer _7 = cb1; // index=1
  // cbuffer _8 = cb0; // index=0
  // _9 = _5;
  // _10 = _6;
  // _11 = _7;
  // _12 = _8;
  float _13 = SV_Position.x;
  float _14 = SV_Position.y;
  int4 _15 = cb0[37u];
  int _16 = _15.x;
  int _17 = _15.y;
  float _18 = float(_16);
  float _19 = float(_17);
  float _20 = _13 - _18;
  float _21 = _14 - _19;
  float4 _22 = cb0[38u];
  float _23 = _22.z;
  float _24 = _22.w;
  float _25 = _20 * _23;
  float _26 = _21 * _24;
  float4 _27 = cb0[5u];
  float _28 = _27.x;
  float _29 = _27.y;
  float _30 = _25 * _28;
  float _31 = _26 * _29;
  float4 _32 = cb0[4u];
  float _33 = _32.x;
  float _34 = _32.y;
  float _35 = _30 + _33;
  float _36 = _31 + _34;
  // _37 = _1;
  // _38 = _3;
  float4 _39 = t1.Sample(s1, float2(_35, _36));
  float _40 = _39.x;
  float _41 = _39.y;
  float _42 = _39.z;
  float _43 = max(_40, 0.0f);
  float _44 = max(_41, 0.0f);
  float _45 = max(_42, 0.0f);
  float _46 = min(_43, 500.0f);
  float _47 = min(_44, 500.0f);
  float _48 = min(_45, 500.0f);
  float4 _49 = cb3[1u];
  float _50 = _49.x;
  float _51 = _50 * _25;
  float _52 = _50 * _26;
  // _53 = _2;
  // _54 = _4;
  float4 _55 = t0.Sample(s0, float2(_51, _52));
  float _56 = _55.x;
  float _57 = _55.y;
  float _58 = _56 * 2.0f;
  float _59 = _57 * 2.0f;
  float _60 = _58 + -1.0f;
  float _61 = _59 + -1.0f;
  float4 _62 = cb3[1u];
  float _63 = _62.y;
  float _64 = _60 * _63;
  float _65 = _61 * _63;
  float _66 = _64 + _25;
  float _67 = _65 + _26;
  float4 _68 = cb0[5u];
  float _69 = _68.x;
  float _70 = _68.y;
  float _71 = _66 * _69;
  float _72 = _67 * _70;
  float4 _73 = cb0[4u];
  float _74 = _73.x;
  float _75 = _73.y;
  float _76 = _71 + _74;
  float _77 = _72 + _75;
  float4 _78 = cb0[6u];
  float _79 = _78.x;
  float _80 = _78.y;
  float _81 = _78.z;
  float _82 = _78.w;
  float _83 = max(_76, _79);
  float _84 = max(_77, _80);
  float _85 = min(_83, _81);
  float _86 = min(_84, _82);
  // _87 = _1;
  // _88 = _3;
  float4 _89 = t1.Sample(s1, float2(_85, _86));
  float _90 = _89.x;
  float _91 = _89.y;
  float _92 = _89.z;
  float4 _93 = cb3[2u];
  float _94 = _93.x;
  float _95 = _93.y;
  float _96 = _94 + _66;
  float _97 = _95 + _67;
  float4 _98 = cb0[5u];
  float _99 = _98.x;
  float _100 = _98.y;
  float _101 = _96 * _99;
  float _102 = _97 * _100;
  float4 _103 = cb0[4u];
  float _104 = _103.x;
  float _105 = _103.y;
  float _106 = _101 + _104;
  float _107 = _102 + _105;
  float4 _108 = cb0[6u];
  float _109 = _108.x;
  float _110 = _108.y;
  float _111 = _108.z;
  float _112 = _108.w;
  float _113 = max(_106, _109);
  float _114 = max(_107, _110);
  float _115 = min(_113, _111);
  float _116 = min(_114, _112);
  // _117 = _1;
  // _118 = _3;
  float4 _119 = t1.Sample(s1, float2(_115, _116));
  float _120 = _119.x;
  float _121 = _119.y;
  float _122 = _119.z;
  float4 _123 = cb3[2u];
  float _124 = _123.z;
  float _125 = _123.w;
  float _126 = _124 + _66;
  float _127 = _125 + _67;
  float4 _128 = cb0[5u];
  float _129 = _128.x;
  float _130 = _128.y;
  float _131 = _126 * _129;
  float _132 = _127 * _130;
  float4 _133 = cb0[4u];
  float _134 = _133.x;
  float _135 = _133.y;
  float _136 = _131 + _134;
  float _137 = _132 + _135;
  float4 _138 = cb0[6u];
  float _139 = _138.x;
  float _140 = _138.y;
  float _141 = _138.z;
  float _142 = _138.w;
  float _143 = max(_136, _139);
  float _144 = max(_137, _140);
  float _145 = min(_143, _141);
  float _146 = min(_144, _142);
  // _147 = _1;
  // _148 = _3;
  float4 _149 = t1.Sample(s1, float2(_145, _146));
  float _150 = _149.x;
  float _151 = _149.y;
  float _152 = _149.z;
  float _153 = _150 + _120;
  float _154 = _151 + _121;
  float _155 = _152 + _122;
  float4 _156 = cb3[3u];
  float _157 = _156.x;
  float _158 = _156.y;
  float _159 = _157 + _66;
  float _160 = _158 + _67;
  float4 _161 = cb0[5u];
  float _162 = _161.x;
  float _163 = _161.y;
  float _164 = _159 * _162;
  float _165 = _160 * _163;
  float4 _166 = cb0[4u];
  float _167 = _166.x;
  float _168 = _166.y;
  float _169 = _164 + _167;
  float _170 = _165 + _168;
  float4 _171 = cb0[6u];
  float _172 = _171.x;
  float _173 = _171.y;
  float _174 = _171.z;
  float _175 = _171.w;
  float _176 = max(_169, _172);
  float _177 = max(_170, _173);
  float _178 = min(_176, _174);
  float _179 = min(_177, _175);
  // _180 = _1;
  // _181 = _3;
  float4 _182 = t1.Sample(s1, float2(_178, _179));
  float _183 = _182.x;
  float _184 = _182.y;
  float _185 = _182.z;
  float _186 = _153 + _183;
  float _187 = _154 + _184;
  float _188 = _155 + _185;
  float4 _189 = cb3[3u];
  float _190 = _189.z;
  float _191 = _189.w;
  float _192 = _190 + _66;
  float _193 = _191 + _67;
  float4 _194 = cb0[5u];
  float _195 = _194.x;
  float _196 = _194.y;
  float _197 = _192 * _195;
  float _198 = _193 * _196;
  float4 _199 = cb0[4u];
  float _200 = _199.x;
  float _201 = _199.y;
  float _202 = _197 + _200;
  float _203 = _198 + _201;
  float4 _204 = cb0[6u];
  float _205 = _204.x;
  float _206 = _204.y;
  float _207 = _204.z;
  float _208 = _204.w;
  float _209 = max(_202, _205);
  float _210 = max(_203, _206);
  float _211 = min(_209, _207);
  float _212 = min(_210, _208);
  // _213 = _1;
  // _214 = _3;
  float4 _215 = t1.Sample(s1, float2(_211, _212));
  float _216 = _215.x;
  float _217 = _215.y;
  float _218 = _215.z;
  float _219 = _186 + _216;
  float _220 = _187 + _217;
  float _221 = _188 + _218;
  float _222 = _219 * 0.25f;
  float _223 = _220 * 0.25f;
  float _224 = _221 * 0.25f;
  float _225 = _222 - _90;
  float _226 = _223 - _91;
  float _227 = _224 - _92;
  float _228 = _225 * 0.33000001311302185f;
  float _229 = _226 * 0.33000001311302185f;
  float _230 = _227 * 0.33000001311302185f;
  float _231 = _228 + _90;
  float _232 = _229 + _91;
  float _233 = _230 + _92;
  float4 _234 = cb3[4u];
  float _235 = _234.x;
  float _236 = _234.y;
  float _237 = _235 + _66;
  float _238 = _236 + _67;
  float4 _239 = cb0[5u];
  float _240 = _239.x;
  float _241 = _239.y;
  float _242 = _237 * _240;
  float _243 = _238 * _241;
  float4 _244 = cb0[4u];
  float _245 = _244.x;
  float _246 = _244.y;
  float _247 = _242 + _245;
  float _248 = _243 + _246;
  float4 _249 = cb0[6u];
  float _250 = _249.x;
  float _251 = _249.y;
  float _252 = _249.z;
  float _253 = _249.w;
  float _254 = max(_247, _250);
  float _255 = max(_248, _251);
  float _256 = min(_254, _252);
  float _257 = min(_255, _253);
  // _258 = _1;
  // _259 = _3;
  float4 _260 = t1.Sample(s1, float2(_256, _257));
  float _261 = _260.x;
  float _262 = _260.y;
  float _263 = _260.z;
  float4 _264 = cb3[4u];
  float _265 = _264.z;
  float _266 = _264.w;
  float _267 = _265 + _66;
  float _268 = _266 + _67;
  float4 _269 = cb0[5u];
  float _270 = _269.x;
  float _271 = _269.y;
  float _272 = _267 * _270;
  float _273 = _268 * _271;
  float4 _274 = cb0[4u];
  float _275 = _274.x;
  float _276 = _274.y;
  float _277 = _272 + _275;
  float _278 = _273 + _276;
  float4 _279 = cb0[6u];
  float _280 = _279.x;
  float _281 = _279.y;
  float _282 = _279.z;
  float _283 = _279.w;
  float _284 = max(_277, _280);
  float _285 = max(_278, _281);
  float _286 = min(_284, _282);
  float _287 = min(_285, _283);
  // _288 = _1;
  // _289 = _3;
  float4 _290 = t1.Sample(s1, float2(_286, _287));
  float _291 = _290.x;
  float _292 = _290.y;
  float _293 = _290.z;
  float _294 = _291 + _261;
  float _295 = _292 + _262;
  float _296 = _293 + _263;
  float4 _297 = cb3[5u];
  float _298 = _297.x;
  float _299 = _297.y;
  float _300 = _298 + _66;
  float _301 = _299 + _67;
  float4 _302 = cb0[5u];
  float _303 = _302.x;
  float _304 = _302.y;
  float _305 = _300 * _303;
  float _306 = _301 * _304;
  float4 _307 = cb0[4u];
  float _308 = _307.x;
  float _309 = _307.y;
  float _310 = _305 + _308;
  float _311 = _306 + _309;
  float4 _312 = cb0[6u];
  float _313 = _312.x;
  float _314 = _312.y;
  float _315 = _312.z;
  float _316 = _312.w;
  float _317 = max(_310, _313);
  float _318 = max(_311, _314);
  float _319 = min(_317, _315);
  float _320 = min(_318, _316);
  // _321 = _1;
  // _322 = _3;
  float4 _323 = t1.Sample(s1, float2(_319, _320));
  float _324 = _323.x;
  float _325 = _323.y;
  float _326 = _323.z;
  float _327 = _294 + _324;
  float _328 = _295 + _325;
  float _329 = _296 + _326;
  float4 _330 = cb3[5u];
  float _331 = _330.z;
  float _332 = _330.w;
  float _333 = _331 + _66;
  float _334 = _332 + _67;
  float4 _335 = cb0[5u];
  float _336 = _335.x;
  float _337 = _335.y;
  float _338 = _333 * _336;
  float _339 = _334 * _337;
  float4 _340 = cb0[4u];
  float _341 = _340.x;
  float _342 = _340.y;
  float _343 = _338 + _341;
  float _344 = _339 + _342;
  float4 _345 = cb0[6u];
  float _346 = _345.x;
  float _347 = _345.y;
  float _348 = _345.z;
  float _349 = _345.w;
  float _350 = max(_343, _346);
  float _351 = max(_344, _347);
  float _352 = min(_350, _348);
  float _353 = min(_351, _349);
  // _354 = _1;
  // _355 = _3;
  float4 _356 = t1.Sample(s1, float2(_352, _353));
  float _357 = _356.x;
  float _358 = _356.y;
  float _359 = _356.z;
  float _360 = _327 + _357;
  float _361 = _328 + _358;
  float _362 = _329 + _359;
  float _363 = _360 * 0.25f;
  float _364 = _361 * 0.25f;
  float _365 = _362 * 0.25f;
  float _366 = _363 - _231;
  float _367 = _364 - _232;
  float _368 = _365 - _233;
  float _369 = _366 * 0.33000001311302185f;
  float _370 = _367 * 0.33000001311302185f;
  float _371 = _368 * 0.33000001311302185f;
  float _372 = _369 + _231;
  float _373 = _370 + _232;
  float _374 = _371 + _233;
  float _375 = _372 + -0.019999999552965164f;
  float _376 = _373 + -0.019999999552965164f;
  float _377 = _374 + -0.019999999552965164f;
  float _378 = abs(_375);
  float _379 = abs(_376);
  float _380 = abs(_377);
  bool _381 = (_378 > 9.999999747378752e-06f);
  bool _382 = (_379 > 9.999999747378752e-06f);
  bool _383 = (_380 > 9.999999747378752e-06f);
  bool _384 = (_372 >= 0.019999999552965164f);
  bool _385 = (_373 >= 0.019999999552965164f);
  bool _386 = (_374 >= 0.019999999552965164f);
  bool _387 = _381 & _384;
  float _388 = _387 ? _372 : 0.019999999552965164f;
  bool _389 = _382 & _385;
  float _390 = _389 ? _373 : 0.019999999552965164f;
  bool _391 = _383 & _386;
  float _392 = _391 ? _374 : 0.019999999552965164f;
  float _393 = _40 / _388;
  float _394 = _41 / _390;
  float _395 = _42 / _392;
  float4 _396 = cb3[6u];
  float _397 = _396.x;
  float _398 = _393 - _397;
  float _399 = _394 - _397;
  float _400 = _395 - _397;
  float4 _401 = cb2[2u];
  float _402 = _401.x;
  float4 _403 = cb2[1u];
  float _404 = _403.z;
  float4 _405 = cb2[0u];
  float _406 = _405.w;
  float _407 = _402 + 1.0f;
  float _408 = _407 + _404;
  float _409 = _408 - _406;
  float _410 = saturate(_409);
  float _411 = _396.y;
  float _412 = _396.z;
  float _413 = _411 - _412;
  float _414 = _413 * _410;
  float _415 = _414 + _412;
  float _416 = _415 * _398;
  float _417 = _415 * _399;
  float _418 = _415 * _400;
  float _419 = _416 * 2.0f;
  float _420 = _417 * 2.0f;
  float _421 = _418 * 2.0f;
  float _422 = 1.0f - _419;
  float _423 = 1.0f - _420;
  float _424 = 1.0f - _421;
  float _425 = 1.0f - _40;
  float _426 = 1.0f - _41;
  float _427 = 1.0f - _42;
  float _428 = _422 * _425;
  float _429 = _423 * _426;
  float _430 = _424 * _427;
  float _431 = 1.0f - _428;
  float _432 = 1.0f - _429;
  float _433 = 1.0f - _430;
  float _434 = _431 * _40;
  float _435 = _432 * _41;
  float _436 = _433 * _42;
  float _437 = _419 * _40;
  float _438 = _420 * _41;
  float _439 = _421 * _42;
  float _440 = 1.0f - _437;
  float _441 = 1.0f - _438;
  float _442 = 1.0f - _439;
  float _443 = _440 * _425;
  float _444 = _441 * _426;
  float _445 = _442 * _427;
  float _446 = 1.0f - _443;
  float _447 = 1.0f - _444;
  float _448 = 1.0f - _445;
  bool _449 = (_416 >= 0.5f);
  float _450 = _449 ? _434 : _446;
  bool _451 = (_417 >= 0.5f);
  float _452 = _451 ? _435 : _447;
  bool _453 = (_418 >= 0.5f);
  float _454 = _453 ? _436 : _448;
  float _455 = max(_450, 0.0f);
  float _456 = max(_452, 0.0f);
  float _457 = max(_454, 0.0f);
  float _458 = min(_455, 500.0f);
  float _459 = min(_456, 500.0f);
  float _460 = min(_457, 500.0f);
  float _461 = _25 * 3.1415927410125732f;
  float _462 = sin(_461);
  float _463 = max(_462, 0.0f);
  float _464 = min(_463, 0.10000000149011612f);
  float _465 = _464 * 9.0f;
  bool _466 = (_465 <= 0.0f);
  float _467 = log2(_465);
  float _468 = _467 * 5.0f;
  float _469 = exp2(_468);
  float _470 = _466 ? 0.0f : _469;
  float _471 = saturate(_470);
  float4 _472 = cb1[129u];
  float _473 = _472.x;
  float _474 = _472.y;
  float _475 = _473 / _474;
  float _476 = 1.0f / _475;
  float _477 = _476 + 0.4399999976158142f;
  float _478 = saturate(_477);
  float _479 = _26 / _478;
  float _480 = _479 + 0.5f;
  float _481 = 0.5f / _478;
  float _482 = _480 - _481;
  float _483 = _482 * 3.1415927410125732f;
  float _484 = sin(_483);
  float _485 = max(_484, 0.0f);
  float _486 = min(_485, 0.10000000149011612f);
  float _487 = _486 * 9.0f;
  bool _488 = (_487 <= 0.0f);
  float _489 = log2(_487);
  float _490 = _489 * 5.0f;
  float _491 = exp2(_490);
  float _492 = _488 ? 0.0f : _491;
  float _493 = saturate(_492);
  float _494 = _493 * _471;
  float _495 = _458 - _46;
  float _496 = _459 - _47;
  float _497 = _460 - _48;
  float _498 = _494 * _495;
  float _499 = _494 * _496;
  float _500 = _494 * _497;
  float _501 = _498 + _46;
  float _502 = _499 + _47;
  float _503 = _500 + _48;
  float _504 = _396.w;
  float4 _505 = cb3[7u];
  float _506 = _505.x;
  float _507 = _505.y;
  float _508 = _505.z;
  float _509 = _506 - _501;
  float _510 = _507 - _502;
  float _511 = _508 - _503;
  float _512 = _509 * _504;
  float _513 = _510 * _504;
  float _514 = _511 * _504;
  float _515 = _512 + _501;
  float _516 = _513 + _502;
  float _517 = _514 + _503;
  float _518 = max(_515, 0.0f);
  float _519 = max(_516, 0.0f);
  float _520 = max(_517, 0.0f);
  SV_Target.x = _518;
  SV_Target.y = _519;
  SV_Target.z = _520;
  SV_Target.w = 0.0f;
  return SV_Target;
}
