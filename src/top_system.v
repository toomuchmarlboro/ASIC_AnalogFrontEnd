// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/top_system.vhd with patches/0001..0003 applied,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module top_system
  (input  clk_24m576,
   input  rst_n,
   input  clk_50m_board,
   output adc_rst_n,
   output test_led,
   output debug_led_rx,
   output debug_led_tx,
   output en_15v,
   output en_48v,
   input  i2c_scl_i,
   output i2c_scl_o,
   output i2c_scl_oe,
   input  i2c_sda_i,
   output i2c_sda_o,
   output i2c_sda_oe,
   output bclk_out,
   output lrclk_out,
   input  sdata_in_A,
   input  sdata_in_B,
   output phy_rst_n,
   input  rmii_ref_clk,
   output rmii_tx_en,
   output [1:0] rmii_txd,
   input  rmii_crs_dv,
   input  [1:0] rmii_rxd,
   output eth_mdc,
   input  eth_mdio_i,
   output eth_mdio_o,
   output eth_mdio_oe,
   output buffer_state);
  wire clk_18m;
  wire pll_locked;
  wire sys_rst;
  wire sys_rst_n;
  reg [25:0] clk_div;
  reg [21:0] phy_rst_cnt;
  reg phy_rst_n_int;
  reg [26:0] adc_rst_cnt;
  reg adc_rst_n_int;
  reg [26:0] pwr_cnt;
  reg en_15v_int;
  reg en_48v_int;
  reg [7:0] udp_flags_int;
  reg en_48v_drv;
  wire en48_permit;
  wire ph_wd_gate;
  reg [1:0] active_tx;
  wire lrclk_int;
  wire [191:0] ch_data_a_int;
  wire [191:0] ch_data_b_int;
  wire [383:0] tdm16_out_int;
  wire tdm16_val_int;
  wire [383:0] decim_data;
  wire decim_valid;
  wire [383:0] fmt_data;
  wire fmt_valid;
  wire packet_ready_int;
  wire fifo_wr_en_int;
  wire [7:0] fifo_wr_data_int;
  wire fifo_rd_en_int;
  wire [7:0] fifo_rd_data_int;
  (* keep=1'b1 *) wire [7:0] rx_data_int;
  (* keep=1'b1 *) wire rx_valid_int;
  wire rx_end_int;
  (* keep=1'b1 *) wire rx_error_int;
  wire udp_tx_start_int;
  wire [7:0] udp_tx_data_int;
  wire udp_tx_ready_int;
  wire arp_tx_req_int;
  wire [7:0] arp_tx_data_int;
  wire arp_tx_ready_int;
  wire tx_start_int;
  wire [7:0] tx_data_int;
  wire tx_ready_int;
  wire tx_busy_int;
  wire i2c_ena_int;
  wire [6:0] i2c_addr_int;
  wire [7:0] i2c_reg_addr_int;
  wire [7:0] i2c_data_wr_int;
  wire i2c_busy_int;
  wire i2c_ack_err_int;
  wire i2c_stuck_int;
  wire i2c_scl_stuck;
  wire i2c_sda_stuck;
  wire i2c_rd_mode_int;
  wire m_scl_o;
  wire m_sda_o;
  wire m_scl_i;
  wire m_sda_i;
  wire i2c_scl_drv_ok;
  wire i2c_sda_drv_ok;
  wire i2c_st_done;
  wire i2c_recovered;
  wire [7:0] dbg_status2_int;
  reg [7:0] dbgt_meta;
  reg [7:0] dbgt_sync;
  reg [7:0] dbgu_meta;
  reg [7:0] dbgu_sync;
  reg [7:0] dbgv_meta;
  reg [7:0] dbgv_sync;
  wire i2c_probe_int;
  wire i2c_addr_nack_int;
  wire [7:0] dbg_scan_cnt_int;
  wire [7:0] dbg_scan_addr_int;
  wire [7:0] dbg_scan_mask_int;
  wire [7:0] dbg_vfy_mask_int;
  reg [7:0] dbgx_meta;
  reg [7:0] dbgx_sync;
  reg [7:0] dbgw_meta;
  reg [7:0] dbgw_sync;
  reg sd_a_f;
  reg sd_b_f;
  reg sd_a_d;
  reg sd_b_d;
  reg [7:0] act_a;
  reg [7:0] act_b;
  reg [7:0] act_a_l;
  reg [7:0] act_b_l;
  reg [7:0] slot_cnt;
  reg lr_d;
  reg pll_lock_s1;
  reg pll_lock_s2;
  reg pll_lock_d;
  reg [7:0] pll_drop;
  reg pll_ever_lost;
  reg rst_ever;
  reg rst_meta;
  reg rst_sync;
  reg pll_lost_meta;
  reg pll_lost_sync;
  reg [7:0] dbgy_meta;
  reg [7:0] dbgy_sync;
  reg [7:0] dbgz_meta;
  reg [7:0] dbgz_sync;
  reg rst_n_d;
  reg rst_seen;
  reg [7:0] rst_drop;
  wire [7:0] dbg_ot_int;
  wire [7:0] dbg_health_int;
  reg [15:0] act_win;
  wire [7:0] i2c_data_rd_int;
  wire adc_pll_lock_int;
  wire adc_cfg_ok_int;
  reg [7:0] dbgs_meta;
  reg [7:0] dbgs_sync;
  wire boot_done_int;
  wire [7:0] dbg_status_int;
  wire i2c_fault_int;
  reg udp_rx_req_int;
  wire udp_rx_ack_int;
  reg [1:0] udp_adc_sel_int;
  reg [1:0] udp_ch_sel_int;
  reg [7:0] udp_gain_int;
  reg [47:0] pc_mac_r;
  wire [47:0] arp_learn_mac;
  wire arp_learn_val;
  wire sdata_b_sel;
  reg lrclk_test;
  reg [25:0] lrclk_div;
  localparam n86 = 1'b0;
  localparam n87 = 1'b0;
  localparam n88 = 1'b0;
  wire n90;
  wire n91;
  wire [25:0] n96;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n134;
  wire n137;
  localparam n139 = 1'b0;
  wire n141;
  wire n143;
  wire n145;
  wire n146;
  localparam n148 = 1'b0;
  wire n150;
  wire n152;
  wire n154;
  wire n155;
  wire n158;
  wire n159;
  wire n169;
  wire n170;
  wire [7:0] n172;
  wire [7:0] n174;
  wire n176;
  wire [15:0] n178;
  wire n179;
  wire [2:0] n180;
  wire [7:0] n185;
  wire n186;
  wire [2:0] n187;
  wire [7:0] n192;
  wire [7:0] n194;
  wire [7:0] n196;
  wire [15:0] n200;
  wire [1:0] n212;
  wire n213;
  wire [2:0] n214;
  wire [3:0] n215;
  wire [4:0] n216;
  wire [5:0] n217;
  wire [6:0] n218;
  wire [7:0] n219;
  wire [1:0] n221;
  wire [2:0] n222;
  wire [3:0] n223;
  wire [4:0] n224;
  wire [5:0] n225;
  wire [6:0] n226;
  wire [7:0] n227;
  wire n228;
  wire n229;
  wire n233;
  wire n235;
  wire [21:0] n237;
  wire [21:0] n238;
  wire n241;
  wire [21:0] n243;
  wire n245;
  wire n252;
  wire n254;
  wire [26:0] n256;
  wire [26:0] n257;
  wire n260;
  wire [26:0] n262;
  wire n264;
  wire n271;
  wire n272;
  wire n274;
  wire n275;
  wire [7:0] n277;
  wire n281;
  wire n283;
  wire n284;
  wire [7:0] n286;
  wire n288;
  wire [7:0] n289;
  wire n290;
  wire [7:0] n293;
  wire n307;
  wire n309;
  wire [26:0] n311;
  wire [26:0] n312;
  wire n314;
  wire n316;
  wire n318;
  wire n320;
  wire [26:0] n322;
  wire n324;
  wire n326;
  wire n333;
  wire n366;
  wire n368;
  wire n369;
  wire n370;
  wire n371;
  wire n373;
  wire [25:0] n378;
  wire n381;
  wire n383;
  wire n388;
  wire n389;
  wire [1:0] n391;
  wire [1:0] n393;
  wire [1:0] n394;
  wire n396;
  wire n397;
  wire n398;
  wire n400;
  wire n401;
  wire n402;
  wire [1:0] n404;
  wire [1:0] n406;
  wire [1:0] n407;
  wire [1:0] n409;
  wire n413;
  wire n414;
  wire n416;
  wire n417;
  wire n420;
  wire [7:0] n421;
  wire n423;
  wire [7:0] n424;
  wire n427;
  wire n428;
  wire n431;
  wire n432;
  wire u_master_n435;
  wire \u_master.bclk_out ;
  wire n440;
  wire [191:0] u_rx_a_n441;
  wire [191:0] u_rx_b_n444;
  wire [383:0] u_merge_n447;
  wire u_merge_n448;
  wire [383:0] u_decim_n453;
  wire u_decim_n454;
  wire \u_decim.saturated ;
  wire [383:0] n463;
  wire n464;
  wire u_fmt_n465;
  wire [7:0] u_fmt_n466;
  wire u_fmt_n467;
  wire \u_fifo.rdempty ;
  wire \u_fifo.wrfull ;
  wire [7:0] u_rmii_rx_n475;
  wire u_rmii_rx_n476;
  wire u_rmii_rx_n477;
  wire u_rmii_rx_n478;
  localparam [47:0] n487 = 48'b110111101010110110111110111011110000000000000001;
  localparam [31:0] n488 = 32'b11000000101010000000001101100101;
  localparam [31:0] n489 = 32'b11000000101010000000001100001010;
  localparam [15:0] n490 = 16'b0001001110001101;
  wire u_udp_n491;
  wire u_udp_n492;
  wire [7:0] u_udp_n493;
  wire [47:0] n508;
  wire [47:0] n510;
  wire [47:0] u_arp_n513;
  wire u_arp_n514;
  wire u_arp_n515;
  wire [7:0] u_arp_n516;
  wire u_rmii_n525;
  wire u_rmii_n526;
  wire u_rmii_n527;
  wire [1:0] u_rmii_n528;
  wire [7:0] u_i2c_master_n537;
  wire u_i2c_master_n538;
  wire u_i2c_master_n539;
  wire u_i2c_master_n540;
  wire u_i2c_master_n541;
  wire u_i2c_master_n542;
  wire u_i2c_master_n543;
  wire u_i2c_master_n544;
  wire u_i2c_master_n545;
  wire u_i2c_master_n546;
  wire u_i2c_master_n547;
  wire u_i2c_master_n548;
  wire u_i2c_master_n549;
  wire u_adau_sequencer_n576;
  wire u_adau_sequencer_n577;
  wire u_adau_sequencer_n578;
  wire [6:0] u_adau_sequencer_n579;
  wire [7:0] u_adau_sequencer_n580;
  wire [7:0] u_adau_sequencer_n581;
  wire u_adau_sequencer_n582;
  wire u_adau_sequencer_n583;
  wire u_adau_sequencer_n584;
  wire u_adau_sequencer_n585;
  wire u_adau_sequencer_n586;
  wire [7:0] u_adau_sequencer_n589;
  wire [7:0] u_adau_sequencer_n590;
  wire [7:0] u_adau_sequencer_n591;
  wire [7:0] u_adau_sequencer_n592;
  wire [7:0] u_adau_sequencer_n593;
  wire [7:0] u_adau_sequencer_n594;
  wire [7:0] \u_adau_sequencer.dbg_rd_pll ;
  wire [7:0] \u_adau_sequencer.dbg_rd_sai ;
  wire n636;
  wire [1:0] n637;
  wire [2:0] n638;
  wire [4:0] n639;
  wire [7:0] n640;
  wire n641;
  wire [1:0] n642;
  wire [5:0] n643;
  wire [7:0] n644;
  wire u_udp_rx_n670;
  wire [1:0] u_udp_rx_n671;
  wire [1:0] u_udp_rx_n672;
  wire [7:0] u_udp_rx_n673;
  wire [7:0] u_udp_rx_n674;
  wire \u_udp_rx.udp_flags_wr ;
  reg [25:0] n688;
  reg [21:0] n689;
  reg n690;
  reg [26:0] n691;
  reg n692;
  reg [26:0] n693;
  reg n694;
  reg n695;
  reg [1:0] n696;
  reg [7:0] n697;
  reg [7:0] n698;
  reg [7:0] n699;
  reg [7:0] n700;
  reg [7:0] n701;
  reg [7:0] n702;
  reg [7:0] n703;
  reg [7:0] n704;
  reg [7:0] n705;
  reg [7:0] n706;
  reg n707;
  reg n708;
  reg n709;
  reg n710;
  reg [7:0] n711;
  reg [7:0] n712;
  wire [7:0] n713;
  reg [7:0] n714;
  wire [7:0] n715;
  reg [7:0] n716;
  reg [7:0] n717;
  reg n718;
  reg n719;
  reg n720;
  reg n721;
  wire [7:0] n722;
  reg [7:0] n723;
  wire n724;
  reg n725;
  reg n726;
  reg n727;
  reg n728;
  reg n729;
  reg n730;
  reg [7:0] n731;
  reg [7:0] n732;
  reg [7:0] n733;
  reg [7:0] n734;
  reg n735;
  wire n736;
  reg n737;
  reg [7:0] n738;
  reg [15:0] n739;
  reg [7:0] n740;
  reg [7:0] n741;
  reg [47:0] n742;
  reg [25:0] n743;
  wire n744;
  wire n745;
  wire n746;
  wire n747;
  wire n748;
  wire n749;
  wire n750;
  wire n751;
  wire n752;
  wire n753;
  wire n754;
  wire n755;
  wire n756;
  wire n757;
  wire n758;
  wire n759;
  wire n760;
  wire n761;
  wire n762;
  wire n763;
  wire n764;
  wire n765;
  wire n766;
  wire n767;
  wire n768;
  wire n769;
  wire n770;
  wire n771;
  wire n772;
  wire n773;
  wire n774;
  wire n775;
  wire n776;
  wire n777;
  wire [7:0] n778;
  wire n779;
  wire n780;
  wire n781;
  wire n782;
  wire n783;
  wire n784;
  wire n785;
  wire n786;
  wire n787;
  wire n788;
  wire n789;
  wire n790;
  wire n791;
  wire n792;
  wire n793;
  wire n794;
  wire n795;
  wire n796;
  wire n797;
  wire n798;
  wire n799;
  wire n800;
  wire n801;
  wire n802;
  wire n803;
  wire n804;
  wire n805;
  wire n806;
  wire n807;
  wire n808;
  wire n809;
  wire n810;
  wire n811;
  wire n812;
  wire [7:0] n813;
  assign adc_rst_n = adc_rst_n_int; //(module output)
  assign test_led = n100; //(module output)
  assign debug_led_rx = n134; //(module output)
  assign debug_led_tx = n137; //(module output)
  assign en_15v = en_15v_int; //(module output)
  assign en_48v = en_48v_drv; //(module output)
  assign i2c_scl_o = n139; //(module output)
  assign i2c_scl_oe = n146; //(module output)
  assign i2c_sda_o = n148; //(module output)
  assign i2c_sda_oe = n155; //(module output)
  assign bclk_out = n373; //(module output)
  assign lrclk_out = n383; //(module output)
  assign phy_rst_n = phy_rst_n_int; //(module output)
  assign rmii_tx_en = u_rmii_n527; //(module output)
  assign rmii_txd = u_rmii_n528; //(module output)
  assign eth_mdc = n86; //(module output)
  assign eth_mdio_o = n87; //(module output)
  assign eth_mdio_oe = n88; //(module output)
  assign buffer_state = n90; //(module output)
  /*# top_asic.vhd:356:12 */
  assign clk_18m = clk_24m576; // (signal)
  /*# top_asic.vhd:357:12 */
  assign pll_locked = rst_n; // (signal)
  /*# top_asic.vhd:358:12 */
  assign sys_rst = n228; // (signal)
  /*# top_asic.vhd:359:12 */
  assign sys_rst_n = n229; // (signal)
  /*# top_asic.vhd:362:12 */
  always @*
    clk_div = n688; // (isignal)
  initial
    clk_div = 26'b00000000000000000000000000;
  /*# top_asic.vhd:367:12 */
  always @*
    phy_rst_cnt = n689; // (isignal)
  initial
    phy_rst_cnt = 22'b0000000000000000000000;
  /*# top_asic.vhd:368:12 */
  always @*
    phy_rst_n_int = n690; // (isignal)
  initial
    phy_rst_n_int = 1'b0;
  /*# top_asic.vhd:371:12 */
  always @*
    adc_rst_cnt = n691; // (isignal)
  initial
    adc_rst_cnt = 27'b000000000000000000000000000;
  /*# top_asic.vhd:372:12 */
  always @*
    adc_rst_n_int = n692; // (isignal)
  initial
    adc_rst_n_int = 1'b0;
  /*# top_asic.vhd:375:12 */
  always @*
    pwr_cnt = n693; // (isignal)
  initial
    pwr_cnt = 27'b000000000000000000000000000;
  /*# top_asic.vhd:376:12 */
  always @*
    en_15v_int = n694; // (isignal)
  initial
    en_15v_int = 1'b0;
  /*# top_asic.vhd:377:12 */
  always @*
    en_48v_int = n695; // (isignal)
  initial
    en_48v_int = 1'b0;
  /*# top_asic.vhd:378:12 */
  always @*
    udp_flags_int = u_udp_rx_n674; // (isignal)
  initial
    udp_flags_int = 8'b00000000;
  /*# top_asic.vhd:382:12 */
  always @*
    en_48v_drv = n371; // (isignal)
  initial
    en_48v_drv = 1'b0;
  /*# top_asic.vhd:383:12 */
  assign en48_permit = n333; // (signal)
  /*# top_asic.vhd:390:12 */
  assign ph_wd_gate = n366; // (signal)
  /*# top_asic.vhd:393:12 */
  always @*
    active_tx = n696; // (isignal)
  initial
    active_tx = 2'b00;
  /*# top_asic.vhd:429:12 */
  assign lrclk_int = u_master_n435; // (signal)
  /*# top_asic.vhd:430:12 */
  assign ch_data_a_int = u_rx_a_n441; // (signal)
  /*# top_asic.vhd:431:12 */
  assign ch_data_b_int = u_rx_b_n444; // (signal)
  /*# top_asic.vhd:432:12 */
  assign tdm16_out_int = u_merge_n447; // (signal)
  /*# top_asic.vhd:433:12 */
  assign tdm16_val_int = u_merge_n448; // (signal)
  /*# top_asic.vhd:436:12 */
  assign decim_data = u_decim_n453; // (signal)
  /*# top_asic.vhd:437:12 */
  assign decim_valid = u_decim_n454; // (signal)
  /*# top_asic.vhd:453:12 */
  assign fmt_data = n463; // (signal)
  /*# top_asic.vhd:454:12 */
  assign fmt_valid = n464; // (signal)
  /*# top_asic.vhd:457:12 */
  assign packet_ready_int = u_fmt_n467; // (signal)
  /*# top_asic.vhd:458:12 */
  assign fifo_wr_en_int = u_fmt_n465; // (signal)
  /*# top_asic.vhd:459:12 */
  assign fifo_wr_data_int = u_fmt_n466; // (signal)
  /*# top_asic.vhd:460:12 */
  assign fifo_rd_en_int = u_udp_n491; // (signal)
  /*# top_asic.vhd:464:12 */
  assign rx_data_int = u_rmii_rx_n475; // (signal)
  /*# top_asic.vhd:465:12 */
  assign rx_valid_int = u_rmii_rx_n476; // (signal)
  /*# top_asic.vhd:466:12 */
  assign rx_end_int = u_rmii_rx_n477; // (signal)
  /*# top_asic.vhd:467:12 */
  assign rx_error_int = u_rmii_rx_n478; // (signal)
  /*# top_asic.vhd:470:12 */
  assign udp_tx_start_int = u_udp_n492; // (signal)
  /*# top_asic.vhd:471:12 */
  assign udp_tx_data_int = u_udp_n493; // (signal)
  /*# top_asic.vhd:472:12 */
  assign udp_tx_ready_int = n432; // (signal)
  /*# top_asic.vhd:475:12 */
  assign arp_tx_req_int = u_arp_n515; // (signal)
  /*# top_asic.vhd:476:12 */
  assign arp_tx_data_int = u_arp_n516; // (signal)
  /*# top_asic.vhd:477:12 */
  assign arp_tx_ready_int = n428; // (signal)
  /*# top_asic.vhd:480:12 */
  assign tx_start_int = n414; // (signal)
  /*# top_asic.vhd:481:12 */
  assign tx_data_int = n421; // (signal)
  /*# top_asic.vhd:482:12 */
  assign tx_ready_int = u_rmii_n525; // (signal)
  /*# top_asic.vhd:483:12 */
  assign tx_busy_int = u_rmii_n526; // (signal)
  /*# top_asic.vhd:486:12 */
  assign i2c_ena_int = u_adau_sequencer_n578; // (signal)
  /*# top_asic.vhd:487:12 */
  assign i2c_addr_int = u_adau_sequencer_n579; // (signal)
  /*# top_asic.vhd:488:12 */
  assign i2c_reg_addr_int = u_adau_sequencer_n580; // (signal)
  /*# top_asic.vhd:489:12 */
  assign i2c_data_wr_int = u_adau_sequencer_n581; // (signal)
  /*# top_asic.vhd:490:12 */
  assign i2c_busy_int = u_i2c_master_n538; // (signal)
  /*# top_asic.vhd:491:12 */
  assign i2c_ack_err_int = u_i2c_master_n539; // (signal)
  /*# top_asic.vhd:492:12 */
  assign i2c_stuck_int = u_i2c_master_n541; // (signal)
  /*# top_asic.vhd:493:12 */
  assign i2c_scl_stuck = u_i2c_master_n542; // (signal)
  /*# top_asic.vhd:494:12 */
  assign i2c_sda_stuck = u_i2c_master_n543; // (signal)
  /*# top_asic.vhd:495:12 */
  assign i2c_rd_mode_int = u_adau_sequencer_n582; // (signal)
  /*# top_asic.vhd:496:12 */
  assign m_scl_o = u_i2c_master_n548; // (signal)
  /*# top_asic.vhd:496:21 */
  assign m_sda_o = u_i2c_master_n549; // (signal)
  /*# top_asic.vhd:496:30 */
  assign m_scl_i = n158; // (signal)
  /*# top_asic.vhd:496:39 */
  assign m_sda_i = n159; // (signal)
  /*# top_asic.vhd:497:12 */
  assign i2c_scl_drv_ok = u_i2c_master_n544; // (signal)
  /*# top_asic.vhd:497:28 */
  assign i2c_sda_drv_ok = u_i2c_master_n545; // (signal)
  /*# top_asic.vhd:497:44 */
  assign i2c_st_done = u_i2c_master_n546; // (signal)
  /*# top_asic.vhd:498:12 */
  assign i2c_recovered = u_i2c_master_n547; // (signal)
  /*# top_asic.vhd:499:12 */
  assign dbg_status2_int = n219; // (signal)
  /*# top_asic.vhd:500:12 */
  always @*
    dbgt_meta = n697; // (isignal)
  initial
    dbgt_meta = 8'b00000000;
  /*# top_asic.vhd:500:23 */
  always @*
    dbgt_sync = n698; // (isignal)
  initial
    dbgt_sync = 8'b00000000;
  /*# top_asic.vhd:501:12 */
  always @*
    dbgu_meta = n699; // (isignal)
  initial
    dbgu_meta = 8'b00000000;
  /*# top_asic.vhd:501:23 */
  always @*
    dbgu_sync = n700; // (isignal)
  initial
    dbgu_sync = 8'b00000000;
  /*# top_asic.vhd:502:12 */
  always @*
    dbgv_meta = n701; // (isignal)
  initial
    dbgv_meta = 8'b00000000;
  /*# top_asic.vhd:502:23 */
  always @*
    dbgv_sync = n702; // (isignal)
  initial
    dbgv_sync = 8'b00000000;
  /*# top_asic.vhd:503:12 */
  assign i2c_probe_int = u_adau_sequencer_n583; // (signal)
  /*# top_asic.vhd:503:27 */
  assign i2c_addr_nack_int = u_i2c_master_n540; // (signal)
  /*# top_asic.vhd:504:12 */
  assign dbg_scan_cnt_int = u_adau_sequencer_n589; // (signal)
  /*# top_asic.vhd:504:30 */
  assign dbg_scan_addr_int = u_adau_sequencer_n590; // (signal)
  /*# top_asic.vhd:505:12 */
  assign dbg_scan_mask_int = u_adau_sequencer_n591; // (signal)
  /*# top_asic.vhd:506:12 */
  assign dbg_vfy_mask_int = u_adau_sequencer_n594; // (signal)
  /*# top_asic.vhd:507:12 */
  always @*
    dbgx_meta = n703; // (isignal)
  initial
    dbgx_meta = 8'b00000000;
  /*# top_asic.vhd:507:23 */
  always @*
    dbgx_sync = n704; // (isignal)
  initial
    dbgx_sync = 8'b00000000;
  /*# top_asic.vhd:508:12 */
  always @*
    dbgw_meta = n705; // (isignal)
  initial
    dbgw_meta = 8'b00000000;
  /*# top_asic.vhd:508:23 */
  always @*
    dbgw_sync = n706; // (isignal)
  initial
    dbgw_sync = 8'b00000000;
  /*# top_asic.vhd:523:12 */
  always @*
    sd_a_f = n707; // (isignal)
  initial
    sd_a_f = 1'b0;
  /*# top_asic.vhd:523:20 */
  always @*
    sd_b_f = n708; // (isignal)
  initial
    sd_b_f = 1'b0;
  /*# top_asic.vhd:524:12 */
  always @*
    sd_a_d = n709; // (isignal)
  initial
    sd_a_d = 1'b0;
  /*# top_asic.vhd:524:20 */
  always @*
    sd_b_d = n710; // (isignal)
  initial
    sd_b_d = 1'b0;
  /*# top_asic.vhd:527:12 */
  always @*
    act_a = n711; // (isignal)
  initial
    act_a = 8'b00000000;
  /*# top_asic.vhd:527:19 */
  always @*
    act_b = n712; // (isignal)
  initial
    act_b = 8'b00000000;
  /*# top_asic.vhd:528:12 */
  always @*
    act_a_l = n714; // (isignal)
  initial
    act_a_l = 8'b00000000;
  /*# top_asic.vhd:528:21 */
  always @*
    act_b_l = n716; // (isignal)
  initial
    act_b_l = 8'b00000000;
  /*# top_asic.vhd:530:12 */
  always @*
    slot_cnt = n717; // (isignal)
  initial
    slot_cnt = 8'b00000000;
  /*# top_asic.vhd:531:12 */
  always @*
    lr_d = n718; // (isignal)
  initial
    lr_d = 1'b0;
  /*# top_asic.vhd:547:12 */
  always @*
    pll_lock_s1 = n719; // (isignal)
  initial
    pll_lock_s1 = 1'b0;
  /*# top_asic.vhd:548:12 */
  always @*
    pll_lock_s2 = n720; // (isignal)
  initial
    pll_lock_s2 = 1'b0;
  /*# top_asic.vhd:549:12 */
  always @*
    pll_lock_d = n721; // (isignal)
  initial
    pll_lock_d = 1'b0;
  /*# top_asic.vhd:550:12 */
  always @*
    pll_drop = n723; // (isignal)
  initial
    pll_drop = 8'b00000000;
  /*# top_asic.vhd:555:12 */
  always @*
    pll_ever_lost = n725; // (isignal)
  initial
    pll_ever_lost = 1'b0;
  /*# top_asic.vhd:561:12 */
  always @*
    rst_ever = n726; // (isignal)
  initial
    rst_ever = 1'b0;
  /*# top_asic.vhd:562:12 */
  always @*
    rst_meta = n727; // (isignal)
  initial
    rst_meta = 1'b0;
  /*# top_asic.vhd:562:22 */
  always @*
    rst_sync = n728; // (isignal)
  initial
    rst_sync = 1'b0;
  /*# top_asic.vhd:563:12 */
  always @*
    pll_lost_meta = n729; // (isignal)
  initial
    pll_lost_meta = 1'b0;
  /*# top_asic.vhd:563:27 */
  always @*
    pll_lost_sync = n730; // (isignal)
  initial
    pll_lost_sync = 1'b0;
  /*# top_asic.vhd:568:12 */
  always @*
    dbgy_meta = n731; // (isignal)
  initial
    dbgy_meta = 8'b00000000;
  /*# top_asic.vhd:568:23 */
  always @*
    dbgy_sync = n732; // (isignal)
  initial
    dbgy_sync = 8'b00000000;
  /*# top_asic.vhd:569:12 */
  always @*
    dbgz_meta = n733; // (isignal)
  initial
    dbgz_meta = 8'b00000000;
  /*# top_asic.vhd:569:23 */
  always @*
    dbgz_sync = n734; // (isignal)
  initial
    dbgz_sync = 8'b00000000;
  /*# top_asic.vhd:570:12 */
  always @*
    rst_n_d = n735; // (isignal)
  initial
    rst_n_d = 1'b0;
  /*# top_asic.vhd:571:12 */
  always @*
    rst_seen = n737; // (isignal)
  initial
    rst_seen = 1'b0;
  /*# top_asic.vhd:572:12 */
  always @*
    rst_drop = n738; // (isignal)
  initial
    rst_drop = 8'b00000000;
  /*# top_asic.vhd:573:12 */
  assign dbg_ot_int = u_adau_sequencer_n592; // (signal)
  /*# top_asic.vhd:574:12 */
  assign dbg_health_int = u_adau_sequencer_n593; // (signal)
  /*# top_asic.vhd:575:12 */
  always @*
    act_win = n739; // (isignal)
  initial
    act_win = 16'b0000000000000000;
  /*# top_asic.vhd:576:12 */
  assign i2c_data_rd_int = u_i2c_master_n537; // (signal)
  /*# top_asic.vhd:577:12 */
  assign adc_pll_lock_int = u_adau_sequencer_n585; // (signal)
  /*# top_asic.vhd:578:12 */
  assign adc_cfg_ok_int = u_adau_sequencer_n586; // (signal)
  /*# top_asic.vhd:585:12 */
  always @*
    dbgs_meta = n740; // (isignal)
  initial
    dbgs_meta = 8'b00000000;
  /*# top_asic.vhd:585:23 */
  always @*
    dbgs_sync = n741; // (isignal)
  initial
    dbgs_sync = 8'b00000000;
  /*# top_asic.vhd:586:12 */
  assign boot_done_int = u_adau_sequencer_n576; // (signal)
  /*# top_asic.vhd:587:12 */
  assign dbg_status_int = n227; // (signal)
  /*# top_asic.vhd:588:12 */
  assign i2c_fault_int = u_adau_sequencer_n584; // (signal)
  /*# top_asic.vhd:591:12 */
  always @*
    udp_rx_req_int = u_udp_rx_n670; // (isignal)
  initial
    udp_rx_req_int = 1'b0;
  /*# top_asic.vhd:592:12 */
  assign udp_rx_ack_int = u_adau_sequencer_n577; // (signal)
  /*# top_asic.vhd:593:12 */
  always @*
    udp_adc_sel_int = u_udp_rx_n671; // (isignal)
  initial
    udp_adc_sel_int = 2'b00;
  /*# top_asic.vhd:594:12 */
  always @*
    udp_ch_sel_int = u_udp_rx_n672; // (isignal)
  initial
    udp_ch_sel_int = 2'b00;
  /*# top_asic.vhd:595:12 */
  always @*
    udp_gain_int = u_udp_rx_n673; // (isignal)
  initial
    udp_gain_int = 8'b10100000;
  /*# top_asic.vhd:668:12 */
  always @*
    pc_mac_r = n742; // (isignal)
  initial
    pc_mac_r = 48'b101000001010110110011111001000100100101101101110;
  /*# top_asic.vhd:669:12 */
  assign arp_learn_mac = u_arp_n513; // (signal)
  /*# top_asic.vhd:670:12 */
  assign arp_learn_val = u_arp_n514; // (signal)
  /*# top_asic.vhd:775:14 */
  assign sdata_b_sel = n440; // (signal)
  /*# top_asic.vhd:776:14 */
  always @*
    lrclk_test = n381; // (isignal)
  initial
    lrclk_test = 1'b0;
  /*# top_asic.vhd:777:14 */
  always @*
    lrclk_div = n743; // (isignal)
  initial
    lrclk_div = 26'b00000000000000000000000000;
  /*# top_asic.vhd:801:32 */
  assign n90 = 1'b1 ? pll_locked : n91;
  /*# top_asic.vhd:801:66 */
  assign n91 = ~pll_locked;
  /*# top_asic.vhd:809:32 */
  assign n96 = clk_div + 26'b00000000000000000000000001;
  /*# top_asic.vhd:821:34 */
  assign n99 = clk_div[21]; // extract
  /*# top_asic.vhd:821:40 */
  assign n100 = i2c_stuck_int ? n99 : n102;
  /*# top_asic.vhd:822:34 */
  assign n101 = clk_div[23]; // extract
  /*# top_asic.vhd:822:12 */
  assign n102 = i2c_fault_int ? n101 : n103;
  /*# top_asic.vhd:823:34 */
  assign n103 = clk_div[25]; // extract
  /*# top_asic.vhd:857:25 */
  assign n134 = i2c_scl_stuck ? 1'b0 : 1'b1;
  /*# top_asic.vhd:858:25 */
  assign n137 = i2c_sda_stuck ? 1'b0 : 1'b1;
  /*# top_asic.vhd:873:52 */
  assign n141 = ~m_sda_o;
  /*# top_asic.vhd:873:40 */
  assign n143 = n141 & 1'b1;
  /*# top_asic.vhd:873:25 */
  assign n145 = 1'b0 | n143;
  /*# top_asic.vhd:872:23 */
  assign n146 = n145 ? 1'b1 : 1'b0;
  /*# top_asic.vhd:876:52 */
  assign n150 = ~m_scl_o;
  /*# top_asic.vhd:876:40 */
  assign n152 = n150 & 1'b1;
  /*# top_asic.vhd:876:25 */
  assign n154 = 1'b0 | n152;
  /*# top_asic.vhd:875:23 */
  assign n155 = n154 ? 1'b1 : 1'b0;
  /*# top_asic.vhd:877:26 */
  assign n158 = 1'b1 ? i2c_sda_i : i2c_scl_i;
  /*# top_asic.vhd:878:26 */
  assign n159 = 1'b1 ? i2c_scl_i : i2c_sda_i;
  /*# top_asic.vhd:959:41 */
  assign n169 = ~lr_d;
  /*# top_asic.vhd:959:32 */
  assign n170 = n169 & lrclk_int;
  /*# top_asic.vhd:962:38 */
  assign n172 = slot_cnt + 8'b00000001;
  /*# top_asic.vhd:959:13 */
  assign n174 = n170 ? 8'b00000001 : n172;
  /*# top_asic.vhd:965:24 */
  assign n176 = act_win == 16'b1111111111111111;
  /*# top_asic.vhd:972:36 */
  assign n178 = act_win + 16'b0000000000000001;
  /*# top_asic.vhd:974:27 */
  assign n179 = sd_a_f != sd_a_d;
  /*# top_asic.vhd:975:46 */
  assign n180 = slot_cnt[7:5]; // extract
  /*# top_asic.vhd:974:17 */
  assign n185 = n179 ? n778 : act_a;
  /*# top_asic.vhd:977:27 */
  assign n186 = sd_b_f != sd_b_d;
  /*# top_asic.vhd:978:46 */
  assign n187 = slot_cnt[7:5]; // extract
  /*# top_asic.vhd:977:17 */
  assign n192 = n186 ? n813 : act_b;
  /*# top_asic.vhd:965:13 */
  assign n194 = n176 ? 8'b00000000 : n185;
  /*# top_asic.vhd:965:13 */
  assign n196 = n176 ? 8'b00000000 : n192;
  /*# top_asic.vhd:965:13 */
  assign n200 = n176 ? 16'b0000000000000000 : n178;
  /*# top_asic.vhd:1016:22 */
  assign n212 = {1'b1, en_48v_drv};
  /*# top_asic.vhd:1017:37 */
  assign n213 = udp_flags_int[0]; // extract
  /*# top_asic.vhd:1017:22 */
  assign n214 = {n212, n213};
  /*# top_asic.vhd:1018:22 */
  assign n215 = {n214, en_48v_int};
  /*# top_asic.vhd:1019:22 */
  assign n216 = {n215, en48_permit};
  /*# top_asic.vhd:1020:22 */
  assign n217 = {n216, i2c_st_done};
  /*# top_asic.vhd:1021:22 */
  assign n218 = {n217, i2c_sda_drv_ok};
  /*# top_asic.vhd:1022:22 */
  assign n219 = {n218, i2c_scl_drv_ok};
  /*# top_asic.vhd:1035:21 */
  assign n221 = {1'b1, adc_cfg_ok_int};
  /*# top_asic.vhd:1036:21 */
  assign n222 = {n221, adc_pll_lock_int};
  /*# top_asic.vhd:1037:21 */
  assign n223 = {n222, boot_done_int};
  /*# top_asic.vhd:1038:21 */
  assign n224 = {n223, i2c_sda_stuck};
  /*# top_asic.vhd:1039:21 */
  assign n225 = {n224, i2c_scl_stuck};
  /*# top_asic.vhd:1040:21 */
  assign n226 = {n225, i2c_stuck_int};
  /*# top_asic.vhd:1041:21 */
  assign n227 = {n226, i2c_fault_int};
  /*# top_asic.vhd:1044:18 */
  assign n228 = ~pll_locked;
  /*# top_asic.vhd:1045:18 */
  assign n229 = ~sys_rst;
  /*# top_asic.vhd:1053:27 */
  assign n233 = ~pll_locked;
  /*# top_asic.vhd:1061:32 */
  assign n235 = $unsigned(phy_rst_cnt) < $unsigned(22'b0001111010000100100000);
  /*# top_asic.vhd:1062:48 */
  assign n237 = phy_rst_cnt + 22'b0000000000000000000001;
  /*# top_asic.vhd:1061:17 */
  assign n238 = n235 ? n237 : phy_rst_cnt;
  /*# top_asic.vhd:1061:17 */
  assign n241 = n235 ? 1'b0 : 1'b1;
  /*# top_asic.vhd:1053:13 */
  assign n243 = n233 ? 22'b0000000000000000000000 : n238;
  /*# top_asic.vhd:1053:13 */
  assign n245 = n233 ? 1'b0 : n241;
  /*# top_asic.vhd:1089:27 */
  assign n252 = ~pll_locked;
  /*# top_asic.vhd:1102:32 */
  assign n254 = $unsigned(adc_rst_cnt) < $unsigned(27'b000010011000100101101000000);
  /*# top_asic.vhd:1103:50 */
  assign n256 = adc_rst_cnt + 27'b000000000000000000000000001;
  /*# top_asic.vhd:1102:17 */
  assign n257 = n254 ? n256 : adc_rst_cnt;
  /*# top_asic.vhd:1102:17 */
  assign n260 = n254 ? 1'b0 : 1'b1;
  /*# top_asic.vhd:1089:13 */
  assign n262 = n252 ? 27'b000000000000000000000000000 : n257;
  /*# top_asic.vhd:1089:13 */
  assign n264 = n252 ? 1'b0 : n260;
  /*# top_asic.vhd:1120:49 */
  assign n271 = ~pll_lock_s2;
  /*# top_asic.vhd:1120:33 */
  assign n272 = n271 & pll_lock_d;
  /*# top_asic.vhd:1120:68 */
  assign n274 = pll_drop != 8'b11111111;
  /*# top_asic.vhd:1120:55 */
  assign n275 = n274 & n272;
  /*# top_asic.vhd:1121:38 */
  assign n277 = pll_drop + 8'b00000001;
  /*# top_asic.vhd:1134:34 */
  assign n281 = rst_n_d & rst_seen;
  /*# top_asic.vhd:1134:65 */
  assign n283 = rst_drop != 8'b11111111;
  /*# top_asic.vhd:1134:52 */
  assign n284 = n283 & n281;
  /*# top_asic.vhd:1135:38 */
  assign n286 = rst_drop + 8'b00000001;
  /*# top_asic.vhd:1134:13 */
  assign n288 = n284 ? 1'b1 : rst_ever;
  /*# top_asic.vhd:1134:13 */
  assign n289 = n284 ? n286 : rst_drop;
  /*# top_asic.vhd:1132:13 */
  assign n290 = adc_rst_n_int ? rst_ever : n288;
  /*# top_asic.vhd:1132:13 */
  assign n293 = adc_rst_n_int ? rst_drop : n289;
  /*# top_asic.vhd:1167:27 */
  assign n307 = ~pll_locked;
  /*# top_asic.vhd:1172:28 */
  assign n309 = $unsigned(pwr_cnt) < $unsigned(27'b010111110101111000010000000);
  /*# top_asic.vhd:1173:40 */
  assign n311 = pwr_cnt + 27'b000000000000000000000000001;
  /*# top_asic.vhd:1172:17 */
  assign n312 = n309 ? n311 : pwr_cnt;
  /*# top_asic.vhd:1175:28 */
  assign n314 = $unsigned(pwr_cnt) >= $unsigned(27'b001011111010111100001000000);
  /*# top_asic.vhd:1175:17 */
  assign n316 = n314 ? 1'b1 : en_15v_int;
  /*# top_asic.vhd:1178:28 */
  assign n318 = $unsigned(pwr_cnt) >= $unsigned(27'b010111110101111000010000000);
  /*# top_asic.vhd:1178:17 */
  assign n320 = n318 ? 1'b1 : en_48v_int;
  /*# top_asic.vhd:1167:13 */
  assign n322 = n307 ? 27'b000000000000000000000000000 : n312;
  /*# top_asic.vhd:1167:13 */
  assign n324 = n307 ? 1'b0 : n316;
  /*# top_asic.vhd:1167:13 */
  assign n326 = n307 ? 1'b0 : n320;
  /*# top_asic.vhd:1190:24 */
  assign n333 = 1'b1 ? 1'b1 : 1'b0;
  /*# top_asic.vhd:1226:23 */
  assign n366 = 1'b0 ? 1'b0 : 1'b1;
  /*# top_asic.vhd:1228:48 */
  assign n368 = udp_flags_int[0]; // extract
  /*# top_asic.vhd:1228:31 */
  assign n369 = en_48v_int & n368;
  /*# top_asic.vhd:1228:52 */
  assign n370 = n369 & en48_permit;
  /*# top_asic.vhd:1228:68 */
  assign n371 = n370 & ph_wd_gate;
  /*# top_asic.vhd:1232:32 */
  assign n373 = 1'b0 ? lrclk_test : clk_18m;
  /*# top_asic.vhd:1248:36 */
  assign n378 = lrclk_div + 26'b00000000000000000000000001;
  /*# top_asic.vhd:1251:38 */
  assign n381 = lrclk_div[25]; // extract
  /*# top_asic.vhd:1256:33 */
  assign n383 = 1'b0 ? lrclk_test : lrclk_int;
  /*# top_asic.vhd:1268:30 */
  assign n388 = active_tx == 2'b00;
  /*# top_asic.vhd:1274:36 */
  assign n389 = ~tx_busy_int;
  /*# top_asic.vhd:1277:25 */
  assign n391 = udp_tx_start_int ? 2'b10 : active_tx;
  /*# top_asic.vhd:1275:25 */
  assign n393 = arp_tx_req_int ? 2'b01 : n391;
  /*# top_asic.vhd:1274:21 */
  assign n394 = n389 ? n393 : active_tx;
  /*# top_asic.vhd:1282:34 */
  assign n396 = active_tx == 2'b01;
  /*# top_asic.vhd:1282:60 */
  assign n397 = ~arp_tx_req_int;
  /*# top_asic.vhd:1282:41 */
  assign n398 = n397 & n396;
  /*# top_asic.vhd:1284:37 */
  assign n400 = active_tx == 2'b10;
  /*# top_asic.vhd:1284:65 */
  assign n401 = ~udp_tx_start_int;
  /*# top_asic.vhd:1284:44 */
  assign n402 = n401 & n400;
  /*# top_asic.vhd:1284:21 */
  assign n404 = n402 ? 2'b00 : active_tx;
  /*# top_asic.vhd:1282:21 */
  assign n406 = n398 ? 2'b00 : n404;
  /*# top_asic.vhd:1268:17 */
  assign n407 = n388 ? n394 : n406;
  /*# top_asic.vhd:1265:13 */
  assign n409 = sys_rst ? 2'b00 : n407;
  /*# top_asic.vhd:1292:52 */
  assign n413 = active_tx == 2'b01;
  /*# top_asic.vhd:1292:37 */
  assign n414 = n413 ? arp_tx_req_int : n417;
  /*# top_asic.vhd:1293:54 */
  assign n416 = active_tx == 2'b10;
  /*# top_asic.vhd:1292:59 */
  assign n417 = n416 ? udp_tx_start_int : 1'b0;
  /*# top_asic.vhd:1296:54 */
  assign n420 = active_tx == 2'b01;
  /*# top_asic.vhd:1296:39 */
  assign n421 = n420 ? arp_tx_data_int : n424;
  /*# top_asic.vhd:1297:54 */
  assign n423 = active_tx == 2'b10;
  /*# top_asic.vhd:1296:61 */
  assign n424 = n423 ? udp_tx_data_int : 8'b00000000;
  /*# top_asic.vhd:1300:53 */
  assign n427 = active_tx == 2'b01;
  /*# top_asic.vhd:1300:38 */
  assign n428 = n427 ? tx_ready_int : 1'b0;
  /*# top_asic.vhd:1301:53 */
  assign n431 = active_tx == 2'b10;
  /*# top_asic.vhd:1301:38 */
  assign n432 = n431 ? tx_ready_int : 1'b0;
  /*# top_asic.vhd:1315:5 */
  tdm8_master u_master (
    .rst(sys_rst),
    .clk_in(clk_18m),
    .bclk_out(),
    .lrclk_out(u_master_n435));
  /*# top_asic.vhd:1336:31 */
  assign n440 = 1'b0 ? sdata_in_A : sdata_in_B;
  /*# top_asic.vhd:1338:5 */
  tdm8_rx u_rx_a (
    .rst(sys_rst),
    .bclk_in(clk_18m),
    .lrclk_in(lrclk_int),
    .sdata_in(sdata_in_A),
    .ch_data_out(u_rx_a_n441));
  /*# top_asic.vhd:1346:5 */
  tdm8_rx u_rx_b (
    .rst(sys_rst),
    .bclk_in(clk_18m),
    .lrclk_in(lrclk_int),
    .sdata_in(sdata_b_sel),
    .ch_data_out(u_rx_b_n444));
  /*# top_asic.vhd:1367:5 */
  tdm16_merge u_merge (
    .clk(clk_18m),
    .rst(sys_rst),
    .lrclk_pulse(lrclk_int),
    .ch_data_a(ch_data_a_int),
    .ch_data_b(ch_data_b_int),
    .tdm16_out(u_merge_n447),
    .tdm16_valid(u_merge_n448));
  /*# top_asic.vhd:1386:5 */
  decimator u_decim (
    .clk(clk_18m),
    .rst(sys_rst),
    .data_in(tdm16_out_int),
    .valid_in(tdm16_val_int),
    .data_out(u_decim_n453),
    .valid_out(u_decim_n454),
    .saturated());
  /*# top_asic.vhd:1396:30 */
  assign n463 = 1'b1 ? decim_data : tdm16_out_int;
  /*# top_asic.vhd:1397:30 */
  assign n464 = 1'b1 ? decim_valid : tdm16_val_int;
  /*# top_asic.vhd:1400:5 */
  packet_formatter u_fmt (
    .clk_18m(clk_18m),
    .rst(sys_rst),
    .tdm16_valid(fmt_valid),
    .tdm16_data(fmt_data),
    .dbg_byte0(act_a_l),
    .dbg_byte1(act_b_l),
    .dbg_status(dbgs_sync),
    .dbg_status2(dbgt_sync),
    .dbg_status3(dbgu_sync),
    .dbg_status4(dbgv_sync),
    .dbg_status5(dbgw_sync),
    .dbg_status6(dbgy_sync),
    .dbg_status7(dbgz_sync),
    .dbg_status8(dbgx_sync),
    .fifo_wr_en(u_fmt_n465),
    .fifo_wr_data(u_fmt_n466),
    .packet_ready(u_fmt_n467));
  /*# top_asic.vhd:1438:5 */
  async_fifo u_fifo (
    .rst_n(sys_rst_n),
    .data(fifo_wr_data_int),
    .rdclk(rmii_ref_clk),
    .rdreq(fifo_rd_en_int),
    .wrclk(clk_18m),
    .wrreq(fifo_wr_en_int),
    .q(fifo_rd_data_int),
    .rdempty(),
    .wrfull());
  /*# top_asic.vhd:1450:5 */
  rmii_rx u_rmii_rx (
    .clk_50m(rmii_ref_clk),
    .rst(sys_rst),
    .rmii_crs_dv(rmii_crs_dv),
    .rmii_rxd(rmii_rxd),
    .rx_data(u_rmii_rx_n475),
    .rx_valid(u_rmii_rx_n476),
    .rx_end(u_rmii_rx_n477),
    .rx_error(u_rmii_rx_n478));
  /*# top_asic.vhd:1469:5 */
  udp_tx_core u_udp (
    .clk_50m(rmii_ref_clk),
    .rst(sys_rst),
    .fpga_mac(48'b110111101010110110111110111011110000000000000001),
    .fpga_ip(32'b11000000101010000000001101100101),
    .pc_mac(pc_mac_r),
    .pc_ip(32'b11000000101010000000001100001010),
    .udp_port(16'b0001001110001101),
    .packet_ready(packet_ready_int),
    .fifo_rd_data(fifo_rd_data_int),
    .tx_ready(udp_tx_ready_int),
    .fifo_rd_en(u_udp_n491),
    .tx_start(u_udp_n492),
    .tx_data(u_udp_n493));
  /*# top_asic.vhd:1533:13 */
  assign n508 = arp_learn_val ? arp_learn_mac : pc_mac_r;
  /*# top_asic.vhd:1531:13 */
  assign n510 = sys_rst ? 48'b101000001010110110011111001000100100101101101110 : n508;
  /*# top_asic.vhd:1539:5 */
  arp_responder u_arp (
    .clk_50m(rmii_ref_clk),
    .rst(sys_rst),
    .fpga_mac(48'b110111101010110110111110111011110000000000000001),
    .fpga_ip(32'b11000000101010000000001101100101),
    .pc_ip(32'b11000000101010000000001100001010),
    .rx_data(rx_data_int),
    .rx_valid(rx_valid_int),
    .rx_end(rx_end_int),
    .rx_error(rx_error_int),
    .tx_ready(arp_tx_ready_int),
    .learn_mac(u_arp_n513),
    .learn_valid(u_arp_n514),
    .arp_tx_req(u_arp_n515),
    .arp_tx_data(u_arp_n516));
  /*# top_asic.vhd:1556:5 */
  rmii_tx u_rmii (
    .clk_50m(rmii_ref_clk),
    .rst(sys_rst),
    .tx_start(tx_start_int),
    .tx_data(tx_data_int),
    .tx_ready(u_rmii_n525),
    .tx_busy(u_rmii_n526),
    .rmii_tx_en(u_rmii_n527),
    .rmii_txd(u_rmii_n528));
  /*# top_asic.vhd:1567:5 */
  i2c_master u_i2c_master (
    .clk(rmii_ref_clk),
    .rst_n(sys_rst_n),
    .ena(i2c_ena_int),
    .rd_mode(i2c_rd_mode_int),
    .probe_mode(i2c_probe_int),
    .addr(i2c_addr_int),
    .reg_addr(i2c_reg_addr_int),
    .data_wr(i2c_data_wr_int),
    .scl_i(m_scl_i),
    .sda_i(m_sda_i),
    .data_rd(u_i2c_master_n537),
    .busy(u_i2c_master_n538),
    .ack_error(u_i2c_master_n539),
    .addr_nack(u_i2c_master_n540),
    .bus_stuck(u_i2c_master_n541),
    .scl_stuck(u_i2c_master_n542),
    .sda_stuck(u_i2c_master_n543),
    .scl_drv_ok(u_i2c_master_n544),
    .sda_drv_ok(u_i2c_master_n545),
    .selftest_done(u_i2c_master_n546),
    .recovered(u_i2c_master_n547),
    .scl_o(u_i2c_master_n548),
    .sda_o(u_i2c_master_n549));
  /*# top_asic.vhd:1606:5 */
  adau1978_sequencer u_adau_sequencer (
    .clk(rmii_ref_clk),
    .rst_n(sys_rst_n),
    .udp_req(udp_rx_req_int),
    .udp_adc_sel(udp_adc_sel_int),
    .udp_ch_sel(udp_ch_sel_int),
    .udp_gain(udp_gain_int),
    .i2c_busy(i2c_busy_int),
    .i2c_ack_error(i2c_ack_err_int),
    .i2c_addr_nack(i2c_addr_nack_int),
    .i2c_data_rd(i2c_data_rd_int),
    .boot_done(u_adau_sequencer_n576),
    .udp_ack(u_adau_sequencer_n577),
    .i2c_ena(u_adau_sequencer_n578),
    .i2c_addr(u_adau_sequencer_n579),
    .i2c_reg_addr(u_adau_sequencer_n580),
    .i2c_data_wr(u_adau_sequencer_n581),
    .i2c_rd_mode(u_adau_sequencer_n582),
    .i2c_probe(u_adau_sequencer_n583),
    .i2c_fault(u_adau_sequencer_n584),
    .adc_pll_lock(u_adau_sequencer_n585),
    .adc_cfg_ok(u_adau_sequencer_n586),
    .dbg_rd_pll(),
    .dbg_rd_sai(),
    .dbg_scan_cnt(u_adau_sequencer_n589),
    .dbg_scan_addr(u_adau_sequencer_n590),
    .dbg_scan_mask(u_adau_sequencer_n591),
    .dbg_ot(u_adau_sequencer_n592),
    .dbg_health(u_adau_sequencer_n593),
    .dbg_vfy_mask(u_adau_sequencer_n594));
  /*# top_asic.vhd:1655:40 */
  assign n636 = dbg_status_int[7]; // extract
  /*# top_asic.vhd:1655:44 */
  assign n637 = {n636, rst_sync};
  /*# top_asic.vhd:1655:55 */
  assign n638 = {n637, pll_lost_sync};
  /*# top_asic.vhd:1656:40 */
  assign n639 = dbg_status_int[4:0]; // extract
  /*# top_asic.vhd:1656:24 */
  assign n640 = {n638, n639};
  /*# top_asic.vhd:1665:42 */
  assign n641 = dbg_vfy_mask_int[7]; // extract
  /*# top_asic.vhd:1665:46 */
  assign n642 = {n641, i2c_recovered};
  /*# top_asic.vhd:1666:42 */
  assign n643 = dbg_vfy_mask_int[5:0]; // extract
  /*# top_asic.vhd:1666:24 */
  assign n644 = {n642, n643};
  /*# top_asic.vhd:1671:5 */
  udp_rx_core u_udp_rx (
    .clk_50m(rmii_ref_clk),
    .rst(sys_rst),
    .fpga_mac(48'b110111101010110110111110111011110000000000000001),
    .fpga_ip(32'b11000000101010000000001101100101),
    .rx_data(rx_data_int),
    .rx_valid(rx_valid_int),
    .rx_end(rx_end_int),
    .rx_error(rx_error_int),
    .udp_ack(udp_rx_ack_int),
    .udp_req(u_udp_rx_n670),
    .udp_adc_sel(u_udp_rx_n671),
    .udp_ch_sel(u_udp_rx_n672),
    .udp_gain(u_udp_rx_n673),
    .udp_flags(u_udp_rx_n674),
    .udp_flags_wr());
  /*# top_asic.vhd:808:9 */
  always @(posedge clk_50m_board)
    n688 <= n96;
  initial
    n688 = 26'b00000000000000000000000000;
  /*# top_asic.vhd:1052:9 */
  always @(posedge clk_50m_board)
    n689 <= n243;
  initial
    n689 = 22'b0000000000000000000000;
  /*# top_asic.vhd:1052:9 */
  always @(posedge clk_50m_board)
    n690 <= n245;
  initial
    n690 = 1'b0;
  /*# top_asic.vhd:1088:9 */
  always @(posedge clk_50m_board)
    n691 <= n262;
  initial
    n691 = 27'b000000000000000000000000000;
  /*# top_asic.vhd:1088:9 */
  always @(posedge clk_50m_board)
    n692 <= n264;
  initial
    n692 = 1'b0;
  /*# top_asic.vhd:1166:9 */
  always @(posedge clk_50m_board)
    n693 <= n322;
  initial
    n693 = 27'b000000000000000000000000000;
  /*# top_asic.vhd:1166:9 */
  always @(posedge clk_50m_board)
    n694 <= n324;
  initial
    n694 = 1'b0;
  /*# top_asic.vhd:1166:9 */
  always @(posedge clk_50m_board)
    n695 <= n326;
  initial
    n695 = 1'b0;
  /*# top_asic.vhd:1264:9 */
  always @(posedge rmii_ref_clk)
    n696 <= n409;
  initial
    n696 = 2'b00;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n697 <= dbg_status2_int;
  initial
    n697 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n698 <= dbgt_meta;
  initial
    n698 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n699 <= dbg_scan_cnt_int;
  initial
    n699 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n700 <= dbgu_meta;
  initial
    n700 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n701 <= dbg_scan_addr_int;
  initial
    n701 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n702 <= dbgv_meta;
  initial
    n702 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n703 <= n644;
  initial
    n703 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n704 <= dbgx_meta;
  initial
    n704 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n705 <= dbg_scan_mask_int;
  initial
    n705 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n706 <= dbgw_meta;
  initial
    n706 = 8'b00000000;
  /*# top_asic.vhd:937:9 */
  always @(negedge clk_18m)
    n707 <= sdata_in_A;
  initial
    n707 = 1'b0;
  /*# top_asic.vhd:937:9 */
  always @(negedge clk_18m)
    n708 <= sdata_in_B;
  initial
    n708 = 1'b0;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n709 <= sd_a_f;
  initial
    n709 = 1'b0;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n710 <= sd_b_f;
  initial
    n710 = 1'b0;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n711 <= n194;
  initial
    n711 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n712 <= n196;
  initial
    n712 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  assign n713 = n176 ? act_a : act_a_l;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n714 <= n713;
  initial
    n714 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  assign n715 = n176 ? act_b : act_b_l;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n716 <= n715;
  initial
    n716 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n717 <= n174;
  initial
    n717 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n718 <= lrclk_int;
  initial
    n718 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n719 <= pll_locked;
  initial
    n719 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n720 <= pll_lock_s1;
  initial
    n720 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n721 <= pll_lock_s2;
  initial
    n721 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  assign n722 = n275 ? n277 : pll_drop;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n723 <= n722;
  initial
    n723 = 8'b00000000;
  /*# top_asic.vhd:1115:9 */
  assign n724 = n275 ? 1'b1 : pll_ever_lost;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n725 <= n724;
  initial
    n725 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n726 <= n290;
  initial
    n726 = 1'b0;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n727 <= rst_ever;
  initial
    n727 = 1'b0;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n728 <= rst_meta;
  initial
    n728 = 1'b0;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n729 <= pll_ever_lost;
  initial
    n729 = 1'b0;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n730 <= pll_lost_meta;
  initial
    n730 = 1'b0;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n731 <= dbg_health_int;
  initial
    n731 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n732 <= dbgy_meta;
  initial
    n732 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n733 <= dbg_ot_int;
  initial
    n733 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n734 <= dbgz_meta;
  initial
    n734 = 8'b00000000;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n735 <= adc_rst_n_int;
  initial
    n735 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  assign n736 = adc_rst_n_int ? 1'b1 : rst_seen;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n737 <= n736;
  initial
    n737 = 1'b0;
  /*# top_asic.vhd:1115:9 */
  always @(posedge clk_50m_board)
    n738 <= n293;
  initial
    n738 = 8'b00000000;
  /*# top_asic.vhd:945:9 */
  always @(posedge clk_18m)
    n739 <= n200;
  initial
    n739 = 16'b0000000000000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n740 <= n640;
  initial
    n740 = 8'b00000000;
  /*# top_asic.vhd:1647:9 */
  always @(posedge clk_18m)
    n741 <= dbgs_meta;
  initial
    n741 = 8'b00000000;
  /*# top_asic.vhd:1530:9 */
  always @(posedge rmii_ref_clk)
    n742 <= n510;
  initial
    n742 = 48'b101000001010110110011111001000100100101101101110;
  /*# top_asic.vhd:1247:9 */
  always @(posedge clk_18m)
    n743 <= n378;
  initial
    n743 = 26'b00000000000000000000000000;
  /*# top_asic.vhd:975:21 */
  assign n744 = n180[2]; // extract
  /*# top_asic.vhd:975:21 */
  assign n745 = ~n744;
  /*# top_asic.vhd:975:21 */
  assign n746 = n180[1]; // extract
  /*# top_asic.vhd:975:21 */
  assign n747 = ~n746;
  /*# top_asic.vhd:975:21 */
  assign n748 = n745 & n747;
  /*# top_asic.vhd:975:21 */
  assign n749 = n745 & n746;
  /*# top_asic.vhd:975:21 */
  assign n750 = n744 & n747;
  /*# top_asic.vhd:975:21 */
  assign n751 = n744 & n746;
  /*# top_asic.vhd:975:21 */
  assign n752 = n180[0]; // extract
  /*# top_asic.vhd:975:21 */
  assign n753 = ~n752;
  /*# top_asic.vhd:975:21 */
  assign n754 = n748 & n753;
  /*# top_asic.vhd:975:21 */
  assign n755 = n748 & n752;
  /*# top_asic.vhd:975:21 */
  assign n756 = n749 & n753;
  /*# top_asic.vhd:975:21 */
  assign n757 = n749 & n752;
  /*# top_asic.vhd:975:21 */
  assign n758 = n750 & n753;
  /*# top_asic.vhd:975:21 */
  assign n759 = n750 & n752;
  /*# top_asic.vhd:975:21 */
  assign n760 = n751 & n753;
  /*# top_asic.vhd:975:21 */
  assign n761 = n751 & n752;
  /*# top_asic.vhd:975:21 */
  assign n762 = act_a[0]; // extract
  /*# top_asic.vhd:975:21 */
  assign n763 = n754 ? 1'b1 : n762;
  /*# top_asic.vhd:975:21 */
  assign n764 = act_a[1]; // extract
  /*# top_asic.vhd:975:21 */
  assign n765 = n755 ? 1'b1 : n764;
  /*# top_asic.vhd:975:21 */
  assign n766 = act_a[2]; // extract
  /*# top_asic.vhd:975:21 */
  assign n767 = n756 ? 1'b1 : n766;
  /*# top_asic.vhd:975:21 */
  assign n768 = act_a[3]; // extract
  /*# top_asic.vhd:975:21 */
  assign n769 = n757 ? 1'b1 : n768;
  /*# top_asic.vhd:975:21 */
  assign n770 = act_a[4]; // extract
  /*# top_asic.vhd:975:21 */
  assign n771 = n758 ? 1'b1 : n770;
  /*# top_asic.vhd:975:21 */
  assign n772 = act_a[5]; // extract
  /*# top_asic.vhd:975:21 */
  assign n773 = n759 ? 1'b1 : n772;
  /*# top_asic.vhd:975:21 */
  assign n774 = act_a[6]; // extract
  /*# top_asic.vhd:975:21 */
  assign n775 = n760 ? 1'b1 : n774;
  /*# top_asic.vhd:975:21 */
  assign n776 = act_a[7]; // extract
  /*# top_asic.vhd:975:21 */
  assign n777 = n761 ? 1'b1 : n776;
  /*# top_asic.vhd:975:21 */
  assign n778 = {n777, n775, n773, n771, n769, n767, n765, n763};
  /*# top_asic.vhd:978:21 */
  assign n779 = n187[2]; // extract
  /*# top_asic.vhd:978:21 */
  assign n780 = ~n779;
  /*# top_asic.vhd:978:21 */
  assign n781 = n187[1]; // extract
  /*# top_asic.vhd:978:21 */
  assign n782 = ~n781;
  /*# top_asic.vhd:978:21 */
  assign n783 = n780 & n782;
  /*# top_asic.vhd:978:21 */
  assign n784 = n780 & n781;
  /*# top_asic.vhd:978:21 */
  assign n785 = n779 & n782;
  /*# top_asic.vhd:978:21 */
  assign n786 = n779 & n781;
  /*# top_asic.vhd:978:21 */
  assign n787 = n187[0]; // extract
  /*# top_asic.vhd:978:21 */
  assign n788 = ~n787;
  /*# top_asic.vhd:978:21 */
  assign n789 = n783 & n788;
  /*# top_asic.vhd:978:21 */
  assign n790 = n783 & n787;
  /*# top_asic.vhd:978:21 */
  assign n791 = n784 & n788;
  /*# top_asic.vhd:978:21 */
  assign n792 = n784 & n787;
  /*# top_asic.vhd:978:21 */
  assign n793 = n785 & n788;
  /*# top_asic.vhd:978:21 */
  assign n794 = n785 & n787;
  /*# top_asic.vhd:978:21 */
  assign n795 = n786 & n788;
  /*# top_asic.vhd:978:21 */
  assign n796 = n786 & n787;
  /*# top_asic.vhd:978:21 */
  assign n797 = act_b[0]; // extract
  /*# top_asic.vhd:978:21 */
  assign n798 = n789 ? 1'b1 : n797;
  /*# top_asic.vhd:978:21 */
  assign n799 = act_b[1]; // extract
  /*# top_asic.vhd:978:21 */
  assign n800 = n790 ? 1'b1 : n799;
  /*# top_asic.vhd:978:21 */
  assign n801 = act_b[2]; // extract
  /*# top_asic.vhd:978:21 */
  assign n802 = n791 ? 1'b1 : n801;
  /*# top_asic.vhd:978:21 */
  assign n803 = act_b[3]; // extract
  /*# top_asic.vhd:978:21 */
  assign n804 = n792 ? 1'b1 : n803;
  /*# top_asic.vhd:978:21 */
  assign n805 = act_b[4]; // extract
  /*# top_asic.vhd:978:21 */
  assign n806 = n793 ? 1'b1 : n805;
  /*# top_asic.vhd:978:21 */
  assign n807 = act_b[5]; // extract
  /*# top_asic.vhd:978:21 */
  assign n808 = n794 ? 1'b1 : n807;
  /*# top_asic.vhd:978:21 */
  assign n809 = act_b[6]; // extract
  /*# top_asic.vhd:978:21 */
  assign n810 = n795 ? 1'b1 : n809;
  /*# top_asic.vhd:978:21 */
  assign n811 = act_b[7]; // extract
  /*# top_asic.vhd:978:21 */
  assign n812 = n796 ? 1'b1 : n811;
  /*# top_asic.vhd:978:21 */
  assign n813 = {n812, n810, n808, n806, n804, n802, n800, n798};
endmodule
