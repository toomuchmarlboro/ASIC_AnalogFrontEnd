// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/tdm8_master.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module tdm8_master
  (input  rst,
   input  clk_in,
   output bclk_out,
   output lrclk_out);
  reg [7:0] bit_cnt;
  wire [31:0] n820;
  wire n822;
  wire [31:0] n823;
  wire [31:0] n825;
  wire [7:0] n826;
  wire [7:0] n828;
  wire [31:0] n829;
  wire n831;
  wire [31:0] n832;
  wire n834;
  wire n836;
  wire n838;
  reg n846;
  reg [7:0] n847;
  assign bclk_out = clk_in; //(module output)
  assign lrclk_out = n846; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:89:12 */
  always @*
    bit_cnt = n847; // (isignal)
  initial
    bit_cnt = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:152:24 */
  assign n820 = {24'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:152:24 */
  assign n822 = n820 == 32'b00000000000000000000000011111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:155:36 */
  assign n823 = {24'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:155:36 */
  assign n825 = n823 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:155:28 */
  assign n826 = n825[7:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:152:13 */
  assign n828 = n822 ? 8'b00000000 : n826;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:161:24 */
  assign n829 = {24'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:161:24 */
  assign n831 = n829 == 32'b00000000000000000000000011111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:167:28 */
  assign n832 = {24'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:167:28 */
  assign n834 = n832 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:167:17 */
  assign n836 = n834 ? 1'b0 : n846;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:161:13 */
  assign n838 = n831 ? 1'b1 : n836;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:150:9 */
  always @(negedge clk_in or posedge rst)
    if (rst)
      n846 <= 1'b0;
    else
      n846 <= n838;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_master.vhd:150:9 */
  always @(negedge clk_in or posedge rst)
    if (rst)
      n847 <= 8'b00000000;
    else
      n847 <= n828;
endmodule
