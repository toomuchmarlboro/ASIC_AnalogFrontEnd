// tdm16_merge: the GHDL-converted RTL against its sky130 netlist, same stimulus.
// sim/tb_tdm16.vhd has no assertions (it is waveform-only), so this is the
// module's real check. See notes/conversion.md.
//
//   ref   legacy/rtl/tdm16_merge.vhd through `ghdl --synth --out=verilog`
//   gate  the same module synthesised to sky130 cells by synth/run_module_gate.sh
//
// Plusargs: +frames=N +seed=N

`timescale 1ns/1ps

module tb_tdm16_merge_gate;

    integer FRAMES, SEED, sd;

    reg clk = 1'b0, rst = 1'b1, lrclk_pulse = 1'b0;
    reg [191:0] ch_a = 192'd0, ch_b = 192'd0;
    wire [383:0] out_ref, out_gate;
    wire valid_ref, valid_gate;

    always #20.345 clk = ~clk;          // 24.576 MHz

    tdm16_merge_ref  u_ref  (.clk(clk), .rst(rst), .lrclk_pulse(lrclk_pulse),
                             .ch_data_A(ch_a), .ch_data_B(ch_b),
                             .tdm16_out(out_ref),  .tdm16_valid(valid_ref));
    tdm16_merge_gate u_gate (.clk(clk), .rst(rst), .lrclk_pulse(lrclk_pulse),
                             .ch_data_A(ch_a), .ch_data_B(ch_b),
                             .tdm16_out(out_gate), .tdm16_valid(valid_gate));

    integer cmp = 0, mm = 0, nvalid = 0, i, f, k;

    always @(posedge clk) begin
        #1;
        cmp = cmp + 1;
        if (valid_ref !== valid_gate || out_ref !== out_gate) begin
            mm = mm + 1;
            if (mm < 4) $display("MISMATCH at %0t: valid %b/%b", $time, valid_ref, valid_gate);
        end
        if (valid_ref) nvalid = nvalid + 1;
    end

    initial begin
        if (!$value$plusargs("frames=%d", FRAMES)) FRAMES = 200;
        if (!$value$plusargs("seed=%d",   SEED))   SEED   = 1;
        sd = SEED;

        repeat (4) @(posedge clk);
        rst <= 1'b0;

        for (f = 0; f < FRAMES; f = f + 1) begin
            for (k = 0; k < 6; k = k + 1) ch_a[32*k +: 32] = $random(sd);
            for (k = 0; k < 6; k = k + 1) ch_b[32*k +: 32] = $random(sd);
            // a frame pulse, then a gap of random length
            @(posedge clk) lrclk_pulse <= 1'b1;
            repeat (1 + ($unsigned($random(sd)) % 4)) @(posedge clk);
            lrclk_pulse <= 1'b0;
            repeat (3 + ($unsigned($random(sd)) % 20)) @(posedge clk);
            // an occasional reset in the middle
            if (($random(sd) & 15) == 0) begin
                rst <= 1'b1;
                repeat (2) @(posedge clk);
                rst <= 1'b0;
            end
        end
        repeat (10) @(posedge clk);

        $display("frames=%0d seed=%0d comparisons=%0d valid pulses=%0d mismatches=%0d",
                 FRAMES, SEED, cmp, nvalid, mm);
        if (mm == 0 && nvalid > 10) $display("TDM16_MERGE PASS");
        else $display("TDM16_MERGE FAIL");
        $finish;
    end
endmodule
