// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/adau_sequencer.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module adau1978_sequencer
  (input  clk,
   input  rst_n,
   output boot_done,
   input  udp_req,
   output udp_ack,
   input  [1:0] udp_adc_sel,
   input  [1:0] udp_ch_sel,
   input  [7:0] udp_gain,
   output i2c_ena,
   output [6:0] i2c_addr,
   output [7:0] i2c_reg_addr,
   output [7:0] i2c_data_wr,
   input  i2c_busy,
   input  i2c_ack_error,
   output i2c_rd_mode,
   output i2c_probe,
   input  i2c_addr_nack,
   input  [7:0] i2c_data_rd,
   output i2c_fault,
   output adc_pll_lock,
   output adc_cfg_ok,
   output [7:0] dbg_rd_pll,
   output [7:0] dbg_rd_sai,
   output [7:0] dbg_scan_cnt,
   output [7:0] dbg_scan_addr,
   output [7:0] dbg_scan_mask,
   output [7:0] dbg_ot,
   output [7:0] dbg_health,
   output [7:0] dbg_vfy_mask);
  wire [3:0] state;
  wire [22:0] delay_cnt;
  wire [1:0] adc_idx;
  wire [3:0] reg_idx;
  wire [2:0] vfy_idx;
  reg [5:0] vfy_mask;
  wire cfg_ok_i;
  wire boot_done_i;
  wire [6:0] scan_addr;
  wire [7:0] found_cnt;
  wire scanned;
  reg [3:0] try_cnt;
  reg [3:0] adr_mask;
  reg scan_bad;
  reg srst_pass;
  reg [20:0] settle_cnt;
  reg pwup_pass;
  reg [24:0] poll_cnt;
  reg [1:0] poll_idx;
  reg polling;
  reg [3:0] pll_mask;
  reg [2:0] poll_reg;
  reg [3:0] clip_ever;
  reg [3:0] cfg_bad;
  reg [3:0] pll_lost;
  reg [3:0] ot_ever;
  wire [7:0] n4400;
  wire [7:0] n4401;
  wire [7:0] n4402;
  wire [1:0] n4404;
  wire [7:0] n4405;
  localparam [7:0] n4407 = 8'b00010001;
  wire n4412;
  wire n4415;
  wire [31:0] n4416;
  wire n4418;
  wire [31:0] n4419;
  wire [31:0] n4421;
  wire [22:0] n4422;
  wire n4423;
  wire [3:0] n4426;
  wire [3:0] n4427;
  wire [22:0] n4428;
  wire n4430;
  wire n4432;
  wire [3:0] n4434;
  wire n4436;
  wire n4437;
  wire n4438;
  wire [7:0] n4440;
  wire n4443;
  wire n4446;
  wire n4449;
  wire n4452;
  wire [3:0] n4453;
  wire n4454;
  reg n4455;
  wire n4456;
  reg n4457;
  wire n4458;
  reg n4459;
  wire n4460;
  reg n4461;
  wire n4468;
  wire n4470;
  wire [7:0] n4471;
  wire [3:0] n4473;
  wire [3:0] n4474;
  wire n4475;
  wire n4477;
  wire [6:0] n4479;
  wire n4481;
  wire [3:0] n4484;
  wire [6:0] n4485;
  wire n4487;
  wire n4488;
  wire [3:0] n4489;
  wire [6:0] n4490;
  wire n4491;
  wire n4493;
  wire n4494;
  wire n4495;
  wire n4497;
  wire [15:0] n4505;
  wire [15:0] n4507;
  wire [7:0] n4509;
  wire n4511;
  wire [15:0] n4518;
  wire [7:0] n4519;
  wire n4521;
  wire [15:0] n4528;
  wire [15:0] n4529;
  wire [15:0] n4530;
  wire n4538;
  wire n4541;
  wire n4544;
  wire n4547;
  wire [3:0] n4549;
  reg [6:0] n4550;
  wire [7:0] n4551;
  wire [7:0] n4552;
  wire n4554;
  wire [3:0] n4556;
  wire n4558;
  wire n4559;
  wire n4561;
  wire n4562;
  wire n4564;
  wire n4565;
  wire n4567;
  wire [1:0] n4569;
  wire [3:0] n4572;
  wire [1:0] n4574;
  wire [20:0] n4576;
  wire [3:0] n4578;
  wire [3:0] n4580;
  wire [1:0] n4581;
  wire [3:0] n4583;
  wire n4584;
  wire n4585;
  wire [3:0] n4586;
  wire n4587;
  wire [3:0] n4588;
  wire n4589;
  wire n4591;
  wire [31:0] n4592;
  wire n4594;
  wire n4595;
  wire n4596;
  wire [31:0] n4597;
  wire n4599;
  wire n4600;
  wire n4601;
  wire [31:0] n4602;
  wire [31:0] n4604;
  wire [20:0] n4605;
  wire n4606;
  wire [3:0] n4609;
  wire [1:0] n4611;
  wire [3:0] n4613;
  wire [2:0] n4615;
  wire n4617;
  wire [3:0] n4619;
  wire [1:0] n4621;
  wire [3:0] n4623;
  wire [2:0] n4624;
  wire n4626;
  wire n4627;
  wire [3:0] n4628;
  wire [1:0] n4629;
  wire [3:0] n4630;
  wire [2:0] n4631;
  wire n4632;
  wire [20:0] n4633;
  wire n4634;
  wire n4636;
  wire n4644;
  wire n4647;
  wire n4650;
  wire n4653;
  wire [3:0] n4655;
  reg [6:0] n4656;
  wire [6:0] n4659;
  wire [2:0] n4662;
  localparam [95:0] n4664 = 96'b000000010000000000001001000000000001100100000000000000000000000100000101010110110000011000001000;
  wire [2:0] n4668;
  localparam [95:0] n4670 = 96'b000000000000000100000001000000110000010000111111000001010101101100000110000010000000100111111000;
  wire [7:0] n4672;
  wire n4674;
  wire [3:0] n4676;
  wire n4678;
  wire n4679;
  wire n4681;
  wire n4682;
  wire n4684;
  wire n4685;
  wire n4687;
  wire n4688;
  wire [30:0] n4689;
  wire n4692;
  wire n4694;
  wire n4695;
  wire n4696;
  wire [3:0] n4701;
  wire n4703;
  wire n4708;
  wire [3:0] n4713;
  wire n4715;
  wire [3:0] n4716;
  wire n4718;
  wire [3:0] n4723;
  wire n4725;
  wire [2:0] n4728;
  wire n4731;
  wire [3:0] n4736;
  wire [2:0] n4737;
  reg [3:0] n4738;
  reg [3:0] n4739;
  reg [3:0] n4740;
  reg [3:0] n4741;
  reg [3:0] n4743;
  wire n4745;
  wire [3:0] n4750;
  wire [3:0] n4751;
  wire [3:0] n4752;
  wire [3:0] n4753;
  wire [3:0] n4754;
  wire [3:0] n4756;
  wire n4758;
  wire n4760;
  wire [2:0] n4762;
  wire [2:0] n4764;
  wire [2:0] n4765;
  wire [1:0] n4767;
  wire n4768;
  wire n4770;
  wire [7:0] n4772;
  wire n4774;
  wire n4776;
  wire n4777;
  wire n4779;
  wire [7:0] n4781;
  wire n4783;
  wire n4785;
  wire n4786;
  wire [2:0] n4789;
  wire n4792;
  wire [5:0] n4797;
  wire [4:0] n4798;
  wire [4:0] n4799;
  wire [4:0] n4800;
  wire n4801;
  wire n4802;
  wire [5:0] n4803;
  wire n4804;
  wire n4805;
  wire n4806;
  wire n4807;
  wire n4808;
  wire [3:0] n4809;
  wire [3:0] n4810;
  wire [3:0] n4811;
  wire [5:0] n4812;
  wire [5:0] n4813;
  wire n4815;
  wire [7:0] n4816;
  wire n4818;
  wire n4820;
  wire n4822;
  wire n4824;
  wire n4826;
  wire n4828;
  wire n4829;
  wire n4830;
  wire n4832;
  wire n4833;
  wire [7:0] n4834;
  wire n4835;
  wire [7:0] n4836;
  wire n4837;
  wire n4839;
  wire [31:0] n4840;
  wire n4842;
  wire n4843;
  wire [31:0] n4844;
  wire [31:0] n4846;
  wire [3:0] n4847;
  wire [3:0] n4850;
  wire n4852;
  wire [3:0] n4853;
  wire [2:0] n4855;
  wire n4857;
  wire [3:0] n4859;
  wire [2:0] n4860;
  wire n4861;
  wire [3:0] n4862;
  wire n4864;
  wire n4865;
  wire [7:0] n4866;
  wire [7:0] n4867;
  wire [3:0] n4869;
  wire [2:0] n4870;
  wire [5:0] n4871;
  wire n4872;
  wire n4873;
  wire [3:0] n4874;
  wire [1:0] n4875;
  wire n4877;
  wire [3:0] n4878;
  wire n4879;
  wire n4880;
  wire n4881;
  wire n4882;
  wire n4884;
  wire n4885;
  wire n4886;
  wire n4887;
  wire [7:0] n4888;
  wire [7:0] n4889;
  wire [3:0] n4890;
  wire [2:0] n4891;
  wire [5:0] n4892;
  wire n4893;
  wire n4894;
  wire [3:0] n4895;
  wire n4896;
  wire n4897;
  wire n4898;
  wire n4899;
  wire n4900;
  wire n4901;
  wire n4902;
  wire n4904;
  wire n4906;
  wire [31:0] n4907;
  wire n4909;
  wire [31:0] n4910;
  wire [31:0] n4912;
  wire [24:0] n4913;
  wire [3:0] n4915;
  wire [2:0] n4917;
  wire [24:0] n4919;
  wire n4921;
  wire n4922;
  wire n4923;
  wire [24:0] n4924;
  wire n4925;
  wire [3:0] n4927;
  wire [2:0] n4928;
  wire [24:0] n4929;
  wire n4930;
  wire n4932;
  wire n4940;
  wire n4943;
  wire n4946;
  wire n4949;
  wire [3:0] n4951;
  reg [6:0] n4952;
  wire n4954;
  wire n4956;
  wire n4958;
  wire n4960;
  wire [3:0] n4961;
  reg [7:0] n4967;
  wire n4969;
  wire [3:0] n4971;
  wire n4973;
  wire n4974;
  wire n4977;
  wire [3:0] n4979;
  wire n4981;
  wire [15:0] n4982;
  reg n4984;
  reg n4991;
  reg [6:0] n4993;
  reg [7:0] n4994;
  reg [7:0] n4995;
  reg n4998;
  reg n5000;
  reg n5001;
  reg n5002;
  reg [7:0] n5003;
  reg [7:0] n5004;
  reg [3:0] n5011;
  reg [22:0] n5013;
  reg [1:0] n5015;
  reg [3:0] n5017;
  reg [2:0] n5018;
  reg [5:0] n5019;
  reg n5020;
  reg n5022;
  reg [6:0] n5023;
  reg [7:0] n5024;
  reg n5026;
  reg [3:0] n5027;
  reg [3:0] n5028;
  reg n5029;
  reg n5030;
  reg [20:0] n5031;
  reg n5032;
  reg [24:0] n5033;
  reg [1:0] n5034;
  reg n5035;
  reg [3:0] n5036;
  reg [2:0] n5037;
  reg [3:0] n5038;
  reg [3:0] n5039;
  reg [3:0] n5040;
  reg [3:0] n5042;
  reg n5168;
  reg n5169;
  reg [6:0] n5170;
  reg [7:0] n5171;
  reg [7:0] n5172;
  reg n5173;
  reg n5174;
  reg n5175;
  reg n5176;
  reg [7:0] n5177;
  reg [7:0] n5178;
  reg [3:0] n5179;
  reg [22:0] n5180;
  reg [1:0] n5181;
  reg [3:0] n5182;
  reg [2:0] n5183;
  wire n5184;
  wire [5:0] n5185;
  reg [5:0] n5186;
  reg n5187;
  reg n5188;
  reg [6:0] n5189;
  reg [7:0] n5190;
  reg n5191;
  reg [3:0] n5192;
  reg [3:0] n5193;
  reg n5194;
  reg n5195;
  reg [20:0] n5196;
  reg n5197;
  reg [24:0] n5198;
  reg [1:0] n5199;
  reg n5200;
  reg [3:0] n5201;
  reg [2:0] n5202;
  reg [3:0] n5203;
  reg [3:0] n5204;
  reg [3:0] n5205;
  reg [3:0] n5206;
  wire [15:0] n5209; // mem_rd
  wire [7:0] n5212; // mem_rd
  wire [7:0] n5215; // mem_rd
  wire [87:0] n5216;
  wire [127:0] n5218;
  wire [15:0] n5219;
  wire [7:0] n5220;
  wire [87:0] n5221;
  wire [127:0] n5223;
  wire [15:0] n5224;
  wire [7:0] n5225;
  wire n5226;
  wire n5227;
  wire n5228;
  wire n5229;
  wire n5230;
  wire n5231;
  wire n5232;
  wire n5233;
  wire n5234;
  wire n5235;
  wire n5236;
  wire n5237;
  wire n5238;
  wire n5239;
  wire n5240;
  wire n5241;
  wire [3:0] n5242;
  wire n5243;
  wire n5244;
  wire n5245;
  wire n5246;
  wire n5247;
  wire n5248;
  wire n5249;
  wire n5250;
  wire n5251;
  wire n5252;
  wire n5253;
  wire n5254;
  wire n5255;
  wire n5256;
  wire n5257;
  wire n5258;
  wire [3:0] n5259;
  wire n5260;
  wire n5261;
  wire n5262;
  wire n5263;
  wire n5264;
  wire n5265;
  wire n5266;
  wire n5267;
  wire n5268;
  wire n5269;
  wire n5270;
  wire n5271;
  wire n5272;
  wire n5273;
  wire n5274;
  wire n5275;
  wire [3:0] n5276;
  wire n5277;
  wire n5278;
  wire n5279;
  wire n5280;
  wire n5281;
  wire n5282;
  wire n5283;
  wire n5284;
  wire n5285;
  wire n5286;
  wire n5287;
  wire n5288;
  wire n5289;
  wire n5290;
  wire n5291;
  wire n5292;
  wire [3:0] n5293;
  wire [127:0] n5295;
  wire [15:0] n5296;
  wire [7:0] n5297;
  wire n5298;
  wire n5299;
  wire n5300;
  wire n5301;
  wire n5302;
  wire n5303;
  wire n5304;
  wire n5305;
  wire n5306;
  wire n5307;
  wire n5308;
  wire n5309;
  wire n5310;
  wire n5311;
  wire n5312;
  wire n5313;
  wire [3:0] n5314;
  wire n5315;
  wire n5316;
  wire n5317;
  wire n5318;
  wire n5319;
  wire n5320;
  wire n5321;
  wire n5322;
  wire n5323;
  wire n5324;
  wire n5325;
  wire n5326;
  wire n5327;
  wire n5328;
  wire n5329;
  wire n5330;
  wire [3:0] n5331;
  wire [127:0] n5333;
  wire [15:0] n5334;
  wire [7:0] n5335;
  wire n5336;
  wire n5337;
  wire n5338;
  wire n5339;
  wire n5340;
  wire n5341;
  wire n5342;
  wire n5343;
  wire n5344;
  wire n5345;
  wire n5346;
  wire n5347;
  wire n5348;
  wire n5349;
  wire n5350;
  wire n5351;
  wire n5352;
  wire n5353;
  wire n5354;
  wire n5355;
  wire n5356;
  wire n5357;
  wire n5358;
  wire n5359;
  wire n5360;
  wire n5361;
  wire n5362;
  wire [5:0] n5363;
  assign boot_done = boot_done_i; //(module output)
  assign udp_ack = n5168; //(module output)
  assign i2c_ena = n5169; //(module output)
  assign i2c_addr = n5170; //(module output)
  assign i2c_reg_addr = n5171; //(module output)
  assign i2c_data_wr = n5172; //(module output)
  assign i2c_rd_mode = n5173; //(module output)
  assign i2c_probe = n5174; //(module output)
  assign i2c_fault = n5175; //(module output)
  assign adc_pll_lock = n5176; //(module output)
  assign adc_cfg_ok = cfg_ok_i; //(module output)
  assign dbg_rd_pll = n5177; //(module output)
  assign dbg_rd_sai = n5178; //(module output)
  assign dbg_scan_cnt = found_cnt; //(module output)
  assign dbg_scan_addr = n4407; //(module output)
  assign dbg_scan_mask = n4400; //(module output)
  assign dbg_ot = n4401; //(module output)
  assign dbg_health = n4402; //(module output)
  assign dbg_vfy_mask = n4405; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:85:12 */
  assign state = n5179; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:88:12 */
  assign delay_cnt = n5180; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:89:12 */
  assign adc_idx = n5181; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:90:12 */
  assign reg_idx = n5182; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:91:12 */
  assign vfy_idx = n5183; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  always @*
    vfy_mask = n5186; // (isignal)
  initial
    vfy_mask = 6'b000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:105:12 */
  assign cfg_ok_i = n5187; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:106:12 */
  assign boot_done_i = n5188; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:107:12 */
  assign scan_addr = n5189; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:108:12 */
  assign found_cnt = n5190; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:110:12 */
  assign scanned = n5191; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:115:12 */
  always @*
    try_cnt = n5192; // (isignal)
  initial
    try_cnt = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:116:12 */
  always @*
    adr_mask = n5193; // (isignal)
  initial
    adr_mask = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:120:12 */
  always @*
    scan_bad = n5194; // (isignal)
  initial
    scan_bad = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:182:12 */
  always @*
    srst_pass = n5195; // (isignal)
  initial
    srst_pass = 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:199:12 */
  always @*
    settle_cnt = n5196; // (isignal)
  initial
    settle_cnt = 21'b000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:200:12 */
  always @*
    pwup_pass = n5197; // (isignal)
  initial
    pwup_pass = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:203:12 */
  always @*
    poll_cnt = n5198; // (isignal)
  initial
    poll_cnt = 25'b0000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:204:12 */
  always @*
    poll_idx = n5199; // (isignal)
  initial
    poll_idx = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:205:12 */
  always @*
    polling = n5200; // (isignal)
  initial
    polling = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:207:12 */
  always @*
    pll_mask = n5201; // (isignal)
  initial
    pll_mask = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:240:12 */
  always @*
    poll_reg = n5202; // (isignal)
  initial
    poll_reg = 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:241:12 */
  always @*
    clip_ever = n5203; // (isignal)
  initial
    clip_ever = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:242:12 */
  always @*
    cfg_bad = n5204; // (isignal)
  initial
    cfg_bad = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:248:12 */
  always @*
    pll_lost = n5205; // (isignal)
  initial
    pll_lost = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:251:12 */
  always @*
    ot_ever = n5206; // (isignal)
  initial
    ot_ever = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:466:31 */
  assign n4400 = {pll_mask, adr_mask};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:469:30 */
  assign n4401 = {ot_ever, pll_lost};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:470:30 */
  assign n4402 = {cfg_bad, clip_ever};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:471:31 */
  assign n4404 = {scan_bad, 1'b0};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:471:37 */
  assign n4405 = {n4404, vfy_mask};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:482:18 */
  assign n4412 = ~rst_n;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:538:17 */
  assign n4415 = state == 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:547:34 */
  assign n4416 = {9'b0, delay_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:547:34 */
  assign n4418 = $signed(n4416) < $signed(32'b00000000011100100111000011100000);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:548:48 */
  assign n4419 = {9'b0, delay_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:548:48 */
  assign n4421 = n4419 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:548:38 */
  assign n4422 = n4421[22:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:549:35 */
  assign n4423 = ~scanned;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:549:21 */
  assign n4426 = n4423 ? 4'b0010 : 4'b0101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:547:21 */
  assign n4427 = n4418 ? state : n4426;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:547:21 */
  assign n4428 = n4418 ? n4422 : delay_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:545:17 */
  assign n4430 = state == 4'b0001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:561:17 */
  assign n4432 = state == 4'b0010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:569:21 */
  assign n4434 = i2c_busy ? 4'b0100 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:568:17 */
  assign n4436 = state == 4'b0011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:33 */
  assign n4437 = ~i2c_busy;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:575:42 */
  assign n4438 = ~i2c_addr_nack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:576:52 */
  assign n4440 = found_cnt + 8'b00000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:578:33 */
  assign n4443 = scan_addr == 7'b0010001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:579:33 */
  assign n4446 = scan_addr == 7'b0110001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:580:33 */
  assign n4449 = scan_addr == 7'b1010001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:581:33 */
  assign n4452 = scan_addr == 7'b1110001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:577:29 */
  assign n4453 = {n4452, n4449, n4446, n4443};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:116:12 */
  assign n4454 = adr_mask[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:577:29 */
  always @*
    case (n4453)
      4'b1000: n4455 = n4454;
      4'b0100: n4455 = n4454;
      4'b0010: n4455 = n4454;
      4'b0001: n4455 = 1'b1;
      default: n4455 = n4454;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:116:12 */
  assign n4456 = adr_mask[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:577:29 */
  always @*
    case (n4453)
      4'b1000: n4457 = n4456;
      4'b0100: n4457 = n4456;
      4'b0010: n4457 = 1'b1;
      4'b0001: n4457 = n4456;
      default: n4457 = n4456;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:116:12 */
  assign n4458 = adr_mask[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:577:29 */
  always @*
    case (n4453)
      4'b1000: n4459 = n4458;
      4'b0100: n4459 = 1'b1;
      4'b0010: n4459 = n4458;
      4'b0001: n4459 = n4458;
      default: n4459 = n4458;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:116:12 */
  assign n4460 = adr_mask[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:577:29 */
  always @*
    case (n4453)
      4'b1000: n4461 = 1'b1;
      4'b0100: n4461 = n4460;
      4'b0010: n4461 = n4460;
      4'b0001: n4461 = n4460;
      default: n4461 = n4460;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:591:42 */
  assign n4468 = $unsigned(found_cnt) >= $unsigned(8'b00000100);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4470 = n4495 ? 1'b1 : scan_bad;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4471 = n4491 ? n4440 : found_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:575:25 */
  assign n4473 = {n4461, n4459, n4457, n4455};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4474 = n4494 ? n4473 : adr_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:575:25 */
  assign n4475 = n4468 & n4438;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:599:38 */
  assign n4477 = scan_addr == 7'b1111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:604:52 */
  assign n4479 = scan_addr + 7'b0000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4481 = n4488 ? 1'b0 : n5174;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:599:25 */
  assign n4484 = n4477 ? 4'b0101 : 4'b0010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:599:25 */
  assign n4485 = n4477 ? scan_addr : n4479;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4487 = n4493 ? 1'b1 : scanned;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4488 = n4477 & n4437;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4489 = n4437 ? n4484 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4490 = n4437 ? n4485 : scan_addr;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4491 = n4438 & n4437;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4493 = n4477 & n4437;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4494 = n4438 & n4437;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:574:21 */
  assign n4495 = n4475 & n4437;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:573:17 */
  assign n4497 = state == 4'b0100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:614:21 */
  assign n4505 = pwup_pass ? 16'b0000000000000001 : n5209;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:612:21 */
  assign n4507 = srst_pass ? 16'b0000000010000000 : n4505;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:670:41 */
  assign n4509 = n4507[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:670:55 */
  assign n4511 = n4509 == 8'b00000111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:671:52 */
  assign n4518 = {8'b00000111, n5212};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:672:44 */
  assign n4519 = n4507[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:672:58 */
  assign n4521 = n4519 == 8'b00001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:673:52 */
  assign n4528 = {8'b00001000, n5215};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:672:21 */
  assign n4529 = n4521 ? n4528 : n4507;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:670:21 */
  assign n4530 = n4511 ? n4518 : n4529;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:453:13 */
  assign n4538 = adc_idx == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:454:13 */
  assign n4541 = adc_idx == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:455:13 */
  assign n4544 = adc_idx == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:456:13 */
  assign n4547 = adc_idx == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  assign n4549 = {n4547, n4544, n4541, n4538};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  always @*
    case (n4549)
      4'b1000: n4550 = 7'b1110001;
      4'b0100: n4550 = 7'b1010001;
      4'b0010: n4550 = 7'b0110001;
      4'b0001: n4550 = 7'b0010001;
      default: n4550 = 7'b0000000;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:677:54 */
  assign n4551 = n4530[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:678:54 */
  assign n4552 = n4530[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:609:17 */
  assign n4554 = state == 4'b0101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:685:21 */
  assign n4556 = i2c_busy ? 4'b0111 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:683:17 */
  assign n4558 = state == 4'b0110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:33 */
  assign n4559 = ~i2c_busy;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4561 = n4585 ? 1'b1 : n5175;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:700:44 */
  assign n4562 = srst_pass | pwup_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:701:39 */
  assign n4564 = reg_idx == 4'b1010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:701:28 */
  assign n4565 = n4562 | n4564;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:703:40 */
  assign n4567 = adc_idx == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:711:52 */
  assign n4569 = adc_idx + 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:703:29 */
  assign n4572 = n4567 ? 4'b1000 : 4'b0101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:703:29 */
  assign n4574 = n4567 ? 2'b00 : n4569;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4576 = n4589 ? 21'b000000000000000000000 : settle_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:715:48 */
  assign n4578 = reg_idx + 4'b0001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:700:25 */
  assign n4580 = n4565 ? n4572 : 4'b0101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4581 = n4587 ? n4574 : adc_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:700:25 */
  assign n4583 = n4565 ? 4'b0000 : n4578;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:700:25 */
  assign n4584 = n4567 & n4565;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4585 = i2c_ack_error & n4559;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4586 = n4559 ? n4580 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4587 = n4565 & n4559;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4588 = n4559 ? n4583 : reg_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:691:21 */
  assign n4589 = n4584 & n4559;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:689:17 */
  assign n4591 = state == 4'b0111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:56 */
  assign n4592 = {11'b0, settle_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:56 */
  assign n4594 = $signed(n4592) < $signed(32'b00000000000000001100001101010000);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:41 */
  assign n4595 = n4594 & srst_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:729:38 */
  assign n4596 = ~srst_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:729:59 */
  assign n4597 = {11'b0, settle_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:729:59 */
  assign n4599 = $signed(n4597) < $signed(32'b00000000000101101110001101100000);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:729:44 */
  assign n4600 = n4599 & n4596;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:729:24 */
  assign n4601 = n4595 | n4600;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:730:50 */
  assign n4602 = {11'b0, settle_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:730:50 */
  assign n4604 = n4602 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:730:39 */
  assign n4605 = n4604[20:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:37 */
  assign n4606 = ~pwup_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:21 */
  assign n4609 = n4606 ? 4'b0101 : 4'b1001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:21 */
  assign n4611 = n4606 ? 2'b00 : adc_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:21 */
  assign n4613 = n4606 ? 4'b1011 : reg_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:21 */
  assign n4615 = n4606 ? vfy_idx : 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:737:21 */
  assign n4617 = n4606 ? 1'b1 : pwup_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4619 = srst_pass ? 4'b0101 : n4609;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4621 = srst_pass ? 2'b00 : n4611;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4623 = srst_pass ? 4'b0000 : n4613;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4624 = srst_pass ? vfy_idx : n4615;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4626 = srst_pass ? 1'b0 : srst_pass;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:731:21 */
  assign n4627 = srst_pass ? pwup_pass : n4617;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4628 = n4601 ? state : n4619;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4629 = n4601 ? adc_idx : n4621;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4630 = n4601 ? reg_idx : n4623;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4631 = n4601 ? vfy_idx : n4624;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4632 = n4601 ? srst_pass : n4626;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4633 = n4601 ? n4605 : settle_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:728:21 */
  assign n4634 = n4601 ? pwup_pass : n4627;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:720:17 */
  assign n4636 = state == 4'b1000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:453:13 */
  assign n4644 = poll_idx == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:454:13 */
  assign n4647 = poll_idx == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:455:13 */
  assign n4650 = poll_idx == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:456:13 */
  assign n4653 = poll_idx == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  assign n4655 = {n4653, n4650, n4647, n4644};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  always @*
    case (n4655)
      4'b1000: n4656 = 7'b1110001;
      4'b0100: n4656 = 7'b1010001;
      4'b0010: n4656 = 7'b0110001;
      4'b0001: n4656 = 7'b0010001;
      default: n4656 = 7'b0000000;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:757:21 */
  assign n4659 = polling ? n4656 : 7'b0010001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:771:51 */
  assign n4662 = 3'b101 - poll_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:773:50 */
  assign n4668 = 3'b101 - vfy_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:770:21 */
  assign n4672 = polling ? n5220 : n5225;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:753:17 */
  assign n4674 = state == 4'b1001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:779:21 */
  assign n4676 = i2c_busy ? 4'b1011 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:778:17 */
  assign n4678 = state == 4'b1010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:33 */
  assign n4679 = ~i2c_busy;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4681 = n4886 ? 1'b1 : n5175;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:798:46 */
  assign n4682 = ~i2c_addr_nack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:799:48 */
  assign n4684 = i2c_data_rd != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:799:32 */
  assign n4685 = n4684 & n4682;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:800:48 */
  assign n4687 = i2c_data_rd != 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:800:32 */
  assign n4688 = n4687 & n4685;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:38 */
  assign n4689 = {28'b0, poll_reg};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:86 */
  assign n4692 = i2c_data_rd[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:804:55 */
  assign n4694 = i2c_data_rd[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:804:59 */
  assign n4695 = ~n4694;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:804:65 */
  assign n4696 = boot_done_i & n4695;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:804:41 */
  assign n4701 = n4696 ? n5259 : pll_lost;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:802:37 */
  assign n4703 = n4689 == 31'b0000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:809:55 */
  assign n4708 = i2c_data_rd[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:809:41 */
  assign n4713 = n4708 ? n5276 : ot_ever;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:807:37 */
  assign n4715 = n4689 == 31'b0000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:813:55 */
  assign n4716 = i2c_data_rd[3:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:813:68 */
  assign n4718 = n4716 != 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:813:41 */
  assign n4723 = n4718 ? n5293 : clip_ever;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:812:37 */
  assign n4725 = n4689 == 31'b0000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:818:57 */
  assign n4728 = 3'b101 - poll_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:818:44 */
  assign n4731 = i2c_data_rd != n5297;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:817:41 */
  assign n4736 = n4731 ? n5314 : cfg_bad;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  assign n4737 = {n4725, n4715, n4703};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  always @*
    case (n4737)
      3'b100: n4738 = pll_mask;
      3'b010: n4738 = pll_mask;
      3'b001: n4738 = n5242;
      default: n4738 = pll_mask;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  always @*
    case (n4737)
      3'b100: n4739 = n4723;
      3'b010: n4739 = clip_ever;
      3'b001: n4739 = clip_ever;
      default: n4739 = clip_ever;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  always @*
    case (n4737)
      3'b100: n4740 = cfg_bad;
      3'b010: n4740 = cfg_bad;
      3'b001: n4740 = cfg_bad;
      default: n4740 = n4736;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  always @*
    case (n4737)
      3'b100: n4741 = pll_lost;
      3'b010: n4741 = pll_lost;
      3'b001: n4741 = n4701;
      default: n4741 = pll_lost;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:801:33 */
  always @*
    case (n4737)
      3'b100: n4743 = ot_ever;
      3'b010: n4743 = n4713;
      3'b001: n4743 = ot_ever;
      default: n4743 = ot_ever;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:822:44 */
  assign n4745 = poll_reg == 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:822:29 */
  assign n4750 = n4745 ? n5331 : pll_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:798:29 */
  assign n4751 = n4688 ? n4738 : n4750;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4752 = n4900 ? n4739 : clip_ever;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4753 = n4901 ? n4740 : cfg_bad;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4754 = n4902 ? n4741 : pll_lost;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4756 = n4904 ? n4743 : ot_ever;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:826:41 */
  assign n4758 = poll_idx == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:827:45 */
  assign n4760 = poll_reg == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:830:58 */
  assign n4762 = poll_reg + 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:827:33 */
  assign n4764 = n4760 ? 3'b000 : n4762;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4765 = n4899 ? n4764 : poll_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:833:53 */
  assign n4767 = poll_idx + 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:840:46 */
  assign n4768 = ~i2c_addr_nack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:44 */
  assign n4770 = vfy_idx == 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:842:53 */
  assign n4772 = i2c_data_rd & 8'b01111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:843:40 */
  assign n4774 = n4772 == 8'b00000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n4776 = vfy_mask[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:842:37 */
  assign n4777 = n4774 ? 1'b1 : n4776;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:846:47 */
  assign n4779 = vfy_idx == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:847:53 */
  assign n4781 = i2c_data_rd & 8'b11111110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:848:40 */
  assign n4783 = n4781 == 8'b11111000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n4785 = vfy_mask[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:847:37 */
  assign n4786 = n4783 ? 1'b1 : n4785;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:62 */
  assign n4789 = 3'b101 - vfy_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:51 */
  assign n4792 = i2c_data_rd == n5335;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:33 */
  assign n4797 = n4792 ? n5363 : vfy_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:33 */
  assign n4798 = n4797[4:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n4799 = vfy_mask[4:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:846:33 */
  assign n4800 = n4779 ? n4799 : n4798;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:33 */
  assign n4801 = n4797[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:846:33 */
  assign n4802 = n4779 ? n4786 : n4801;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4803 = {n4802, n4800};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4804 = n4803[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n4805 = vfy_mask[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4806 = n4770 ? n4805 : n4804;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4807 = n4803[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4808 = n4770 ? n4777 : n4807;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4809 = n4803[5:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n4810 = vfy_mask[5:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:841:33 */
  assign n4811 = n4770 ? n4810 : n4809;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:840:29 */
  assign n4812 = {n4811, n4808, n4806};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:840:29 */
  assign n4813 = n4768 ? n4812 : vfy_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:856:40 */
  assign n4815 = vfy_idx == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:856:29 */
  assign n4816 = n4815 ? i2c_data_rd : n5178;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:862:40 */
  assign n4818 = vfy_idx == 3'b011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:875:48 */
  assign n4820 = i2c_data_rd == 8'b01011011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:862:29 */
  assign n4822 = n4837 ? 1'b1 : cfg_ok_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:878:43 */
  assign n4824 = vfy_idx == 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:880:48 */
  assign n4826 = i2c_data_rd != 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:880:73 */
  assign n4828 = i2c_data_rd != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:880:57 */
  assign n4829 = n4828 & n4826;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:881:64 */
  assign n4830 = i2c_data_rd[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:880:33 */
  assign n4832 = n4829 ? n4830 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:878:29 */
  assign n4833 = n4824 ? n4832 : n5176;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:878:29 */
  assign n4834 = n4824 ? i2c_data_rd : n5177;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:862:29 */
  assign n4835 = n4818 ? n5176 : n4833;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:862:29 */
  assign n4836 = n4818 ? n5177 : n4834;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:862:29 */
  assign n4837 = n4820 & n4818;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:40 */
  assign n4839 = vfy_idx == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:889:62 */
  assign n4840 = {28'b0, try_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:889:62 */
  assign n4842 = n4840 == 32'b00000000000000000000000000001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:889:51 */
  assign n4843 = cfg_ok_i | n4842;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:893:56 */
  assign n4844 = {28'b0, try_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:893:56 */
  assign n4846 = n4844 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:893:48 */
  assign n4847 = n4846[3:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:889:33 */
  assign n4850 = n4843 ? 4'b1100 : 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4852 = n4861 ? 1'b1 : boot_done_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:889:33 */
  assign n4853 = n4843 ? try_cnt : n4847;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:897:52 */
  assign n4855 = vfy_idx + 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4857 = n4839 ? 1'b0 : n5173;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4859 = n4839 ? n4850 : 4'b1001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4860 = n4839 ? vfy_idx : n4855;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4861 = n4843 & n4839;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:887:29 */
  assign n4862 = n4839 ? n4853 : try_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4864 = polling ? 1'b0 : n4857;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4865 = polling ? n5176 : n4835;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4866 = polling ? n5177 : n4836;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4867 = polling ? n5178 : n4816;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4869 = polling ? 4'b1100 : n4859;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4870 = polling ? vfy_idx : n4860;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4871 = polling ? vfy_mask : n4813;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4872 = polling ? cfg_ok_i : n4822;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4873 = polling ? boot_done_i : n4852;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4874 = polling ? try_cnt : n4862;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4875 = n4896 ? n4767 : poll_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4877 = n4897 ? 1'b0 : polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4878 = n4898 ? n4751 : pll_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4879 = n4758 & polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4880 = n4688 & polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4881 = n4688 & polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4882 = n4688 & polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:788:25 */
  assign n4884 = n4688 & polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4885 = n4679 ? n4864 : n5173;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4886 = i2c_ack_error & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4887 = n4679 ? n4865 : n5176;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4888 = n4679 ? n4866 : n5177;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4889 = n4679 ? n4867 : n5178;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4890 = n4679 ? n4869 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4891 = n4679 ? n4870 : vfy_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4892 = n4679 ? n4871 : vfy_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4893 = n4679 ? n4872 : cfg_ok_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4894 = n4679 ? n4873 : boot_done_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4895 = n4679 ? n4874 : try_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4896 = polling & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4897 = polling & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4898 = polling & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4899 = n4879 & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4900 = n4880 & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4901 = n4881 & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4902 = n4882 & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:784:21 */
  assign n4904 = n4884 & n4679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:783:17 */
  assign n4906 = state == 4'b1011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:916:37 */
  assign n4907 = {7'b0, poll_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:916:37 */
  assign n4909 = n4907 == 32'b00000001011111010111100001000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:922:50 */
  assign n4910 = {7'b0, poll_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:922:50 */
  assign n4912 = n4910 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:922:41 */
  assign n4913 = n4912[24:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4915 = n4922 ? 4'b1001 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4917 = n4923 ? 3'b001 : vfy_idx;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:916:25 */
  assign n4919 = n4909 ? 25'b0000000000000000000000000 : n4913;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4921 = n4925 ? 1'b1 : polling;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4922 = n4909 & boot_done_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4923 = n4909 & boot_done_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4924 = boot_done_i ? n4919 : poll_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:914:21 */
  assign n4925 = n4909 & boot_done_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:908:21 */
  assign n4927 = udp_req ? 4'b1101 : n4915;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:908:21 */
  assign n4928 = udp_req ? vfy_idx : n4917;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:908:21 */
  assign n4929 = udp_req ? poll_cnt : n4924;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:908:21 */
  assign n4930 = udp_req ? polling : n4921;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:906:17 */
  assign n4932 = state == 4'b1100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:453:13 */
  assign n4940 = udp_adc_sel == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:454:13 */
  assign n4943 = udp_adc_sel == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:455:13 */
  assign n4946 = udp_adc_sel == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:456:13 */
  assign n4949 = udp_adc_sel == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  assign n4951 = {n4949, n4946, n4943, n4940};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:452:9 */
  always @*
    case (n4951)
      4'b1000: n4952 = 7'b1110001;
      4'b0100: n4952 = 7'b1010001;
      4'b0010: n4952 = 7'b0110001;
      4'b0001: n4952 = 7'b0010001;
      default: n4952 = 7'b0000000;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:933:25 */
  assign n4954 = udp_ch_sel == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:934:25 */
  assign n4956 = udp_ch_sel == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:935:25 */
  assign n4958 = udp_ch_sel == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:936:25 */
  assign n4960 = udp_ch_sel == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:932:21 */
  assign n4961 = {n4960, n4958, n4956, n4954};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:932:21 */
  always @*
    case (n4961)
      4'b1000: n4967 = 8'b00001101;
      4'b0100: n4967 = 8'b00001100;
      4'b0010: n4967 = 8'b00001011;
      4'b0001: n4967 = 8'b00001010;
      default: n4967 = 8'b00001010;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:926:17 */
  assign n4969 = state == 4'b1101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:944:21 */
  assign n4971 = i2c_busy ? 4'b1111 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:943:17 */
  assign n4973 = state == 4'b1110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:949:33 */
  assign n4974 = ~i2c_busy;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:949:21 */
  assign n4977 = n4974 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:949:21 */
  assign n4979 = n4974 ? 4'b1100 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:948:17 */
  assign n4981 = state == 4'b1111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  assign n4982 = {n4981, n4973, n4969, n4932, n4906, n4678, n4674, n4636, n4591, n4558, n4554, n4497, n4436, n4432, n4430, n4415};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4984 = n4977;
      16'b0100000000000000: n4984 = 1'b0;
      16'b0010000000000000: n4984 = 1'b0;
      16'b0001000000000000: n4984 = 1'b0;
      16'b0000100000000000: n4984 = 1'b0;
      16'b0000010000000000: n4984 = 1'b0;
      16'b0000001000000000: n4984 = 1'b0;
      16'b0000000100000000: n4984 = 1'b0;
      16'b0000000010000000: n4984 = 1'b0;
      16'b0000000001000000: n4984 = 1'b0;
      16'b0000000000100000: n4984 = 1'b0;
      16'b0000000000010000: n4984 = 1'b0;
      16'b0000000000001000: n4984 = 1'b0;
      16'b0000000000000100: n4984 = 1'b0;
      16'b0000000000000010: n4984 = 1'b0;
      16'b0000000000000001: n4984 = 1'b0;
      default: n4984 = 1'b0;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4991 = 1'b0;
      16'b0100000000000000: n4991 = 1'b0;
      16'b0010000000000000: n4991 = 1'b1;
      16'b0001000000000000: n4991 = 1'b0;
      16'b0000100000000000: n4991 = 1'b0;
      16'b0000010000000000: n4991 = 1'b0;
      16'b0000001000000000: n4991 = 1'b1;
      16'b0000000100000000: n4991 = 1'b0;
      16'b0000000010000000: n4991 = 1'b0;
      16'b0000000001000000: n4991 = 1'b0;
      16'b0000000000100000: n4991 = 1'b1;
      16'b0000000000010000: n4991 = 1'b0;
      16'b0000000000001000: n4991 = 1'b0;
      16'b0000000000000100: n4991 = 1'b1;
      16'b0000000000000010: n4991 = 1'b0;
      16'b0000000000000001: n4991 = 1'b0;
      default: n4991 = 1'b0;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4993 = n5170;
      16'b0100000000000000: n4993 = n5170;
      16'b0010000000000000: n4993 = n4952;
      16'b0001000000000000: n4993 = n5170;
      16'b0000100000000000: n4993 = n5170;
      16'b0000010000000000: n4993 = n5170;
      16'b0000001000000000: n4993 = n4659;
      16'b0000000100000000: n4993 = n5170;
      16'b0000000010000000: n4993 = n5170;
      16'b0000000001000000: n4993 = n5170;
      16'b0000000000100000: n4993 = n4550;
      16'b0000000000010000: n4993 = n5170;
      16'b0000000000001000: n4993 = n5170;
      16'b0000000000000100: n4993 = scan_addr;
      16'b0000000000000010: n4993 = n5170;
      16'b0000000000000001: n4993 = n5170;
      default: n4993 = n5170;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4994 = n5171;
      16'b0100000000000000: n4994 = n5171;
      16'b0010000000000000: n4994 = n4967;
      16'b0001000000000000: n4994 = n5171;
      16'b0000100000000000: n4994 = n5171;
      16'b0000010000000000: n4994 = n5171;
      16'b0000001000000000: n4994 = n4672;
      16'b0000000100000000: n4994 = n5171;
      16'b0000000010000000: n4994 = n5171;
      16'b0000000001000000: n4994 = n5171;
      16'b0000000000100000: n4994 = n4551;
      16'b0000000000010000: n4994 = n5171;
      16'b0000000000001000: n4994 = n5171;
      16'b0000000000000100: n4994 = n5171;
      16'b0000000000000010: n4994 = n5171;
      16'b0000000000000001: n4994 = n5171;
      default: n4994 = n5171;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4995 = n5172;
      16'b0100000000000000: n4995 = n5172;
      16'b0010000000000000: n4995 = udp_gain;
      16'b0001000000000000: n4995 = n5172;
      16'b0000100000000000: n4995 = n5172;
      16'b0000010000000000: n4995 = n5172;
      16'b0000001000000000: n4995 = n5172;
      16'b0000000100000000: n4995 = n5172;
      16'b0000000010000000: n4995 = n5172;
      16'b0000000001000000: n4995 = n5172;
      16'b0000000000100000: n4995 = n4552;
      16'b0000000000010000: n4995 = n5172;
      16'b0000000000001000: n4995 = n5172;
      16'b0000000000000100: n4995 = n5172;
      16'b0000000000000010: n4995 = n5172;
      16'b0000000000000001: n4995 = n5172;
      default: n4995 = n5172;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n4998 = n5173;
      16'b0100000000000000: n4998 = n5173;
      16'b0010000000000000: n4998 = n5173;
      16'b0001000000000000: n4998 = n5173;
      16'b0000100000000000: n4998 = n4885;
      16'b0000010000000000: n4998 = n5173;
      16'b0000001000000000: n4998 = 1'b1;
      16'b0000000100000000: n4998 = n5173;
      16'b0000000010000000: n4998 = n5173;
      16'b0000000001000000: n4998 = n5173;
      16'b0000000000100000: n4998 = n5173;
      16'b0000000000010000: n4998 = n5173;
      16'b0000000000001000: n4998 = n5173;
      16'b0000000000000100: n4998 = 1'b0;
      16'b0000000000000010: n4998 = n5173;
      16'b0000000000000001: n4998 = n5173;
      default: n4998 = n5173;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5000 = n5174;
      16'b0100000000000000: n5000 = n5174;
      16'b0010000000000000: n5000 = n5174;
      16'b0001000000000000: n5000 = n5174;
      16'b0000100000000000: n5000 = n5174;
      16'b0000010000000000: n5000 = n5174;
      16'b0000001000000000: n5000 = n5174;
      16'b0000000100000000: n5000 = n5174;
      16'b0000000010000000: n5000 = n5174;
      16'b0000000001000000: n5000 = n5174;
      16'b0000000000100000: n5000 = n5174;
      16'b0000000000010000: n5000 = n4481;
      16'b0000000000001000: n5000 = n5174;
      16'b0000000000000100: n5000 = 1'b1;
      16'b0000000000000010: n5000 = n5174;
      16'b0000000000000001: n5000 = n5174;
      default: n5000 = n5174;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5001 = n5175;
      16'b0100000000000000: n5001 = n5175;
      16'b0010000000000000: n5001 = n5175;
      16'b0001000000000000: n5001 = n5175;
      16'b0000100000000000: n5001 = n4681;
      16'b0000010000000000: n5001 = n5175;
      16'b0000001000000000: n5001 = n5175;
      16'b0000000100000000: n5001 = n5175;
      16'b0000000010000000: n5001 = n4561;
      16'b0000000001000000: n5001 = n5175;
      16'b0000000000100000: n5001 = n5175;
      16'b0000000000010000: n5001 = n5175;
      16'b0000000000001000: n5001 = n5175;
      16'b0000000000000100: n5001 = n5175;
      16'b0000000000000010: n5001 = n5175;
      16'b0000000000000001: n5001 = n5175;
      default: n5001 = n5175;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5002 = n5176;
      16'b0100000000000000: n5002 = n5176;
      16'b0010000000000000: n5002 = n5176;
      16'b0001000000000000: n5002 = n5176;
      16'b0000100000000000: n5002 = n4887;
      16'b0000010000000000: n5002 = n5176;
      16'b0000001000000000: n5002 = n5176;
      16'b0000000100000000: n5002 = n5176;
      16'b0000000010000000: n5002 = n5176;
      16'b0000000001000000: n5002 = n5176;
      16'b0000000000100000: n5002 = n5176;
      16'b0000000000010000: n5002 = n5176;
      16'b0000000000001000: n5002 = n5176;
      16'b0000000000000100: n5002 = n5176;
      16'b0000000000000010: n5002 = n5176;
      16'b0000000000000001: n5002 = n5176;
      default: n5002 = n5176;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5003 = n5177;
      16'b0100000000000000: n5003 = n5177;
      16'b0010000000000000: n5003 = n5177;
      16'b0001000000000000: n5003 = n5177;
      16'b0000100000000000: n5003 = n4888;
      16'b0000010000000000: n5003 = n5177;
      16'b0000001000000000: n5003 = n5177;
      16'b0000000100000000: n5003 = n5177;
      16'b0000000010000000: n5003 = n5177;
      16'b0000000001000000: n5003 = n5177;
      16'b0000000000100000: n5003 = n5177;
      16'b0000000000010000: n5003 = n5177;
      16'b0000000000001000: n5003 = n5177;
      16'b0000000000000100: n5003 = n5177;
      16'b0000000000000010: n5003 = n5177;
      16'b0000000000000001: n5003 = n5177;
      default: n5003 = n5177;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5004 = n5178;
      16'b0100000000000000: n5004 = n5178;
      16'b0010000000000000: n5004 = n5178;
      16'b0001000000000000: n5004 = n5178;
      16'b0000100000000000: n5004 = n4889;
      16'b0000010000000000: n5004 = n5178;
      16'b0000001000000000: n5004 = n5178;
      16'b0000000100000000: n5004 = n5178;
      16'b0000000010000000: n5004 = n5178;
      16'b0000000001000000: n5004 = n5178;
      16'b0000000000100000: n5004 = n5178;
      16'b0000000000010000: n5004 = n5178;
      16'b0000000000001000: n5004 = n5178;
      16'b0000000000000100: n5004 = n5178;
      16'b0000000000000010: n5004 = n5178;
      16'b0000000000000001: n5004 = n5178;
      default: n5004 = n5178;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5011 = n4979;
      16'b0100000000000000: n5011 = n4971;
      16'b0010000000000000: n5011 = 4'b1110;
      16'b0001000000000000: n5011 = n4927;
      16'b0000100000000000: n5011 = n4890;
      16'b0000010000000000: n5011 = n4676;
      16'b0000001000000000: n5011 = 4'b1010;
      16'b0000000100000000: n5011 = n4628;
      16'b0000000010000000: n5011 = n4586;
      16'b0000000001000000: n5011 = n4556;
      16'b0000000000100000: n5011 = 4'b0110;
      16'b0000000000010000: n5011 = n4489;
      16'b0000000000001000: n5011 = n4434;
      16'b0000000000000100: n5011 = 4'b0011;
      16'b0000000000000010: n5011 = n4427;
      16'b0000000000000001: n5011 = 4'b0001;
      default: n5011 = 4'b0000;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5013 = delay_cnt;
      16'b0100000000000000: n5013 = delay_cnt;
      16'b0010000000000000: n5013 = delay_cnt;
      16'b0001000000000000: n5013 = delay_cnt;
      16'b0000100000000000: n5013 = delay_cnt;
      16'b0000010000000000: n5013 = delay_cnt;
      16'b0000001000000000: n5013 = delay_cnt;
      16'b0000000100000000: n5013 = delay_cnt;
      16'b0000000010000000: n5013 = delay_cnt;
      16'b0000000001000000: n5013 = delay_cnt;
      16'b0000000000100000: n5013 = delay_cnt;
      16'b0000000000010000: n5013 = delay_cnt;
      16'b0000000000001000: n5013 = delay_cnt;
      16'b0000000000000100: n5013 = delay_cnt;
      16'b0000000000000010: n5013 = n4428;
      16'b0000000000000001: n5013 = 23'b00000000000000000000000;
      default: n5013 = delay_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5015 = adc_idx;
      16'b0100000000000000: n5015 = adc_idx;
      16'b0010000000000000: n5015 = adc_idx;
      16'b0001000000000000: n5015 = adc_idx;
      16'b0000100000000000: n5015 = adc_idx;
      16'b0000010000000000: n5015 = adc_idx;
      16'b0000001000000000: n5015 = adc_idx;
      16'b0000000100000000: n5015 = n4629;
      16'b0000000010000000: n5015 = n4581;
      16'b0000000001000000: n5015 = adc_idx;
      16'b0000000000100000: n5015 = adc_idx;
      16'b0000000000010000: n5015 = adc_idx;
      16'b0000000000001000: n5015 = adc_idx;
      16'b0000000000000100: n5015 = adc_idx;
      16'b0000000000000010: n5015 = adc_idx;
      16'b0000000000000001: n5015 = 2'b00;
      default: n5015 = adc_idx;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5017 = reg_idx;
      16'b0100000000000000: n5017 = reg_idx;
      16'b0010000000000000: n5017 = reg_idx;
      16'b0001000000000000: n5017 = reg_idx;
      16'b0000100000000000: n5017 = reg_idx;
      16'b0000010000000000: n5017 = reg_idx;
      16'b0000001000000000: n5017 = reg_idx;
      16'b0000000100000000: n5017 = n4630;
      16'b0000000010000000: n5017 = n4588;
      16'b0000000001000000: n5017 = reg_idx;
      16'b0000000000100000: n5017 = reg_idx;
      16'b0000000000010000: n5017 = reg_idx;
      16'b0000000000001000: n5017 = reg_idx;
      16'b0000000000000100: n5017 = reg_idx;
      16'b0000000000000010: n5017 = reg_idx;
      16'b0000000000000001: n5017 = 4'b0000;
      default: n5017 = reg_idx;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5018 = vfy_idx;
      16'b0100000000000000: n5018 = vfy_idx;
      16'b0010000000000000: n5018 = vfy_idx;
      16'b0001000000000000: n5018 = n4928;
      16'b0000100000000000: n5018 = n4891;
      16'b0000010000000000: n5018 = vfy_idx;
      16'b0000001000000000: n5018 = vfy_idx;
      16'b0000000100000000: n5018 = n4631;
      16'b0000000010000000: n5018 = vfy_idx;
      16'b0000000001000000: n5018 = vfy_idx;
      16'b0000000000100000: n5018 = vfy_idx;
      16'b0000000000010000: n5018 = vfy_idx;
      16'b0000000000001000: n5018 = vfy_idx;
      16'b0000000000000100: n5018 = vfy_idx;
      16'b0000000000000010: n5018 = vfy_idx;
      16'b0000000000000001: n5018 = vfy_idx;
      default: n5018 = vfy_idx;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5019 = vfy_mask;
      16'b0100000000000000: n5019 = vfy_mask;
      16'b0010000000000000: n5019 = vfy_mask;
      16'b0001000000000000: n5019 = vfy_mask;
      16'b0000100000000000: n5019 = n4892;
      16'b0000010000000000: n5019 = vfy_mask;
      16'b0000001000000000: n5019 = vfy_mask;
      16'b0000000100000000: n5019 = vfy_mask;
      16'b0000000010000000: n5019 = vfy_mask;
      16'b0000000001000000: n5019 = vfy_mask;
      16'b0000000000100000: n5019 = vfy_mask;
      16'b0000000000010000: n5019 = vfy_mask;
      16'b0000000000001000: n5019 = vfy_mask;
      16'b0000000000000100: n5019 = vfy_mask;
      16'b0000000000000010: n5019 = vfy_mask;
      16'b0000000000000001: n5019 = vfy_mask;
      default: n5019 = vfy_mask;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5020 = cfg_ok_i;
      16'b0100000000000000: n5020 = cfg_ok_i;
      16'b0010000000000000: n5020 = cfg_ok_i;
      16'b0001000000000000: n5020 = cfg_ok_i;
      16'b0000100000000000: n5020 = n4893;
      16'b0000010000000000: n5020 = cfg_ok_i;
      16'b0000001000000000: n5020 = cfg_ok_i;
      16'b0000000100000000: n5020 = cfg_ok_i;
      16'b0000000010000000: n5020 = cfg_ok_i;
      16'b0000000001000000: n5020 = cfg_ok_i;
      16'b0000000000100000: n5020 = cfg_ok_i;
      16'b0000000000010000: n5020 = cfg_ok_i;
      16'b0000000000001000: n5020 = cfg_ok_i;
      16'b0000000000000100: n5020 = cfg_ok_i;
      16'b0000000000000010: n5020 = cfg_ok_i;
      16'b0000000000000001: n5020 = cfg_ok_i;
      default: n5020 = cfg_ok_i;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5022 = boot_done_i;
      16'b0100000000000000: n5022 = boot_done_i;
      16'b0010000000000000: n5022 = boot_done_i;
      16'b0001000000000000: n5022 = boot_done_i;
      16'b0000100000000000: n5022 = n4894;
      16'b0000010000000000: n5022 = boot_done_i;
      16'b0000001000000000: n5022 = boot_done_i;
      16'b0000000100000000: n5022 = boot_done_i;
      16'b0000000010000000: n5022 = boot_done_i;
      16'b0000000001000000: n5022 = boot_done_i;
      16'b0000000000100000: n5022 = boot_done_i;
      16'b0000000000010000: n5022 = boot_done_i;
      16'b0000000000001000: n5022 = boot_done_i;
      16'b0000000000000100: n5022 = boot_done_i;
      16'b0000000000000010: n5022 = boot_done_i;
      16'b0000000000000001: n5022 = 1'b0;
      default: n5022 = boot_done_i;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5023 = scan_addr;
      16'b0100000000000000: n5023 = scan_addr;
      16'b0010000000000000: n5023 = scan_addr;
      16'b0001000000000000: n5023 = scan_addr;
      16'b0000100000000000: n5023 = scan_addr;
      16'b0000010000000000: n5023 = scan_addr;
      16'b0000001000000000: n5023 = scan_addr;
      16'b0000000100000000: n5023 = scan_addr;
      16'b0000000010000000: n5023 = scan_addr;
      16'b0000000001000000: n5023 = scan_addr;
      16'b0000000000100000: n5023 = scan_addr;
      16'b0000000000010000: n5023 = n4490;
      16'b0000000000001000: n5023 = scan_addr;
      16'b0000000000000100: n5023 = scan_addr;
      16'b0000000000000010: n5023 = scan_addr;
      16'b0000000000000001: n5023 = scan_addr;
      default: n5023 = scan_addr;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5024 = found_cnt;
      16'b0100000000000000: n5024 = found_cnt;
      16'b0010000000000000: n5024 = found_cnt;
      16'b0001000000000000: n5024 = found_cnt;
      16'b0000100000000000: n5024 = found_cnt;
      16'b0000010000000000: n5024 = found_cnt;
      16'b0000001000000000: n5024 = found_cnt;
      16'b0000000100000000: n5024 = found_cnt;
      16'b0000000010000000: n5024 = found_cnt;
      16'b0000000001000000: n5024 = found_cnt;
      16'b0000000000100000: n5024 = found_cnt;
      16'b0000000000010000: n5024 = n4471;
      16'b0000000000001000: n5024 = found_cnt;
      16'b0000000000000100: n5024 = found_cnt;
      16'b0000000000000010: n5024 = found_cnt;
      16'b0000000000000001: n5024 = found_cnt;
      default: n5024 = found_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5026 = scanned;
      16'b0100000000000000: n5026 = scanned;
      16'b0010000000000000: n5026 = scanned;
      16'b0001000000000000: n5026 = scanned;
      16'b0000100000000000: n5026 = scanned;
      16'b0000010000000000: n5026 = scanned;
      16'b0000001000000000: n5026 = scanned;
      16'b0000000100000000: n5026 = scanned;
      16'b0000000010000000: n5026 = scanned;
      16'b0000000001000000: n5026 = scanned;
      16'b0000000000100000: n5026 = scanned;
      16'b0000000000010000: n5026 = n4487;
      16'b0000000000001000: n5026 = scanned;
      16'b0000000000000100: n5026 = scanned;
      16'b0000000000000010: n5026 = scanned;
      16'b0000000000000001: n5026 = scanned;
      default: n5026 = scanned;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5027 = try_cnt;
      16'b0100000000000000: n5027 = try_cnt;
      16'b0010000000000000: n5027 = try_cnt;
      16'b0001000000000000: n5027 = try_cnt;
      16'b0000100000000000: n5027 = n4895;
      16'b0000010000000000: n5027 = try_cnt;
      16'b0000001000000000: n5027 = try_cnt;
      16'b0000000100000000: n5027 = try_cnt;
      16'b0000000010000000: n5027 = try_cnt;
      16'b0000000001000000: n5027 = try_cnt;
      16'b0000000000100000: n5027 = try_cnt;
      16'b0000000000010000: n5027 = try_cnt;
      16'b0000000000001000: n5027 = try_cnt;
      16'b0000000000000100: n5027 = try_cnt;
      16'b0000000000000010: n5027 = try_cnt;
      16'b0000000000000001: n5027 = try_cnt;
      default: n5027 = try_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5028 = adr_mask;
      16'b0100000000000000: n5028 = adr_mask;
      16'b0010000000000000: n5028 = adr_mask;
      16'b0001000000000000: n5028 = adr_mask;
      16'b0000100000000000: n5028 = adr_mask;
      16'b0000010000000000: n5028 = adr_mask;
      16'b0000001000000000: n5028 = adr_mask;
      16'b0000000100000000: n5028 = adr_mask;
      16'b0000000010000000: n5028 = adr_mask;
      16'b0000000001000000: n5028 = adr_mask;
      16'b0000000000100000: n5028 = adr_mask;
      16'b0000000000010000: n5028 = n4474;
      16'b0000000000001000: n5028 = adr_mask;
      16'b0000000000000100: n5028 = adr_mask;
      16'b0000000000000010: n5028 = adr_mask;
      16'b0000000000000001: n5028 = adr_mask;
      default: n5028 = adr_mask;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5029 = scan_bad;
      16'b0100000000000000: n5029 = scan_bad;
      16'b0010000000000000: n5029 = scan_bad;
      16'b0001000000000000: n5029 = scan_bad;
      16'b0000100000000000: n5029 = scan_bad;
      16'b0000010000000000: n5029 = scan_bad;
      16'b0000001000000000: n5029 = scan_bad;
      16'b0000000100000000: n5029 = scan_bad;
      16'b0000000010000000: n5029 = scan_bad;
      16'b0000000001000000: n5029 = scan_bad;
      16'b0000000000100000: n5029 = scan_bad;
      16'b0000000000010000: n5029 = n4470;
      16'b0000000000001000: n5029 = scan_bad;
      16'b0000000000000100: n5029 = scan_bad;
      16'b0000000000000010: n5029 = scan_bad;
      16'b0000000000000001: n5029 = scan_bad;
      default: n5029 = scan_bad;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5030 = srst_pass;
      16'b0100000000000000: n5030 = srst_pass;
      16'b0010000000000000: n5030 = srst_pass;
      16'b0001000000000000: n5030 = srst_pass;
      16'b0000100000000000: n5030 = srst_pass;
      16'b0000010000000000: n5030 = srst_pass;
      16'b0000001000000000: n5030 = srst_pass;
      16'b0000000100000000: n5030 = n4632;
      16'b0000000010000000: n5030 = srst_pass;
      16'b0000000001000000: n5030 = srst_pass;
      16'b0000000000100000: n5030 = srst_pass;
      16'b0000000000010000: n5030 = srst_pass;
      16'b0000000000001000: n5030 = srst_pass;
      16'b0000000000000100: n5030 = srst_pass;
      16'b0000000000000010: n5030 = srst_pass;
      16'b0000000000000001: n5030 = srst_pass;
      default: n5030 = srst_pass;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5031 = settle_cnt;
      16'b0100000000000000: n5031 = settle_cnt;
      16'b0010000000000000: n5031 = settle_cnt;
      16'b0001000000000000: n5031 = settle_cnt;
      16'b0000100000000000: n5031 = settle_cnt;
      16'b0000010000000000: n5031 = settle_cnt;
      16'b0000001000000000: n5031 = settle_cnt;
      16'b0000000100000000: n5031 = n4633;
      16'b0000000010000000: n5031 = n4576;
      16'b0000000001000000: n5031 = settle_cnt;
      16'b0000000000100000: n5031 = settle_cnt;
      16'b0000000000010000: n5031 = settle_cnt;
      16'b0000000000001000: n5031 = settle_cnt;
      16'b0000000000000100: n5031 = settle_cnt;
      16'b0000000000000010: n5031 = settle_cnt;
      16'b0000000000000001: n5031 = settle_cnt;
      default: n5031 = settle_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5032 = pwup_pass;
      16'b0100000000000000: n5032 = pwup_pass;
      16'b0010000000000000: n5032 = pwup_pass;
      16'b0001000000000000: n5032 = pwup_pass;
      16'b0000100000000000: n5032 = pwup_pass;
      16'b0000010000000000: n5032 = pwup_pass;
      16'b0000001000000000: n5032 = pwup_pass;
      16'b0000000100000000: n5032 = n4634;
      16'b0000000010000000: n5032 = pwup_pass;
      16'b0000000001000000: n5032 = pwup_pass;
      16'b0000000000100000: n5032 = pwup_pass;
      16'b0000000000010000: n5032 = pwup_pass;
      16'b0000000000001000: n5032 = pwup_pass;
      16'b0000000000000100: n5032 = pwup_pass;
      16'b0000000000000010: n5032 = pwup_pass;
      16'b0000000000000001: n5032 = pwup_pass;
      default: n5032 = pwup_pass;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5033 = poll_cnt;
      16'b0100000000000000: n5033 = poll_cnt;
      16'b0010000000000000: n5033 = poll_cnt;
      16'b0001000000000000: n5033 = n4929;
      16'b0000100000000000: n5033 = poll_cnt;
      16'b0000010000000000: n5033 = poll_cnt;
      16'b0000001000000000: n5033 = poll_cnt;
      16'b0000000100000000: n5033 = poll_cnt;
      16'b0000000010000000: n5033 = poll_cnt;
      16'b0000000001000000: n5033 = poll_cnt;
      16'b0000000000100000: n5033 = poll_cnt;
      16'b0000000000010000: n5033 = poll_cnt;
      16'b0000000000001000: n5033 = poll_cnt;
      16'b0000000000000100: n5033 = poll_cnt;
      16'b0000000000000010: n5033 = poll_cnt;
      16'b0000000000000001: n5033 = poll_cnt;
      default: n5033 = poll_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5034 = poll_idx;
      16'b0100000000000000: n5034 = poll_idx;
      16'b0010000000000000: n5034 = poll_idx;
      16'b0001000000000000: n5034 = poll_idx;
      16'b0000100000000000: n5034 = n4875;
      16'b0000010000000000: n5034 = poll_idx;
      16'b0000001000000000: n5034 = poll_idx;
      16'b0000000100000000: n5034 = poll_idx;
      16'b0000000010000000: n5034 = poll_idx;
      16'b0000000001000000: n5034 = poll_idx;
      16'b0000000000100000: n5034 = poll_idx;
      16'b0000000000010000: n5034 = poll_idx;
      16'b0000000000001000: n5034 = poll_idx;
      16'b0000000000000100: n5034 = poll_idx;
      16'b0000000000000010: n5034 = poll_idx;
      16'b0000000000000001: n5034 = poll_idx;
      default: n5034 = poll_idx;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5035 = polling;
      16'b0100000000000000: n5035 = polling;
      16'b0010000000000000: n5035 = polling;
      16'b0001000000000000: n5035 = n4930;
      16'b0000100000000000: n5035 = n4877;
      16'b0000010000000000: n5035 = polling;
      16'b0000001000000000: n5035 = polling;
      16'b0000000100000000: n5035 = polling;
      16'b0000000010000000: n5035 = polling;
      16'b0000000001000000: n5035 = polling;
      16'b0000000000100000: n5035 = polling;
      16'b0000000000010000: n5035 = polling;
      16'b0000000000001000: n5035 = polling;
      16'b0000000000000100: n5035 = polling;
      16'b0000000000000010: n5035 = polling;
      16'b0000000000000001: n5035 = polling;
      default: n5035 = polling;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5036 = pll_mask;
      16'b0100000000000000: n5036 = pll_mask;
      16'b0010000000000000: n5036 = pll_mask;
      16'b0001000000000000: n5036 = pll_mask;
      16'b0000100000000000: n5036 = n4878;
      16'b0000010000000000: n5036 = pll_mask;
      16'b0000001000000000: n5036 = pll_mask;
      16'b0000000100000000: n5036 = pll_mask;
      16'b0000000010000000: n5036 = pll_mask;
      16'b0000000001000000: n5036 = pll_mask;
      16'b0000000000100000: n5036 = pll_mask;
      16'b0000000000010000: n5036 = pll_mask;
      16'b0000000000001000: n5036 = pll_mask;
      16'b0000000000000100: n5036 = pll_mask;
      16'b0000000000000010: n5036 = pll_mask;
      16'b0000000000000001: n5036 = pll_mask;
      default: n5036 = pll_mask;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5037 = poll_reg;
      16'b0100000000000000: n5037 = poll_reg;
      16'b0010000000000000: n5037 = poll_reg;
      16'b0001000000000000: n5037 = poll_reg;
      16'b0000100000000000: n5037 = n4765;
      16'b0000010000000000: n5037 = poll_reg;
      16'b0000001000000000: n5037 = poll_reg;
      16'b0000000100000000: n5037 = poll_reg;
      16'b0000000010000000: n5037 = poll_reg;
      16'b0000000001000000: n5037 = poll_reg;
      16'b0000000000100000: n5037 = poll_reg;
      16'b0000000000010000: n5037 = poll_reg;
      16'b0000000000001000: n5037 = poll_reg;
      16'b0000000000000100: n5037 = poll_reg;
      16'b0000000000000010: n5037 = poll_reg;
      16'b0000000000000001: n5037 = poll_reg;
      default: n5037 = poll_reg;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5038 = clip_ever;
      16'b0100000000000000: n5038 = clip_ever;
      16'b0010000000000000: n5038 = clip_ever;
      16'b0001000000000000: n5038 = clip_ever;
      16'b0000100000000000: n5038 = n4752;
      16'b0000010000000000: n5038 = clip_ever;
      16'b0000001000000000: n5038 = clip_ever;
      16'b0000000100000000: n5038 = clip_ever;
      16'b0000000010000000: n5038 = clip_ever;
      16'b0000000001000000: n5038 = clip_ever;
      16'b0000000000100000: n5038 = clip_ever;
      16'b0000000000010000: n5038 = clip_ever;
      16'b0000000000001000: n5038 = clip_ever;
      16'b0000000000000100: n5038 = clip_ever;
      16'b0000000000000010: n5038 = clip_ever;
      16'b0000000000000001: n5038 = clip_ever;
      default: n5038 = clip_ever;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5039 = cfg_bad;
      16'b0100000000000000: n5039 = cfg_bad;
      16'b0010000000000000: n5039 = cfg_bad;
      16'b0001000000000000: n5039 = cfg_bad;
      16'b0000100000000000: n5039 = n4753;
      16'b0000010000000000: n5039 = cfg_bad;
      16'b0000001000000000: n5039 = cfg_bad;
      16'b0000000100000000: n5039 = cfg_bad;
      16'b0000000010000000: n5039 = cfg_bad;
      16'b0000000001000000: n5039 = cfg_bad;
      16'b0000000000100000: n5039 = cfg_bad;
      16'b0000000000010000: n5039 = cfg_bad;
      16'b0000000000001000: n5039 = cfg_bad;
      16'b0000000000000100: n5039 = cfg_bad;
      16'b0000000000000010: n5039 = cfg_bad;
      16'b0000000000000001: n5039 = cfg_bad;
      default: n5039 = cfg_bad;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5040 = pll_lost;
      16'b0100000000000000: n5040 = pll_lost;
      16'b0010000000000000: n5040 = pll_lost;
      16'b0001000000000000: n5040 = pll_lost;
      16'b0000100000000000: n5040 = n4754;
      16'b0000010000000000: n5040 = pll_lost;
      16'b0000001000000000: n5040 = pll_lost;
      16'b0000000100000000: n5040 = pll_lost;
      16'b0000000010000000: n5040 = pll_lost;
      16'b0000000001000000: n5040 = pll_lost;
      16'b0000000000100000: n5040 = pll_lost;
      16'b0000000000010000: n5040 = pll_lost;
      16'b0000000000001000: n5040 = pll_lost;
      16'b0000000000000100: n5040 = pll_lost;
      16'b0000000000000010: n5040 = pll_lost;
      16'b0000000000000001: n5040 = pll_lost;
      default: n5040 = pll_lost;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:533:13 */
  always @*
    case (n4982)
      16'b1000000000000000: n5042 = ot_ever;
      16'b0100000000000000: n5042 = ot_ever;
      16'b0010000000000000: n5042 = ot_ever;
      16'b0001000000000000: n5042 = ot_ever;
      16'b0000100000000000: n5042 = n4756;
      16'b0000010000000000: n5042 = ot_ever;
      16'b0000001000000000: n5042 = ot_ever;
      16'b0000000100000000: n5042 = ot_ever;
      16'b0000000010000000: n5042 = ot_ever;
      16'b0000000001000000: n5042 = ot_ever;
      16'b0000000000100000: n5042 = ot_ever;
      16'b0000000000010000: n5042 = ot_ever;
      16'b0000000000001000: n5042 = ot_ever;
      16'b0000000000000100: n5042 = ot_ever;
      16'b0000000000000010: n5042 = ot_ever;
      16'b0000000000000001: n5042 = ot_ever;
      default: n5042 = ot_ever;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5168 <= 1'b0;
    else
      n5168 <= n4984;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5169 <= 1'b0;
    else
      n5169 <= n4991;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5170 <= 7'b0000000;
    else
      n5170 <= n4993;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5171 <= 8'b00000000;
    else
      n5171 <= n4994;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5172 <= 8'b00000000;
    else
      n5172 <= n4995;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5173 <= 1'b0;
    else
      n5173 <= n4998;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5174 <= 1'b0;
    else
      n5174 <= n5000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5175 <= 1'b0;
    else
      n5175 <= n5001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5176 <= 1'b0;
    else
      n5176 <= n5002;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5177 <= 8'b00000000;
    else
      n5177 <= n5003;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5178 <= 8'b00000000;
    else
      n5178 <= n5004;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5179 <= 4'b0000;
    else
      n5179 <= n5011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5180 <= 23'b00000000000000000000000;
    else
      n5180 <= n5013;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5181 <= 2'b00;
    else
      n5181 <= n5015;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5182 <= 4'b0000;
    else
      n5182 <= n5017;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5183 <= 3'b000;
    else
      n5183 <= n5018;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:104:12 */
  assign n5184 = ~n4412;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  assign n5185 = n5184 ? n5019 : vfy_mask;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk)
    n5186 <= n5185;
  initial
    n5186 = 6'b000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5187 <= 1'b0;
    else
      n5187 <= n5020;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5188 <= 1'b0;
    else
      n5188 <= n5022;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5189 <= 7'b0000000;
    else
      n5189 <= n5023;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5190 <= 8'b00000000;
    else
      n5190 <= n5024;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5191 <= 1'b0;
    else
      n5191 <= n5026;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5192 <= 4'b0000;
    else
      n5192 <= n5027;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5193 <= 4'b0000;
    else
      n5193 <= n5028;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5194 <= 1'b0;
    else
      n5194 <= n5029;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5195 <= 1'b1;
    else
      n5195 <= n5030;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5196 <= 21'b000000000000000000000;
    else
      n5196 <= n5031;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5197 <= 1'b0;
    else
      n5197 <= n5032;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5198 <= 25'b0000000000000000000000000;
    else
      n5198 <= n5033;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5199 <= 2'b00;
    else
      n5199 <= n5034;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5200 <= 1'b0;
    else
      n5200 <= n5035;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5201 <= 4'b0000;
    else
      n5201 <= n5036;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5202 <= 3'b000;
    else
      n5202 <= n5037;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5203 <= 4'b0000;
    else
      n5203 <= n5038;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5204 <= 4'b0000;
    else
      n5204 <= n5039;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5205 <= 4'b0000;
    else
      n5205 <= n5040;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:527:9 */
  always @(posedge clk or posedge n4412)
    if (n4412)
      n5206 <= 4'b0000;
    else
      n5206 <= n5042;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:611:51 */
  reg [15:0] n5207[11:0] ; // memory
  initial begin
    n5207[11] = 16'b0000000000000001;
    n5207[10] = 16'b0000110110100000;
    n5207[9] = 16'b0000110010100000;
    n5207[8] = 16'b0000101110100000;
    n5207[7] = 16'b0000101010100000;
    n5207[6] = 16'b0000010000111111;
    n5207[5] = 16'b0000100111111000;
    n5207[4] = 16'b0000100000110010;
    n5207[3] = 16'b0000011100010000;
    n5207[2] = 16'b0000011000001000;
    n5207[1] = 16'b0000010101011011;
    n5207[0] = 16'b0000000100000011;
    end
  assign n5209 = n5207[reg_idx];
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:611:51 */
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:671:68 */
  reg [7:0] n5210[3:0] ; // memory
  initial begin
    n5210[3] = 8'b01010100;
    n5210[2] = 8'b00010000;
    n5210[1] = 8'b01010100;
    n5210[0] = 8'b00010000;
    end
  assign n5212 = n5210[adc_idx];
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:671:68 */
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:673:68 */
  reg [7:0] n5213[3:0] ; // memory
  initial begin
    n5213[3] = 8'b01110110;
    n5213[2] = 8'b00110010;
    n5213[1] = 8'b01110110;
    n5213[0] = 8'b00110010;
    end
  assign n5215 = n5213[adc_idx];
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:673:68 */
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:771:72 */
  assign n5216 = n4664[95:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:771:51 */
  assign n5218 = {40'bX, n5216};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:771:51 */
  assign n5219 = n5218[n4662 * 16 +: 16]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:771:72 */
  assign n5220 = n5219[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:773:70 */
  assign n5221 = n4670[95:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:773:50 */
  assign n5223 = {40'bX, n5221};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:773:50 */
  assign n5224 = n5223[n4668 * 16 +: 16]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:773:70 */
  assign n5225 = n5224[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5226 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5227 = ~n5226;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5228 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5229 = ~n5228;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5230 = n5227 & n5229;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5231 = n5227 & n5228;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5232 = n5226 & n5229;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5233 = n5226 & n5228;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5234 = pll_mask[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5235 = n5230 ? n4692 : n5234;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5236 = pll_mask[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5237 = n5231 ? n4692 : n5236;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5238 = pll_mask[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5239 = n5232 ? n4692 : n5238;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5240 = pll_mask[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5241 = n5233 ? n4692 : n5240;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:803:41 */
  assign n5242 = {n5241, n5239, n5237, n5235};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5243 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5244 = ~n5243;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5245 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5246 = ~n5245;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5247 = n5244 & n5246;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5248 = n5244 & n5245;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5249 = n5243 & n5246;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5250 = n5243 & n5245;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5251 = pll_lost[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5252 = n5247 ? 1'b1 : n5251;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5253 = pll_lost[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5254 = n5248 ? 1'b1 : n5253;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5255 = pll_lost[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5256 = n5249 ? 1'b1 : n5255;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5257 = pll_lost[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5258 = n5250 ? 1'b1 : n5257;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:805:45 */
  assign n5259 = {n5258, n5256, n5254, n5252};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5260 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5261 = ~n5260;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5262 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5263 = ~n5262;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5264 = n5261 & n5263;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5265 = n5261 & n5262;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5266 = n5260 & n5263;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5267 = n5260 & n5262;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5268 = ot_ever[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5269 = n5264 ? 1'b1 : n5268;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5270 = ot_ever[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5271 = n5265 ? 1'b1 : n5270;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5272 = ot_ever[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5273 = n5266 ? 1'b1 : n5272;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5274 = ot_ever[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5275 = n5267 ? 1'b1 : n5274;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:810:45 */
  assign n5276 = {n5275, n5273, n5271, n5269};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5277 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5278 = ~n5277;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5279 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5280 = ~n5279;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5281 = n5278 & n5280;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5282 = n5278 & n5279;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5283 = n5277 & n5280;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5284 = n5277 & n5279;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5285 = clip_ever[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5286 = n5281 ? 1'b1 : n5285;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5287 = clip_ever[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5288 = n5282 ? 1'b1 : n5287;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5289 = clip_ever[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5290 = n5283 ? 1'b1 : n5289;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5291 = clip_ever[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5292 = n5284 ? 1'b1 : n5291;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:814:45 */
  assign n5293 = {n5292, n5290, n5288, n5286};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:818:57 */
  assign n5295 = {32'bX, 96'b000000010000000000001001000000000001100100000000000000000000000100000101010110110000011000001000};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:818:57 */
  assign n5296 = n5295[n4728 * 16 +: 16]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:818:78 */
  assign n5297 = n5296[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5298 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5299 = ~n5298;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5300 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5301 = ~n5300;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5302 = n5299 & n5301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5303 = n5299 & n5300;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5304 = n5298 & n5301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5305 = n5298 & n5300;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5306 = cfg_bad[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5307 = n5302 ? 1'b1 : n5306;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5308 = cfg_bad[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5309 = n5303 ? 1'b1 : n5308;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5310 = cfg_bad[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5311 = n5304 ? 1'b1 : n5310;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5312 = cfg_bad[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5313 = n5305 ? 1'b1 : n5312;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:819:45 */
  assign n5314 = {n5313, n5311, n5309, n5307};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5315 = poll_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5316 = ~n5315;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5317 = poll_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5318 = ~n5317;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5319 = n5316 & n5318;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5320 = n5316 & n5317;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5321 = n5315 & n5318;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5322 = n5315 & n5317;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5323 = pll_mask[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5324 = n5319 ? 1'b0 : n5323;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5325 = pll_mask[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5326 = n5320 ? 1'b0 : n5325;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5327 = pll_mask[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5328 = n5321 ? 1'b0 : n5327;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5329 = pll_mask[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5330 = n5322 ? 1'b0 : n5329;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:823:33 */
  assign n5331 = {n5330, n5328, n5326, n5324};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:62 */
  assign n5333 = {32'bX, 96'b000000000000000100000001000000110000010000111111000001010101101100000110000010000000100111111000};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:62 */
  assign n5334 = n5333[n4789 * 16 +: 16]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:851:82 */
  assign n5335 = n5334[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5336 = vfy_idx[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5337 = ~n5336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5338 = vfy_idx[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5339 = ~n5338;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5340 = n5337 & n5339;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5341 = n5337 & n5338;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5342 = n5336 & n5339;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5343 = vfy_idx[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5344 = ~n5343;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5345 = n5340 & n5344;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5346 = n5340 & n5343;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5347 = n5341 & n5344;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5348 = n5341 & n5343;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5349 = n5342 & n5344;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5350 = n5342 & n5343;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5351 = vfy_mask[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5352 = n5345 ? 1'b1 : n5351;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5353 = vfy_mask[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5354 = n5346 ? 1'b1 : n5353;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5355 = vfy_mask[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5356 = n5347 ? 1'b1 : n5355;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5357 = vfy_mask[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5358 = n5348 ? 1'b1 : n5357;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5359 = vfy_mask[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5360 = n5349 ? 1'b1 : n5359;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5361 = vfy_mask[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5362 = n5350 ? 1'b1 : n5361;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/adau_sequencer.vhd:852:37 */
  assign n5363 = {n5362, n5360, n5358, n5356, n5354, n5352};
endmodule
