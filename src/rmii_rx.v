// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/rmii_rx.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module rmii_rx
  (input  clk_50m,
   input  rst,
   input  rmii_crs_dv,
   input  [1:0] rmii_rxd,
   output [7:0] rx_data,
   output rx_valid,
   output rx_end,
   output rx_error);
  reg [1:0] state;
  reg [1:0] di_bit_cnt;
  localparam [7:0] n2089 = 8'b00000000;
  reg [7:0] current_byte;
  reg [7:0] byte_reg;
  reg crs_dv_d;
  reg crc_rst;
  reg crc_en;
  (* keep=1'b1 *) wire [31:0] crc_value;
  (* keep=1'b1 *) reg fcs_bad;
  wire [31:0] u_crc_n2095;
  wire [1:0] n2102;
  wire n2104;
  wire n2105;
  wire n2107;
  wire [1:0] n2109;
  wire [1:0] n2111;
  wire [1:0] n2113;
  wire [1:0] n2114;
  wire n2116;
  wire n2117;
  wire n2118;
  wire n2119;
  wire [31:0] n2120;
  wire n2122;
  wire [31:0] n2123;
  wire n2125;
  wire [31:0] n2126;
  wire n2128;
  wire [31:0] n2129;
  wire n2131;
  wire [5:0] n2132;
  wire [7:0] n2133;
  wire [5:0] n2134;
  wire [7:0] n2135;
  wire [7:0] n2136;
  wire n2139;
  wire [7:0] n2140;
  wire n2143;
  wire [7:0] n2144;
  wire n2146;
  wire [1:0] n2147;
  wire [1:0] n2148;
  wire [7:0] n2149;
  wire n2151;
  wire [7:0] n2152;
  wire n2154;
  wire [1:0] n2155;
  wire [1:0] n2156;
  wire [1:0] n2157;
  wire [1:0] n2158;
  wire [7:0] n2159;
  wire n2161;
  wire [7:0] n2162;
  wire n2164;
  wire [3:0] n2165;
  wire [1:0] n2166;
  wire [1:0] n2167;
  wire [3:0] n2168;
  wire [3:0] n2169;
  wire [7:0] n2170;
  wire n2172;
  wire [31:0] n2173;
  wire n2175;
  wire [31:0] n2176;
  wire [31:0] n2178;
  wire [1:0] n2179;
  wire [1:0] n2181;
  wire [7:0] n2182;
  wire n2184;
  wire [1:0] n2186;
  wire [1:0] n2187;
  wire [5:0] n2188;
  wire [5:0] n2189;
  wire [5:0] n2190;
  wire [7:0] n2191;
  wire n2193;
  wire n2195;
  wire [31:0] n2196;
  wire n2198;
  wire n2201;
  wire n2203;
  wire [3:0] n2204;
  reg [7:0] n2206;
  reg n2209;
  reg n2214;
  reg [1:0] n2218;
  reg [1:0] n2221;
  wire [5:0] n2222;
  reg [5:0] n2224;
  reg [7:0] n2226;
  reg n2231;
  reg n2235;
  reg n2239;
  wire [7:0] n2242;
  wire n2244;
  wire n2246;
  wire [1:0] n2248;
  wire [1:0] n2250;
  wire [5:0] n2251;
  wire [5:0] n2252;
  wire [7:0] n2253;
  wire n2255;
  wire n2257;
  wire n2259;
  wire n2260;
  wire [1:0] n2276;
  wire [7:0] n2277;
  reg [7:0] n2278;
  reg n2279;
  reg n2280;
  reg n2281;
  reg [1:0] n2282;
  reg [1:0] n2283;
  wire [5:0] n2284;
  reg [5:0] n2285;
  reg [7:0] n2286;
  reg n2287;
  reg n2288;
  reg n2289;
  reg n2290;
  assign rx_data = n2278; //(module output)
  assign rx_valid = n2279; //(module output)
  assign rx_end = n2280; //(module output)
  assign rx_error = n2281; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:42:12 */
  always @*
    state = n2282; // (isignal)
  initial
    state = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:44:12 */
  always @*
    di_bit_cnt = n2283; // (isignal)
  initial
    di_bit_cnt = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  always @*
    current_byte = n2277; // (isignal)
  initial
    current_byte = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:51:12 */
  always @*
    byte_reg = n2286; // (isignal)
  initial
    byte_reg = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:54:12 */
  always @*
    crs_dv_d = n2287; // (isignal)
  initial
    crs_dv_d = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:56:12 */
  always @*
    crc_rst = n2288; // (isignal)
  initial
    crc_rst = 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:57:12 */
  always @*
    crc_en = n2289; // (isignal)
  initial
    crc_en = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:58:12 */
  assign crc_value = u_crc_n2095; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:69:12 */
  always @*
    fcs_bad = n2290; // (isignal)
  initial
    fcs_bad = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:77:5 */
  crc32 u_crc (
    .clk(clk_50m),
    .rst(crc_rst),
    .en(crc_en),
    .data_in(byte_reg),
    .crc_out(u_crc_n2095));
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:115:25 */
  assign n2102 = rmii_crs_dv ? 2'b01 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:112:21 */
  assign n2104 = state == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:122:40 */
  assign n2105 = ~rmii_crs_dv;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:126:40 */
  assign n2107 = rmii_rxd == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:126:25 */
  assign n2109 = n2107 ? 2'b10 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:126:25 */
  assign n2111 = n2107 ? 2'b00 : di_bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:122:25 */
  assign n2113 = n2105 ? 2'b00 : n2109;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:122:25 */
  assign n2114 = n2105 ? di_bit_cnt : n2111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:119:21 */
  assign n2116 = state == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:40 */
  assign n2117 = ~rmii_crs_dv;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:59 */
  assign n2118 = ~crs_dv_d;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:46 */
  assign n2119 = n2118 & n2117;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:43 */
  assign n2120 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:43 */
  assign n2122 = n2120 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:46 */
  assign n2123 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:46 */
  assign n2125 = n2123 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:46 */
  assign n2126 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:46 */
  assign n2128 = n2126 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:46 */
  assign n2129 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:46 */
  assign n2131 = n2129 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:152:67 */
  assign n2132 = current_byte[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:152:53 */
  assign n2133 = {rmii_rxd, n2132};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:153:68 */
  assign n2134 = current_byte[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:153:54 */
  assign n2135 = {rmii_rxd, n2134};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:29 */
  assign n2136 = n2131 ? n2133 : n2278;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:29 */
  assign n2139 = n2131 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:29 */
  assign n2140 = n2131 ? n2135 : byte_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:150:29 */
  assign n2143 = n2131 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:29 */
  assign n2144 = n2128 ? n2278 : n2136;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:29 */
  assign n2146 = n2128 ? 1'b0 : n2139;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2147 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:29 */
  assign n2148 = n2128 ? rmii_rxd : n2147;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:29 */
  assign n2149 = n2128 ? byte_reg : n2140;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:148:29 */
  assign n2151 = n2128 ? 1'b0 : n2143;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2152 = n2125 ? n2278 : n2144;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2154 = n2125 ? 1'b0 : n2146;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2155 = current_byte[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2156 = n2125 ? rmii_rxd : n2155;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2157 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2158 = n2125 ? n2157 : n2148;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2159 = n2125 ? byte_reg : n2149;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:146:29 */
  assign n2161 = n2125 ? 1'b0 : n2151;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2162 = n2122 ? n2278 : n2152;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2164 = n2122 ? 1'b0 : n2154;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2165 = {n2158, n2156};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2166 = current_byte[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2167 = n2122 ? rmii_rxd : n2166;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2168 = current_byte[5:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2169 = n2122 ? n2168 : n2165;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2170 = n2122 ? byte_reg : n2159;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:144:29 */
  assign n2172 = n2122 ? 1'b0 : n2161;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:158:43 */
  assign n2173 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:158:43 */
  assign n2175 = n2173 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:161:58 */
  assign n2176 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:161:58 */
  assign n2178 = n2176 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:161:47 */
  assign n2179 = n2178[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:158:29 */
  assign n2181 = n2175 ? 2'b00 : n2179;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2182 = n2119 ? n2278 : n2162;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2184 = n2119 ? 1'b0 : n2164;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2186 = n2119 ? 2'b11 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2187 = n2119 ? di_bit_cnt : n2181;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2188 = {n2169, n2167};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2189 = current_byte[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2190 = n2119 ? n2189 : n2188;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2191 = n2119 ? byte_reg : n2170;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:138:25 */
  assign n2193 = n2119 ? 1'b0 : n2172;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:131:21 */
  assign n2195 = state == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:173:29 */
  assign n2196 = ~crc_value;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:173:44 */
  assign n2198 = n2196 != 32'b11000111000001001101110101111011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:173:25 */
  assign n2201 = n2198 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:165:21 */
  assign n2203 = state == 2'b11;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  assign n2204 = {n2203, n2195, n2116, n2104};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2206 = n2278;
      4'b0100: n2206 = n2182;
      4'b0010: n2206 = n2278;
      4'b0001: n2206 = n2278;
      default: n2206 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2209 = 1'b0;
      4'b0100: n2209 = n2184;
      4'b0010: n2209 = 1'b0;
      4'b0001: n2209 = 1'b0;
      default: n2209 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2214 = 1'b1;
      4'b0100: n2214 = 1'b0;
      4'b0010: n2214 = 1'b0;
      4'b0001: n2214 = 1'b0;
      default: n2214 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2218 = 2'b00;
      4'b0100: n2218 = n2186;
      4'b0010: n2218 = n2113;
      4'b0001: n2218 = n2102;
      default: n2218 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2221 = di_bit_cnt;
      4'b0100: n2221 = n2187;
      4'b0010: n2221 = n2114;
      4'b0001: n2221 = 2'b00;
      default: n2221 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2222 = current_byte[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2224 = n2222;
      4'b0100: n2224 = n2190;
      4'b0010: n2224 = n2222;
      4'b0001: n2224 = n2222;
      default: n2224 = 6'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2226 = byte_reg;
      4'b0100: n2226 = n2191;
      4'b0010: n2226 = byte_reg;
      4'b0001: n2226 = byte_reg;
      default: n2226 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2231 = 1'b0;
      4'b0100: n2231 = 1'b0;
      4'b0010: n2231 = 1'b1;
      4'b0001: n2231 = 1'b1;
      default: n2231 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2235 = 1'b0;
      4'b0100: n2235 = n2193;
      4'b0010: n2235 = 1'b0;
      4'b0001: n2235 = 1'b0;
      default: n2235 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:110:17 */
  always @*
    case (n2204)
      4'b1000: n2239 = n2201;
      4'b0100: n2239 = 1'b0;
      4'b0010: n2239 = 1'b0;
      4'b0001: n2239 = 1'b0;
      default: n2239 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2242 = rst ? 8'b00000000 : n2206;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2244 = rst ? 1'b0 : n2209;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2246 = rst ? 1'b0 : n2214;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2248 = rst ? 2'b00 : n2218;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2250 = rst ? 2'b00 : n2221;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2251 = current_byte[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2252 = rst ? n2251 : n2224;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2253 = rst ? byte_reg : n2226;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2255 = rst ? 1'b0 : rmii_crs_dv;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2257 = rst ? 1'b1 : n2231;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2259 = rst ? 1'b0 : n2235;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:89:13 */
  assign n2260 = rst ? fcs_bad : n2239;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2276 = n2089[7:6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2277 = {n2276, n2285};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2278 <= n2242;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2279 <= n2244;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2280 <= n2246;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2281 <= 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2282 <= n2248;
  initial
    n2282 = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2283 <= n2250;
  initial
    n2283 = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:45:12 */
  assign n2284 = n2089[5:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2285 <= n2252;
  initial
    n2285 = n2089[5:0];
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2286 <= n2253;
  initial
    n2286 = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2287 <= n2255;
  initial
    n2287 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2288 <= n2257;
  initial
    n2288 = 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2289 <= n2259;
  initial
    n2289 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_rx.vhd:88:9 */
  always @(posedge clk_50m)
    n2290 <= n2260;
  initial
    n2290 = 1'b0;
endmodule
