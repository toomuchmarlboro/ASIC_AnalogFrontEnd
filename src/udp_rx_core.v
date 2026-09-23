// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/udp_rx_core.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module udp_rx_core
  (input  clk_50m,
   input  rst,
   input  [47:0] fpga_mac,
   input  [31:0] fpga_ip,
   input  [7:0] rx_data,
   input  rx_valid,
   input  rx_end,
   input  rx_error,
   output udp_req,
   input  udp_ack,
   output [1:0] udp_adc_sel,
   output [1:0] udp_ch_sel,
   output [7:0] udp_gain,
   output [7:0] udp_flags,
   output udp_flags_wr);
  reg [1:0] state;
  reg [6:0] byte_cnt;
  reg is_valid_pkt;
  reg [1:0] int_adc_sel;
  reg [1:0] int_ch_sel;
  reg [7:0] int_gain;
  reg [7:0] int_flags;
  reg have_flags;
  wire [7:0] n5381;
  wire n5382;
  wire n5384;
  wire n5385;
  wire n5388;
  wire [1:0] n5390;
  wire [6:0] n5393;
  wire n5396;
  wire n5399;
  wire n5401;
  wire [31:0] n5402;
  wire n5404;
  wire [7:0] n5405;
  wire n5406;
  wire n5407;
  wire n5409;
  wire n5410;
  wire [31:0] n5411;
  wire n5413;
  wire [7:0] n5414;
  wire n5415;
  wire n5416;
  wire n5418;
  wire n5419;
  wire [31:0] n5420;
  wire n5422;
  wire [7:0] n5423;
  wire n5424;
  wire n5425;
  wire n5427;
  wire n5428;
  wire [31:0] n5429;
  wire n5431;
  wire [7:0] n5432;
  wire n5433;
  wire n5434;
  wire n5436;
  wire n5437;
  wire [31:0] n5438;
  wire n5440;
  wire [7:0] n5441;
  wire n5442;
  wire n5443;
  wire n5445;
  wire n5446;
  wire [31:0] n5447;
  wire n5449;
  wire n5451;
  wire n5452;
  wire [31:0] n5453;
  wire n5455;
  wire n5457;
  wire n5458;
  wire [31:0] n5459;
  wire n5461;
  wire n5463;
  wire n5464;
  wire [31:0] n5465;
  wire n5467;
  wire [7:0] n5468;
  wire n5469;
  wire n5470;
  wire [31:0] n5471;
  wire n5473;
  wire [7:0] n5474;
  wire n5475;
  wire n5476;
  wire [31:0] n5477;
  wire n5479;
  wire [7:0] n5480;
  wire n5481;
  wire n5482;
  wire [31:0] n5483;
  wire n5485;
  wire [7:0] n5486;
  wire n5487;
  wire n5488;
  wire [31:0] n5489;
  wire n5491;
  wire [1:0] n5492;
  wire [1:0] n5493;
  wire [31:0] n5494;
  wire n5496;
  wire [31:0] n5497;
  wire n5499;
  wire [7:0] n5500;
  wire n5502;
  wire [7:0] n5503;
  wire [7:0] n5504;
  wire n5505;
  wire [1:0] n5506;
  wire [1:0] n5507;
  wire [7:0] n5508;
  wire [7:0] n5509;
  wire n5510;
  wire n5512;
  wire [1:0] n5513;
  wire [1:0] n5514;
  wire [7:0] n5515;
  wire [7:0] n5516;
  wire n5517;
  wire n5519;
  wire [1:0] n5520;
  wire [1:0] n5521;
  wire [7:0] n5522;
  wire [7:0] n5523;
  wire n5524;
  wire n5526;
  wire [1:0] n5527;
  wire [1:0] n5528;
  wire [7:0] n5529;
  wire [7:0] n5530;
  wire n5531;
  wire n5533;
  wire [1:0] n5534;
  wire [1:0] n5535;
  wire [7:0] n5536;
  wire [7:0] n5537;
  wire n5538;
  wire n5540;
  wire [1:0] n5541;
  wire [1:0] n5542;
  wire [7:0] n5543;
  wire [7:0] n5544;
  wire n5545;
  wire n5547;
  wire [1:0] n5548;
  wire [1:0] n5549;
  wire [7:0] n5550;
  wire [7:0] n5551;
  wire n5552;
  wire n5554;
  wire [1:0] n5555;
  wire [1:0] n5556;
  wire [7:0] n5557;
  wire [7:0] n5558;
  wire n5559;
  wire n5561;
  wire [1:0] n5562;
  wire [1:0] n5563;
  wire [7:0] n5564;
  wire [7:0] n5565;
  wire n5566;
  wire n5568;
  wire [1:0] n5569;
  wire [1:0] n5570;
  wire [7:0] n5571;
  wire [7:0] n5572;
  wire n5573;
  wire n5575;
  wire [1:0] n5576;
  wire [1:0] n5577;
  wire [7:0] n5578;
  wire [7:0] n5579;
  wire n5580;
  wire n5582;
  wire [1:0] n5583;
  wire [1:0] n5584;
  wire [7:0] n5585;
  wire [7:0] n5586;
  wire n5587;
  wire n5589;
  wire [1:0] n5590;
  wire [1:0] n5591;
  wire [7:0] n5592;
  wire [7:0] n5593;
  wire n5594;
  wire [31:0] n5595;
  wire n5597;
  wire [31:0] n5598;
  wire [31:0] n5600;
  wire [6:0] n5601;
  wire [1:0] n5603;
  wire [6:0] n5604;
  wire n5605;
  wire [6:0] n5606;
  wire n5607;
  wire [1:0] n5608;
  wire [1:0] n5609;
  wire [7:0] n5610;
  wire [7:0] n5611;
  wire n5612;
  wire [1:0] n5614;
  wire [6:0] n5615;
  wire n5616;
  wire [1:0] n5617;
  wire [1:0] n5618;
  wire [7:0] n5619;
  wire [7:0] n5620;
  wire n5621;
  wire [1:0] n5623;
  wire n5625;
  wire n5626;
  wire n5627;
  wire [1:0] n5630;
  wire [1:0] n5631;
  wire n5633;
  wire [7:0] n5634;
  wire n5636;
  wire n5638;
  wire [3:0] n5639;
  reg n5642;
  reg [1:0] n5644;
  reg [1:0] n5646;
  reg [7:0] n5648;
  reg [7:0] n5650;
  reg n5653;
  reg [1:0] n5656;
  reg [6:0] n5658;
  reg n5660;
  reg [1:0] n5662;
  reg [1:0] n5664;
  reg [7:0] n5666;
  reg [7:0] n5668;
  reg n5671;
  wire n5673;
  wire [1:0] n5675;
  wire [1:0] n5677;
  wire [7:0] n5679;
  wire [7:0] n5681;
  wire n5683;
  wire [1:0] n5685;
  wire [6:0] n5687;
  wire n5689;
  wire [1:0] n5690;
  wire [1:0] n5691;
  wire [7:0] n5692;
  wire [7:0] n5693;
  wire n5695;
  reg n5711;
  reg [1:0] n5712;
  reg [1:0] n5713;
  reg [7:0] n5714;
  reg [7:0] n5715;
  reg n5716;
  reg [1:0] n5717;
  reg [6:0] n5718;
  reg n5719;
  reg [1:0] n5720;
  reg [1:0] n5721;
  reg [7:0] n5722;
  reg [7:0] n5723;
  reg n5724;
  assign udp_req = n5711; //(module output)
  assign udp_adc_sel = n5712; //(module output)
  assign udp_ch_sel = n5713; //(module output)
  assign udp_gain = n5714; //(module output)
  assign udp_flags = n5715; //(module output)
  assign udp_flags_wr = n5716; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:41:12 */
  always @*
    state = n5717; // (isignal)
  initial
    state = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:43:12 */
  always @*
    byte_cnt = n5718; // (isignal)
  initial
    byte_cnt = 7'b0000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:44:12 */
  always @*
    is_valid_pkt = n5719; // (isignal)
  initial
    is_valid_pkt = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:47:12 */
  always @*
    int_adc_sel = n5720; // (isignal)
  initial
    int_adc_sel = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:48:12 */
  always @*
    int_ch_sel = n5721; // (isignal)
  initial
    int_ch_sel = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:49:12 */
  always @*
    int_gain = n5722; // (isignal)
  initial
    int_gain = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:50:12 */
  always @*
    int_flags = n5723; // (isignal)
  initial
    int_flags = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:51:12 */
  always @*
    have_flags = n5724; // (isignal)
  initial
    have_flags = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:80:51 */
  assign n5381 = fpga_mac[47:40]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:80:40 */
  assign n5382 = rx_data != n5381;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:80:78 */
  assign n5384 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:80:66 */
  assign n5385 = n5384 & n5382;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:80:29 */
  assign n5388 = n5385 ? 1'b0 : 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:76:25 */
  assign n5390 = rx_valid ? 2'b01 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:76:25 */
  assign n5393 = rx_valid ? 7'b0000001 : 7'b0000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:76:25 */
  assign n5396 = rx_valid ? n5388 : 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:88:25 */
  assign n5399 = udp_ack ? 1'b0 : n5711;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:72:21 */
  assign n5401 = state == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:41 */
  assign n5402 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:41 */
  assign n5404 = n5402 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:68 */
  assign n5405 = fpga_mac[39:32]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:57 */
  assign n5406 = rx_data != n5405;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:45 */
  assign n5407 = n5406 & n5404;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:95 */
  assign n5409 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:83 */
  assign n5410 = n5409 & n5407;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:44 */
  assign n5411 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:44 */
  assign n5413 = n5411 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:71 */
  assign n5414 = fpga_mac[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:60 */
  assign n5415 = rx_data != n5414;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:48 */
  assign n5416 = n5415 & n5413;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:98 */
  assign n5418 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:86 */
  assign n5419 = n5418 & n5416;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:44 */
  assign n5420 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:44 */
  assign n5422 = n5420 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:71 */
  assign n5423 = fpga_mac[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:60 */
  assign n5424 = rx_data != n5423;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:48 */
  assign n5425 = n5424 & n5422;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:98 */
  assign n5427 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:86 */
  assign n5428 = n5427 & n5425;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:44 */
  assign n5429 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:44 */
  assign n5431 = n5429 == 32'b00000000000000000000000000000100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:71 */
  assign n5432 = fpga_mac[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:60 */
  assign n5433 = rx_data != n5432;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:48 */
  assign n5434 = n5433 & n5431;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:98 */
  assign n5436 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:86 */
  assign n5437 = n5436 & n5434;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:44 */
  assign n5438 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:44 */
  assign n5440 = n5438 == 32'b00000000000000000000000000000101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:71 */
  assign n5441 = fpga_mac[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:60 */
  assign n5442 = rx_data != n5441;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:48 */
  assign n5443 = n5442 & n5440;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:98 */
  assign n5445 = rx_data != 8'b11111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:86 */
  assign n5446 = n5445 & n5443;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:44 */
  assign n5447 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:44 */
  assign n5449 = n5447 == 32'b00000000000000000000000000001100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:61 */
  assign n5451 = rx_data != 8'b00001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:49 */
  assign n5452 = n5451 & n5449;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:44 */
  assign n5453 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:44 */
  assign n5455 = n5453 == 32'b00000000000000000000000000001101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:61 */
  assign n5457 = rx_data != 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:49 */
  assign n5458 = n5457 & n5455;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:44 */
  assign n5459 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:44 */
  assign n5461 = n5459 == 32'b00000000000000000000000000010111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:61 */
  assign n5463 = rx_data != 8'b00010001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:49 */
  assign n5464 = n5463 & n5461;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:44 */
  assign n5465 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:44 */
  assign n5467 = n5465 == 32'b00000000000000000000000000011110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:71 */
  assign n5468 = fpga_ip[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:61 */
  assign n5469 = rx_data != n5468;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:49 */
  assign n5470 = n5469 & n5467;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:44 */
  assign n5471 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:44 */
  assign n5473 = n5471 == 32'b00000000000000000000000000011111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:71 */
  assign n5474 = fpga_ip[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:61 */
  assign n5475 = rx_data != n5474;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:49 */
  assign n5476 = n5475 & n5473;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:44 */
  assign n5477 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:44 */
  assign n5479 = n5477 == 32'b00000000000000000000000000100000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:71 */
  assign n5480 = fpga_ip[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:61 */
  assign n5481 = rx_data != n5480;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:49 */
  assign n5482 = n5481 & n5479;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:44 */
  assign n5483 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:44 */
  assign n5485 = n5483 == 32'b00000000000000000000000000100001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:71 */
  assign n5486 = fpga_ip[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:61 */
  assign n5487 = rx_data != n5486;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:49 */
  assign n5488 = n5487 & n5485;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:44 */
  assign n5489 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:44 */
  assign n5491 = n5489 == 32'b00000000000000000000000000101010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:120:55 */
  assign n5492 = rx_data[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:121:55 */
  assign n5493 = rx_data[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:123:44 */
  assign n5494 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:123:44 */
  assign n5496 = n5494 == 32'b00000000000000000000000000101011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:126:44 */
  assign n5497 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:126:44 */
  assign n5499 = n5497 == 32'b00000000000000000000000000101100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:126:29 */
  assign n5500 = n5499 ? rx_data : int_flags;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:126:29 */
  assign n5502 = n5499 ? 1'b1 : have_flags;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:123:29 */
  assign n5503 = n5496 ? rx_data : int_gain;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:123:29 */
  assign n5504 = n5496 ? int_flags : n5500;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:123:29 */
  assign n5505 = n5496 ? have_flags : n5502;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:29 */
  assign n5506 = n5491 ? n5492 : int_adc_sel;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:29 */
  assign n5507 = n5491 ? n5493 : int_ch_sel;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:29 */
  assign n5508 = n5491 ? int_gain : n5503;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:29 */
  assign n5509 = n5491 ? int_flags : n5504;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:119:29 */
  assign n5510 = n5491 ? have_flags : n5505;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5512 = n5488 ? 1'b0 : is_valid_pkt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5513 = n5488 ? int_adc_sel : n5506;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5514 = n5488 ? int_ch_sel : n5507;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5515 = n5488 ? int_gain : n5508;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5516 = n5488 ? int_flags : n5509;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:115:29 */
  assign n5517 = n5488 ? have_flags : n5510;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5519 = n5482 ? 1'b0 : n5512;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5520 = n5482 ? int_adc_sel : n5513;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5521 = n5482 ? int_ch_sel : n5514;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5522 = n5482 ? int_gain : n5515;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5523 = n5482 ? int_flags : n5516;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:114:29 */
  assign n5524 = n5482 ? have_flags : n5517;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5526 = n5476 ? 1'b0 : n5519;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5527 = n5476 ? int_adc_sel : n5520;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5528 = n5476 ? int_ch_sel : n5521;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5529 = n5476 ? int_gain : n5522;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5530 = n5476 ? int_flags : n5523;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:113:29 */
  assign n5531 = n5476 ? have_flags : n5524;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5533 = n5470 ? 1'b0 : n5526;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5534 = n5470 ? int_adc_sel : n5527;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5535 = n5470 ? int_ch_sel : n5528;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5536 = n5470 ? int_gain : n5529;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5537 = n5470 ? int_flags : n5530;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:112:29 */
  assign n5538 = n5470 ? have_flags : n5531;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5540 = n5464 ? 1'b0 : n5533;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5541 = n5464 ? int_adc_sel : n5534;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5542 = n5464 ? int_ch_sel : n5535;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5543 = n5464 ? int_gain : n5536;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5544 = n5464 ? int_flags : n5537;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:109:29 */
  assign n5545 = n5464 ? have_flags : n5538;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5547 = n5458 ? 1'b0 : n5540;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5548 = n5458 ? int_adc_sel : n5541;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5549 = n5458 ? int_ch_sel : n5542;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5550 = n5458 ? int_gain : n5543;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5551 = n5458 ? int_flags : n5544;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:106:29 */
  assign n5552 = n5458 ? have_flags : n5545;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5554 = n5452 ? 1'b0 : n5547;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5555 = n5452 ? int_adc_sel : n5548;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5556 = n5452 ? int_ch_sel : n5549;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5557 = n5452 ? int_gain : n5550;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5558 = n5452 ? int_flags : n5551;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:105:29 */
  assign n5559 = n5452 ? have_flags : n5552;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5561 = n5446 ? 1'b0 : n5554;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5562 = n5446 ? int_adc_sel : n5555;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5563 = n5446 ? int_ch_sel : n5556;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5564 = n5446 ? int_gain : n5557;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5565 = n5446 ? int_flags : n5558;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:102:29 */
  assign n5566 = n5446 ? have_flags : n5559;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5568 = n5437 ? 1'b0 : n5561;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5569 = n5437 ? int_adc_sel : n5562;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5570 = n5437 ? int_ch_sel : n5563;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5571 = n5437 ? int_gain : n5564;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5572 = n5437 ? int_flags : n5565;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:101:29 */
  assign n5573 = n5437 ? have_flags : n5566;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5575 = n5428 ? 1'b0 : n5568;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5576 = n5428 ? int_adc_sel : n5569;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5577 = n5428 ? int_ch_sel : n5570;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5578 = n5428 ? int_gain : n5571;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5579 = n5428 ? int_flags : n5572;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:100:29 */
  assign n5580 = n5428 ? have_flags : n5573;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5582 = n5419 ? 1'b0 : n5575;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5583 = n5419 ? int_adc_sel : n5576;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5584 = n5419 ? int_ch_sel : n5577;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5585 = n5419 ? int_gain : n5578;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5586 = n5419 ? int_flags : n5579;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:99:29 */
  assign n5587 = n5419 ? have_flags : n5580;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5589 = n5410 ? 1'b0 : n5582;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5590 = n5410 ? int_adc_sel : n5583;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5591 = n5410 ? int_ch_sel : n5584;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5592 = n5410 ? int_gain : n5585;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5593 = n5410 ? int_flags : n5586;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:98:29 */
  assign n5594 = n5410 ? have_flags : n5587;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:136:41 */
  assign n5595 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:136:41 */
  assign n5597 = n5595 == 32'b00000000000000000000000000101100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:139:54 */
  assign n5598 = {25'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:139:54 */
  assign n5600 = n5598 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:139:45 */
  assign n5601 = n5600[6:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5603 = n5605 ? 2'b10 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:136:29 */
  assign n5604 = n5597 ? byte_cnt : n5601;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5605 = n5597 & rx_valid;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5606 = rx_valid ? n5604 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5607 = rx_valid ? n5589 : is_valid_pkt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5608 = rx_valid ? n5590 : int_adc_sel;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5609 = rx_valid ? n5591 : int_ch_sel;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5610 = rx_valid ? n5592 : int_gain;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5611 = rx_valid ? n5593 : int_flags;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:95:25 */
  assign n5612 = rx_valid ? n5594 : have_flags;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5614 = rx_end ? 2'b00 : n5603;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5615 = rx_end ? byte_cnt : n5606;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5616 = rx_end ? is_valid_pkt : n5607;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5617 = rx_end ? int_adc_sel : n5608;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5618 = rx_end ? int_ch_sel : n5609;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5619 = rx_end ? int_gain : n5610;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5620 = rx_end ? int_flags : n5611;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:93:25 */
  assign n5621 = rx_end ? have_flags : n5612;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:144:25 */
  assign n5623 = rx_end ? 2'b10 : n5614;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:92:21 */
  assign n5625 = state == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:151:64 */
  assign n5626 = ~rx_error;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:151:51 */
  assign n5627 = n5626 & is_valid_pkt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:151:29 */
  assign n5630 = n5627 ? 2'b11 : 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:150:25 */
  assign n5631 = rx_end ? n5630 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:148:21 */
  assign n5633 = state == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:163:25 */
  assign n5634 = have_flags ? int_flags : n5715;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:163:25 */
  assign n5636 = have_flags ? 1'b1 : n5716;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:158:21 */
  assign n5638 = state == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  assign n5639 = {n5638, n5633, n5625, n5401};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5642 = 1'b1;
      4'b0100: n5642 = n5711;
      4'b0010: n5642 = n5711;
      4'b0001: n5642 = n5399;
      default: n5642 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5644 = int_adc_sel;
      4'b0100: n5644 = n5712;
      4'b0010: n5644 = n5712;
      4'b0001: n5644 = n5712;
      default: n5644 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5646 = int_ch_sel;
      4'b0100: n5646 = n5713;
      4'b0010: n5646 = n5713;
      4'b0001: n5646 = n5713;
      default: n5646 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5648 = int_gain;
      4'b0100: n5648 = n5714;
      4'b0010: n5648 = n5714;
      4'b0001: n5648 = n5714;
      default: n5648 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5650 = n5634;
      4'b0100: n5650 = n5715;
      4'b0010: n5650 = n5715;
      4'b0001: n5650 = n5715;
      default: n5650 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5653 = n5636;
      4'b0100: n5653 = n5716;
      4'b0010: n5653 = n5716;
      4'b0001: n5653 = 1'b0;
      default: n5653 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5656 = 2'b00;
      4'b0100: n5656 = n5631;
      4'b0010: n5656 = n5623;
      4'b0001: n5656 = n5390;
      default: n5656 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5658 = byte_cnt;
      4'b0100: n5658 = byte_cnt;
      4'b0010: n5658 = n5615;
      4'b0001: n5658 = n5393;
      default: n5658 = 7'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5660 = is_valid_pkt;
      4'b0100: n5660 = is_valid_pkt;
      4'b0010: n5660 = n5616;
      4'b0001: n5660 = n5396;
      default: n5660 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5662 = int_adc_sel;
      4'b0100: n5662 = int_adc_sel;
      4'b0010: n5662 = n5617;
      4'b0001: n5662 = int_adc_sel;
      default: n5662 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5664 = int_ch_sel;
      4'b0100: n5664 = int_ch_sel;
      4'b0010: n5664 = n5618;
      4'b0001: n5664 = int_ch_sel;
      default: n5664 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5666 = int_gain;
      4'b0100: n5666 = int_gain;
      4'b0010: n5666 = n5619;
      4'b0001: n5666 = int_gain;
      default: n5666 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5668 = int_flags;
      4'b0100: n5668 = int_flags;
      4'b0010: n5668 = n5620;
      4'b0001: n5668 = int_flags;
      default: n5668 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:70:17 */
  always @*
    case (n5639)
      4'b1000: n5671 = 1'b0;
      4'b0100: n5671 = have_flags;
      4'b0010: n5671 = n5621;
      4'b0001: n5671 = have_flags;
      default: n5671 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5673 = rst ? 1'b0 : n5642;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5675 = rst ? 2'b00 : n5644;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5677 = rst ? 2'b00 : n5646;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5679 = rst ? 8'b10100000 : n5648;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5681 = rst ? 8'b00000000 : n5650;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5683 = rst ? 1'b0 : n5653;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5685 = rst ? 2'b00 : n5656;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5687 = rst ? 7'b0000000 : n5658;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5689 = rst ? 1'b0 : n5660;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5690 = rst ? int_adc_sel : n5662;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5691 = rst ? int_ch_sel : n5664;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5692 = rst ? int_gain : n5666;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5693 = rst ? int_flags : n5668;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:58:13 */
  assign n5695 = rst ? 1'b0 : n5671;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5711 <= n5673;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5712 <= n5675;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5713 <= n5677;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5714 <= n5679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5715 <= n5681;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5716 <= n5683;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5717 <= n5685;
  initial
    n5717 = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5718 <= n5687;
  initial
    n5718 = 7'b0000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5719 <= n5689;
  initial
    n5719 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5720 <= n5690;
  initial
    n5720 = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5721 <= n5691;
  initial
    n5721 = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5722 <= n5692;
  initial
    n5722 = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5723 <= n5693;
  initial
    n5723 = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_rx_core.vhd:57:9 */
  always @(posedge clk_50m)
    n5724 <= n5695;
  initial
    n5724 = 1'b0;
endmodule
