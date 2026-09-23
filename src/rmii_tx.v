// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/rmii_tx.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module rmii_tx
  (input  clk_50m,
   input  rst,
   input  tx_start,
   input  [7:0] tx_data,
   output tx_ready,
   output tx_busy,
   output rmii_tx_en,
   output [1:0] rmii_txd);
  reg [2:0] state;
  reg [10:0] byte_cnt;
  reg [1:0] di_bit_cnt;
  wire [7:0] current_byte;
  reg crc_rst;
  reg crc_en;
  reg [7:0] crc_data;
  wire [31:0] crc_value;
  wire n3070;
  wire n3071;
  wire [31:0] u_crc_n3073;
  wire [2:0] n3080;
  wire [10:0] n3082;
  wire [1:0] n3084;
  wire [7:0] n3086;
  wire n3088;
  wire [31:0] n3089;
  wire n3091;
  wire [1:0] n3092;
  wire [31:0] n3093;
  wire n3095;
  wire [1:0] n3096;
  wire [31:0] n3097;
  wire n3099;
  wire [1:0] n3100;
  wire [31:0] n3101;
  wire n3103;
  wire [1:0] n3104;
  wire [1:0] n3105;
  wire [1:0] n3106;
  wire [1:0] n3107;
  wire [1:0] n3108;
  wire [31:0] n3109;
  wire n3111;
  wire [31:0] n3112;
  wire n3114;
  wire [31:0] n3115;
  wire [31:0] n3117;
  wire [10:0] n3118;
  wire [2:0] n3120;
  wire [10:0] n3121;
  wire [7:0] n3123;
  wire [31:0] n3124;
  wire [31:0] n3126;
  wire [1:0] n3127;
  wire n3128;
  wire [10:0] n3129;
  wire [1:0] n3131;
  wire n3132;
  wire n3134;
  wire [31:0] n3135;
  wire n3137;
  wire [1:0] n3138;
  wire [31:0] n3139;
  wire n3141;
  wire [1:0] n3142;
  wire [31:0] n3143;
  wire n3145;
  wire [1:0] n3146;
  wire [31:0] n3147;
  wire n3149;
  wire [1:0] n3150;
  wire [1:0] n3151;
  wire [1:0] n3152;
  wire [1:0] n3153;
  wire [1:0] n3154;
  wire [31:0] n3155;
  wire n3157;
  wire n3160;
  wire [31:0] n3161;
  wire n3163;
  wire [31:0] n3164;
  wire [31:0] n3166;
  wire [1:0] n3167;
  wire [2:0] n3169;
  wire [1:0] n3171;
  wire [7:0] n3172;
  wire n3175;
  wire [7:0] n3176;
  wire n3178;
  wire [31:0] n3179;
  wire n3181;
  wire [1:0] n3182;
  wire [31:0] n3183;
  wire n3185;
  wire [1:0] n3186;
  wire [31:0] n3187;
  wire n3189;
  wire [1:0] n3190;
  wire [31:0] n3191;
  wire n3193;
  wire [1:0] n3194;
  wire [1:0] n3195;
  wire [1:0] n3196;
  wire [1:0] n3197;
  wire [1:0] n3198;
  wire [31:0] n3199;
  wire n3201;
  wire n3204;
  wire [31:0] n3205;
  wire n3207;
  wire n3208;
  wire n3209;
  wire [1:0] n3210;
  wire n3211;
  wire [2:0] n3212;
  wire n3213;
  wire [3:0] n3214;
  wire n3215;
  wire [4:0] n3216;
  wire n3217;
  wire [5:0] n3218;
  wire n3219;
  wire [6:0] n3220;
  wire n3221;
  wire [7:0] n3222;
  wire [2:0] n3224;
  wire [10:0] n3226;
  wire [7:0] n3227;
  wire n3230;
  wire [7:0] n3231;
  wire [31:0] n3232;
  wire [31:0] n3234;
  wire [1:0] n3235;
  wire [2:0] n3236;
  wire [10:0] n3237;
  wire [1:0] n3239;
  wire [7:0] n3240;
  wire n3242;
  wire n3243;
  wire n3245;
  wire [31:0] n3246;
  wire n3248;
  wire [1:0] n3249;
  wire [31:0] n3250;
  wire n3252;
  wire [1:0] n3253;
  wire [31:0] n3254;
  wire n3256;
  wire [1:0] n3257;
  wire [31:0] n3258;
  wire n3260;
  wire [1:0] n3261;
  wire [1:0] n3262;
  wire [1:0] n3263;
  wire [1:0] n3264;
  wire [1:0] n3265;
  wire [31:0] n3266;
  wire n3268;
  wire [31:0] n3269;
  wire n3271;
  wire [31:0] n3272;
  wire [31:0] n3274;
  wire [10:0] n3275;
  wire [31:0] n3276;
  wire n3278;
  wire n3279;
  wire n3280;
  wire [1:0] n3281;
  wire n3282;
  wire [2:0] n3283;
  wire n3284;
  wire [3:0] n3285;
  wire n3286;
  wire [4:0] n3287;
  wire n3288;
  wire [5:0] n3289;
  wire n3290;
  wire [6:0] n3291;
  wire n3292;
  wire [7:0] n3293;
  wire [31:0] n3294;
  wire n3296;
  wire n3297;
  wire n3298;
  wire [1:0] n3299;
  wire n3300;
  wire [2:0] n3301;
  wire n3302;
  wire [3:0] n3303;
  wire n3304;
  wire [4:0] n3305;
  wire n3306;
  wire [5:0] n3307;
  wire n3308;
  wire [6:0] n3309;
  wire n3310;
  wire [7:0] n3311;
  wire [31:0] n3312;
  wire n3314;
  wire n3315;
  wire n3316;
  wire [1:0] n3317;
  wire n3318;
  wire [2:0] n3319;
  wire n3320;
  wire [3:0] n3321;
  wire n3322;
  wire [4:0] n3323;
  wire n3324;
  wire [5:0] n3325;
  wire n3326;
  wire [6:0] n3327;
  wire n3328;
  wire [7:0] n3329;
  wire [7:0] n3330;
  wire [7:0] n3331;
  wire [7:0] n3332;
  wire [2:0] n3334;
  wire [10:0] n3336;
  wire [7:0] n3337;
  wire [31:0] n3338;
  wire [31:0] n3340;
  wire [1:0] n3341;
  wire n3342;
  wire [10:0] n3343;
  wire [1:0] n3345;
  wire [7:0] n3346;
  wire n3348;
  wire [31:0] n3349;
  wire n3351;
  wire [31:0] n3352;
  wire [31:0] n3354;
  wire [10:0] n3355;
  wire [2:0] n3357;
  wire [10:0] n3358;
  wire n3360;
  wire [5:0] n3361;
  reg n3364;
  reg n3373;
  reg [1:0] n3377;
  reg [2:0] n3379;
  reg [10:0] n3381;
  reg [1:0] n3383;
  reg [7:0] n3385;
  reg n3389;
  reg n3393;
  reg [7:0] n3396;
  reg n3426;
  reg n3427;
  reg [1:0] n3428;
  reg [2:0] n3429;
  reg [10:0] n3430;
  reg [1:0] n3431;
  wire n3432;
  wire [7:0] n3433;
  reg [7:0] n3434;
  reg n3435;
  reg n3436;
  wire n3437;
  wire [7:0] n3438;
  reg [7:0] n3439;
  assign tx_ready = n3426; //(module output)
  assign tx_busy = n3071; //(module output)
  assign rmii_tx_en = n3427; //(module output)
  assign rmii_txd = n3428; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:43:12 */
  always @*
    state = n3429; // (isignal)
  initial
    state = 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:45:12 */
  always @*
    byte_cnt = n3430; // (isignal)
  initial
    byte_cnt = 11'b00000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:46:12 */
  always @*
    di_bit_cnt = n3431; // (isignal)
  initial
    di_bit_cnt = 2'b00;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:48:12 */
  assign current_byte = n3434; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:50:12 */
  always @*
    crc_rst = n3435; // (isignal)
  initial
    crc_rst = 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:51:12 */
  always @*
    crc_en = n3436; // (isignal)
  initial
    crc_en = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:52:12 */
  always @*
    crc_data = n3439; // (isignal)
  initial
    crc_data = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:53:12 */
  assign crc_value = u_crc_n3073; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:59:31 */
  assign n3070 = state == 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:59:20 */
  assign n3071 = n3070 ? 1'b0 : 1'b1;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:61:5 */
  crc32 u_crc (
    .clk(clk_50m),
    .rst(crc_rst),
    .en(crc_en),
    .data_in(crc_data),
    .crc_out(u_crc_n3073));
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:94:21 */
  assign n3080 = tx_start ? 3'b001 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:94:21 */
  assign n3082 = tx_start ? 11'b00000000000 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:94:21 */
  assign n3084 = tx_start ? 2'b00 : di_bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:94:21 */
  assign n3086 = tx_start ? 8'b01010101 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:90:17 */
  assign n3088 = state == 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:105:35 */
  assign n3089 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:105:35 */
  assign n3091 = n3089 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:105:68 */
  assign n3092 = current_byte[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:106:38 */
  assign n3093 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:106:38 */
  assign n3095 = n3093 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:106:71 */
  assign n3096 = current_byte[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:107:38 */
  assign n3097 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:107:38 */
  assign n3099 = n3097 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:107:71 */
  assign n3100 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:108:38 */
  assign n3101 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:108:38 */
  assign n3103 = n3101 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:108:71 */
  assign n3104 = current_byte[7:6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:108:21 */
  assign n3105 = n3103 ? n3104 : n3428;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:107:21 */
  assign n3106 = n3099 ? n3100 : n3105;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:106:21 */
  assign n3107 = n3095 ? n3096 : n3106;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:105:21 */
  assign n3108 = n3091 ? n3092 : n3107;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:35 */
  assign n3109 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:35 */
  assign n3111 = n3109 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:113:37 */
  assign n3112 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:113:37 */
  assign n3114 = n3112 == 32'b00000000000000000000000000000110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:118:50 */
  assign n3115 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:118:50 */
  assign n3117 = n3115 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:118:41 */
  assign n3118 = n3117[10:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3120 = n3128 ? 3'b010 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:113:25 */
  assign n3121 = n3114 ? byte_cnt : n3118;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3123 = n3132 ? 8'b11010101 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:121:50 */
  assign n3124 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:121:50 */
  assign n3126 = n3124 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:121:39 */
  assign n3127 = n3126[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3128 = n3114 & n3111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3129 = n3111 ? n3121 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3131 = n3111 ? 2'b00 : n3127;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:111:21 */
  assign n3132 = n3114 & n3111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:101:17 */
  assign n3134 = state == 3'b001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:127:35 */
  assign n3135 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:127:35 */
  assign n3137 = n3135 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:127:68 */
  assign n3138 = current_byte[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:128:38 */
  assign n3139 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:128:38 */
  assign n3141 = n3139 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:128:71 */
  assign n3142 = current_byte[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:129:38 */
  assign n3143 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:129:38 */
  assign n3145 = n3143 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:129:71 */
  assign n3146 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:130:38 */
  assign n3147 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:130:38 */
  assign n3149 = n3147 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:130:71 */
  assign n3150 = current_byte[7:6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:130:21 */
  assign n3151 = n3149 ? n3150 : n3428;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:129:21 */
  assign n3152 = n3145 ? n3146 : n3151;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:128:21 */
  assign n3153 = n3141 ? n3142 : n3152;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:127:21 */
  assign n3154 = n3137 ? n3138 : n3153;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:134:35 */
  assign n3155 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:134:35 */
  assign n3157 = n3155 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:134:21 */
  assign n3160 = n3157 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:35 */
  assign n3161 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:35 */
  assign n3163 = n3161 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:147:50 */
  assign n3164 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:147:50 */
  assign n3166 = n3164 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:147:39 */
  assign n3167 = n3166[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:21 */
  assign n3169 = n3163 ? 3'b011 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:21 */
  assign n3171 = n3163 ? 2'b00 : n3167;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:21 */
  assign n3172 = n3163 ? tx_data : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:21 */
  assign n3175 = n3163 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:138:21 */
  assign n3176 = n3163 ? tx_data : crc_data;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:124:17 */
  assign n3178 = state == 3'b010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:153:35 */
  assign n3179 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:153:35 */
  assign n3181 = n3179 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:153:68 */
  assign n3182 = current_byte[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:154:38 */
  assign n3183 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:154:38 */
  assign n3185 = n3183 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:154:71 */
  assign n3186 = current_byte[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:155:38 */
  assign n3187 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:155:38 */
  assign n3189 = n3187 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:155:71 */
  assign n3190 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:156:38 */
  assign n3191 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:156:38 */
  assign n3193 = n3191 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:156:71 */
  assign n3194 = current_byte[7:6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:156:21 */
  assign n3195 = n3193 ? n3194 : n3428;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:155:21 */
  assign n3196 = n3189 ? n3190 : n3195;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:154:21 */
  assign n3197 = n3185 ? n3186 : n3196;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:153:21 */
  assign n3198 = n3181 ? n3182 : n3197;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:160:35 */
  assign n3199 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:160:35 */
  assign n3201 = n3199 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:160:21 */
  assign n3204 = n3201 ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:35 */
  assign n3205 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:35 */
  assign n3207 = n3205 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:54 */
  assign n3208 = crc_value[24]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:70 */
  assign n3209 = crc_value[25]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:59 */
  assign n3210 = {n3208, n3209};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:86 */
  assign n3211 = crc_value[26]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:75 */
  assign n3212 = {n3210, n3211};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:102 */
  assign n3213 = crc_value[27]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:91 */
  assign n3214 = {n3212, n3213};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:54 */
  assign n3215 = crc_value[28]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:179:107 */
  assign n3216 = {n3214, n3215};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:70 */
  assign n3217 = crc_value[29]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:59 */
  assign n3218 = {n3216, n3217};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:86 */
  assign n3219 = crc_value[30]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:75 */
  assign n3220 = {n3218, n3219};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:102 */
  assign n3221 = crc_value[31]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:180:91 */
  assign n3222 = {n3220, n3221};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:167:25 */
  assign n3224 = tx_start ? state : 3'b100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:167:25 */
  assign n3226 = tx_start ? byte_cnt : 11'b00000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:167:25 */
  assign n3227 = tx_start ? tx_data : n3222;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:167:25 */
  assign n3230 = tx_start ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3231 = n3243 ? tx_data : crc_data;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:183:50 */
  assign n3232 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:183:50 */
  assign n3234 = n3232 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:183:39 */
  assign n3235 = n3234[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3236 = n3207 ? n3224 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3237 = n3207 ? n3226 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3239 = n3207 ? 2'b00 : n3235;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3240 = n3207 ? n3227 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3242 = n3207 ? n3230 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:164:21 */
  assign n3243 = tx_start & n3207;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:150:17 */
  assign n3245 = state == 3'b011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:189:35 */
  assign n3246 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:189:35 */
  assign n3248 = n3246 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:189:68 */
  assign n3249 = current_byte[1:0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:190:38 */
  assign n3250 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:190:38 */
  assign n3252 = n3250 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:190:71 */
  assign n3253 = current_byte[3:2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:191:38 */
  assign n3254 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:191:38 */
  assign n3256 = n3254 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:191:71 */
  assign n3257 = current_byte[5:4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:192:38 */
  assign n3258 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:192:38 */
  assign n3260 = n3258 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:192:71 */
  assign n3261 = current_byte[7:6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:192:21 */
  assign n3262 = n3260 ? n3261 : n3428;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:191:21 */
  assign n3263 = n3256 ? n3257 : n3262;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:190:21 */
  assign n3264 = n3252 ? n3253 : n3263;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:189:21 */
  assign n3265 = n3248 ? n3249 : n3264;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:35 */
  assign n3266 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:35 */
  assign n3268 = n3266 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:197:37 */
  assign n3269 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:197:37 */
  assign n3271 = n3269 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:202:50 */
  assign n3272 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:202:50 */
  assign n3274 = n3272 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:202:41 */
  assign n3275 = n3274[10:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:204:41 */
  assign n3276 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:204:41 */
  assign n3278 = n3276 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:58 */
  assign n3279 = crc_value[16]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:74 */
  assign n3280 = crc_value[17]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:63 */
  assign n3281 = {n3279, n3280};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:90 */
  assign n3282 = crc_value[18]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:79 */
  assign n3283 = {n3281, n3282};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:106 */
  assign n3284 = crc_value[19]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:95 */
  assign n3285 = {n3283, n3284};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:58 */
  assign n3286 = crc_value[20]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:205:111 */
  assign n3287 = {n3285, n3286};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:74 */
  assign n3288 = crc_value[21]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:63 */
  assign n3289 = {n3287, n3288};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:90 */
  assign n3290 = crc_value[22]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:79 */
  assign n3291 = {n3289, n3290};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:106 */
  assign n3292 = crc_value[23]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:206:95 */
  assign n3293 = {n3291, n3292};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:207:44 */
  assign n3294 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:207:44 */
  assign n3296 = n3294 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:58 */
  assign n3297 = crc_value[8]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:73 */
  assign n3298 = crc_value[9]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:62 */
  assign n3299 = {n3297, n3298};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:88 */
  assign n3300 = crc_value[10]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:77 */
  assign n3301 = {n3299, n3300};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:104 */
  assign n3302 = crc_value[11]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:93 */
  assign n3303 = {n3301, n3302};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:58 */
  assign n3304 = crc_value[12]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:208:109 */
  assign n3305 = {n3303, n3304};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:74 */
  assign n3306 = crc_value[13]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:63 */
  assign n3307 = {n3305, n3306};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:90 */
  assign n3308 = crc_value[14]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:79 */
  assign n3309 = {n3307, n3308};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:106 */
  assign n3310 = crc_value[15]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:209:95 */
  assign n3311 = {n3309, n3310};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:210:44 */
  assign n3312 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:210:44 */
  assign n3314 = n3312 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:58 */
  assign n3315 = crc_value[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:73 */
  assign n3316 = crc_value[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:62 */
  assign n3317 = {n3315, n3316};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:88 */
  assign n3318 = crc_value[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:77 */
  assign n3319 = {n3317, n3318};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:103 */
  assign n3320 = crc_value[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:92 */
  assign n3321 = {n3319, n3320};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:58 */
  assign n3322 = crc_value[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:211:107 */
  assign n3323 = {n3321, n3322};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:73 */
  assign n3324 = crc_value[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:62 */
  assign n3325 = {n3323, n3324};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:88 */
  assign n3326 = crc_value[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:77 */
  assign n3327 = {n3325, n3326};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:103 */
  assign n3328 = crc_value[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:212:92 */
  assign n3329 = {n3327, n3328};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:210:29 */
  assign n3330 = n3314 ? n3329 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:207:29 */
  assign n3331 = n3296 ? n3311 : n3330;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:204:29 */
  assign n3332 = n3278 ? n3293 : n3331;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:21 */
  assign n3334 = n3342 ? 3'b101 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:197:25 */
  assign n3336 = n3271 ? 11'b00000000000 : n3275;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:197:25 */
  assign n3337 = n3271 ? current_byte : n3332;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:216:50 */
  assign n3338 = {30'b0, di_bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:216:50 */
  assign n3340 = n3338 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:216:39 */
  assign n3341 = n3340[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:21 */
  assign n3342 = n3271 & n3268;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:21 */
  assign n3343 = n3268 ? n3336 : byte_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:21 */
  assign n3345 = n3268 ? 2'b00 : n3341;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:195:21 */
  assign n3346 = n3268 ? n3337 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:186:17 */
  assign n3348 = state == 3'b100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:224:33 */
  assign n3349 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:224:33 */
  assign n3351 = n3349 == 32'b00000000000000000000000000110000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:227:46 */
  assign n3352 = {21'b0, byte_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:227:46 */
  assign n3354 = n3352 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:227:37 */
  assign n3355 = n3354[10:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:224:21 */
  assign n3357 = n3351 ? 3'b000 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:224:21 */
  assign n3358 = n3351 ? byte_cnt : n3355;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:219:17 */
  assign n3360 = state == 3'b101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  assign n3361 = {n3360, n3348, n3245, n3178, n3134, n3088};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3364 = 1'b0;
      6'b010000: n3364 = 1'b0;
      6'b001000: n3364 = n3204;
      6'b000100: n3364 = n3160;
      6'b000010: n3364 = 1'b0;
      6'b000001: n3364 = 1'b0;
      default: n3364 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3373 = 1'b0;
      6'b010000: n3373 = 1'b1;
      6'b001000: n3373 = 1'b1;
      6'b000100: n3373 = 1'b1;
      6'b000010: n3373 = 1'b1;
      6'b000001: n3373 = 1'b0;
      default: n3373 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3377 = 2'b00;
      6'b010000: n3377 = n3265;
      6'b001000: n3377 = n3198;
      6'b000100: n3377 = n3154;
      6'b000010: n3377 = n3108;
      6'b000001: n3377 = 2'b00;
      default: n3377 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3379 = n3357;
      6'b010000: n3379 = n3334;
      6'b001000: n3379 = n3236;
      6'b000100: n3379 = n3169;
      6'b000010: n3379 = n3120;
      6'b000001: n3379 = n3080;
      default: n3379 = 3'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3381 = n3358;
      6'b010000: n3381 = n3343;
      6'b001000: n3381 = n3237;
      6'b000100: n3381 = byte_cnt;
      6'b000010: n3381 = n3129;
      6'b000001: n3381 = n3082;
      default: n3381 = 11'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3383 = di_bit_cnt;
      6'b010000: n3383 = n3345;
      6'b001000: n3383 = n3239;
      6'b000100: n3383 = n3171;
      6'b000010: n3383 = n3131;
      6'b000001: n3383 = n3084;
      default: n3383 = 2'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3385 = current_byte;
      6'b010000: n3385 = n3346;
      6'b001000: n3385 = n3240;
      6'b000100: n3385 = n3172;
      6'b000010: n3385 = n3123;
      6'b000001: n3385 = n3086;
      default: n3385 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3389 = 1'b0;
      6'b010000: n3389 = 1'b0;
      6'b001000: n3389 = 1'b0;
      6'b000100: n3389 = 1'b0;
      6'b000010: n3389 = 1'b0;
      6'b000001: n3389 = 1'b1;
      default: n3389 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3393 = 1'b0;
      6'b010000: n3393 = 1'b0;
      6'b001000: n3393 = n3242;
      6'b000100: n3393 = n3175;
      6'b000010: n3393 = 1'b0;
      6'b000001: n3393 = 1'b0;
      default: n3393 = 1'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:88:13 */
  always @*
    case (n3361)
      6'b100000: n3396 = crc_data;
      6'b010000: n3396 = crc_data;
      6'b001000: n3396 = n3231;
      6'b000100: n3396 = n3176;
      6'b000010: n3396 = crc_data;
      6'b000001: n3396 = crc_data;
      default: n3396 = 8'bX;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3426 <= 1'b0;
    else
      n3426 <= n3364;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3427 <= 1'b0;
    else
      n3427 <= n3373;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3428 <= 2'b00;
    else
      n3428 <= n3377;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3429 <= 3'b000;
    else
      n3429 <= n3379;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3430 <= 11'b00000000000;
    else
      n3430 <= n3381;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3431 <= 2'b00;
    else
      n3431 <= n3383;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:48:12 */
  assign n3432 = ~rst;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  assign n3433 = n3432 ? n3385 : current_byte;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m)
    n3434 <= n3433;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3435 <= 1'b1;
    else
      n3435 <= n3389;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m or posedge rst)
    if (rst)
      n3436 <= 1'b0;
    else
      n3436 <= n3393;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:52:12 */
  assign n3437 = ~rst;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  assign n3438 = n3437 ? n3396 : crc_data;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/rmii_tx.vhd:81:9 */
  always @(posedge clk_50m)
    n3439 <= n3438;
  initial
    n3439 = 8'b00000000;
endmodule
