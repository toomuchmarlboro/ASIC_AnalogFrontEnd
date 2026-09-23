// Server-side equivalence check for tdm8_rx, Icarus Verilog.
//
// One stimulus into four implementations, compared 1 ns after every rising
// BCLK and 1 ns after every reset assertion:
//
//   ref   legacy/rtl/tdm8_rx.vhd through `ghdl --synth --out=verilog`
//   v1    the hand conversion as first verified (git 39e609a), active-high `rst`
//   rtl   phase0/tdm8_rx.v, the Phase 0 hand conversion, active-low `rst_n`
//   conv  src/tdm8_rx.v, the Phase 2 generated module, active-high `rst`
//   gate  a synthesised or placed netlist, run on the sky130 cell models
//
// BCLK and LRCLK come from tdm8_master, also through GHDL, exactly as in
// tb_tdm8_rx_equiv.vhd. Run it with tb/run_tdm8_rx_gate.sh.
//
// Plusargs: +slot=N +launch=N +frames=N +random=0|1 +seed=N +pattern=0|1

`timescale 1ns/1ps

module tb_tdm8_rx_gate;

    integer SLOT, LAUNCH, FRAMES, RANDOM, SEED, PATTERN;

    reg  rst   = 1'b1;
    reg  clk   = 1'b0;
    reg  sdata = 1'b0;
    wire bclk, lrclk;
    wire rst_n = ~rst;

    wire [191:0] ch_ref, ch_v1, ch_rtl, ch_conv, ch_gate;

    // 24.576 MHz, the master clock the design is specified for
    localparam real HALF = 20.345;
    always #(HALF) clk = ~clk;

    tdm8_master u_master (.rst(rst), .clk_in(clk), .bclk_out(bclk), .lrclk_out(lrclk));

    tdm8_rx_vhdl u_ref  (.rst(rst), .bclk_in(bclk), .lrclk_in(lrclk), .sdata_in(sdata), .ch_data_out(ch_ref));
    tdm8_rx_v1   u_v1   (.rst(rst), .bclk_in(bclk), .lrclk_in(lrclk), .sdata_in(sdata), .ch_data_out(ch_v1));
    tdm8_rx      u_rtl  (.rst_n(rst_n), .bclk_in(bclk), .lrclk_in(lrclk), .sdata_in(sdata), .ch_data_out(ch_rtl));
    tdm8_rx_conv u_conv (.rst(rst),     .bclk_in(bclk), .lrclk_in(lrclk), .sdata_in(sdata), .ch_data_out(ch_conv));
    tdm8_rx_gate u_gate (.rst_n(rst_n), .bclk_in(bclk), .lrclk_in(lrclk), .sdata_in(sdata), .ch_data_out(ch_gate));

    reg [23:0] test_frame [0:7];
    initial begin
        test_frame[0] = 24'hA1A1A1;
        test_frame[1] = 24'hB2B2B2;
        test_frame[2] = 24'hC3C3C3;
        test_frame[3] = 24'hD4D4D4;
        test_frame[4] = 24'hE5E5E5;
        test_frame[5] = 24'hF6F6F6;
        test_frame[6] = 24'h070707;
        test_frame[7] = 24'h181818;
    end

    // Waveform dump for reports, off by default: +vcd=<file.vcd>. See notes/waveforms.md.
    // +vcd_until=<n>: stop dumping after n time units of this file's timescale.
    reg [1023:0] vcd_file;
    reg [63:0]   vcd_until;
    initial if ($value$plusargs("vcd_until=%d", vcd_until)) begin
        #(vcd_until) $dumpoff;
    end
    initial if ($value$plusargs("vcd=%s", vcd_file)) begin
        $dumpfile(vcd_file);
        $dumpvars(1, tb_tdm8_rx_gate);
        $dumpvars(1, u_rtl);
    end

    // ---- comparison -------------------------------------------------------

    reg     armed = 1'b0;      // set at the first reset release
    integer cmp = 0, mm_v1 = 0, mm_rtl = 0, mm_conv = 0, mm_gate = 0, nreset = 0;

    task compare;
        begin
            cmp = cmp + 1;
            if (ch_v1 !== ch_ref) begin
                mm_v1 = mm_v1 + 1;
                if (mm_v1 < 4) $display("MISMATCH v1   at %0t", $time);
            end
            if (ch_rtl !== ch_ref) begin
                mm_rtl = mm_rtl + 1;
                if (mm_rtl < 4) $display("MISMATCH rtl  at %0t", $time);
            end
            if (ch_conv !== ch_ref) begin
                mm_conv = mm_conv + 1;
                if (mm_conv < 4) $display("MISMATCH conv at %0t", $time);
            end
            if (ch_gate !== ch_ref) begin
                mm_gate = mm_gate + 1;
                if (mm_gate < 4) $display("MISMATCH gate at %0t ref=%h gate=%h", $time, ch_ref, ch_gate);
            end
        end
    endtask

    always @(posedge bclk) if (armed) begin #1; compare; end
    always @(posedge rst)  if (armed) begin #1; compare; end

    // ---- stimulus ---------------------------------------------------------

    integer i, ch, b, frame, n_bits, sd;
    reg [0:511] frame_bits;

    initial begin
        if (!$value$plusargs("slot=%d",    SLOT))    SLOT    = 32;
        if (!$value$plusargs("launch=%d",  LAUNCH))  LAUNCH  = 0;
        if (!$value$plusargs("frames=%d",  FRAMES))  FRAMES  = 3;
        if (!$value$plusargs("random=%d",  RANDOM))  RANDOM  = 0;
        if (!$value$plusargs("seed=%d",    SEED))    SEED    = 1;
        if (!$value$plusargs("pattern=%d", PATTERN)) PATTERN = 0;
        sd = SEED;

        n_bits = 8 * SLOT;
        frame_bits = {512{1'b0}};
        for (ch = 0; ch < 8; ch = ch + 1)
            for (b = 0; b < 24; b = b + 1)
                if (ch * SLOT + b + LAUNCH < n_bits)
                    frame_bits[ch * SLOT + b + LAUNCH] = test_frame[ch][23 - b];

        rst = 1'b1;
        sdata = 1'b0;
        #200;
        @(negedge clk) rst <= 1'b0;
        armed = 1'b1;

        if (RANDOM == 0) begin
            for (frame = 1; frame <= FRAMES; frame = frame + 1) begin
                wait (lrclk === 1'b1);
                for (i = 0; i < n_bits; i = i + 1) begin
                    sdata <= frame_bits[i];
                    @(negedge bclk);
                end
            end
            #300;
        end else begin
            // Random serial data for FRAMES frames, with asynchronous resets
            // dropped in at random moments. SDATA is held low while reset is
            // asserted: the FPGA original has no reset on its falling-edge
            // input register and ours does (notes/tdm8_rx.md, deviation 1),
            // so this is the condition under which they are specified equal.
            for (frame = 1; frame <= FRAMES; frame = frame + 1) begin
                for (i = 0; i < 256; i = i + 1) begin
                    @(negedge bclk);
                    sdata <= $random(sd);
                end
                if (($random(sd) & 7) == 0) begin
                    #($unsigned($random(sd)) % 40);
                    sdata <= 1'b0;
                    rst   <= 1'b1;
                    nreset = nreset + 1;
                    #(200 + ($unsigned($random(sd)) % 300));
                    @(negedge clk) rst <= 1'b0;
                end
            end
            #300;
        end

        $display("slot=%0d launch=%0d random=%0d frames=%0d seed=%0d resets=%0d",
                 SLOT, LAUNCH, RANDOM, FRAMES, SEED, nreset);
        $display("comparisons=%0d  mismatches: v1=%0d rtl=%0d conv=%0d gate=%0d",
                 cmp, mm_v1, mm_rtl, mm_conv, mm_gate);

        if (PATTERN != 0) begin
            for (ch = 0; ch < 8; ch = ch + 1) begin
                $display("ch%0d rtl=%h gate=%h expected=%h", ch + 1,
                         ch_rtl[191 - 24*ch -: 24], ch_gate[191 - 24*ch -: 24], test_frame[ch]);
                if (ch_rtl[191 - 24*ch -: 24] !== test_frame[ch] ||
                    ch_gate[191 - 24*ch -: 24] !== test_frame[ch]) begin
                    $display("PATTERN FAIL on channel %0d", ch + 1);
                    $finish(1);
                end
            end
        end

        if (mm_v1 != 0 || mm_rtl != 0 || mm_conv != 0 || mm_gate != 0) begin
            $display("EQUIVALENCE FAIL");
            $finish(1);
        end
        if (cmp < 500) begin
            $display("EQUIVALENCE INCONCLUSIVE: too few comparisons");
            $finish(1);
        end
        $display("EQUIVALENCE PASS");
        $finish;
    end

endmodule
