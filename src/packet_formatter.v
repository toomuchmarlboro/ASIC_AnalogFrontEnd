// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/packet_formatter.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module packet_formatter
  (input  clk_18m,
   input  rst,
   input  tdm16_valid,
   input  [383:0] tdm16_data,
   input  [7:0] dbg_byte0,
   input  [7:0] dbg_byte1,
   input  [7:0] dbg_status,
   input  [7:0] dbg_status2,
   input  [7:0] dbg_status3,
   input  [7:0] dbg_status4,
   input  [7:0] dbg_status5,
   input  [7:0] dbg_status6,
   input  [7:0] dbg_status7,
   input  [7:0] dbg_status8,
   output fifo_wr_en,
   output [7:0] fifo_wr_data,
   output packet_ready);
  reg [1:0] state;
  reg [383:0] latched_tdm;
  reg [5:0] byte_cnt;
  reg [2:0] frame_count;
  reg [31:0] seq_num;
  reg ready_toggle;
  wire [31:0] n1911;
  wire n1913;
  wire [1:0] n1916;
  wire [1:0] n1917;
  wire [383:0] n1918;
  wire [5:0] n1920;
  wire n1922;
  wire n1924;
  wire n1926;
  wire n1928;
  wire n1930;
  wire [7:0] n1931;
  wire n1933;
  wire [7:0] n1934;
  wire n1936;
  wire [7:0] n1937;
  wire n1939;
  wire [7:0] n1940;
  wire n1942;
  wire n1944;
  wire n1946;
  wire [9:0] n1947;
  reg [7:0] n1953;
  wire [31:0] n1954;
  wire n1956;
  wire [31:0] n1957;
  wire [31:0] n1959;
  wire [5:0] n1960;
  wire [1:0] n1962;
  wire [5:0] n1964;
  wire n1966;
  wire [31:0] n1967;
  wire n1969;
  wire n1971;
  wire n1973;
  wire n1975;
  wire n1977;
  wire n1979;
  wire n1981;
  wire n1983;
  wire [6:0] n1984;
  reg [7:0] n1985;
  wire [31:0] n1986;
  wire n1988;
  wire [7:0] n1990;
  wire [7:0] n1991;
  wire [375:0] n1992;
  wire [383:0] n1994;
  wire [7:0] n1995;
  wire [383:0] n1996;
  wire [7:0] n1997;
  wire [383:0] n1998;
  wire [31:0] n1999;
  wire n2001;
  wire [31:0] n2002;
  wire n2004;
  wire [31:0] n2006;
  wire n2007;
  wire [31:0] n2008;
  wire [31:0] n2010;
  wire [2:0] n2011;
  wire [2:0] n2013;
  wire [31:0] n2014;
  wire n2015;
  wire [31:0] n2016;
  wire [31:0] n2018;
  wire [5:0] n2019;
  wire [1:0] n2021;
  wire [5:0] n2022;
  wire [2:0] n2023;
  wire n2024;
  wire n2025;
  wire n2027;
  wire [2:0] n2028;
  reg n2033;
  reg [7:0] n2036;
  reg [1:0] n2038;
  reg [383:0] n2040;
  reg [5:0] n2042;
  reg [2:0] n2044;
  reg [31:0] n2046;
  reg n2048;
  reg n2073;
  reg [7:0] n2074;
  reg [1:0] n2075;
  wire n2076;
  wire [383:0] n2077;
  reg [383:0] n2078;
  reg [5:0] n2079;
  reg [2:0] n2080;
  reg [31:0] n2081;
  reg n2082;
  assign fifo_wr_en = n2073; //(module output)
  assign fifo_wr_data = n2074; //(module output)
  assign packet_ready = ready_toggle; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:39:12 */
  always @*
    state = n2075; // (isignal)
  initial
    state = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:41:12 */
  always @*
    latched_tdm = n2078; // (isignal)
  initial
    latched_tdm = 384'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:42:12 */
  always @*
    byte_cnt = n2079; // (isignal)
  initial
    byte_cnt = 6'b000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:43:12 */
  always @*
    frame_count = n2080; // (isignal)
  initial
    frame_count = 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:44:12 */
  always @*
    seq_num = n2081; // (isignal)
  initial
    seq_num = 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:47:12 */
  always @*
    ready_toggle = n2082; // (isignal)
  initial
    ready_toggle = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:73:40 */
  assign n1911 = {29'b0, frame_count};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:73:40 */
  assign n1913 = n1911 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:73:25 */
  assign n1916 = n1913 ? 2'b01 : 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:71:21 */
  assign n1917 = tdm16_valid ? n1916 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:71:21 */
  assign n1918 = tdm16_valid ? tdm16_data : latched_tdm;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:71:21 */
  assign n1920 = tdm16_valid ? 6'b000000 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:70:17 */
  assign n1922 = state == 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:86:25 */
  assign n1924 = byte_cnt == 6'b000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:87:25 */
  assign n1926 = byte_cnt == 6'b000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:88:25 */
  assign n1928 = byte_cnt == 6'b000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:89:25 */
  assign n1930 = byte_cnt == 6'b000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:90:75 */
  assign n1931 = seq_num[31:24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:90:25 */
  assign n1933 = byte_cnt == 6'b000100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:91:75 */
  assign n1934 = seq_num[23:16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:91:25 */
  assign n1936 = byte_cnt == 6'b000101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:92:75 */
  assign n1937 = seq_num[15:8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:92:25 */
  assign n1939 = byte_cnt == 6'b000110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:93:75 */
  assign n1940 = seq_num[7:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:93:25 */
  assign n1942 = byte_cnt == 6'b000111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:100:25 */
  assign n1944 = byte_cnt == 6'b001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:101:25 */
  assign n1946 = byte_cnt == 6'b001001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:85:21 */
  assign n1947 = {n1946, n1944, n1942, n1939, n1936, n1933, n1930, n1928, n1926, n1924};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:85:21 */
  always @*
    case (n1947)
      10'b1000000000: n1953 = dbg_byte1;
      10'b0100000000: n1953 = dbg_byte0;
      10'b0010000000: n1953 = n1940;
      10'b0001000000: n1953 = n1937;
      10'b0000100000: n1953 = n1934;
      10'b0000010000: n1953 = n1931;
      10'b0000001000: n1953 = 8'b01111000;
      10'b0000000100: n1953 = 8'b10010111;
      10'b0000000010: n1953 = 8'b10100001;
      10'b0000000001: n1953 = 8'b10101101;
      default: n1953 = 8'b00000000;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:105:33 */
  assign n1954 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:105:33 */
  assign n1956 = n1954 == 32'b00000000000000000000000000001001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:109:46 */
  assign n1957 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:109:46 */
  assign n1959 = n1957 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:109:37 */
  assign n1960 = n1959[5:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:105:21 */
  assign n1962 = n1956 ? 2'b10 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:105:21 */
  assign n1964 = n1956 ? 6'b000000 : n1960;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:82:17 */
  assign n1966 = state == 2'b01;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:115:33 */
  assign n1967 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:115:33 */
  assign n1969 = n1967 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:119:29 */
  assign n1971 = frame_count == 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:120:29 */
  assign n1973 = frame_count == 3'b010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:121:29 */
  assign n1975 = frame_count == 3'b011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:122:29 */
  assign n1977 = frame_count == 3'b100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:123:29 */
  assign n1979 = frame_count == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:124:29 */
  assign n1981 = frame_count == 3'b110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:125:29 */
  assign n1983 = frame_count == 3'b111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:118:25 */
  assign n1984 = {n1983, n1981, n1979, n1977, n1975, n1973, n1971};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:118:25 */
  always @*
    case (n1984)
      7'b1000000: n1985 = dbg_status8;
      7'b0100000: n1985 = dbg_status7;
      7'b0010000: n1985 = dbg_status6;
      7'b0001000: n1985 = dbg_status5;
      7'b0000100: n1985 = dbg_status4;
      7'b0000010: n1985 = dbg_status3;
      7'b0000001: n1985 = dbg_status2;
      default: n1985 = dbg_status;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:128:36 */
  assign n1986 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:128:36 */
  assign n1988 = n1986 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:129:58 */
  assign n1990 = {5'b0, frame_count};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:132:52 */
  assign n1991 = latched_tdm[383:376]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:135:51 */
  assign n1992 = latched_tdm[375:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:135:66 */
  assign n1994 = {n1992, 8'b00000000};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:128:21 */
  assign n1995 = n1988 ? n1990 : n1991;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:128:21 */
  assign n1996 = n1988 ? latched_tdm : n1994;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:115:21 */
  assign n1997 = n1969 ? n1985 : n1995;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:115:21 */
  assign n1998 = n1969 ? latched_tdm : n1996;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:33 */
  assign n1999 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:33 */
  assign n2001 = n1999 == 32'b00000000000000000000000000110001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:142:40 */
  assign n2002 = {29'b0, frame_count};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:142:40 */
  assign n2004 = n2002 == 32'b00000000000000000000000000000111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:144:53 */
  assign n2006 = seq_num + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:145:45 */
  assign n2007 = ~ready_toggle;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:147:57 */
  assign n2008 = {29'b0, frame_count};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:147:57 */
  assign n2010 = n2008 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:147:45 */
  assign n2011 = n2010[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:142:25 */
  assign n2013 = n2004 ? 3'b000 : n2011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2014 = n2024 ? n2006 : seq_num;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2015 = n2025 ? n2007 : ready_toggle;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:150:46 */
  assign n2016 = {26'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:150:46 */
  assign n2018 = n2016 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:150:37 */
  assign n2019 = n2018[5:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2021 = n2001 ? 2'b00 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2022 = n2001 ? byte_cnt : n2019;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2023 = n2001 ? n2013 : frame_count;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2024 = n2004 & n2001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:138:21 */
  assign n2025 = n2004 & n2001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:112:17 */
  assign n2027 = state == 2'b10;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  assign n2028 = {n2027, n1966, n1922};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2033 = 1'b1;
      3'b010: n2033 = 1'b1;
      3'b001: n2033 = 1'b0;
      default: n2033 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2036 = n1997;
      3'b010: n2036 = n1953;
      3'b001: n2036 = n2074;
      default: n2036 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2038 = n2021;
      3'b010: n2038 = n1962;
      3'b001: n2038 = n1917;
      default: n2038 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2040 = n1998;
      3'b010: n2040 = latched_tdm;
      3'b001: n2040 = n1918;
      default: n2040 = 384'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2042 = n2022;
      3'b010: n2042 = n1964;
      3'b001: n2042 = n1920;
      default: n2042 = 6'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2044 = n2023;
      3'b010: n2044 = frame_count;
      3'b001: n2044 = frame_count;
      default: n2044 = 3'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2046 = n2014;
      3'b010: n2046 = seq_num;
      3'b001: n2046 = seq_num;
      default: n2046 = 32'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:69:13 */
  always @*
    case (n2028)
      3'b100: n2048 = n2015;
      3'b010: n2048 = ready_toggle;
      3'b001: n2048 = ready_toggle;
      default: n2048 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2073 <= 1'b0;
    else
      n2073 <= n2033;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2074 <= 8'b00000000;
    else
      n2074 <= n2036;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2075 <= 2'b00;
    else
      n2075 <= n2038;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:41:12 */
  assign n2076 = ~rst;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  assign n2077 = n2076 ? n2040 : latched_tdm;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m)
    n2078 <= n2077;
  initial
    n2078 = 384'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2079 <= 6'b000000;
    else
      n2079 <= n2042;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2080 <= 3'b000;
    else
      n2080 <= n2044;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2081 <= 32'b00000000000000000000000000000000;
    else
      n2081 <= n2046;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/packet_formatter.vhd:64:9 */
  always @(posedge clk_18m or posedge rst)
    if (rst)
      n2082 <= 1'b0;
    else
      n2082 <= n2048;
endmodule
