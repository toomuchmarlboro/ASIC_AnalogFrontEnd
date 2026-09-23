// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/udp_tx_core.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module udp_tx_core
  (input  clk_50m,
   input  rst,
   input  [47:0] fpga_mac,
   input  [31:0] fpga_ip,
   input  [47:0] pc_mac,
   input  [31:0] pc_ip,
   input  [15:0] udp_port,
   input  packet_ready,
   output fifo_rd_en,
   input  [7:0] fifo_rd_data,
   output tx_start,
   output [7:0] tx_data,
   input  tx_ready);
  reg sync_ready_1;
  reg sync_ready_2;
  reg sync_ready_3;
  reg trigger;
  reg state;
  reg [8:0] byte_cnt;
  reg tx_req;
  wire [7:0] next_byte;
  wire [15:0] ip_checksum;
  wire [15:0] n2307;
  wire [31:0] n2309;
  wire [31:0] n2310;
  wire [15:0] n2312;
  wire [31:0] n2313;
  wire [31:0] n2314;
  wire [15:0] n2315;
  wire [31:0] n2316;
  wire [31:0] n2317;
  wire [15:0] n2318;
  wire [31:0] n2319;
  wire [31:0] n2320;
  wire [31:0] n2322;
  wire [31:0] n2324;
  wire [31:0] n2325;
  wire [31:0] n2327;
  wire [31:0] n2329;
  wire [31:0] n2330;
  wire [15:0] n2331;
  wire [15:0] n2332;
  wire n2336;
  wire n2339;
  wire [7:0] n2347;
  wire n2349;
  wire [7:0] n2350;
  wire n2352;
  wire [7:0] n2353;
  wire n2355;
  wire [7:0] n2356;
  wire n2358;
  wire [7:0] n2359;
  wire n2361;
  wire [7:0] n2362;
  wire n2364;
  wire [7:0] n2365;
  wire n2367;
  wire [7:0] n2368;
  wire n2370;
  wire [7:0] n2371;
  wire n2373;
  wire [7:0] n2374;
  wire n2376;
  wire [7:0] n2377;
  wire n2379;
  wire [7:0] n2380;
  wire n2382;
  wire n2384;
  wire n2386;
  wire n2388;
  wire n2390;
  wire n2392;
  wire n2394;
  wire n2396;
  wire n2398;
  wire n2400;
  wire n2402;
  wire n2404;
  wire n2406;
  wire [7:0] n2407;
  wire n2409;
  wire [7:0] n2410;
  wire n2412;
  wire [7:0] n2413;
  wire n2415;
  wire [7:0] n2416;
  wire n2418;
  wire [7:0] n2419;
  wire n2421;
  wire [7:0] n2422;
  wire n2424;
  wire [7:0] n2425;
  wire n2427;
  wire [7:0] n2428;
  wire n2430;
  wire [7:0] n2431;
  wire n2433;
  wire [7:0] n2434;
  wire n2436;
  wire [7:0] n2437;
  wire n2439;
  wire [7:0] n2440;
  wire n2442;
  wire [7:0] n2443;
  wire n2445;
  wire [7:0] n2446;
  wire n2448;
  wire n2450;
  wire n2452;
  wire n2454;
  wire n2456;
  wire [41:0] n2457;
  reg [7:0] n2474;
  wire [7:0] n2479;
  wire n2481;
  wire [8:0] n2483;
  wire n2485;
  wire n2487;
  wire [31:0] n2488;
  wire n2490;
  wire [31:0] n2491;
  wire [31:0] n2493;
  wire [8:0] n2494;
  wire [31:0] n2495;
  wire n2497;
  wire [31:0] n2498;
  wire n2500;
  wire n2501;
  wire n2504;
  wire n2506;
  wire [7:0] n2507;
  wire n2509;
  wire [8:0] n2511;
  wire n2513;
  wire n2515;
  wire [7:0] n2516;
  wire n2517;
  wire [8:0] n2518;
  wire n2519;
  wire n2521;
  wire [1:0] n2522;
  reg n2525;
  reg [7:0] n2528;
  reg n2530;
  reg [8:0] n2532;
  reg n2534;
  reg n2551;
  reg [7:0] n2552;
  reg n2553;
  reg n2554;
  reg n2555;
  reg n2556;
  reg n2557;
  reg [8:0] n2558;
  reg n2559;
  assign fifo_rd_en = n2551; //(module output)
  assign tx_start = tx_req; //(module output)
  assign tx_data = n2552; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:42:12 */
  always @*
    sync_ready_1 = n2553; // (isignal)
  initial
    sync_ready_1 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:43:12 */
  always @*
    sync_ready_2 = n2554; // (isignal)
  initial
    sync_ready_2 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:44:12 */
  always @*
    sync_ready_3 = n2555; // (isignal)
  initial
    sync_ready_3 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:45:12 */
  always @*
    trigger = n2556; // (isignal)
  initial
    trigger = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:48:12 */
  always @*
    state = n2557; // (isignal)
  initial
    state = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:59:12 */
  always @*
    byte_cnt = n2558; // (isignal)
  initial
    byte_cnt = 9'b000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:60:12 */
  always @*
    tx_req = n2559; // (isignal)
  initial
    tx_req = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:61:12 */
  assign next_byte = n2474; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:83:12 */
  assign ip_checksum = n2332; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:44:30 */
  assign n2307 = fpga_ip[31:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:44:16 */
  assign n2309 = {16'b0, n2307};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:44:16 */
  assign n2310 = 32'b00000000000000001100011011000111 + n2309;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:45:30 */
  assign n2312 = fpga_ip[15:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:45:16 */
  assign n2313 = {16'b0, n2312};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:45:16 */
  assign n2314 = n2310 + n2313;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:46:30 */
  assign n2315 = pc_ip[31:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:46:16 */
  assign n2316 = {16'b0, n2315};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:46:16 */
  assign n2317 = n2314 + n2316;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:47:30 */
  assign n2318 = pc_ip[15:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:47:16 */
  assign n2319 = {16'b0, n2318};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:47:16 */
  assign n2320 = n2317 + n2319;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:52:17 */
  assign n2322 = n2320 & 32'b00000000000000001111111111111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:52:39 */
  assign n2324 = n2320 >> 32'b00000000000000000000000000010000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:52:34 */
  assign n2325 = n2322 + n2324;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:53:17 */
  assign n2327 = n2325 & 32'b00000000000000001111111111111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:53:39 */
  assign n2329 = n2325 >> 32'b00000000000000000000000000010000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:53:34 */
  assign n2330 = n2327 + n2329;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:55:38 */
  assign n2331 = n2330[15:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/net_pkg.vhd:55:33 */
  assign n2332 = ~n2331;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:98:29 */
  assign n2336 = sync_ready_2 != sync_ready_3;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:98:13 */
  assign n2339 = n2336 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:116:43 */
  assign n2347 = pc_mac[47:40]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:116:13 */
  assign n2349 = byte_cnt == 9'b000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:117:43 */
  assign n2350 = pc_mac[39:32]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:117:13 */
  assign n2352 = byte_cnt == 9'b000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:118:43 */
  assign n2353 = pc_mac[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:118:13 */
  assign n2355 = byte_cnt == 9'b000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:119:43 */
  assign n2356 = pc_mac[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:119:13 */
  assign n2358 = byte_cnt == 9'b000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:120:43 */
  assign n2359 = pc_mac[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:120:13 */
  assign n2361 = byte_cnt == 9'b000000100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:121:43 */
  assign n2362 = pc_mac[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:121:13 */
  assign n2364 = byte_cnt == 9'b000000101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:122:45 */
  assign n2365 = fpga_mac[47:40]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:122:13 */
  assign n2367 = byte_cnt == 9'b000000110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:123:45 */
  assign n2368 = fpga_mac[39:32]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:123:13 */
  assign n2370 = byte_cnt == 9'b000000111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:124:45 */
  assign n2371 = fpga_mac[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:124:13 */
  assign n2373 = byte_cnt == 9'b000001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:125:45 */
  assign n2374 = fpga_mac[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:125:13 */
  assign n2376 = byte_cnt == 9'b000001001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:126:45 */
  assign n2377 = fpga_mac[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:126:13 */
  assign n2379 = byte_cnt == 9'b000001010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:127:45 */
  assign n2380 = fpga_mac[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:127:13 */
  assign n2382 = byte_cnt == 9'b000001011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:128:13 */
  assign n2384 = byte_cnt == 9'b000001100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:129:13 */
  assign n2386 = byte_cnt == 9'b000001101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:132:13 */
  assign n2388 = byte_cnt == 9'b000001110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:133:13 */
  assign n2390 = byte_cnt == 9'b000001111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:134:13 */
  assign n2392 = byte_cnt == 9'b000010000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:135:13 */
  assign n2394 = byte_cnt == 9'b000010001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:136:13 */
  assign n2396 = byte_cnt == 9'b000010010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:137:13 */
  assign n2398 = byte_cnt == 9'b000010011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:138:13 */
  assign n2400 = byte_cnt == 9'b000010100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:139:13 */
  assign n2402 = byte_cnt == 9'b000010101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:140:13 */
  assign n2404 = byte_cnt == 9'b000010110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:141:13 */
  assign n2406 = byte_cnt == 9'b000010111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:142:48 */
  assign n2407 = ip_checksum[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:142:13 */
  assign n2409 = byte_cnt == 9'b000011000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:143:48 */
  assign n2410 = ip_checksum[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:143:13 */
  assign n2412 = byte_cnt == 9'b000011001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:144:44 */
  assign n2413 = fpga_ip[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:144:13 */
  assign n2415 = byte_cnt == 9'b000011010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:145:44 */
  assign n2416 = fpga_ip[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:145:13 */
  assign n2418 = byte_cnt == 9'b000011011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:146:44 */
  assign n2419 = fpga_ip[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:146:13 */
  assign n2421 = byte_cnt == 9'b000011100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:147:44 */
  assign n2422 = fpga_ip[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:147:13 */
  assign n2424 = byte_cnt == 9'b000011101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:148:42 */
  assign n2425 = pc_ip[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:148:13 */
  assign n2427 = byte_cnt == 9'b000011110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:149:42 */
  assign n2428 = pc_ip[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:149:13 */
  assign n2430 = byte_cnt == 9'b000011111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:150:42 */
  assign n2431 = pc_ip[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:150:13 */
  assign n2433 = byte_cnt == 9'b000100000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:151:42 */
  assign n2434 = pc_ip[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:151:13 */
  assign n2436 = byte_cnt == 9'b000100001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:154:45 */
  assign n2437 = udp_port[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:154:13 */
  assign n2439 = byte_cnt == 9'b000100010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:155:45 */
  assign n2440 = udp_port[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:155:13 */
  assign n2442 = byte_cnt == 9'b000100011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:156:45 */
  assign n2443 = udp_port[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:156:13 */
  assign n2445 = byte_cnt == 9'b000100100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:157:45 */
  assign n2446 = udp_port[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:157:13 */
  assign n2448 = byte_cnt == 9'b000100101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:158:13 */
  assign n2450 = byte_cnt == 9'b000100110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:159:13 */
  assign n2452 = byte_cnt == 9'b000100111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:160:13 */
  assign n2454 = byte_cnt == 9'b000101000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:161:13 */
  assign n2456 = byte_cnt == 9'b000101001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:114:9 */
  assign n2457 = {n2456, n2454, n2452, n2450, n2448, n2445, n2442, n2439, n2436, n2433, n2430, n2427, n2424, n2421, n2418, n2415, n2412, n2409, n2406, n2404, n2402, n2400, n2398, n2396, n2394, n2392, n2390, n2388, n2386, n2384, n2382, n2379, n2376, n2373, n2370, n2367, n2364, n2361, n2358, n2355, n2352, n2349};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:114:9 */
  always @*
    case (n2457)
      42'b100000000000000000000000000000000000000000: n2474 = 8'b00000000;
      42'b010000000000000000000000000000000000000000: n2474 = 8'b00000000;
      42'b001000000000000000000000000000000000000000: n2474 = 8'b10100010;
      42'b000100000000000000000000000000000000000000: n2474 = 8'b00000001;
      42'b000010000000000000000000000000000000000000: n2474 = n2446;
      42'b000001000000000000000000000000000000000000: n2474 = n2443;
      42'b000000100000000000000000000000000000000000: n2474 = n2440;
      42'b000000010000000000000000000000000000000000: n2474 = n2437;
      42'b000000001000000000000000000000000000000000: n2474 = n2434;
      42'b000000000100000000000000000000000000000000: n2474 = n2431;
      42'b000000000010000000000000000000000000000000: n2474 = n2428;
      42'b000000000001000000000000000000000000000000: n2474 = n2425;
      42'b000000000000100000000000000000000000000000: n2474 = n2422;
      42'b000000000000010000000000000000000000000000: n2474 = n2419;
      42'b000000000000001000000000000000000000000000: n2474 = n2416;
      42'b000000000000000100000000000000000000000000: n2474 = n2413;
      42'b000000000000000010000000000000000000000000: n2474 = n2410;
      42'b000000000000000001000000000000000000000000: n2474 = n2407;
      42'b000000000000000000100000000000000000000000: n2474 = 8'b00010001;
      42'b000000000000000000010000000000000000000000: n2474 = 8'b01000000;
      42'b000000000000000000001000000000000000000000: n2474 = 8'b00000000;
      42'b000000000000000000000100000000000000000000: n2474 = 8'b01000000;
      42'b000000000000000000000010000000000000000000: n2474 = 8'b00000000;
      42'b000000000000000000000001000000000000000000: n2474 = 8'b00000000;
      42'b000000000000000000000000100000000000000000: n2474 = 8'b10110110;
      42'b000000000000000000000000010000000000000000: n2474 = 8'b00000001;
      42'b000000000000000000000000001000000000000000: n2474 = 8'b00000000;
      42'b000000000000000000000000000100000000000000: n2474 = 8'b01000101;
      42'b000000000000000000000000000010000000000000: n2474 = 8'b00000000;
      42'b000000000000000000000000000001000000000000: n2474 = 8'b00001000;
      42'b000000000000000000000000000000100000000000: n2474 = n2380;
      42'b000000000000000000000000000000010000000000: n2474 = n2377;
      42'b000000000000000000000000000000001000000000: n2474 = n2374;
      42'b000000000000000000000000000000000100000000: n2474 = n2371;
      42'b000000000000000000000000000000000010000000: n2474 = n2368;
      42'b000000000000000000000000000000000001000000: n2474 = n2365;
      42'b000000000000000000000000000000000000100000: n2474 = n2362;
      42'b000000000000000000000000000000000000010000: n2474 = n2359;
      42'b000000000000000000000000000000000000001000: n2474 = n2356;
      42'b000000000000000000000000000000000000000100: n2474 = n2353;
      42'b000000000000000000000000000000000000000010: n2474 = n2350;
      42'b000000000000000000000000000000000000000001: n2474 = n2347;
      default: n2474 = fifo_rd_data;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:187:21 */
  assign n2479 = trigger ? next_byte : n2552;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:187:21 */
  assign n2481 = trigger ? 1'b1 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:187:21 */
  assign n2483 = trigger ? 9'b000000001 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:187:21 */
  assign n2485 = trigger ? 1'b1 : tx_req;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:186:17 */
  assign n2487 = state == 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:200:37 */
  assign n2488 = {23'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:200:37 */
  assign n2490 = n2488 == 32'b00000000000000000000000111000100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:209:50 */
  assign n2491 = {23'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:209:50 */
  assign n2493 = n2491 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:209:41 */
  assign n2494 = n2493[8:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:41 */
  assign n2495 = {23'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:41 */
  assign n2497 = $signed(n2495) >= $signed(32'b00000000000000000000000000101001);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:71 */
  assign n2498 = {23'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:71 */
  assign n2500 = $signed(n2498) <= $signed(32'b00000000000000000000000111000010);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:58 */
  assign n2501 = n2500 & n2497;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:215:29 */
  assign n2504 = n2501 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:200:25 */
  assign n2506 = n2490 ? 1'b0 : n2504;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:200:25 */
  assign n2507 = n2490 ? n2552 : next_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2509 = n2517 ? 1'b0 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:200:25 */
  assign n2511 = n2490 ? 9'b000000000 : n2494;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2513 = n2519 ? 1'b0 : tx_req;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2515 = tx_ready ? n2506 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2516 = tx_ready ? n2507 : n2552;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2517 = n2490 & tx_ready;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2518 = tx_ready ? n2511 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:199:21 */
  assign n2519 = n2490 & tx_ready;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:198:17 */
  assign n2521 = state == 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  assign n2522 = {n2521, n2487};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  always @*
    case (n2522)
      2'b10: n2525 = n2515;
      2'b01: n2525 = 1'b0;
      default: n2525 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  always @*
    case (n2522)
      2'b10: n2528 = n2516;
      2'b01: n2528 = n2479;
      default: n2528 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  always @*
    case (n2522)
      2'b10: n2530 = n2509;
      2'b01: n2530 = n2481;
      default: n2530 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  always @*
    case (n2522)
      2'b10: n2532 = n2518;
      2'b01: n2532 = n2483;
      default: n2532 = 9'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:185:13 */
  always @*
    case (n2522)
      2'b10: n2534 = n2513;
      2'b01: n2534 = n2485;
      default: n2534 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:181:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n2551 <= 1'b0;
    else
      n2551 <= n2525;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:181:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n2552 <= 8'b00000000;
    else
      n2552 <= n2528;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:92:9 */
  always @(posedge clk_50m)
    n2553 <= packet_ready;
  initial
    n2553 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:92:9 */
  always @(posedge clk_50m)
    n2554 <= sync_ready_1;
  initial
    n2554 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:92:9 */
  always @(posedge clk_50m)
    n2555 <= sync_ready_2;
  initial
    n2555 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:92:9 */
  always @(posedge clk_50m)
    n2556 <= n2339;
  initial
    n2556 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:181:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n2557 <= 1'b0;
    else
      n2557 <= n2530;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:181:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n2558 <= 9'b000000000;
    else
      n2558 <= n2532;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/udp_tx_core.vhd:181:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n2559 <= 1'b0;
    else
      n2559 <= n2534;
endmodule
