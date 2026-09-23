// DO NOT EDIT. Regenerate with synth/convert_vhdl.sh; see notes/conversion.md.
// Generated from legacy/rtl/i2c_master.vhd,
// by `ghdl --synth --std=08 --latches --out=verilog top_system`, which converts
// the whole hierarchy in one pass so the top's generic values are applied.
// Source: UATR_TDM commit c1fc108c68fad7cef11b884a3e889c5dd4281cc6, vendored in legacy/rtl.
// GHDL 6.0.0 (mcode). Module names are the VHDL entity names; GHDL's
// architecture/generic suffixes are stripped.

module i2c_master
  (input  clk,
   input  rst_n,
   input  ena,
   input  rd_mode,
   input  probe_mode,
   input  [6:0] addr,
   input  [7:0] reg_addr,
   input  [7:0] data_wr,
   output [7:0] data_rd,
   output busy,
   output ack_error,
   output addr_nack,
   output bus_stuck,
   output scl_stuck,
   output sda_stuck,
   output scl_drv_ok,
   output sda_drv_ok,
   output selftest_done,
   output recovered,
   output scl_o,
   output sda_o,
   input  scl_i,
   input  sda_i);
  wire [4:0] state;
  wire sda_int;
  wire scl_int;
  wire [7:0] clk_cnt;
  wire [1:0] phase;
  reg [2:0] bit_cnt;
  wire [7:0] tx_shift;
  reg [7:0] rx_shift;
  reg is_read;
  reg ena_latched;
  reg scl_drv;
  reg sda_drv;
  reg st_done;
  reg is_probe;
  reg [3:0] rec_cnt;
  reg [3:0] rec_tries;
  reg recovered_i;
  reg anack;
  reg nack_flag;
  reg stuck_flag;
  reg scl_low;
  reg sda_low;
  reg [7:0] scl_low_cnt;
  reg [7:0] sda_low_cnt;
  wire n3473;
  wire n3476;
  wire [31:0] n3477;
  wire n3479;
  wire [31:0] n3480;
  wire [31:0] n3482;
  wire [7:0] n3483;
  wire [31:0] n3484;
  wire n3486;
  wire [31:0] n3487;
  wire [31:0] n3489;
  wire [1:0] n3490;
  wire [1:0] n3492;
  wire n3494;
  wire n3495;
  wire n3497;
  wire n3499;
  wire n3500;
  wire n3502;
  wire n3504;
  wire n3506;
  wire n3507;
  wire n3508;
  wire [31:0] n3509;
  wire n3511;
  wire [31:0] n3512;
  wire [31:0] n3514;
  wire [7:0] n3515;
  wire n3517;
  wire [7:0] n3518;
  wire n3520;
  wire [7:0] n3522;
  wire n3523;
  wire [31:0] n3524;
  wire n3526;
  wire [31:0] n3527;
  wire [31:0] n3529;
  wire [7:0] n3530;
  wire n3532;
  wire [7:0] n3533;
  wire n3535;
  wire [7:0] n3537;
  wire n3538;
  wire n3539;
  wire n3540;
  wire n3541;
  wire [7:0] n3542;
  wire [7:0] n3543;
  wire n3544;
  wire n3545;
  wire n3546;
  wire [31:0] n3547;
  wire n3549;
  wire n3550;
  wire [31:0] n3551;
  wire [31:0] n3553;
  wire [3:0] n3554;
  wire [7:0] n3556;
  wire [7:0] n3558;
  wire n3559;
  wire n3562;
  wire [4:0] n3564;
  wire [7:0] n3565;
  wire n3566;
  wire n3568;
  wire n3569;
  wire n3571;
  wire n3573;
  wire [7:0] n3574;
  wire n3575;
  wire [4:0] n3577;
  wire [7:0] n3578;
  wire n3579;
  wire n3580;
  wire n3581;
  wire [3:0] n3583;
  wire [3:0] n3584;
  wire n3586;
  wire n3587;
  wire n3588;
  wire n3590;
  wire [31:0] n3591;
  wire n3593;
  wire [31:0] n3594;
  wire n3596;
  wire [31:0] n3597;
  wire n3599;
  wire [31:0] n3600;
  wire [31:0] n3602;
  wire [3:0] n3603;
  wire [4:0] n3605;
  wire [3:0] n3606;
  wire n3607;
  wire n3609;
  wire [3:0] n3610;
  wire [4:0] n3611;
  wire n3613;
  wire [3:0] n3614;
  wire n3616;
  wire [31:0] n3617;
  wire n3619;
  wire [31:0] n3620;
  wire n3622;
  wire [31:0] n3623;
  wire n3625;
  wire [31:0] n3626;
  wire n3628;
  wire [4:0] n3630;
  wire n3632;
  wire [2:0] n3634;
  wire [4:0] n3635;
  wire n3636;
  wire [2:0] n3637;
  wire [4:0] n3638;
  wire n3640;
  wire n3641;
  wire [2:0] n3642;
  wire [4:0] n3643;
  wire n3645;
  wire n3647;
  wire [2:0] n3648;
  wire n3650;
  wire [31:0] n3651;
  wire n3653;
  wire [31:0] n3656;
  wire n3658;
  wire [31:0] n3659;
  wire n3661;
  wire [31:0] n3662;
  wire n3664;
  wire [31:0] n3665;
  wire [31:0] n3667;
  wire [2:0] n3668;
  wire [4:0] n3670;
  wire [2:0] n3671;
  wire n3672;
  wire n3674;
  wire [2:0] n3675;
  wire [4:0] n3676;
  wire n3678;
  wire [2:0] n3679;
  wire [4:0] n3680;
  wire n3681;
  wire n3682;
  wire [2:0] n3683;
  wire n3685;
  wire [31:0] n3686;
  wire n3688;
  wire [31:0] n3689;
  wire n3691;
  wire [31:0] n3692;
  wire n3694;
  wire n3696;
  wire n3698;
  wire n3700;
  wire [31:0] n3701;
  wire n3703;
  wire [4:0] n3706;
  wire [2:0] n3708;
  wire [7:0] n3709;
  wire [4:0] n3710;
  wire n3712;
  wire [2:0] n3713;
  wire [7:0] n3714;
  wire [4:0] n3715;
  wire n3716;
  wire [2:0] n3717;
  wire [7:0] n3718;
  wire n3719;
  wire n3720;
  wire [4:0] n3721;
  wire n3723;
  wire [2:0] n3724;
  wire [7:0] n3725;
  wire n3726;
  wire n3727;
  wire [4:0] n3728;
  wire n3730;
  wire n3731;
  wire [2:0] n3732;
  wire [7:0] n3733;
  wire n3734;
  wire n3735;
  wire n3737;
  wire [31:0] n3738;
  wire n3740;
  wire [31:0] n3743;
  wire n3745;
  wire [31:0] n3746;
  wire n3748;
  wire [31:0] n3749;
  wire n3751;
  wire [31:0] n3752;
  wire [31:0] n3754;
  wire [2:0] n3755;
  wire [4:0] n3757;
  wire [2:0] n3758;
  wire n3759;
  wire n3761;
  wire [2:0] n3762;
  wire [4:0] n3763;
  wire n3765;
  wire [2:0] n3766;
  wire [4:0] n3767;
  wire n3768;
  wire n3769;
  wire [2:0] n3770;
  wire n3772;
  wire [31:0] n3773;
  wire n3775;
  wire [31:0] n3776;
  wire n3778;
  wire [31:0] n3779;
  wire n3781;
  wire n3783;
  wire n3785;
  wire [31:0] n3786;
  wire n3788;
  wire [4:0] n3791;
  wire [2:0] n3793;
  wire [7:0] n3794;
  wire [4:0] n3795;
  wire n3797;
  wire [2:0] n3798;
  wire [7:0] n3799;
  wire [4:0] n3800;
  wire n3801;
  wire [2:0] n3802;
  wire [7:0] n3803;
  wire n3804;
  wire [4:0] n3805;
  wire n3807;
  wire [2:0] n3808;
  wire [7:0] n3809;
  wire n3810;
  wire [4:0] n3811;
  wire n3813;
  wire n3814;
  wire [2:0] n3815;
  wire [7:0] n3816;
  wire n3817;
  wire n3819;
  wire [31:0] n3820;
  wire n3822;
  wire [31:0] n3825;
  wire n3827;
  wire [31:0] n3828;
  wire n3830;
  wire [31:0] n3831;
  wire n3833;
  wire [31:0] n3834;
  wire [31:0] n3836;
  wire [2:0] n3837;
  wire [4:0] n3839;
  wire [2:0] n3840;
  wire n3841;
  wire n3843;
  wire [2:0] n3844;
  wire [4:0] n3845;
  wire n3847;
  wire [2:0] n3848;
  wire [4:0] n3849;
  wire n3850;
  wire n3851;
  wire [2:0] n3852;
  wire n3854;
  wire [31:0] n3855;
  wire n3857;
  wire [31:0] n3858;
  wire n3860;
  wire [31:0] n3861;
  wire n3863;
  wire n3865;
  wire n3867;
  wire [31:0] n3868;
  wire n3870;
  wire [4:0] n3872;
  wire n3874;
  wire [4:0] n3875;
  wire n3876;
  wire n3877;
  wire [4:0] n3878;
  wire n3880;
  wire n3881;
  wire [4:0] n3882;
  wire n3884;
  wire n3885;
  wire n3886;
  wire n3888;
  wire [31:0] n3889;
  wire n3891;
  wire [31:0] n3892;
  wire n3894;
  wire [31:0] n3895;
  wire n3897;
  wire [31:0] n3898;
  wire n3900;
  wire [7:0] n3902;
  wire [4:0] n3904;
  wire n3906;
  wire [2:0] n3908;
  wire [7:0] n3909;
  wire [4:0] n3910;
  wire n3912;
  wire n3913;
  wire [2:0] n3914;
  wire [7:0] n3915;
  wire [4:0] n3916;
  wire n3917;
  wire n3918;
  wire [2:0] n3919;
  wire [7:0] n3920;
  wire [4:0] n3921;
  wire n3923;
  wire n3925;
  wire [2:0] n3926;
  wire [7:0] n3927;
  wire n3929;
  wire [31:0] n3930;
  wire n3932;
  wire [31:0] n3935;
  wire n3937;
  wire [31:0] n3938;
  wire n3940;
  wire [31:0] n3941;
  wire n3943;
  wire [31:0] n3944;
  wire [31:0] n3946;
  wire [2:0] n3947;
  wire [4:0] n3949;
  wire [2:0] n3950;
  wire n3951;
  wire n3953;
  wire [2:0] n3954;
  wire [4:0] n3955;
  wire n3957;
  wire [2:0] n3958;
  wire [4:0] n3959;
  wire n3960;
  wire n3961;
  wire [2:0] n3962;
  wire n3964;
  wire [31:0] n3965;
  wire n3967;
  wire [31:0] n3968;
  wire n3970;
  wire [31:0] n3971;
  wire n3973;
  wire n3975;
  wire n3977;
  wire [31:0] n3978;
  wire n3980;
  wire [4:0] n3982;
  wire n3984;
  wire [2:0] n3986;
  wire [4:0] n3987;
  wire n3988;
  wire [2:0] n3989;
  wire n3990;
  wire [4:0] n3991;
  wire n3993;
  wire [2:0] n3994;
  wire n3995;
  wire [4:0] n3996;
  wire n3998;
  wire n3999;
  wire [2:0] n4000;
  wire n4001;
  wire n4003;
  wire [31:0] n4004;
  wire n4006;
  wire [31:0] n4007;
  wire n4009;
  wire [31:0] n4010;
  wire n4012;
  wire n4013;
  wire [7:0] n4020;
  wire [31:0] n4021;
  wire n4023;
  wire [31:0] n4024;
  wire n4026;
  wire [31:0] n4027;
  wire [31:0] n4029;
  wire [2:0] n4030;
  wire [4:0] n4032;
  wire [2:0] n4033;
  wire n4034;
  wire n4036;
  wire [2:0] n4037;
  wire [4:0] n4038;
  wire n4039;
  wire [2:0] n4040;
  wire [7:0] n4041;
  wire [4:0] n4042;
  wire n4044;
  wire [2:0] n4045;
  wire [7:0] n4046;
  wire [4:0] n4047;
  wire n4049;
  wire n4050;
  wire [2:0] n4051;
  wire [7:0] n4052;
  wire n4054;
  wire [31:0] n4055;
  wire n4057;
  wire [31:0] n4058;
  wire n4060;
  wire [31:0] n4061;
  wire n4063;
  wire [7:0] n4064;
  wire [4:0] n4066;
  wire n4068;
  wire [7:0] n4069;
  wire [4:0] n4070;
  wire n4072;
  wire [7:0] n4073;
  wire [4:0] n4074;
  wire n4076;
  wire n4077;
  wire n4079;
  wire [31:0] n4080;
  wire n4082;
  wire [31:0] n4083;
  wire n4085;
  wire [31:0] n4086;
  wire n4088;
  wire [31:0] n4089;
  wire n4091;
  wire n4093;
  wire [4:0] n4095;
  wire n4097;
  wire n4098;
  wire [4:0] n4099;
  wire n4100;
  wire n4101;
  wire [4:0] n4102;
  wire n4103;
  wire n4105;
  wire n4106;
  wire [4:0] n4107;
  wire n4109;
  wire n4110;
  wire n4112;
  wire [18:0] n4113;
  reg [7:0] n4114;
  reg n4115;
  reg [4:0] n4121;
  reg n4127;
  reg n4131;
  reg [1:0] n4133;
  reg [2:0] n4134;
  reg [7:0] n4135;
  reg [7:0] n4136;
  reg n4137;
  reg n4138;
  reg n4139;
  reg n4140;
  reg n4142;
  reg n4143;
  reg [3:0] n4145;
  reg [3:0] n4146;
  reg n4147;
  reg n4148;
  reg n4149;
  reg n4150;
  reg n4151;
  reg n4152;
  reg [7:0] n4153;
  reg [7:0] n4154;
  wire [7:0] n4155;
  wire n4156;
  wire [4:0] n4157;
  wire n4158;
  wire n4159;
  wire [7:0] n4161;
  wire [1:0] n4162;
  wire [2:0] n4163;
  wire [7:0] n4164;
  wire [7:0] n4165;
  wire n4166;
  wire n4167;
  wire n4168;
  wire n4169;
  wire n4170;
  wire n4171;
  wire [3:0] n4172;
  wire [3:0] n4173;
  wire n4174;
  wire n4175;
  wire n4176;
  wire n4177;
  wire n4178;
  wire n4179;
  wire [7:0] n4180;
  wire [7:0] n4181;
  reg [7:0] n4259;
  reg n4260;
  reg [4:0] n4261;
  reg n4262;
  reg n4263;
  reg [7:0] n4264;
  reg [1:0] n4265;
  reg [2:0] n4266;
  reg [7:0] n4267;
  reg [7:0] n4268;
  reg n4269;
  reg n4270;
  reg n4271;
  reg n4272;
  reg n4273;
  wire n4274;
  wire n4275;
  reg n4276;
  reg [3:0] n4277;
  reg [3:0] n4278;
  reg n4279;
  wire n4280;
  wire n4281;
  reg n4282;
  reg n4283;
  reg n4284;
  reg n4285;
  reg n4286;
  reg [7:0] n4287;
  reg [7:0] n4288;
  wire n4289;
  wire n4290;
  wire n4291;
  wire n4292;
  wire n4293;
  wire n4294;
  wire n4295;
  wire n4296;
  wire n4297;
  wire n4298;
  wire n4299;
  wire n4300;
  wire n4301;
  wire n4302;
  wire n4303;
  wire n4304;
  wire n4305;
  wire n4306;
  wire n4307;
  wire n4308;
  wire n4309;
  wire n4310;
  wire n4311;
  wire n4312;
  wire n4313;
  wire n4314;
  wire n4315;
  wire n4316;
  wire n4317;
  wire n4318;
  wire n4319;
  wire n4320;
  wire n4321;
  wire n4322;
  wire n4323;
  wire n4324;
  wire n4325;
  wire n4326;
  wire [7:0] n4327;
  wire n4328;
  wire n4329;
  wire n4330;
  wire n4331;
  wire n4332;
  wire n4333;
  wire n4334;
  wire n4335;
  wire n4336;
  wire n4337;
  wire n4338;
  wire n4339;
  wire n4340;
  wire n4341;
  wire n4342;
  wire n4343;
  wire n4344;
  wire n4345;
  wire n4346;
  wire n4347;
  wire n4348;
  wire n4349;
  wire n4350;
  wire n4351;
  wire n4352;
  wire n4353;
  wire n4354;
  wire n4355;
  wire n4356;
  wire n4357;
  wire n4358;
  wire n4359;
  wire n4360;
  wire n4361;
  wire [7:0] n4362;
  assign data_rd = n4259; //(module output)
  assign busy = n4260; //(module output)
  assign ack_error = nack_flag; //(module output)
  assign addr_nack = anack; //(module output)
  assign bus_stuck = stuck_flag; //(module output)
  assign scl_stuck = scl_low; //(module output)
  assign sda_stuck = sda_low; //(module output)
  assign scl_drv_ok = scl_drv; //(module output)
  assign sda_drv_ok = sda_drv; //(module output)
  assign selftest_done = st_done; //(module output)
  assign recovered = recovered_i; //(module output)
  assign scl_o = scl_int; //(module output)
  assign sda_o = sda_int; //(module output)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:79:12 */
  assign state = n4261; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:82:12 */
  assign sda_int = n4262; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:83:12 */
  assign scl_int = n4263; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:86:12 */
  assign clk_cnt = n4264; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:87:12 */
  assign phase = n4265; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:88:12 */
  always @*
    bit_cnt = n4266; // (isignal)
  initial
    bit_cnt = 3'b000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:90:12 */
  assign tx_shift = n4267; // (signal)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:91:12 */
  always @*
    rx_shift = n4268; // (isignal)
  initial
    rx_shift = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:92:12 */
  always @*
    is_read = n4269; // (isignal)
  initial
    is_read = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:98:12 */
  always @*
    ena_latched = n4270; // (isignal)
  initial
    ena_latched = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:99:12 */
  always @*
    scl_drv = n4271; // (isignal)
  initial
    scl_drv = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:99:21 */
  always @*
    sda_drv = n4272; // (isignal)
  initial
    sda_drv = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:99:30 */
  always @*
    st_done = n4273; // (isignal)
  initial
    st_done = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:100:12 */
  always @*
    is_probe = n4276; // (isignal)
  initial
    is_probe = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:104:12 */
  always @*
    rec_cnt = n4277; // (isignal)
  initial
    rec_cnt = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:105:12 */
  always @*
    rec_tries = n4278; // (isignal)
  initial
    rec_tries = 4'b0000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:106:12 */
  always @*
    recovered_i = n4279; // (isignal)
  initial
    recovered_i = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:107:12 */
  always @*
    anack = n4282; // (isignal)
  initial
    anack = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:110:12 */
  always @*
    nack_flag = n4283; // (isignal)
  initial
    nack_flag = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:112:12 */
  always @*
    stuck_flag = n4284; // (isignal)
  initial
    stuck_flag = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:113:12 */
  always @*
    scl_low = n4285; // (isignal)
  initial
    scl_low = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:114:12 */
  always @*
    sda_low = n4286; // (isignal)
  initial
    sda_low = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:121:12 */
  always @*
    scl_low_cnt = n4287; // (isignal)
  initial
    scl_low_cnt = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:122:12 */
  always @*
    sda_low_cnt = n4288; // (isignal)
  initial
    sda_low_cnt = 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:141:18 */
  assign n3473 = ~rst_n;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:170:13 */
  assign n3476 = ena ? 1'b1 : ena_latched;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:24 */
  assign n3477 = {24'b0, clk_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:24 */
  assign n3479 = $signed(n3477) < $signed(32'b00000000000000000000000011111010);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:175:36 */
  assign n3480 = {24'b0, clk_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:175:36 */
  assign n3482 = n3480 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:175:28 */
  assign n3483 = n3482[7:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:179:26 */
  assign n3484 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:179:26 */
  assign n3486 = n3484 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:182:36 */
  assign n3487 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:182:36 */
  assign n3489 = n3487 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:182:30 */
  assign n3490 = n3489[1:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:179:17 */
  assign n3492 = n3486 ? 2'b00 : n3490;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:188:21 */
  assign n3494 = state == 5'b00000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:196:34 */
  assign n3495 = ~scl_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:196:25 */
  assign n3497 = n3495 ? 1'b1 : scl_drv;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:193:21 */
  assign n3499 = state == 5'b00001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:204:34 */
  assign n3500 = ~sda_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:204:25 */
  assign n3502 = n3500 ? 1'b1 : sda_drv;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:203:21 */
  assign n3504 = state == 5'b00010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:210:21 */
  assign n3506 = state == 5'b00011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:42 */
  assign n3507 = scl_int & sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:232:38 */
  assign n3508 = ~sda_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:233:48 */
  assign n3509 = {24'b0, sda_low_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:233:48 */
  assign n3511 = n3509 == 32'b00000000000000000000000011001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:236:64 */
  assign n3512 = {24'b0, sda_low_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:236:64 */
  assign n3514 = n3512 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:236:52 */
  assign n3515 = n3514[7:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:233:33 */
  assign n3517 = n3511 ? 1'b1 : sda_low;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:233:33 */
  assign n3518 = n3511 ? sda_low_cnt : n3515;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:232:29 */
  assign n3520 = n3508 ? n3517 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:232:29 */
  assign n3522 = n3508 ? n3518 : 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:243:38 */
  assign n3523 = ~scl_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:244:48 */
  assign n3524 = {24'b0, scl_low_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:244:48 */
  assign n3526 = n3524 == 32'b00000000000000000000000011001000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:247:64 */
  assign n3527 = {24'b0, scl_low_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:247:64 */
  assign n3529 = n3527 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:247:52 */
  assign n3530 = n3529[7:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:244:33 */
  assign n3532 = n3526 ? 1'b1 : scl_low;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:244:33 */
  assign n3533 = n3526 ? scl_low_cnt : n3530;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:243:29 */
  assign n3535 = n3523 ? n3532 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:243:29 */
  assign n3537 = n3523 ? n3533 : 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:254:51 */
  assign n3538 = scl_low | sda_low;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:25 */
  assign n3539 = n3507 ? n3538 : stuck_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:25 */
  assign n3540 = n3507 ? n3535 : scl_low;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:25 */
  assign n3541 = n3507 ? n3520 : sda_low;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:25 */
  assign n3542 = n3507 ? n3537 : scl_low_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:227:25 */
  assign n3543 = n3507 ? n3522 : sda_low_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:35 */
  assign n3544 = ~sda_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:50 */
  assign n3545 = ~scl_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:41 */
  assign n3546 = n3544 | n3545;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:71 */
  assign n3547 = {28'b0, rec_tries};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:71 */
  assign n3549 = $signed(n3547) < $signed(32'b00000000000000000000000000001111);
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:57 */
  assign n3550 = n3549 & n3546;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:267:54 */
  assign n3551 = {28'b0, rec_tries};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:267:54 */
  assign n3553 = n3551 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:267:44 */
  assign n3554 = n3553[3:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3556 = n3559 ? 8'b11111111 : n4259;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:288:47 */
  assign n3558 = {addr, 1'b0};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3559 = rd_mode & ena_latched;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3562 = ena_latched ? 1'b1 : 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3564 = ena_latched ? 5'b00110 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3565 = ena_latched ? n3558 : tx_shift;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3566 = ena_latched ? rd_mode : is_read;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3568 = ena_latched ? 1'b0 : n3476;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3569 = ena_latched ? probe_mode : is_probe;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3571 = ena_latched ? 1'b0 : anack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:271:25 */
  assign n3573 = ena_latched ? 1'b0 : nack_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3574 = n3550 ? n4259 : n3556;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3575 = n3550 ? n4260 : n3562;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3577 = n3550 ? 5'b00100 : n3564;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3578 = n3550 ? tx_shift : n3565;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3579 = n3550 ? is_read : n3566;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3580 = n3550 ? n3476 : n3568;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3581 = n3550 ? is_probe : n3569;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3583 = n3550 ? 4'b0000 : rec_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3584 = n3550 ? n3554 : rec_tries;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3586 = n3550 ? 1'b1 : recovered_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3587 = n3550 ? anack : n3571;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:257:25 */
  assign n3588 = n3550 ? nack_flag : n3573;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:220:21 */
  assign n3590 = state == 5'b00101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:296:34 */
  assign n3591 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:296:34 */
  assign n3593 = n3591 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:37 */
  assign n3594 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:37 */
  assign n3596 = n3594 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:300:40 */
  assign n3597 = {28'b0, rec_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:300:40 */
  assign n3599 = n3597 == 32'b00000000000000000000000000001001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:303:52 */
  assign n3600 = {28'b0, rec_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:303:52 */
  assign n3602 = n3600 + 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:303:44 */
  assign n3603 = n3602[3:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:25 */
  assign n3605 = n3607 ? 5'b10010 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:300:29 */
  assign n3606 = n3599 ? rec_cnt : n3603;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:25 */
  assign n3607 = n3599 & n3596;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:25 */
  assign n3609 = n3596 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:298:25 */
  assign n3610 = n3596 ? n3606 : rec_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:296:25 */
  assign n3611 = n3593 ? state : n3605;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:296:25 */
  assign n3613 = n3593 ? 1'b1 : n3609;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:296:25 */
  assign n3614 = n3593 ? rec_cnt : n3610;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:294:21 */
  assign n3616 = state == 5'b00100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:34 */
  assign n3617 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:34 */
  assign n3619 = n3617 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:37 */
  assign n3620 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:37 */
  assign n3622 = n3620 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:321:37 */
  assign n3623 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:321:37 */
  assign n3625 = n3623 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:323:37 */
  assign n3626 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:323:37 */
  assign n3628 = n3626 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:323:25 */
  assign n3630 = n3628 ? 5'b00111 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:323:25 */
  assign n3632 = n3628 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:323:25 */
  assign n3634 = n3628 ? 3'b111 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:321:25 */
  assign n3635 = n3625 ? state : n3630;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:321:25 */
  assign n3636 = n3625 ? scl_int : n3632;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:321:25 */
  assign n3637 = n3625 ? bit_cnt : n3634;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:25 */
  assign n3638 = n3622 ? state : n3635;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:25 */
  assign n3640 = n3622 ? 1'b0 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:25 */
  assign n3641 = n3622 ? scl_int : n3636;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:319:25 */
  assign n3642 = n3622 ? bit_cnt : n3637;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:25 */
  assign n3643 = n3619 ? state : n3638;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:25 */
  assign n3645 = n3619 ? 1'b1 : n3640;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:25 */
  assign n3647 = n3619 ? 1'b1 : n3641;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:316:25 */
  assign n3648 = n3619 ? bit_cnt : n3642;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:307:21 */
  assign n3650 = state == 5'b00110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:34 */
  assign n3651 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:34 */
  assign n3653 = n3651 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:332:37 */
  assign n3656 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:332:37 */
  assign n3658 = n3656 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:37 */
  assign n3659 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:37 */
  assign n3661 = n3659 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:336:40 */
  assign n3662 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:336:40 */
  assign n3664 = n3662 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:339:52 */
  assign n3665 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:339:52 */
  assign n3667 = n3665 - 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:339:44 */
  assign n3668 = n3667[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:25 */
  assign n3670 = n3672 ? 5'b01000 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:336:29 */
  assign n3671 = n3664 ? bit_cnt : n3668;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:25 */
  assign n3672 = n3664 & n3661;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:25 */
  assign n3674 = n3661 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:334:25 */
  assign n3675 = n3661 ? n3671 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:332:25 */
  assign n3676 = n3658 ? state : n3670;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:332:25 */
  assign n3678 = n3658 ? 1'b1 : n3674;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:332:25 */
  assign n3679 = n3658 ? bit_cnt : n3675;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:25 */
  assign n3680 = n3653 ? state : n3676;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:25 */
  assign n3681 = n3653 ? n4289 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:25 */
  assign n3682 = n3653 ? scl_int : n3678;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:330:25 */
  assign n3683 = n3653 ? bit_cnt : n3679;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:329:21 */
  assign n3685 = state == 5'b00111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:34 */
  assign n3686 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:34 */
  assign n3688 = n3686 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:37 */
  assign n3689 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:37 */
  assign n3691 = n3689 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:37 */
  assign n3692 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:37 */
  assign n3694 = n3692 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:349:38 */
  assign n3696 = sda_i != 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3698 = n3719 ? 1'b1 : anack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3700 = n3720 ? 1'b1 : nack_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:37 */
  assign n3701 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:37 */
  assign n3703 = n3701 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:355:29 */
  assign n3706 = is_probe ? 5'b10010 : 5'b01001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:355:29 */
  assign n3708 = is_probe ? bit_cnt : 3'b111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:355:29 */
  assign n3709 = is_probe ? tx_shift : reg_addr;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:25 */
  assign n3710 = n3703 ? n3706 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:25 */
  assign n3712 = n3703 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:25 */
  assign n3713 = n3703 ? n3708 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:353:25 */
  assign n3714 = n3703 ? n3709 : tx_shift;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3715 = n3694 ? state : n3710;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3716 = n3694 ? scl_int : n3712;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3717 = n3694 ? bit_cnt : n3713;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3718 = n3694 ? tx_shift : n3714;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3719 = n3696 & n3694;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:348:25 */
  assign n3720 = n3696 & n3694;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3721 = n3691 ? state : n3715;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3723 = n3691 ? 1'b1 : n3716;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3724 = n3691 ? bit_cnt : n3717;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3725 = n3691 ? tx_shift : n3718;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3726 = n3691 ? anack : n3698;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:346:25 */
  assign n3727 = n3691 ? nack_flag : n3700;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3728 = n3688 ? state : n3721;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3730 = n3688 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3731 = n3688 ? scl_int : n3723;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3732 = n3688 ? bit_cnt : n3724;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3733 = n3688 ? tx_shift : n3725;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3734 = n3688 ? anack : n3726;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:344:25 */
  assign n3735 = n3688 ? nack_flag : n3727;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:343:21 */
  assign n3737 = state == 5'b01000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:34 */
  assign n3738 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:34 */
  assign n3740 = n3738 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:367:37 */
  assign n3743 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:367:37 */
  assign n3745 = n3743 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:37 */
  assign n3746 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:37 */
  assign n3748 = n3746 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:371:40 */
  assign n3749 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:371:40 */
  assign n3751 = n3749 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:374:52 */
  assign n3752 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:374:52 */
  assign n3754 = n3752 - 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:374:44 */
  assign n3755 = n3754[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:25 */
  assign n3757 = n3759 ? 5'b01010 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:371:29 */
  assign n3758 = n3751 ? bit_cnt : n3755;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:25 */
  assign n3759 = n3751 & n3748;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:25 */
  assign n3761 = n3748 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:369:25 */
  assign n3762 = n3748 ? n3758 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:367:25 */
  assign n3763 = n3745 ? state : n3757;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:367:25 */
  assign n3765 = n3745 ? 1'b1 : n3761;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:367:25 */
  assign n3766 = n3745 ? bit_cnt : n3762;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:25 */
  assign n3767 = n3740 ? state : n3763;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:25 */
  assign n3768 = n3740 ? n4290 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:25 */
  assign n3769 = n3740 ? scl_int : n3765;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:365:25 */
  assign n3770 = n3740 ? bit_cnt : n3766;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:364:21 */
  assign n3772 = state == 5'b01001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:34 */
  assign n3773 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:34 */
  assign n3775 = n3773 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:37 */
  assign n3776 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:37 */
  assign n3778 = n3776 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:37 */
  assign n3779 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:37 */
  assign n3781 = n3779 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:384:38 */
  assign n3783 = sda_i != 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3785 = n3804 ? 1'b1 : nack_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:37 */
  assign n3786 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:37 */
  assign n3788 = n3786 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:389:29 */
  assign n3791 = is_read ? 5'b01101 : 5'b01011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:389:29 */
  assign n3793 = is_read ? bit_cnt : 3'b111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:389:29 */
  assign n3794 = is_read ? tx_shift : data_wr;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:25 */
  assign n3795 = n3788 ? n3791 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:25 */
  assign n3797 = n3788 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:25 */
  assign n3798 = n3788 ? n3793 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:387:25 */
  assign n3799 = n3788 ? n3794 : tx_shift;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3800 = n3781 ? state : n3795;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3801 = n3781 ? scl_int : n3797;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3802 = n3781 ? bit_cnt : n3798;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3803 = n3781 ? tx_shift : n3799;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:383:25 */
  assign n3804 = n3783 & n3781;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:25 */
  assign n3805 = n3778 ? state : n3800;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:25 */
  assign n3807 = n3778 ? 1'b1 : n3801;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:25 */
  assign n3808 = n3778 ? bit_cnt : n3802;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:25 */
  assign n3809 = n3778 ? tx_shift : n3803;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:381:25 */
  assign n3810 = n3778 ? nack_flag : n3785;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3811 = n3775 ? state : n3805;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3813 = n3775 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3814 = n3775 ? scl_int : n3807;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3815 = n3775 ? bit_cnt : n3808;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3816 = n3775 ? tx_shift : n3809;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:379:25 */
  assign n3817 = n3775 ? nack_flag : n3810;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:378:21 */
  assign n3819 = state == 5'b01010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:34 */
  assign n3820 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:34 */
  assign n3822 = n3820 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:402:37 */
  assign n3825 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:402:37 */
  assign n3827 = n3825 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:37 */
  assign n3828 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:37 */
  assign n3830 = n3828 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:406:40 */
  assign n3831 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:406:40 */
  assign n3833 = n3831 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:409:52 */
  assign n3834 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:409:52 */
  assign n3836 = n3834 - 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:409:44 */
  assign n3837 = n3836[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:25 */
  assign n3839 = n3841 ? 5'b01100 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:406:29 */
  assign n3840 = n3833 ? bit_cnt : n3837;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:25 */
  assign n3841 = n3833 & n3830;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:25 */
  assign n3843 = n3830 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:404:25 */
  assign n3844 = n3830 ? n3840 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:402:25 */
  assign n3845 = n3827 ? state : n3839;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:402:25 */
  assign n3847 = n3827 ? 1'b1 : n3843;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:402:25 */
  assign n3848 = n3827 ? bit_cnt : n3844;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:25 */
  assign n3849 = n3822 ? state : n3845;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:25 */
  assign n3850 = n3822 ? n4291 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:25 */
  assign n3851 = n3822 ? scl_int : n3847;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:400:25 */
  assign n3852 = n3822 ? bit_cnt : n3848;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:399:21 */
  assign n3854 = state == 5'b01011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:34 */
  assign n3855 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:34 */
  assign n3857 = n3855 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:416:37 */
  assign n3858 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:416:37 */
  assign n3860 = n3858 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:37 */
  assign n3861 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:37 */
  assign n3863 = n3861 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:419:38 */
  assign n3865 = sda_i != 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:25 */
  assign n3867 = n3877 ? 1'b1 : nack_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:422:37 */
  assign n3868 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:422:37 */
  assign n3870 = n3868 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:422:25 */
  assign n3872 = n3870 ? 5'b10010 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:422:25 */
  assign n3874 = n3870 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:25 */
  assign n3875 = n3863 ? state : n3872;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:25 */
  assign n3876 = n3863 ? scl_int : n3874;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:418:25 */
  assign n3877 = n3865 & n3863;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:416:25 */
  assign n3878 = n3860 ? state : n3875;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:416:25 */
  assign n3880 = n3860 ? 1'b1 : n3876;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:416:25 */
  assign n3881 = n3860 ? nack_flag : n3867;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:25 */
  assign n3882 = n3857 ? state : n3878;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:25 */
  assign n3884 = n3857 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:25 */
  assign n3885 = n3857 ? scl_int : n3880;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:414:25 */
  assign n3886 = n3857 ? nack_flag : n3881;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:413:21 */
  assign n3888 = state == 5'b01100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:34 */
  assign n3889 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:34 */
  assign n3891 = n3889 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:37 */
  assign n3892 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:37 */
  assign n3894 = n3892 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:37 */
  assign n3895 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:37 */
  assign n3897 = n3895 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:37 */
  assign n3898 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:37 */
  assign n3900 = n3898 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:441:46 */
  assign n3902 = {addr, 1'b1};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:25 */
  assign n3904 = n3900 ? 5'b01110 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:25 */
  assign n3906 = n3900 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:25 */
  assign n3908 = n3900 ? 3'b111 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:439:25 */
  assign n3909 = n3900 ? n3902 : tx_shift;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:25 */
  assign n3910 = n3897 ? state : n3904;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:25 */
  assign n3912 = n3897 ? 1'b0 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:25 */
  assign n3913 = n3897 ? scl_int : n3906;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:25 */
  assign n3914 = n3897 ? bit_cnt : n3908;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:437:25 */
  assign n3915 = n3897 ? tx_shift : n3909;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:25 */
  assign n3916 = n3894 ? state : n3910;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:25 */
  assign n3917 = n3894 ? sda_int : n3912;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:25 */
  assign n3918 = n3894 ? scl_int : n3913;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:25 */
  assign n3919 = n3894 ? bit_cnt : n3914;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:435:25 */
  assign n3920 = n3894 ? tx_shift : n3915;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:25 */
  assign n3921 = n3891 ? state : n3916;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:25 */
  assign n3923 = n3891 ? 1'b1 : n3917;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:25 */
  assign n3925 = n3891 ? 1'b1 : n3918;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:25 */
  assign n3926 = n3891 ? bit_cnt : n3919;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:432:25 */
  assign n3927 = n3891 ? tx_shift : n3920;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:428:21 */
  assign n3929 = state == 5'b01101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:34 */
  assign n3930 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:34 */
  assign n3932 = n3930 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:449:37 */
  assign n3935 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:449:37 */
  assign n3937 = n3935 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:37 */
  assign n3938 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:37 */
  assign n3940 = n3938 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:453:40 */
  assign n3941 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:453:40 */
  assign n3943 = n3941 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:456:52 */
  assign n3944 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:456:52 */
  assign n3946 = n3944 - 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:456:44 */
  assign n3947 = n3946[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:25 */
  assign n3949 = n3951 ? 5'b01111 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:453:29 */
  assign n3950 = n3943 ? bit_cnt : n3947;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:25 */
  assign n3951 = n3943 & n3940;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:25 */
  assign n3953 = n3940 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:451:25 */
  assign n3954 = n3940 ? n3950 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:449:25 */
  assign n3955 = n3937 ? state : n3949;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:449:25 */
  assign n3957 = n3937 ? 1'b1 : n3953;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:449:25 */
  assign n3958 = n3937 ? bit_cnt : n3954;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:25 */
  assign n3959 = n3932 ? state : n3955;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:25 */
  assign n3960 = n3932 ? n4292 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:25 */
  assign n3961 = n3932 ? scl_int : n3957;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:447:25 */
  assign n3962 = n3932 ? bit_cnt : n3958;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:446:21 */
  assign n3964 = state == 5'b01110;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:34 */
  assign n3965 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:34 */
  assign n3967 = n3965 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:37 */
  assign n3968 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:37 */
  assign n3970 = n3968 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:37 */
  assign n3971 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:37 */
  assign n3973 = n3971 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:466:38 */
  assign n3975 = sda_i != 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:25 */
  assign n3977 = n3990 ? 1'b1 : nack_flag;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:469:37 */
  assign n3978 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:469:37 */
  assign n3980 = n3978 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:469:25 */
  assign n3982 = n3980 ? 5'b10000 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:469:25 */
  assign n3984 = n3980 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:469:25 */
  assign n3986 = n3980 ? 3'b111 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:25 */
  assign n3987 = n3973 ? state : n3982;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:25 */
  assign n3988 = n3973 ? scl_int : n3984;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:25 */
  assign n3989 = n3973 ? bit_cnt : n3986;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:465:25 */
  assign n3990 = n3975 & n3973;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:25 */
  assign n3991 = n3970 ? state : n3987;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:25 */
  assign n3993 = n3970 ? 1'b1 : n3988;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:25 */
  assign n3994 = n3970 ? bit_cnt : n3989;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:463:25 */
  assign n3995 = n3970 ? nack_flag : n3977;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:25 */
  assign n3996 = n3967 ? state : n3991;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:25 */
  assign n3998 = n3967 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:25 */
  assign n3999 = n3967 ? scl_int : n3993;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:25 */
  assign n4000 = n3967 ? bit_cnt : n3994;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:461:25 */
  assign n4001 = n3967 ? nack_flag : n3995;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:460:21 */
  assign n4003 = state == 5'b01111;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:34 */
  assign n4004 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:34 */
  assign n4006 = n4004 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:37 */
  assign n4007 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:37 */
  assign n4009 = n4007 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:37 */
  assign n4010 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:37 */
  assign n4012 = n4010 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:482:38 */
  assign n4013 = ~sda_i;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:482:29 */
  assign n4020 = n4013 ? n4327 : n4362;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:37 */
  assign n4021 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:37 */
  assign n4023 = n4021 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:489:40 */
  assign n4024 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:489:40 */
  assign n4026 = n4024 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:492:52 */
  assign n4027 = {29'b0, bit_cnt};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:492:52 */
  assign n4029 = n4027 - 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:492:44 */
  assign n4030 = n4029[2:0];  // trunc
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:25 */
  assign n4032 = n4034 ? 5'b10001 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:489:29 */
  assign n4033 = n4026 ? bit_cnt : n4030;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:25 */
  assign n4034 = n4026 & n4023;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:25 */
  assign n4036 = n4023 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:487:25 */
  assign n4037 = n4023 ? n4033 : bit_cnt;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:25 */
  assign n4038 = n4012 ? state : n4032;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:25 */
  assign n4039 = n4012 ? scl_int : n4036;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:25 */
  assign n4040 = n4012 ? bit_cnt : n4037;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:481:25 */
  assign n4041 = n4012 ? n4020 : rx_shift;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:25 */
  assign n4042 = n4009 ? state : n4038;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:25 */
  assign n4044 = n4009 ? 1'b1 : n4039;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:25 */
  assign n4045 = n4009 ? bit_cnt : n4040;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:479:25 */
  assign n4046 = n4009 ? rx_shift : n4041;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:25 */
  assign n4047 = n4006 ? state : n4042;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:25 */
  assign n4049 = n4006 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:25 */
  assign n4050 = n4006 ? scl_int : n4044;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:25 */
  assign n4051 = n4006 ? bit_cnt : n4045;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:477:25 */
  assign n4052 = n4006 ? rx_shift : n4046;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:475:21 */
  assign n4054 = state == 5'b10000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:34 */
  assign n4055 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:34 */
  assign n4057 = n4055 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:500:37 */
  assign n4058 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:500:37 */
  assign n4060 = n4058 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:502:37 */
  assign n4061 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:502:37 */
  assign n4063 = n4061 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:502:25 */
  assign n4064 = n4063 ? rx_shift : n4259;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:502:25 */
  assign n4066 = n4063 ? 5'b10010 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:502:25 */
  assign n4068 = n4063 ? 1'b0 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:500:25 */
  assign n4069 = n4060 ? n4259 : n4064;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:500:25 */
  assign n4070 = n4060 ? state : n4066;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:500:25 */
  assign n4072 = n4060 ? 1'b1 : n4068;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:25 */
  assign n4073 = n4057 ? n4259 : n4069;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:25 */
  assign n4074 = n4057 ? state : n4070;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:25 */
  assign n4076 = n4057 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:498:25 */
  assign n4077 = n4057 ? scl_int : n4072;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:496:21 */
  assign n4079 = state == 5'b10001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:34 */
  assign n4080 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:34 */
  assign n4082 = n4080 == 32'b00000000000000000000000000000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:37 */
  assign n4083 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:37 */
  assign n4085 = n4083 == 32'b00000000000000000000000000000001;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:516:37 */
  assign n4086 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:516:37 */
  assign n4088 = n4086 == 32'b00000000000000000000000000000010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:518:37 */
  assign n4089 = {30'b0, phase};  // uext
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:518:37 */
  assign n4091 = n4089 == 32'b00000000000000000000000000000011;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:518:25 */
  assign n4093 = n4091 ? 1'b0 : n4260;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:518:25 */
  assign n4095 = n4091 ? 5'b00101 : state;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:518:25 */
  assign n4097 = n4091 ? 1'b1 : sda_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:516:25 */
  assign n4098 = n4088 ? n4260 : n4093;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:516:25 */
  assign n4099 = n4088 ? state : n4095;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:516:25 */
  assign n4100 = n4088 ? sda_int : n4097;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:25 */
  assign n4101 = n4085 ? n4260 : n4098;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:25 */
  assign n4102 = n4085 ? state : n4099;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:25 */
  assign n4103 = n4085 ? sda_int : n4100;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:514:25 */
  assign n4105 = n4085 ? 1'b1 : scl_int;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:25 */
  assign n4106 = n4082 ? n4260 : n4101;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:25 */
  assign n4107 = n4082 ? state : n4102;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:25 */
  assign n4109 = n4082 ? 1'b0 : n4103;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:512:25 */
  assign n4110 = n4082 ? scl_int : n4105;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:508:21 */
  assign n4112 = state == 5'b10010;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  assign n4113 = {n4112, n4079, n4054, n4003, n3964, n3929, n3888, n3854, n3819, n3772, n3737, n3685, n3650, n3616, n3590, n3506, n3504, n3499, n3494};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4114 = n4259;
      19'b0100000000000000000: n4114 = n4073;
      19'b0010000000000000000: n4114 = n4259;
      19'b0001000000000000000: n4114 = n4259;
      19'b0000100000000000000: n4114 = n4259;
      19'b0000010000000000000: n4114 = n4259;
      19'b0000001000000000000: n4114 = n4259;
      19'b0000000100000000000: n4114 = n4259;
      19'b0000000010000000000: n4114 = n4259;
      19'b0000000001000000000: n4114 = n4259;
      19'b0000000000100000000: n4114 = n4259;
      19'b0000000000010000000: n4114 = n4259;
      19'b0000000000001000000: n4114 = n4259;
      19'b0000000000000100000: n4114 = n4259;
      19'b0000000000000010000: n4114 = n3574;
      19'b0000000000000001000: n4114 = n4259;
      19'b0000000000000000100: n4114 = n4259;
      19'b0000000000000000010: n4114 = n4259;
      19'b0000000000000000001: n4114 = n4259;
      default: n4114 = n4259;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4115 = n4106;
      19'b0100000000000000000: n4115 = n4260;
      19'b0010000000000000000: n4115 = n4260;
      19'b0001000000000000000: n4115 = n4260;
      19'b0000100000000000000: n4115 = n4260;
      19'b0000010000000000000: n4115 = n4260;
      19'b0000001000000000000: n4115 = n4260;
      19'b0000000100000000000: n4115 = n4260;
      19'b0000000010000000000: n4115 = n4260;
      19'b0000000001000000000: n4115 = n4260;
      19'b0000000000100000000: n4115 = n4260;
      19'b0000000000010000000: n4115 = n4260;
      19'b0000000000001000000: n4115 = n4260;
      19'b0000000000000100000: n4115 = n4260;
      19'b0000000000000010000: n4115 = n3575;
      19'b0000000000000001000: n4115 = n4260;
      19'b0000000000000000100: n4115 = n4260;
      19'b0000000000000000010: n4115 = n4260;
      19'b0000000000000000001: n4115 = n4260;
      default: n4115 = n4260;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4121 = n4107;
      19'b0100000000000000000: n4121 = n4074;
      19'b0010000000000000000: n4121 = n4047;
      19'b0001000000000000000: n4121 = n3996;
      19'b0000100000000000000: n4121 = n3959;
      19'b0000010000000000000: n4121 = n3921;
      19'b0000001000000000000: n4121 = n3882;
      19'b0000000100000000000: n4121 = n3849;
      19'b0000000010000000000: n4121 = n3811;
      19'b0000000001000000000: n4121 = n3767;
      19'b0000000000100000000: n4121 = n3728;
      19'b0000000000010000000: n4121 = n3680;
      19'b0000000000001000000: n4121 = n3643;
      19'b0000000000000100000: n4121 = n3611;
      19'b0000000000000010000: n4121 = n3577;
      19'b0000000000000001000: n4121 = 5'b00100;
      19'b0000000000000000100: n4121 = 5'b00011;
      19'b0000000000000000010: n4121 = 5'b00010;
      19'b0000000000000000001: n4121 = 5'b00001;
      default: n4121 = 5'b00101;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4127 = n4109;
      19'b0100000000000000000: n4127 = n4076;
      19'b0010000000000000000: n4127 = n4049;
      19'b0001000000000000000: n4127 = n3998;
      19'b0000100000000000000: n4127 = n3960;
      19'b0000010000000000000: n4127 = n3923;
      19'b0000001000000000000: n4127 = n3884;
      19'b0000000100000000000: n4127 = n3850;
      19'b0000000010000000000: n4127 = n3813;
      19'b0000000001000000000: n4127 = n3768;
      19'b0000000000100000000: n4127 = n3730;
      19'b0000000000010000000: n4127 = n3681;
      19'b0000000000001000000: n4127 = n3645;
      19'b0000000000000100000: n4127 = 1'b1;
      19'b0000000000000010000: n4127 = 1'b1;
      19'b0000000000000001000: n4127 = sda_int;
      19'b0000000000000000100: n4127 = 1'b1;
      19'b0000000000000000010: n4127 = 1'b0;
      19'b0000000000000000001: n4127 = 1'b1;
      default: n4127 = sda_int;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4131 = n4110;
      19'b0100000000000000000: n4131 = n4077;
      19'b0010000000000000000: n4131 = n4050;
      19'b0001000000000000000: n4131 = n3999;
      19'b0000100000000000000: n4131 = n3961;
      19'b0000010000000000000: n4131 = n3925;
      19'b0000001000000000000: n4131 = n3885;
      19'b0000000100000000000: n4131 = n3851;
      19'b0000000010000000000: n4131 = n3814;
      19'b0000000001000000000: n4131 = n3769;
      19'b0000000000100000000: n4131 = n3731;
      19'b0000000000010000000: n4131 = n3682;
      19'b0000000000001000000: n4131 = n3647;
      19'b0000000000000100000: n4131 = n3613;
      19'b0000000000000010000: n4131 = 1'b1;
      19'b0000000000000001000: n4131 = scl_int;
      19'b0000000000000000100: n4131 = scl_int;
      19'b0000000000000000010: n4131 = 1'b1;
      19'b0000000000000000001: n4131 = 1'b0;
      default: n4131 = scl_int;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4133 = n3492;
      19'b0100000000000000000: n4133 = n3492;
      19'b0010000000000000000: n4133 = n3492;
      19'b0001000000000000000: n4133 = n3492;
      19'b0000100000000000000: n4133 = n3492;
      19'b0000010000000000000: n4133 = n3492;
      19'b0000001000000000000: n4133 = n3492;
      19'b0000000100000000000: n4133 = n3492;
      19'b0000000010000000000: n4133 = n3492;
      19'b0000000001000000000: n4133 = n3492;
      19'b0000000000100000000: n4133 = n3492;
      19'b0000000000010000000: n4133 = n3492;
      19'b0000000000001000000: n4133 = n3492;
      19'b0000000000000100000: n4133 = n3492;
      19'b0000000000000010000: n4133 = 2'b00;
      19'b0000000000000001000: n4133 = n3492;
      19'b0000000000000000100: n4133 = n3492;
      19'b0000000000000000010: n4133 = n3492;
      19'b0000000000000000001: n4133 = n3492;
      default: n4133 = n3492;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4134 = bit_cnt;
      19'b0100000000000000000: n4134 = bit_cnt;
      19'b0010000000000000000: n4134 = n4051;
      19'b0001000000000000000: n4134 = n4000;
      19'b0000100000000000000: n4134 = n3962;
      19'b0000010000000000000: n4134 = n3926;
      19'b0000001000000000000: n4134 = bit_cnt;
      19'b0000000100000000000: n4134 = n3852;
      19'b0000000010000000000: n4134 = n3815;
      19'b0000000001000000000: n4134 = n3770;
      19'b0000000000100000000: n4134 = n3732;
      19'b0000000000010000000: n4134 = n3683;
      19'b0000000000001000000: n4134 = n3648;
      19'b0000000000000100000: n4134 = bit_cnt;
      19'b0000000000000010000: n4134 = bit_cnt;
      19'b0000000000000001000: n4134 = bit_cnt;
      19'b0000000000000000100: n4134 = bit_cnt;
      19'b0000000000000000010: n4134 = bit_cnt;
      19'b0000000000000000001: n4134 = bit_cnt;
      default: n4134 = bit_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4135 = tx_shift;
      19'b0100000000000000000: n4135 = tx_shift;
      19'b0010000000000000000: n4135 = tx_shift;
      19'b0001000000000000000: n4135 = tx_shift;
      19'b0000100000000000000: n4135 = tx_shift;
      19'b0000010000000000000: n4135 = n3927;
      19'b0000001000000000000: n4135 = tx_shift;
      19'b0000000100000000000: n4135 = tx_shift;
      19'b0000000010000000000: n4135 = n3816;
      19'b0000000001000000000: n4135 = tx_shift;
      19'b0000000000100000000: n4135 = n3733;
      19'b0000000000010000000: n4135 = tx_shift;
      19'b0000000000001000000: n4135 = tx_shift;
      19'b0000000000000100000: n4135 = tx_shift;
      19'b0000000000000010000: n4135 = n3578;
      19'b0000000000000001000: n4135 = tx_shift;
      19'b0000000000000000100: n4135 = tx_shift;
      19'b0000000000000000010: n4135 = tx_shift;
      19'b0000000000000000001: n4135 = tx_shift;
      default: n4135 = tx_shift;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4136 = rx_shift;
      19'b0100000000000000000: n4136 = rx_shift;
      19'b0010000000000000000: n4136 = n4052;
      19'b0001000000000000000: n4136 = rx_shift;
      19'b0000100000000000000: n4136 = rx_shift;
      19'b0000010000000000000: n4136 = rx_shift;
      19'b0000001000000000000: n4136 = rx_shift;
      19'b0000000100000000000: n4136 = rx_shift;
      19'b0000000010000000000: n4136 = rx_shift;
      19'b0000000001000000000: n4136 = rx_shift;
      19'b0000000000100000000: n4136 = rx_shift;
      19'b0000000000010000000: n4136 = rx_shift;
      19'b0000000000001000000: n4136 = rx_shift;
      19'b0000000000000100000: n4136 = rx_shift;
      19'b0000000000000010000: n4136 = rx_shift;
      19'b0000000000000001000: n4136 = rx_shift;
      19'b0000000000000000100: n4136 = rx_shift;
      19'b0000000000000000010: n4136 = rx_shift;
      19'b0000000000000000001: n4136 = rx_shift;
      default: n4136 = rx_shift;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4137 = is_read;
      19'b0100000000000000000: n4137 = is_read;
      19'b0010000000000000000: n4137 = is_read;
      19'b0001000000000000000: n4137 = is_read;
      19'b0000100000000000000: n4137 = is_read;
      19'b0000010000000000000: n4137 = is_read;
      19'b0000001000000000000: n4137 = is_read;
      19'b0000000100000000000: n4137 = is_read;
      19'b0000000010000000000: n4137 = is_read;
      19'b0000000001000000000: n4137 = is_read;
      19'b0000000000100000000: n4137 = is_read;
      19'b0000000000010000000: n4137 = is_read;
      19'b0000000000001000000: n4137 = is_read;
      19'b0000000000000100000: n4137 = is_read;
      19'b0000000000000010000: n4137 = n3579;
      19'b0000000000000001000: n4137 = is_read;
      19'b0000000000000000100: n4137 = is_read;
      19'b0000000000000000010: n4137 = is_read;
      19'b0000000000000000001: n4137 = is_read;
      default: n4137 = is_read;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4138 = n3476;
      19'b0100000000000000000: n4138 = n3476;
      19'b0010000000000000000: n4138 = n3476;
      19'b0001000000000000000: n4138 = n3476;
      19'b0000100000000000000: n4138 = n3476;
      19'b0000010000000000000: n4138 = n3476;
      19'b0000001000000000000: n4138 = n3476;
      19'b0000000100000000000: n4138 = n3476;
      19'b0000000010000000000: n4138 = n3476;
      19'b0000000001000000000: n4138 = n3476;
      19'b0000000000100000000: n4138 = n3476;
      19'b0000000000010000000: n4138 = n3476;
      19'b0000000000001000000: n4138 = n3476;
      19'b0000000000000100000: n4138 = n3476;
      19'b0000000000000010000: n4138 = n3580;
      19'b0000000000000001000: n4138 = n3476;
      19'b0000000000000000100: n4138 = n3476;
      19'b0000000000000000010: n4138 = n3476;
      19'b0000000000000000001: n4138 = n3476;
      default: n4138 = n3476;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4139 = scl_drv;
      19'b0100000000000000000: n4139 = scl_drv;
      19'b0010000000000000000: n4139 = scl_drv;
      19'b0001000000000000000: n4139 = scl_drv;
      19'b0000100000000000000: n4139 = scl_drv;
      19'b0000010000000000000: n4139 = scl_drv;
      19'b0000001000000000000: n4139 = scl_drv;
      19'b0000000100000000000: n4139 = scl_drv;
      19'b0000000010000000000: n4139 = scl_drv;
      19'b0000000001000000000: n4139 = scl_drv;
      19'b0000000000100000000: n4139 = scl_drv;
      19'b0000000000010000000: n4139 = scl_drv;
      19'b0000000000001000000: n4139 = scl_drv;
      19'b0000000000000100000: n4139 = scl_drv;
      19'b0000000000000010000: n4139 = scl_drv;
      19'b0000000000000001000: n4139 = scl_drv;
      19'b0000000000000000100: n4139 = scl_drv;
      19'b0000000000000000010: n4139 = n3497;
      19'b0000000000000000001: n4139 = scl_drv;
      default: n4139 = scl_drv;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4140 = sda_drv;
      19'b0100000000000000000: n4140 = sda_drv;
      19'b0010000000000000000: n4140 = sda_drv;
      19'b0001000000000000000: n4140 = sda_drv;
      19'b0000100000000000000: n4140 = sda_drv;
      19'b0000010000000000000: n4140 = sda_drv;
      19'b0000001000000000000: n4140 = sda_drv;
      19'b0000000100000000000: n4140 = sda_drv;
      19'b0000000010000000000: n4140 = sda_drv;
      19'b0000000001000000000: n4140 = sda_drv;
      19'b0000000000100000000: n4140 = sda_drv;
      19'b0000000000010000000: n4140 = sda_drv;
      19'b0000000000001000000: n4140 = sda_drv;
      19'b0000000000000100000: n4140 = sda_drv;
      19'b0000000000000010000: n4140 = sda_drv;
      19'b0000000000000001000: n4140 = sda_drv;
      19'b0000000000000000100: n4140 = n3502;
      19'b0000000000000000010: n4140 = sda_drv;
      19'b0000000000000000001: n4140 = sda_drv;
      default: n4140 = sda_drv;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4142 = st_done;
      19'b0100000000000000000: n4142 = st_done;
      19'b0010000000000000000: n4142 = st_done;
      19'b0001000000000000000: n4142 = st_done;
      19'b0000100000000000000: n4142 = st_done;
      19'b0000010000000000000: n4142 = st_done;
      19'b0000001000000000000: n4142 = st_done;
      19'b0000000100000000000: n4142 = st_done;
      19'b0000000010000000000: n4142 = st_done;
      19'b0000000001000000000: n4142 = st_done;
      19'b0000000000100000000: n4142 = st_done;
      19'b0000000000010000000: n4142 = st_done;
      19'b0000000000001000000: n4142 = st_done;
      19'b0000000000000100000: n4142 = st_done;
      19'b0000000000000010000: n4142 = st_done;
      19'b0000000000000001000: n4142 = 1'b1;
      19'b0000000000000000100: n4142 = st_done;
      19'b0000000000000000010: n4142 = st_done;
      19'b0000000000000000001: n4142 = st_done;
      default: n4142 = st_done;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4143 = is_probe;
      19'b0100000000000000000: n4143 = is_probe;
      19'b0010000000000000000: n4143 = is_probe;
      19'b0001000000000000000: n4143 = is_probe;
      19'b0000100000000000000: n4143 = is_probe;
      19'b0000010000000000000: n4143 = is_probe;
      19'b0000001000000000000: n4143 = is_probe;
      19'b0000000100000000000: n4143 = is_probe;
      19'b0000000010000000000: n4143 = is_probe;
      19'b0000000001000000000: n4143 = is_probe;
      19'b0000000000100000000: n4143 = is_probe;
      19'b0000000000010000000: n4143 = is_probe;
      19'b0000000000001000000: n4143 = is_probe;
      19'b0000000000000100000: n4143 = is_probe;
      19'b0000000000000010000: n4143 = n3581;
      19'b0000000000000001000: n4143 = is_probe;
      19'b0000000000000000100: n4143 = is_probe;
      19'b0000000000000000010: n4143 = is_probe;
      19'b0000000000000000001: n4143 = is_probe;
      default: n4143 = is_probe;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4145 = rec_cnt;
      19'b0100000000000000000: n4145 = rec_cnt;
      19'b0010000000000000000: n4145 = rec_cnt;
      19'b0001000000000000000: n4145 = rec_cnt;
      19'b0000100000000000000: n4145 = rec_cnt;
      19'b0000010000000000000: n4145 = rec_cnt;
      19'b0000001000000000000: n4145 = rec_cnt;
      19'b0000000100000000000: n4145 = rec_cnt;
      19'b0000000010000000000: n4145 = rec_cnt;
      19'b0000000001000000000: n4145 = rec_cnt;
      19'b0000000000100000000: n4145 = rec_cnt;
      19'b0000000000010000000: n4145 = rec_cnt;
      19'b0000000000001000000: n4145 = rec_cnt;
      19'b0000000000000100000: n4145 = n3614;
      19'b0000000000000010000: n4145 = n3583;
      19'b0000000000000001000: n4145 = 4'b0000;
      19'b0000000000000000100: n4145 = rec_cnt;
      19'b0000000000000000010: n4145 = rec_cnt;
      19'b0000000000000000001: n4145 = rec_cnt;
      default: n4145 = rec_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4146 = rec_tries;
      19'b0100000000000000000: n4146 = rec_tries;
      19'b0010000000000000000: n4146 = rec_tries;
      19'b0001000000000000000: n4146 = rec_tries;
      19'b0000100000000000000: n4146 = rec_tries;
      19'b0000010000000000000: n4146 = rec_tries;
      19'b0000001000000000000: n4146 = rec_tries;
      19'b0000000100000000000: n4146 = rec_tries;
      19'b0000000010000000000: n4146 = rec_tries;
      19'b0000000001000000000: n4146 = rec_tries;
      19'b0000000000100000000: n4146 = rec_tries;
      19'b0000000000010000000: n4146 = rec_tries;
      19'b0000000000001000000: n4146 = rec_tries;
      19'b0000000000000100000: n4146 = rec_tries;
      19'b0000000000000010000: n4146 = n3584;
      19'b0000000000000001000: n4146 = rec_tries;
      19'b0000000000000000100: n4146 = rec_tries;
      19'b0000000000000000010: n4146 = rec_tries;
      19'b0000000000000000001: n4146 = rec_tries;
      default: n4146 = rec_tries;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4147 = recovered_i;
      19'b0100000000000000000: n4147 = recovered_i;
      19'b0010000000000000000: n4147 = recovered_i;
      19'b0001000000000000000: n4147 = recovered_i;
      19'b0000100000000000000: n4147 = recovered_i;
      19'b0000010000000000000: n4147 = recovered_i;
      19'b0000001000000000000: n4147 = recovered_i;
      19'b0000000100000000000: n4147 = recovered_i;
      19'b0000000010000000000: n4147 = recovered_i;
      19'b0000000001000000000: n4147 = recovered_i;
      19'b0000000000100000000: n4147 = recovered_i;
      19'b0000000000010000000: n4147 = recovered_i;
      19'b0000000000001000000: n4147 = recovered_i;
      19'b0000000000000100000: n4147 = recovered_i;
      19'b0000000000000010000: n4147 = n3586;
      19'b0000000000000001000: n4147 = recovered_i;
      19'b0000000000000000100: n4147 = recovered_i;
      19'b0000000000000000010: n4147 = recovered_i;
      19'b0000000000000000001: n4147 = recovered_i;
      default: n4147 = recovered_i;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4148 = anack;
      19'b0100000000000000000: n4148 = anack;
      19'b0010000000000000000: n4148 = anack;
      19'b0001000000000000000: n4148 = anack;
      19'b0000100000000000000: n4148 = anack;
      19'b0000010000000000000: n4148 = anack;
      19'b0000001000000000000: n4148 = anack;
      19'b0000000100000000000: n4148 = anack;
      19'b0000000010000000000: n4148 = anack;
      19'b0000000001000000000: n4148 = anack;
      19'b0000000000100000000: n4148 = n3734;
      19'b0000000000010000000: n4148 = anack;
      19'b0000000000001000000: n4148 = anack;
      19'b0000000000000100000: n4148 = anack;
      19'b0000000000000010000: n4148 = n3587;
      19'b0000000000000001000: n4148 = anack;
      19'b0000000000000000100: n4148 = anack;
      19'b0000000000000000010: n4148 = anack;
      19'b0000000000000000001: n4148 = anack;
      default: n4148 = anack;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4149 = nack_flag;
      19'b0100000000000000000: n4149 = nack_flag;
      19'b0010000000000000000: n4149 = nack_flag;
      19'b0001000000000000000: n4149 = n4001;
      19'b0000100000000000000: n4149 = nack_flag;
      19'b0000010000000000000: n4149 = nack_flag;
      19'b0000001000000000000: n4149 = n3886;
      19'b0000000100000000000: n4149 = nack_flag;
      19'b0000000010000000000: n4149 = n3817;
      19'b0000000001000000000: n4149 = nack_flag;
      19'b0000000000100000000: n4149 = n3735;
      19'b0000000000010000000: n4149 = nack_flag;
      19'b0000000000001000000: n4149 = nack_flag;
      19'b0000000000000100000: n4149 = nack_flag;
      19'b0000000000000010000: n4149 = n3588;
      19'b0000000000000001000: n4149 = nack_flag;
      19'b0000000000000000100: n4149 = nack_flag;
      19'b0000000000000000010: n4149 = nack_flag;
      19'b0000000000000000001: n4149 = nack_flag;
      default: n4149 = nack_flag;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4150 = stuck_flag;
      19'b0100000000000000000: n4150 = stuck_flag;
      19'b0010000000000000000: n4150 = stuck_flag;
      19'b0001000000000000000: n4150 = stuck_flag;
      19'b0000100000000000000: n4150 = stuck_flag;
      19'b0000010000000000000: n4150 = stuck_flag;
      19'b0000001000000000000: n4150 = stuck_flag;
      19'b0000000100000000000: n4150 = stuck_flag;
      19'b0000000010000000000: n4150 = stuck_flag;
      19'b0000000001000000000: n4150 = stuck_flag;
      19'b0000000000100000000: n4150 = stuck_flag;
      19'b0000000000010000000: n4150 = stuck_flag;
      19'b0000000000001000000: n4150 = stuck_flag;
      19'b0000000000000100000: n4150 = stuck_flag;
      19'b0000000000000010000: n4150 = n3539;
      19'b0000000000000001000: n4150 = stuck_flag;
      19'b0000000000000000100: n4150 = stuck_flag;
      19'b0000000000000000010: n4150 = stuck_flag;
      19'b0000000000000000001: n4150 = stuck_flag;
      default: n4150 = stuck_flag;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4151 = scl_low;
      19'b0100000000000000000: n4151 = scl_low;
      19'b0010000000000000000: n4151 = scl_low;
      19'b0001000000000000000: n4151 = scl_low;
      19'b0000100000000000000: n4151 = scl_low;
      19'b0000010000000000000: n4151 = scl_low;
      19'b0000001000000000000: n4151 = scl_low;
      19'b0000000100000000000: n4151 = scl_low;
      19'b0000000010000000000: n4151 = scl_low;
      19'b0000000001000000000: n4151 = scl_low;
      19'b0000000000100000000: n4151 = scl_low;
      19'b0000000000010000000: n4151 = scl_low;
      19'b0000000000001000000: n4151 = scl_low;
      19'b0000000000000100000: n4151 = scl_low;
      19'b0000000000000010000: n4151 = n3540;
      19'b0000000000000001000: n4151 = scl_low;
      19'b0000000000000000100: n4151 = scl_low;
      19'b0000000000000000010: n4151 = scl_low;
      19'b0000000000000000001: n4151 = scl_low;
      default: n4151 = scl_low;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4152 = sda_low;
      19'b0100000000000000000: n4152 = sda_low;
      19'b0010000000000000000: n4152 = sda_low;
      19'b0001000000000000000: n4152 = sda_low;
      19'b0000100000000000000: n4152 = sda_low;
      19'b0000010000000000000: n4152 = sda_low;
      19'b0000001000000000000: n4152 = sda_low;
      19'b0000000100000000000: n4152 = sda_low;
      19'b0000000010000000000: n4152 = sda_low;
      19'b0000000001000000000: n4152 = sda_low;
      19'b0000000000100000000: n4152 = sda_low;
      19'b0000000000010000000: n4152 = sda_low;
      19'b0000000000001000000: n4152 = sda_low;
      19'b0000000000000100000: n4152 = sda_low;
      19'b0000000000000010000: n4152 = n3541;
      19'b0000000000000001000: n4152 = sda_low;
      19'b0000000000000000100: n4152 = sda_low;
      19'b0000000000000000010: n4152 = sda_low;
      19'b0000000000000000001: n4152 = sda_low;
      default: n4152 = sda_low;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4153 = scl_low_cnt;
      19'b0100000000000000000: n4153 = scl_low_cnt;
      19'b0010000000000000000: n4153 = scl_low_cnt;
      19'b0001000000000000000: n4153 = scl_low_cnt;
      19'b0000100000000000000: n4153 = scl_low_cnt;
      19'b0000010000000000000: n4153 = scl_low_cnt;
      19'b0000001000000000000: n4153 = scl_low_cnt;
      19'b0000000100000000000: n4153 = scl_low_cnt;
      19'b0000000010000000000: n4153 = scl_low_cnt;
      19'b0000000001000000000: n4153 = scl_low_cnt;
      19'b0000000000100000000: n4153 = scl_low_cnt;
      19'b0000000000010000000: n4153 = scl_low_cnt;
      19'b0000000000001000000: n4153 = scl_low_cnt;
      19'b0000000000000100000: n4153 = scl_low_cnt;
      19'b0000000000000010000: n4153 = n3542;
      19'b0000000000000001000: n4153 = scl_low_cnt;
      19'b0000000000000000100: n4153 = scl_low_cnt;
      19'b0000000000000000010: n4153 = scl_low_cnt;
      19'b0000000000000000001: n4153 = scl_low_cnt;
      default: n4153 = scl_low_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:185:17 */
  always @*
    case (n4113)
      19'b1000000000000000000: n4154 = sda_low_cnt;
      19'b0100000000000000000: n4154 = sda_low_cnt;
      19'b0010000000000000000: n4154 = sda_low_cnt;
      19'b0001000000000000000: n4154 = sda_low_cnt;
      19'b0000100000000000000: n4154 = sda_low_cnt;
      19'b0000010000000000000: n4154 = sda_low_cnt;
      19'b0000001000000000000: n4154 = sda_low_cnt;
      19'b0000000100000000000: n4154 = sda_low_cnt;
      19'b0000000010000000000: n4154 = sda_low_cnt;
      19'b0000000001000000000: n4154 = sda_low_cnt;
      19'b0000000000100000000: n4154 = sda_low_cnt;
      19'b0000000000010000000: n4154 = sda_low_cnt;
      19'b0000000000001000000: n4154 = sda_low_cnt;
      19'b0000000000000100000: n4154 = sda_low_cnt;
      19'b0000000000000010000: n4154 = n3543;
      19'b0000000000000001000: n4154 = sda_low_cnt;
      19'b0000000000000000100: n4154 = sda_low_cnt;
      19'b0000000000000000010: n4154 = sda_low_cnt;
      19'b0000000000000000001: n4154 = sda_low_cnt;
      default: n4154 = sda_low_cnt;
    endcase
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4155 = n3479 ? n4259 : n4114;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4156 = n3479 ? n4260 : n4115;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4157 = n3479 ? state : n4121;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4158 = n3479 ? sda_int : n4127;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4159 = n3479 ? scl_int : n4131;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4161 = n3479 ? n3483 : 8'b00000000;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4162 = n3479 ? phase : n4133;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4163 = n3479 ? bit_cnt : n4134;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4164 = n3479 ? tx_shift : n4135;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4165 = n3479 ? rx_shift : n4136;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4166 = n3479 ? is_read : n4137;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4167 = n3479 ? n3476 : n4138;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4168 = n3479 ? scl_drv : n4139;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4169 = n3479 ? sda_drv : n4140;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4170 = n3479 ? st_done : n4142;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4171 = n3479 ? is_probe : n4143;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4172 = n3479 ? rec_cnt : n4145;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4173 = n3479 ? rec_tries : n4146;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4174 = n3479 ? recovered_i : n4147;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4175 = n3479 ? anack : n4148;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4176 = n3479 ? nack_flag : n4149;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4177 = n3479 ? stuck_flag : n4150;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4178 = n3479 ? scl_low : n4151;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4179 = n3479 ? sda_low : n4152;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4180 = n3479 ? scl_low_cnt : n4153;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:174:13 */
  assign n4181 = n3479 ? sda_low_cnt : n4154;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4259 <= 8'b00000000;
    else
      n4259 <= n4155;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4260 <= 1'b0;
    else
      n4260 <= n4156;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4261 <= 5'b00000;
    else
      n4261 <= n4157;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4262 <= 1'b1;
    else
      n4262 <= n4158;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4263 <= 1'b1;
    else
      n4263 <= n4159;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4264 <= 8'b00000000;
    else
      n4264 <= n4161;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4265 <= 2'b00;
    else
      n4265 <= n4162;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4266 <= 3'b111;
    else
      n4266 <= n4163;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4267 <= 8'b00000000;
    else
      n4267 <= n4164;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4268 <= 8'b00000000;
    else
      n4268 <= n4165;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4269 <= 1'b0;
    else
      n4269 <= n4166;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4270 <= 1'b0;
    else
      n4270 <= n4167;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4271 <= 1'b0;
    else
      n4271 <= n4168;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4272 <= 1'b0;
    else
      n4272 <= n4169;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4273 <= 1'b0;
    else
      n4273 <= n4170;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:100:12 */
  assign n4274 = ~n3473;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  assign n4275 = n4274 ? n4171 : is_probe;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk)
    n4276 <= n4275;
  initial
    n4276 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4277 <= 4'b0000;
    else
      n4277 <= n4172;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4278 <= 4'b0000;
    else
      n4278 <= n4173;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4279 <= 1'b0;
    else
      n4279 <= n4174;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:107:12 */
  assign n4280 = ~n3473;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  assign n4281 = n4280 ? n4175 : anack;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk)
    n4282 <= n4281;
  initial
    n4282 = 1'b0;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4283 <= 1'b0;
    else
      n4283 <= n4176;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4284 <= 1'b0;
    else
      n4284 <= n4177;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4285 <= 1'b0;
    else
      n4285 <= n4178;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4286 <= 1'b0;
    else
      n4286 <= n4179;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4287 <= 8'b00000000;
    else
      n4287 <= n4180;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:167:9 */
  always @(posedge clk or posedge n3473)
    if (n3473)
      n4288 <= 8'b00000000;
    else
      n4288 <= n4181;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:331:49 */
  assign n4289 = tx_shift[bit_cnt * 1 +: 1]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:366:49 */
  assign n4290 = tx_shift[bit_cnt * 1 +: 1]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:401:49 */
  assign n4291 = tx_shift[bit_cnt * 1 +: 1]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:448:49 */
  assign n4292 = tx_shift[bit_cnt * 1 +: 1]; //(Bmux)
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4293 = bit_cnt[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4294 = ~n4293;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4295 = bit_cnt[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4296 = ~n4295;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4297 = n4294 & n4296;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4298 = n4294 & n4295;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4299 = n4293 & n4296;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4300 = n4293 & n4295;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4301 = bit_cnt[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4302 = ~n4301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4303 = n4297 & n4302;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4304 = n4297 & n4301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4305 = n4298 & n4302;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4306 = n4298 & n4301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4307 = n4299 & n4302;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4308 = n4299 & n4301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4309 = n4300 & n4302;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4310 = n4300 & n4301;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4311 = rx_shift[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4312 = n4303 ? 1'b0 : n4311;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4313 = rx_shift[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4314 = n4304 ? 1'b0 : n4313;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4315 = rx_shift[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4316 = n4305 ? 1'b0 : n4315;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4317 = rx_shift[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4318 = n4306 ? 1'b0 : n4317;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4319 = rx_shift[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4320 = n4307 ? 1'b0 : n4319;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4321 = rx_shift[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4322 = n4308 ? 1'b0 : n4321;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4323 = rx_shift[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4324 = n4309 ? 1'b0 : n4323;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4325 = rx_shift[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4326 = n4310 ? 1'b0 : n4325;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:483:33 */
  assign n4327 = {n4326, n4324, n4322, n4320, n4318, n4316, n4314, n4312};
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4328 = bit_cnt[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4329 = ~n4328;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4330 = bit_cnt[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4331 = ~n4330;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4332 = n4329 & n4331;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4333 = n4329 & n4330;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4334 = n4328 & n4331;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4335 = n4328 & n4330;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4336 = bit_cnt[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4337 = ~n4336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4338 = n4332 & n4337;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4339 = n4332 & n4336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4340 = n4333 & n4337;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4341 = n4333 & n4336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4342 = n4334 & n4337;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4343 = n4334 & n4336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4344 = n4335 & n4337;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4345 = n4335 & n4336;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4346 = rx_shift[0]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4347 = n4338 ? 1'b1 : n4346;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4348 = rx_shift[1]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4349 = n4339 ? 1'b1 : n4348;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4350 = rx_shift[2]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4351 = n4340 ? 1'b1 : n4350;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4352 = rx_shift[3]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4353 = n4341 ? 1'b1 : n4352;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4354 = rx_shift[4]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4355 = n4342 ? 1'b1 : n4354;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4356 = rx_shift[5]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4357 = n4343 ? 1'b1 : n4356;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4358 = rx_shift[6]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4359 = n4344 ? 1'b1 : n4358;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4360 = rx_shift[7]; // extract
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4361 = n4345 ? 1'b1 : n4360;
  /*# /mnt/Data1/Peoples/faiz836b/ASIC_UATR/legacy/rtl/i2c_master.vhd:485:33 */
  assign n4362 = {n4361, n4359, n4357, n4355, n4353, n4351, n4349, n4347};
endmodule
