// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/tdm8_rx.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module tdm8_rx
  (input  rst,
   input  bclk_in,
   input  lrclk_in,
   input  sdata_in,
   output [191:0] ch_data_out);
  reg [263:0] shift_reg;
  reg lrclk_d;
  reg lrclk_d2;
  reg sdata_f;
  wire [262:0] n861;
  wire [263:0] n862;
  wire n865;
  wire n866;
  wire [23:0] n867;
  wire [23:0] n868;
  wire [23:0] n869;
  wire [23:0] n870;
  wire [23:0] n871;
  wire [23:0] n872;
  wire [23:0] n873;
  wire [23:0] n874;
  wire [191:0] n875;
  wire [191:0] n890;
  reg [191:0] n891;
  reg [263:0] n892;
  reg n893;
  reg n894;
  reg n895;
  assign ch_data_out = n891; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:77:12 */
  always @*
    shift_reg = n892; // (isignal)
  initial
    shift_reg = 264'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:84:12 */
  always @*
    lrclk_d = n893; // (isignal)
  initial
    lrclk_d = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:98:12 */
  always @*
    lrclk_d2 = n894; // (isignal)
  initial
    lrclk_d2 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:114:12 */
  always @*
    sdata_f = n895; // (isignal)
  initial
    sdata_f = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:138:35 */
  assign n861 = shift_reg[262:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:138:50 */
  assign n862 = {n861, sdata_f};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:147:46 */
  assign n865 = ~lrclk_d2;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:147:33 */
  assign n866 = n865 & lrclk_d;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n867 = shift_reg[254:231]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n868 = shift_reg[222:199]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n869 = shift_reg[190:167]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n870 = shift_reg[158:135]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n871 = shift_reg[126:103]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n872 = shift_reg[94:71]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n873 = shift_reg[62:39]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:150:37 */
  assign n874 = shift_reg[30:7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:147:13 */
  assign n875 = {n867, n868, n869, n870, n871, n872, n873, n874};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:132:9 */
  assign n890 = n866 ? n875 : n891;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:132:9 */
  always @(posedge bclk_in or posedge rst)
    if (rst)
      n891 <= 192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    else
      n891 <= n890;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:132:9 */
  always @(posedge bclk_in or posedge rst)
    if (rst)
      n892 <= 264'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    else
      n892 <= n862;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:132:9 */
  always @(posedge bclk_in or posedge rst)
    if (rst)
      n893 <= 1'b0;
    else
      n893 <= lrclk_in;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:132:9 */
  always @(posedge bclk_in or posedge rst)
    if (rst)
      n894 <= 1'b0;
    else
      n894 <= lrclk_d;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/tdm8_rx.vhd:120:9 */
  always @(negedge bclk_in)
    n895 <= sdata_in;
  initial
    n895 = 1'b0;
endmodule
