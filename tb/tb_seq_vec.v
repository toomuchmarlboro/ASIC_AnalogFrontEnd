// Vector dump for adau1978_sequencer, Verilog side. Pairs with
// tb/tb_seq_vec_vhdl.vhd: identical stimulus, identical output format, and the
// two files must match byte for byte. See notes/conversion.md.
//
// Plusargs: +cycles=N +out=<file>

`timescale 1ns/1ps

module tb_seq_vec;

    integer CYCLES, fh, i;
    reg [1023:0] outfile;

    reg clk = 1'b0, rst_n = 1'b0;
    reg udp_req = 1'b0, i2c_busy = 1'b0, i2c_ack_error = 1'b0, i2c_addr_nack = 1'b0;
    reg [1:0] udp_adc_sel = 2'b00, udp_ch_sel = 2'b00;
    reg [7:0] udp_gain = 8'h00, i2c_data_rd = 8'h00;

    wire boot_done, udp_ack, i2c_ena, i2c_rd_mode, i2c_probe, i2c_fault;
    wire adc_pll_lock, adc_cfg_ok;
    wire [6:0] i2c_addr;
    wire [7:0] i2c_reg_addr, i2c_data_wr, dbg_rd_pll, dbg_rd_sai;
    wire [7:0] dbg_scan_cnt, dbg_scan_addr, dbg_scan_mask, dbg_ot, dbg_health, dbg_vfy_mask;

    always #10 clk = ~clk;

    adau1978_sequencer uut (
        .clk(clk), .rst_n(rst_n), .boot_done(boot_done),
        .udp_req(udp_req), .udp_ack(udp_ack), .udp_adc_sel(udp_adc_sel),
        .udp_ch_sel(udp_ch_sel), .udp_gain(udp_gain),
        .i2c_ena(i2c_ena), .i2c_addr(i2c_addr), .i2c_reg_addr(i2c_reg_addr),
        .i2c_data_wr(i2c_data_wr), .i2c_busy(i2c_busy),
        .i2c_ack_error(i2c_ack_error), .i2c_rd_mode(i2c_rd_mode),
        .i2c_probe(i2c_probe), .i2c_addr_nack(i2c_addr_nack),
        .i2c_data_rd(i2c_data_rd), .i2c_fault(i2c_fault),
        .adc_pll_lock(adc_pll_lock), .adc_cfg_ok(adc_cfg_ok),
        .dbg_rd_pll(dbg_rd_pll), .dbg_rd_sai(dbg_rd_sai),
        .dbg_scan_cnt(dbg_scan_cnt), .dbg_scan_addr(dbg_scan_addr),
        .dbg_scan_mask(dbg_scan_mask), .dbg_ot(dbg_ot),
        .dbg_health(dbg_health), .dbg_vfy_mask(dbg_vfy_mask));

    reg [31:0] v = 32'h12345678;
    reg fb;
    reg [95:0] prev = {96{1'bx}}, cur;

    initial begin
        if (!$value$plusargs("cycles=%d", CYCLES)) CYCLES = 40000;
        if (!$value$plusargs("out=%s", outfile)) outfile = "vec_v.txt";
        fh = $fopen(outfile, "w");

        rst_n = 1'b0;
        repeat (10) @(posedge clk);
        rst_n <= 1'b1;

        for (i = 0; i < CYCLES; i = i + 1) begin
            @(posedge clk);
            fb = v[31] ^ v[21] ^ v[1] ^ v[0];
            v = {v[30:0], fb};
            i2c_busy      <= v[0];
            i2c_ack_error <= v[1] & v[2];
            i2c_addr_nack <= v[3] & v[4];
            i2c_data_rd   <= v[15:8];
            udp_req       <= v[5] & v[6] & v[7];
            udp_adc_sel   <= v[17:16];
            udp_ch_sel    <= v[19:18];
            udp_gain      <= v[27:20];
            #1;
            cur = {boot_done, udp_ack, i2c_ena, i2c_rd_mode, i2c_probe, i2c_fault,
                   adc_pll_lock, adc_cfg_ok, 1'b0, i2c_addr, i2c_reg_addr, i2c_data_wr,
                   dbg_rd_pll, dbg_rd_sai, dbg_scan_cnt, dbg_scan_addr,
                   dbg_scan_mask, dbg_ot, dbg_health, dbg_vfy_mask};
            // only record a line when an output changes, see the VHDL side
            if (cur !== prev) begin
            prev = cur;
            $fwrite(fh, "%0d %02X %02X %04X %08X %08X\n", i,
                    {boot_done, udp_ack, i2c_ena, i2c_rd_mode, i2c_probe, i2c_fault, adc_pll_lock, adc_cfg_ok},
                    {1'b0, i2c_addr},
                    {i2c_reg_addr, i2c_data_wr},
                    {dbg_rd_pll, dbg_rd_sai, dbg_scan_cnt, dbg_scan_addr},
                    {dbg_scan_mask, dbg_ot, dbg_health, dbg_vfy_mask});
            end
        end
        $fclose(fh);
        $display("wrote %0d vectors", CYCLES);
        $finish;
    end
endmodule
