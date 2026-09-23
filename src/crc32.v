// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/crc32.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module crc32
  (input  clk,
   input  rst,
   input  en,
   input  [7:0] data_in,
   output [31:0] crc_out);
  reg [31:0] crc_reg;
  wire [31:0] n5727;
  wire n5733;
  wire n5734;
  wire [1:0] n5735;
  wire n5736;
  wire [2:0] n5737;
  wire n5738;
  wire [3:0] n5739;
  wire n5740;
  wire [4:0] n5741;
  wire n5742;
  wire [5:0] n5743;
  wire n5744;
  wire [6:0] n5745;
  wire n5746;
  wire [7:0] n5747;
  wire n5748;
  wire n5749;
  wire n5750;
  wire n5751;
  wire n5752;
  wire n5753;
  wire n5754;
  wire n5755;
  wire n5756;
  wire n5757;
  wire n5758;
  wire n5759;
  wire n5760;
  wire n5761;
  wire n5762;
  wire n5763;
  wire n5764;
  wire n5765;
  wire n5766;
  wire n5767;
  wire n5768;
  wire n5769;
  wire n5770;
  wire n5771;
  wire n5772;
  wire n5773;
  wire n5774;
  wire n5775;
  wire n5776;
  wire n5777;
  wire n5778;
  wire n5779;
  wire n5780;
  wire n5781;
  wire n5782;
  wire n5783;
  wire n5784;
  wire n5785;
  wire n5786;
  wire n5787;
  wire n5788;
  wire n5789;
  wire n5790;
  wire n5791;
  wire n5792;
  wire n5793;
  wire n5794;
  wire n5795;
  wire n5796;
  wire n5797;
  wire n5798;
  wire n5799;
  wire n5800;
  wire n5801;
  wire n5802;
  wire n5803;
  wire n5804;
  wire n5805;
  wire n5806;
  wire n5807;
  wire n5808;
  wire n5809;
  wire n5810;
  wire n5811;
  wire n5812;
  wire n5813;
  wire n5814;
  wire n5815;
  wire n5816;
  wire n5817;
  wire n5818;
  wire n5819;
  wire n5820;
  wire n5821;
  wire n5822;
  wire n5823;
  wire n5824;
  wire n5825;
  wire n5826;
  wire n5827;
  wire n5828;
  wire n5829;
  wire n5830;
  wire n5831;
  wire n5832;
  wire n5833;
  wire n5834;
  wire n5835;
  wire n5836;
  wire n5837;
  wire n5838;
  wire n5839;
  wire n5840;
  wire n5841;
  wire n5842;
  wire n5843;
  wire n5844;
  wire n5845;
  wire n5846;
  wire n5847;
  wire n5848;
  wire n5849;
  wire n5850;
  wire n5851;
  wire n5852;
  wire n5853;
  wire n5854;
  wire n5855;
  wire n5856;
  wire n5857;
  wire n5858;
  wire n5859;
  wire n5860;
  wire n5861;
  wire n5862;
  wire n5863;
  wire n5864;
  wire n5865;
  wire n5866;
  wire n5867;
  wire n5868;
  wire n5869;
  wire n5870;
  wire n5871;
  wire n5872;
  wire n5873;
  wire n5874;
  wire n5875;
  wire n5876;
  wire n5877;
  wire n5878;
  wire n5879;
  wire n5880;
  wire n5881;
  wire n5882;
  wire n5883;
  wire n5884;
  wire n5885;
  wire n5886;
  wire n5887;
  wire n5888;
  wire n5889;
  wire n5890;
  wire n5891;
  wire n5892;
  wire n5893;
  wire n5894;
  wire n5895;
  wire n5896;
  wire n5897;
  wire n5898;
  wire n5899;
  wire n5900;
  wire n5901;
  wire n5902;
  wire n5903;
  wire n5904;
  wire n5905;
  wire n5906;
  wire n5907;
  wire n5908;
  wire n5909;
  wire n5910;
  wire n5911;
  wire n5912;
  wire n5913;
  wire n5914;
  wire n5915;
  wire n5916;
  wire n5917;
  wire n5918;
  wire n5919;
  wire n5920;
  wire n5921;
  wire n5922;
  wire n5923;
  wire n5924;
  wire n5925;
  wire n5926;
  wire n5927;
  wire n5928;
  wire n5929;
  wire n5930;
  wire n5931;
  wire n5932;
  wire n5933;
  wire n5934;
  wire n5935;
  wire n5936;
  wire n5937;
  wire n5938;
  wire n5939;
  wire n5940;
  wire n5941;
  wire n5942;
  wire n5943;
  wire n5944;
  wire n5945;
  wire n5946;
  wire n5947;
  wire n5948;
  wire n5949;
  wire n5950;
  wire n5951;
  wire n5952;
  wire n5953;
  wire n5954;
  wire n5955;
  wire n5956;
  wire n5957;
  wire n5958;
  wire n5959;
  wire n5960;
  wire n5961;
  wire n5962;
  wire n5963;
  wire n5964;
  wire n5965;
  wire n5966;
  wire n5967;
  wire n5968;
  wire n5969;
  wire n5970;
  wire n5971;
  wire n5972;
  wire n5973;
  wire n5974;
  wire n5975;
  wire n5976;
  wire n5977;
  wire n5978;
  wire n5979;
  wire n5980;
  wire n5981;
  wire n5982;
  wire n5983;
  wire n5984;
  wire n5985;
  wire n5986;
  wire n5987;
  wire n5988;
  wire n5989;
  wire n5990;
  wire n5991;
  wire n5992;
  wire n5993;
  wire n5994;
  wire n5995;
  wire n5996;
  wire n5997;
  wire n5998;
  wire n5999;
  wire n6000;
  wire n6001;
  wire n6002;
  wire n6003;
  wire n6004;
  wire n6005;
  wire n6006;
  wire n6007;
  wire n6008;
  wire n6009;
  wire n6010;
  wire n6011;
  wire n6012;
  wire n6013;
  wire n6014;
  wire n6015;
  wire n6016;
  wire n6017;
  wire n6018;
  wire n6019;
  wire n6020;
  wire n6021;
  wire n6022;
  wire n6023;
  wire n6024;
  wire n6025;
  wire n6026;
  wire n6027;
  wire n6028;
  wire n6029;
  wire n6030;
  wire n6031;
  wire n6032;
  wire n6033;
  wire n6034;
  wire n6035;
  wire n6036;
  wire n6037;
  wire n6038;
  wire n6039;
  wire n6040;
  wire n6041;
  wire n6042;
  wire n6043;
  wire n6044;
  wire n6045;
  wire n6046;
  wire n6047;
  wire n6048;
  wire n6049;
  wire n6050;
  wire n6051;
  wire n6052;
  wire n6053;
  wire n6054;
  wire n6055;
  wire n6056;
  wire n6057;
  wire n6058;
  wire n6059;
  wire n6060;
  wire n6061;
  wire n6062;
  wire n6063;
  wire n6064;
  wire n6065;
  wire n6066;
  wire n6067;
  wire n6068;
  wire n6069;
  wire n6070;
  wire n6071;
  wire n6072;
  wire n6073;
  wire n6074;
  wire n6075;
  wire n6076;
  wire n6077;
  wire n6078;
  wire n6079;
  wire n6080;
  wire n6081;
  wire n6082;
  wire n6083;
  wire n6084;
  wire n6085;
  wire n6086;
  wire n6087;
  wire n6088;
  wire n6089;
  wire n6090;
  wire n6091;
  wire n6092;
  wire n6093;
  wire n6094;
  wire n6095;
  wire n6096;
  wire n6097;
  wire n6098;
  wire n6099;
  wire n6100;
  wire n6101;
  wire n6102;
  wire n6103;
  wire n6104;
  wire n6105;
  wire n6106;
  wire n6107;
  wire n6108;
  wire n6109;
  wire n6110;
  wire n6111;
  wire n6112;
  wire n6113;
  wire n6114;
  wire n6115;
  wire n6116;
  wire n6117;
  wire n6118;
  wire n6119;
  wire n6120;
  wire n6121;
  wire n6122;
  wire n6123;
  wire n6124;
  wire n6125;
  wire n6126;
  wire n6127;
  wire n6128;
  wire n6129;
  wire n6130;
  wire n6131;
  wire n6132;
  wire n6133;
  wire n6134;
  wire n6135;
  wire n6136;
  wire n6137;
  wire n6138;
  wire n6139;
  wire n6140;
  wire n6141;
  wire n6142;
  wire n6143;
  wire n6144;
  wire n6145;
  wire n6146;
  wire n6147;
  wire n6148;
  wire n6149;
  wire n6150;
  wire n6151;
  wire n6152;
  wire n6153;
  wire n6154;
  wire n6155;
  wire n6156;
  wire n6157;
  wire n6158;
  wire n6159;
  wire n6160;
  wire n6161;
  wire n6162;
  wire n6163;
  wire n6164;
  wire n6165;
  wire n6166;
  wire n6167;
  wire n6168;
  wire n6169;
  wire n6170;
  wire n6171;
  wire n6172;
  wire n6173;
  wire n6174;
  wire n6175;
  wire n6176;
  wire n6177;
  wire n6178;
  wire n6179;
  wire n6180;
  wire n6181;
  wire n6182;
  wire n6183;
  wire n6184;
  wire n6185;
  wire n6186;
  wire n6187;
  wire n6188;
  wire n6189;
  wire n6190;
  wire n6191;
  wire n6192;
  wire n6193;
  wire n6194;
  wire n6195;
  wire n6196;
  wire n6197;
  wire n6198;
  wire n6199;
  wire n6200;
  wire n6201;
  wire n6202;
  wire n6203;
  wire n6204;
  wire n6205;
  wire n6206;
  wire n6207;
  wire n6208;
  wire n6209;
  wire n6210;
  wire n6211;
  wire n6212;
  wire n6213;
  wire n6214;
  wire n6215;
  wire n6216;
  wire n6217;
  wire n6218;
  wire n6219;
  wire [31:0] n6220;
  wire [31:0] n6232;
  reg [31:0] n6233;
  assign crc_out = n5727; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:15:12 */
  always @*
    crc_reg = n6233; // (isignal)
  initial
    crc_reg = 32'b11111111111111111111111111111111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:18:16 */
  assign n5727 = ~crc_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:29 */
  assign n5733 = data_in[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:42 */
  assign n5734 = data_in[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:33 */
  assign n5735 = {n5733, n5734};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:55 */
  assign n5736 = data_in[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:46 */
  assign n5737 = {n5735, n5736};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:68 */
  assign n5738 = data_in[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:59 */
  assign n5739 = {n5737, n5738};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:29 */
  assign n5740 = data_in[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:30:72 */
  assign n5741 = {n5739, n5740};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:42 */
  assign n5742 = data_in[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:33 */
  assign n5743 = {n5741, n5742};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:55 */
  assign n5744 = data_in[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:46 */
  assign n5745 = {n5743, n5744};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:68 */
  assign n5746 = data_in[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:31:59 */
  assign n5747 = {n5745, n5746};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:32 */
  assign n5748 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:42 */
  assign n5749 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:37 */
  assign n5750 = n5748 ^ n5749;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:52 */
  assign n5751 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:47 */
  assign n5752 = n5750 ^ n5751;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:61 */
  assign n5753 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:34:56 */
  assign n5754 = n5752 ^ n5753;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:32 */
  assign n5755 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:42 */
  assign n5756 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:37 */
  assign n5757 = n5755 ^ n5756;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:52 */
  assign n5758 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:47 */
  assign n5759 = n5757 ^ n5758;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:62 */
  assign n5760 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:57 */
  assign n5761 = n5759 ^ n5760;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:72 */
  assign n5762 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:67 */
  assign n5763 = n5761 ^ n5762;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:81 */
  assign n5764 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:76 */
  assign n5765 = n5763 ^ n5764;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:90 */
  assign n5766 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:85 */
  assign n5767 = n5765 ^ n5766;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:99 */
  assign n5768 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:35:94 */
  assign n5769 = n5767 ^ n5768;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:32 */
  assign n5770 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:42 */
  assign n5771 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:37 */
  assign n5772 = n5770 ^ n5771;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:52 */
  assign n5773 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:47 */
  assign n5774 = n5772 ^ n5773;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:62 */
  assign n5775 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:57 */
  assign n5776 = n5774 ^ n5775;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:72 */
  assign n5777 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:67 */
  assign n5778 = n5776 ^ n5777;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:82 */
  assign n5779 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:77 */
  assign n5780 = n5778 ^ n5779;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:91 */
  assign n5781 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:86 */
  assign n5782 = n5780 ^ n5781;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:100 */
  assign n5783 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:95 */
  assign n5784 = n5782 ^ n5783;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:109 */
  assign n5785 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:104 */
  assign n5786 = n5784 ^ n5785;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:118 */
  assign n5787 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:36:113 */
  assign n5788 = n5786 ^ n5787;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:32 */
  assign n5789 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:42 */
  assign n5790 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:37 */
  assign n5791 = n5789 ^ n5790;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:52 */
  assign n5792 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:47 */
  assign n5793 = n5791 ^ n5792;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:62 */
  assign n5794 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:57 */
  assign n5795 = n5793 ^ n5794;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:72 */
  assign n5796 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:67 */
  assign n5797 = n5795 ^ n5796;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:81 */
  assign n5798 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:76 */
  assign n5799 = n5797 ^ n5798;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:90 */
  assign n5800 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:85 */
  assign n5801 = n5799 ^ n5800;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:99 */
  assign n5802 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:37:94 */
  assign n5803 = n5801 ^ n5802;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:32 */
  assign n5804 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:42 */
  assign n5805 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:37 */
  assign n5806 = n5804 ^ n5805;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:52 */
  assign n5807 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:47 */
  assign n5808 = n5806 ^ n5807;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:62 */
  assign n5809 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:57 */
  assign n5810 = n5808 ^ n5809;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:72 */
  assign n5811 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:67 */
  assign n5812 = n5810 ^ n5811;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:82 */
  assign n5813 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:77 */
  assign n5814 = n5812 ^ n5813;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:91 */
  assign n5815 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:86 */
  assign n5816 = n5814 ^ n5815;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:100 */
  assign n5817 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:95 */
  assign n5818 = n5816 ^ n5817;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:109 */
  assign n5819 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:104 */
  assign n5820 = n5818 ^ n5819;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:118 */
  assign n5821 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:38:113 */
  assign n5822 = n5820 ^ n5821;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:32 */
  assign n5823 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:42 */
  assign n5824 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:37 */
  assign n5825 = n5823 ^ n5824;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:52 */
  assign n5826 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:47 */
  assign n5827 = n5825 ^ n5826;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:62 */
  assign n5828 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:57 */
  assign n5829 = n5827 ^ n5828;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:72 */
  assign n5830 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:67 */
  assign n5831 = n5829 ^ n5830;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:82 */
  assign n5832 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:77 */
  assign n5833 = n5831 ^ n5832;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:92 */
  assign n5834 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:87 */
  assign n5835 = n5833 ^ n5834;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:102 */
  assign n5836 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:97 */
  assign n5837 = n5835 ^ n5836;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:111 */
  assign n5838 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:106 */
  assign n5839 = n5837 ^ n5838;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:120 */
  assign n5840 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:115 */
  assign n5841 = n5839 ^ n5840;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:129 */
  assign n5842 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:124 */
  assign n5843 = n5841 ^ n5842;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:138 */
  assign n5844 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:133 */
  assign n5845 = n5843 ^ n5844;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:147 */
  assign n5846 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:142 */
  assign n5847 = n5845 ^ n5846;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:156 */
  assign n5848 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:39:151 */
  assign n5849 = n5847 ^ n5848;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:32 */
  assign n5850 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:42 */
  assign n5851 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:37 */
  assign n5852 = n5850 ^ n5851;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:52 */
  assign n5853 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:47 */
  assign n5854 = n5852 ^ n5853;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:62 */
  assign n5855 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:57 */
  assign n5856 = n5854 ^ n5855;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:72 */
  assign n5857 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:67 */
  assign n5858 = n5856 ^ n5857;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:82 */
  assign n5859 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:77 */
  assign n5860 = n5858 ^ n5859;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:92 */
  assign n5861 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:87 */
  assign n5862 = n5860 ^ n5861;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:101 */
  assign n5863 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:96 */
  assign n5864 = n5862 ^ n5863;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:110 */
  assign n5865 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:105 */
  assign n5866 = n5864 ^ n5865;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:119 */
  assign n5867 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:114 */
  assign n5868 = n5866 ^ n5867;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:128 */
  assign n5869 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:123 */
  assign n5870 = n5868 ^ n5869;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:137 */
  assign n5871 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:40:132 */
  assign n5872 = n5870 ^ n5871;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:32 */
  assign n5873 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:42 */
  assign n5874 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:37 */
  assign n5875 = n5873 ^ n5874;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:52 */
  assign n5876 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:47 */
  assign n5877 = n5875 ^ n5876;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:62 */
  assign n5878 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:57 */
  assign n5879 = n5877 ^ n5878;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:72 */
  assign n5880 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:67 */
  assign n5881 = n5879 ^ n5880;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:82 */
  assign n5882 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:77 */
  assign n5883 = n5881 ^ n5882;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:91 */
  assign n5884 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:86 */
  assign n5885 = n5883 ^ n5884;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:100 */
  assign n5886 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:95 */
  assign n5887 = n5885 ^ n5886;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:109 */
  assign n5888 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:104 */
  assign n5889 = n5887 ^ n5888;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:118 */
  assign n5890 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:41:113 */
  assign n5891 = n5889 ^ n5890;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:32 */
  assign n5892 = crc_reg[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:41 */
  assign n5893 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:36 */
  assign n5894 = n5892 ^ n5893;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:51 */
  assign n5895 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:46 */
  assign n5896 = n5894 ^ n5895;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:61 */
  assign n5897 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:56 */
  assign n5898 = n5896 ^ n5897;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:71 */
  assign n5899 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:66 */
  assign n5900 = n5898 ^ n5899;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:81 */
  assign n5901 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:76 */
  assign n5902 = n5900 ^ n5901;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:90 */
  assign n5903 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:85 */
  assign n5904 = n5902 ^ n5903;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:99 */
  assign n5905 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:94 */
  assign n5906 = n5904 ^ n5905;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:108 */
  assign n5907 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:42:103 */
  assign n5908 = n5906 ^ n5907;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:32 */
  assign n5909 = crc_reg[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:41 */
  assign n5910 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:36 */
  assign n5911 = n5909 ^ n5910;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:51 */
  assign n5912 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:46 */
  assign n5913 = n5911 ^ n5912;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:61 */
  assign n5914 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:56 */
  assign n5915 = n5913 ^ n5914;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:71 */
  assign n5916 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:66 */
  assign n5917 = n5915 ^ n5916;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:81 */
  assign n5918 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:76 */
  assign n5919 = n5917 ^ n5918;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:90 */
  assign n5920 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:85 */
  assign n5921 = n5919 ^ n5920;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:99 */
  assign n5922 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:94 */
  assign n5923 = n5921 ^ n5922;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:108 */
  assign n5924 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:43:103 */
  assign n5925 = n5923 ^ n5924;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:33 */
  assign n5926 = crc_reg[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:42 */
  assign n5927 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:37 */
  assign n5928 = n5926 ^ n5927;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:52 */
  assign n5929 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:47 */
  assign n5930 = n5928 ^ n5929;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:62 */
  assign n5931 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:57 */
  assign n5932 = n5930 ^ n5931;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:72 */
  assign n5933 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:67 */
  assign n5934 = n5932 ^ n5933;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:82 */
  assign n5935 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:77 */
  assign n5936 = n5934 ^ n5935;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:91 */
  assign n5937 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:86 */
  assign n5938 = n5936 ^ n5937;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:100 */
  assign n5939 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:95 */
  assign n5940 = n5938 ^ n5939;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:109 */
  assign n5941 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:44:104 */
  assign n5942 = n5940 ^ n5941;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:33 */
  assign n5943 = crc_reg[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:42 */
  assign n5944 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:37 */
  assign n5945 = n5943 ^ n5944;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:52 */
  assign n5946 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:47 */
  assign n5947 = n5945 ^ n5946;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:62 */
  assign n5948 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:57 */
  assign n5949 = n5947 ^ n5948;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:72 */
  assign n5950 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:67 */
  assign n5951 = n5949 ^ n5950;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:82 */
  assign n5952 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:77 */
  assign n5953 = n5951 ^ n5952;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:91 */
  assign n5954 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:86 */
  assign n5955 = n5953 ^ n5954;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:100 */
  assign n5956 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:95 */
  assign n5957 = n5955 ^ n5956;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:109 */
  assign n5958 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:45:104 */
  assign n5959 = n5957 ^ n5958;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:33 */
  assign n5960 = crc_reg[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:42 */
  assign n5961 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:37 */
  assign n5962 = n5960 ^ n5961;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:52 */
  assign n5963 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:47 */
  assign n5964 = n5962 ^ n5963;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:62 */
  assign n5965 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:57 */
  assign n5966 = n5964 ^ n5965;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:72 */
  assign n5967 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:67 */
  assign n5968 = n5966 ^ n5967;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:82 */
  assign n5969 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:77 */
  assign n5970 = n5968 ^ n5969;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:92 */
  assign n5971 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:87 */
  assign n5972 = n5970 ^ n5971;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:102 */
  assign n5973 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:97 */
  assign n5974 = n5972 ^ n5973;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:111 */
  assign n5975 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:106 */
  assign n5976 = n5974 ^ n5975;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:120 */
  assign n5977 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:115 */
  assign n5978 = n5976 ^ n5977;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:129 */
  assign n5979 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:124 */
  assign n5980 = n5978 ^ n5979;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:138 */
  assign n5981 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:133 */
  assign n5982 = n5980 ^ n5981;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:147 */
  assign n5983 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:46:142 */
  assign n5984 = n5982 ^ n5983;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:33 */
  assign n5985 = crc_reg[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:42 */
  assign n5986 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:37 */
  assign n5987 = n5985 ^ n5986;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:52 */
  assign n5988 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:47 */
  assign n5989 = n5987 ^ n5988;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:62 */
  assign n5990 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:57 */
  assign n5991 = n5989 ^ n5990;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:72 */
  assign n5992 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:67 */
  assign n5993 = n5991 ^ n5992;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:82 */
  assign n5994 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:77 */
  assign n5995 = n5993 ^ n5994;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:92 */
  assign n5996 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:87 */
  assign n5997 = n5995 ^ n5996;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:102 */
  assign n5998 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:97 */
  assign n5999 = n5997 ^ n5998;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:111 */
  assign n6000 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:106 */
  assign n6001 = n5999 ^ n6000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:120 */
  assign n6002 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:115 */
  assign n6003 = n6001 ^ n6002;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:129 */
  assign n6004 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:124 */
  assign n6005 = n6003 ^ n6004;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:138 */
  assign n6006 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:133 */
  assign n6007 = n6005 ^ n6006;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:147 */
  assign n6008 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:47:142 */
  assign n6009 = n6007 ^ n6008;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:33 */
  assign n6010 = crc_reg[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:42 */
  assign n6011 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:37 */
  assign n6012 = n6010 ^ n6011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:52 */
  assign n6013 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:47 */
  assign n6014 = n6012 ^ n6013;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:62 */
  assign n6015 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:57 */
  assign n6016 = n6014 ^ n6015;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:72 */
  assign n6017 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:67 */
  assign n6018 = n6016 ^ n6017;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:82 */
  assign n6019 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:77 */
  assign n6020 = n6018 ^ n6019;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:92 */
  assign n6021 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:87 */
  assign n6022 = n6020 ^ n6021;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:101 */
  assign n6023 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:96 */
  assign n6024 = n6022 ^ n6023;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:110 */
  assign n6025 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:105 */
  assign n6026 = n6024 ^ n6025;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:119 */
  assign n6027 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:114 */
  assign n6028 = n6026 ^ n6027;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:128 */
  assign n6029 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:48:123 */
  assign n6030 = n6028 ^ n6029;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:33 */
  assign n6031 = crc_reg[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:42 */
  assign n6032 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:37 */
  assign n6033 = n6031 ^ n6032;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:52 */
  assign n6034 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:47 */
  assign n6035 = n6033 ^ n6034;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:62 */
  assign n6036 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:57 */
  assign n6037 = n6035 ^ n6036;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:72 */
  assign n6038 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:67 */
  assign n6039 = n6037 ^ n6038;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:82 */
  assign n6040 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:77 */
  assign n6041 = n6039 ^ n6040;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:91 */
  assign n6042 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:86 */
  assign n6043 = n6041 ^ n6042;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:100 */
  assign n6044 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:95 */
  assign n6045 = n6043 ^ n6044;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:109 */
  assign n6046 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:49:104 */
  assign n6047 = n6045 ^ n6046;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:33 */
  assign n6048 = crc_reg[8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:42 */
  assign n6049 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:37 */
  assign n6050 = n6048 ^ n6049;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:52 */
  assign n6051 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:47 */
  assign n6052 = n6050 ^ n6051;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:62 */
  assign n6053 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:57 */
  assign n6054 = n6052 ^ n6053;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:72 */
  assign n6055 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:67 */
  assign n6056 = n6054 ^ n6055;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:81 */
  assign n6057 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:76 */
  assign n6058 = n6056 ^ n6057;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:90 */
  assign n6059 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:50:85 */
  assign n6060 = n6058 ^ n6059;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:33 */
  assign n6061 = crc_reg[9]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:42 */
  assign n6062 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:37 */
  assign n6063 = n6061 ^ n6062;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:52 */
  assign n6064 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:47 */
  assign n6065 = n6063 ^ n6064;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:62 */
  assign n6066 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:57 */
  assign n6067 = n6065 ^ n6066;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:72 */
  assign n6068 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:67 */
  assign n6069 = n6067 ^ n6068;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:81 */
  assign n6070 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:76 */
  assign n6071 = n6069 ^ n6070;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:90 */
  assign n6072 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:51:85 */
  assign n6073 = n6071 ^ n6072;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:33 */
  assign n6074 = crc_reg[10]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:43 */
  assign n6075 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:38 */
  assign n6076 = n6074 ^ n6075;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:53 */
  assign n6077 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:48 */
  assign n6078 = n6076 ^ n6077;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:63 */
  assign n6079 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:58 */
  assign n6080 = n6078 ^ n6079;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:73 */
  assign n6081 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:68 */
  assign n6082 = n6080 ^ n6081;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:82 */
  assign n6083 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:77 */
  assign n6084 = n6082 ^ n6083;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:91 */
  assign n6085 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:52:86 */
  assign n6086 = n6084 ^ n6085;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:33 */
  assign n6087 = crc_reg[11]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:43 */
  assign n6088 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:38 */
  assign n6089 = n6087 ^ n6088;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:53 */
  assign n6090 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:48 */
  assign n6091 = n6089 ^ n6090;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:63 */
  assign n6092 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:58 */
  assign n6093 = n6091 ^ n6092;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:72 */
  assign n6094 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:53:67 */
  assign n6095 = n6093 ^ n6094;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:54:33 */
  assign n6096 = crc_reg[12]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:54:43 */
  assign n6097 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:54:38 */
  assign n6098 = n6096 ^ n6097;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:54:53 */
  assign n6099 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:54:48 */
  assign n6100 = n6098 ^ n6099;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:55:33 */
  assign n6101 = crc_reg[13]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:55:43 */
  assign n6102 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:55:38 */
  assign n6103 = n6101 ^ n6102;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:55:53 */
  assign n6104 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:55:48 */
  assign n6105 = n6103 ^ n6104;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:56:33 */
  assign n6106 = crc_reg[14]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:56:43 */
  assign n6107 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:56:38 */
  assign n6108 = n6106 ^ n6107;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:56:53 */
  assign n6109 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:56:48 */
  assign n6110 = n6108 ^ n6109;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:33 */
  assign n6111 = crc_reg[15]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:43 */
  assign n6112 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:38 */
  assign n6113 = n6111 ^ n6112;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:53 */
  assign n6114 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:48 */
  assign n6115 = n6113 ^ n6114;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:63 */
  assign n6116 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:58 */
  assign n6117 = n6115 ^ n6116;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:73 */
  assign n6118 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:68 */
  assign n6119 = n6117 ^ n6118;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:82 */
  assign n6120 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:77 */
  assign n6121 = n6119 ^ n6120;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:91 */
  assign n6122 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:57:86 */
  assign n6123 = n6121 ^ n6122;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:33 */
  assign n6124 = crc_reg[16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:43 */
  assign n6125 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:38 */
  assign n6126 = n6124 ^ n6125;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:53 */
  assign n6127 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:48 */
  assign n6128 = n6126 ^ n6127;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:63 */
  assign n6129 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:58 */
  assign n6130 = n6128 ^ n6129;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:73 */
  assign n6131 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:68 */
  assign n6132 = n6130 ^ n6131;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:82 */
  assign n6133 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:77 */
  assign n6134 = n6132 ^ n6133;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:91 */
  assign n6135 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:58:86 */
  assign n6136 = n6134 ^ n6135;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:33 */
  assign n6137 = crc_reg[17]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:43 */
  assign n6138 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:38 */
  assign n6139 = n6137 ^ n6138;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:53 */
  assign n6140 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:48 */
  assign n6141 = n6139 ^ n6140;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:63 */
  assign n6142 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:58 */
  assign n6143 = n6141 ^ n6142;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:72 */
  assign n6144 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:59:67 */
  assign n6145 = n6143 ^ n6144;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:33 */
  assign n6146 = crc_reg[18]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:43 */
  assign n6147 = crc_reg[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:38 */
  assign n6148 = n6146 ^ n6147;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:53 */
  assign n6149 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:48 */
  assign n6150 = n6148 ^ n6149;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:63 */
  assign n6151 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:58 */
  assign n6152 = n6150 ^ n6151;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:73 */
  assign n6153 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:68 */
  assign n6154 = n6152 ^ n6153;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:83 */
  assign n6155 = n5747[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:78 */
  assign n6156 = n6154 ^ n6155;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:92 */
  assign n6157 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:87 */
  assign n6158 = n6156 ^ n6157;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:101 */
  assign n6159 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:96 */
  assign n6160 = n6158 ^ n6159;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:110 */
  assign n6161 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:60:105 */
  assign n6162 = n6160 ^ n6161;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:33 */
  assign n6163 = crc_reg[19]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:43 */
  assign n6164 = crc_reg[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:38 */
  assign n6165 = n6163 ^ n6164;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:53 */
  assign n6166 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:48 */
  assign n6167 = n6165 ^ n6166;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:63 */
  assign n6168 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:58 */
  assign n6169 = n6167 ^ n6168;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:73 */
  assign n6170 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:68 */
  assign n6171 = n6169 ^ n6170;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:83 */
  assign n6172 = n5747[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:78 */
  assign n6173 = n6171 ^ n6172;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:92 */
  assign n6174 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:87 */
  assign n6175 = n6173 ^ n6174;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:101 */
  assign n6176 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:96 */
  assign n6177 = n6175 ^ n6176;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:110 */
  assign n6178 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:61:105 */
  assign n6179 = n6177 ^ n6178;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:33 */
  assign n6180 = crc_reg[20]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:43 */
  assign n6181 = crc_reg[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:38 */
  assign n6182 = n6180 ^ n6181;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:53 */
  assign n6183 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:48 */
  assign n6184 = n6182 ^ n6183;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:63 */
  assign n6185 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:58 */
  assign n6186 = n6184 ^ n6185;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:73 */
  assign n6187 = n5747[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:68 */
  assign n6188 = n6186 ^ n6187;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:82 */
  assign n6189 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:77 */
  assign n6190 = n6188 ^ n6189;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:91 */
  assign n6191 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:62:86 */
  assign n6192 = n6190 ^ n6191;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:33 */
  assign n6193 = crc_reg[21]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:43 */
  assign n6194 = crc_reg[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:38 */
  assign n6195 = n6193 ^ n6194;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:53 */
  assign n6196 = crc_reg[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:48 */
  assign n6197 = n6195 ^ n6196;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:63 */
  assign n6198 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:58 */
  assign n6199 = n6197 ^ n6198;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:73 */
  assign n6200 = n5747[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:68 */
  assign n6201 = n6199 ^ n6200;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:82 */
  assign n6202 = n5747[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:77 */
  assign n6203 = n6201 ^ n6202;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:91 */
  assign n6204 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:63:86 */
  assign n6205 = n6203 ^ n6204;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:33 */
  assign n6206 = crc_reg[22]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:43 */
  assign n6207 = crc_reg[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:38 */
  assign n6208 = n6206 ^ n6207;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:53 */
  assign n6209 = crc_reg[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:48 */
  assign n6210 = n6208 ^ n6209;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:63 */
  assign n6211 = n5747[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:58 */
  assign n6212 = n6210 ^ n6211;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:72 */
  assign n6213 = n5747[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:64:67 */
  assign n6214 = n6212 ^ n6213;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:65:33 */
  assign n6215 = crc_reg[23]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:65:43 */
  assign n6216 = crc_reg[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:65:38 */
  assign n6217 = n6215 ^ n6216;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:65:53 */
  assign n6218 = n5747[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:65:48 */
  assign n6219 = n6217 ^ n6218;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:27:13 */
  assign n6220 = {n6219, n6214, n6205, n6192, n6179, n6162, n6145, n6136, n6123, n6110, n6105, n6100, n6095, n6086, n6073, n6060, n6047, n6030, n6009, n5984, n5959, n5942, n5925, n5908, n5891, n5872, n5849, n5822, n5803, n5788, n5769, n5754};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:26:9 */
  assign n6232 = en ? n6220 : crc_reg;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/crc32.vhd:26:9 */
  always @(posedge clk or posedge rst)
    if (rst)
      n6233 <= 32'b11111111111111111111111111111111;
    else
      n6233 <= n6232;
endmodule
