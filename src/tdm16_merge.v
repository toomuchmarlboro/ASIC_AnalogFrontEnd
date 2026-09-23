// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/tdm16_merge.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module tdm16_merge
  (input  clk,
   input  rst,
   input  lrclk_pulse,
   input  [191:0] ch_data_a,
   input  [191:0] ch_data_b,
   output [383:0] tdm16_out,
   output tdm16_valid);
  reg lrclk_d1;
  reg lrclk_d2;
  wire n903;
  wire n904;
  wire [383:0] n905;
  wire n909;
  wire [383:0] n924;
  reg [383:0] n925;
  reg n926;
  reg n927;
  reg n928;
  assign tdm16_out = n925; //(module output)
  assign tdm16_valid = n926; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:41:12 */
  always @*
    lrclk_d1 = n927; // (isignal)
  initial
    lrclk_d1 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:42:12 */
  always @*
    lrclk_d2 = n928; // (isignal)
  initial
    lrclk_d2 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:60:44 */
  assign n903 = ~lrclk_d2;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:60:31 */
  assign n904 = n903 & lrclk_d1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:65:42 */
  assign n905 = {ch_data_a, ch_data_b};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:60:13 */
  assign n909 = n904 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:51:9 */
  assign n924 = n904 ? n905 : n925;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:51:9 */
  always @(posedge clk or posedge rst)
    if (rst)
      n925 <= 384'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    else
      n925 <= n924;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:51:9 */
  always @(posedge clk or posedge rst)
    if (rst)
      n926 <= 1'b0;
    else
      n926 <= n909;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:51:9 */
  always @(posedge clk or posedge rst)
    if (rst)
      n927 <= 1'b0;
    else
      n927 <= lrclk_pulse;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm16_merge.vhd:51:9 */
  always @(posedge clk or posedge rst)
    if (rst)
      n928 <= 1'b0;
    else
      n928 <= lrclk_d1;
endmodule
