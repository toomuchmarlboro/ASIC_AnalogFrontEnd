// Self-checking testbench for src/async_fifo.v. See notes/fifo.md.
//
// Independent clocks, a scoreboard of every accepted write and read, and:
//   1  reset state
//   2  fill past full (overflow must be ignored), then drain past empty
//      (underflow must be ignored); order and count must be exact
//   3  random traffic at several read/write duty cycles
//   4  reset in the middle of traffic
//
// Plusargs: +wper=<ps> +rper=<ps>  clock periods, default 40690 / 20000 (the
// audio and RMII clocks). Parameter AW sets the depth: -Ptb_async_fifo.AW=3.

`timescale 1ps/1ps

module tb_async_fifo;

    parameter AW = 9;
    localparam DEPTH = 1 << AW;

    integer WPER, RPER;

    reg  rst_n = 1'b1;
    reg  wrclk = 1'b0, rdclk = 1'b0;
    reg  wrreq = 1'b0, rdreq = 1'b0;
    reg  [7:0] data = 8'h00;
    wire [7:0] q;
    wire wrfull, rdempty;

    async_fifo #(.DATA_WIDTH(8), .ADDR_WIDTH(AW)) dut (
        .rst_n(rst_n),
        .wrclk(wrclk), .wrreq(wrreq), .data(data), .wrfull(wrfull),
        .rdclk(rdclk), .rdreq(rdreq), .q(q), .rdempty(rdempty)
    );

    initial begin
        if (!$value$plusargs("wper=%d", WPER)) WPER = 40690;
        if (!$value$plusargs("rper=%d", RPER)) RPER = 20000;
    end
    always begin #(WPER/2) wrclk = ~wrclk; end
    always begin #(RPER/2) rdclk = ~rdclk; end

    // Waveform dump for reports, off by default: +vcd=<file.vcd>. See notes/waveforms.md.
    // +vcd_until=<n>: stop dumping after n time units of this file's timescale.
    reg [1023:0] vcd_file;
    reg [63:0]   vcd_until;
    initial if ($value$plusargs("vcd_until=%d", vcd_until)) begin
        #(vcd_until) $dumpoff;
    end
    initial if ($value$plusargs("vcd=%s", vcd_file)) begin
        $dumpfile(vcd_file);
        $dumpvars(1, tb_async_fifo);
        $dumpvars(1, dut);
    end

    // ---- scoreboard -------------------------------------------------------

    reg [7:0] sb [0:65535];
    integer wcnt = 0, rcnt = 0, errors = 0, peak = 0, occ;
    reg     sb_on = 1'b0;

    task fail;
        input [255:0] msg;
        begin
            errors = errors + 1;
            if (errors < 10) $display("ERROR t=%0t %0s  wcnt=%0d rcnt=%0d", $time, msg, wcnt, rcnt);
        end
    endtask

    always @(posedge wrclk) if (sb_on && wrreq && !wrfull) begin
        sb[wcnt & 16'hFFFF] = data;
        wcnt = wcnt + 1;
        occ = wcnt - rcnt;
        if (occ > peak) peak = occ;
        if (occ > DEPTH) fail("overflow: more than DEPTH words held");
    end

    always @(posedge rdclk) if (sb_on && rdreq && !rdempty) begin
        if (rcnt >= wcnt) fail("read of a word never written");
        else begin
            #1;
            if (q !== sb[rcnt & 16'hFFFF]) begin
                fail("data mismatch");
                if (errors < 10) $display("   got %h expected %h", q, sb[rcnt & 16'hFFFF]);
            end
        end
        rcnt = rcnt + 1;
    end

    // ---- helpers ----------------------------------------------------------

    integer i, iw, ir, n, seed, pw, pr;

    task write_cycle;
        input do_write;
        begin
            @(posedge wrclk); #1;
            wrreq <= do_write;
            data  <= $random(seed);
        end
    endtask

    task read_cycle;
        input do_read;
        begin
            @(posedge rdclk); #1;
            rdreq <= do_read;
        end
    endtask

    task settle;
        begin
            wrreq <= 1'b0; rdreq <= 1'b0;
            repeat (12) @(posedge wrclk);
            repeat (12) @(posedge rdclk);
            #1;
        end
    endtask

    task reset_dut;
        begin
            wrreq <= 1'b0; rdreq <= 1'b0;
            #1000 rst_n = 1'b0;
            #5000 rst_n = 1'b1;
            sb_on = 1'b0; wcnt = 0; rcnt = 0;
            repeat (6) @(posedge wrclk);
            repeat (6) @(posedge rdclk);
            sb_on = 1'b1;
        end
    endtask

    // ---- test -------------------------------------------------------------

    initial begin
        seed = 1;
        #1000   rst_n = 1'b0;       // assert with the clocks running
        #200000 rst_n = 1'b1;
        repeat (6) @(posedge wrclk);
        repeat (6) @(posedge rdclk);
        #1;

        // 1  reset state
        if (rdempty !== 1'b1) fail("rdempty not set after reset");
        if (wrfull  !== 1'b0) fail("wrfull set after reset");
        sb_on = 1'b1;

        // 2a fill past full: keep requesting writes; overflow must be ignored
        fork
            begin : fillw
                for (i = 0; i < DEPTH + 40; i = i + 1) write_cycle(1'b1);
                write_cycle(1'b0);
            end
        join
        settle;
        if (wrfull !== 1'b1)          fail("wrfull not set with FIFO full");
        if (wcnt !== DEPTH)           begin fail("accepted writes != DEPTH"); $display("   wcnt=%0d", wcnt); end
        if (rdempty !== 1'b0)         fail("rdempty set with data present");

        // 2b drain past empty: keep requesting reads; underflow must be ignored
        for (i = 0; i < DEPTH + 40; i = i + 1) read_cycle(1'b1);
        read_cycle(1'b0);
        settle;
        if (rcnt !== DEPTH)           fail("drained word count != DEPTH");
        if (rdempty !== 1'b1)         fail("rdempty not set after drain");
        if (wrfull  !== 1'b0)         fail("wrfull still set after drain");

        // 3  random traffic, several duty cycles: write%, read%
        for (n = 0; n < 6; n = n + 1) begin
            case (n)
                0: begin pw = 50; pr = 50; end
                1: begin pw = 90; pr = 30; end     // write heavy, hits full
                2: begin pw = 30; pr = 90; end     // read heavy, hits empty
                3: begin pw = 100; pr = 100; end
                4: begin pw = 10; pr = 10; end
                default: begin pw = 70; pr = 70; end
            endcase
            fork
                begin : rw
                    for (iw = 0; iw < 6000; iw = iw + 1) write_cycle(($unsigned($random(seed)) % 100) < pw);
                end
                begin : rr
                    for (ir = 0; ir < 12000; ir = ir + 1) read_cycle(($unsigned($random(seed)) % 100) < pr);
                end
            join
            settle;
        end
        // flush what is left, then the counts must agree
        for (i = 0; i < DEPTH + 40; i = i + 1) read_cycle(1'b1);
        settle;
        if (wcnt !== rcnt) fail("random traffic: words lost or duplicated");
        if (rdempty !== 1'b1) fail("rdempty not set after flush");

        // 4  reset in the middle of traffic
        fork
            begin : mw   for (iw = 0; iw < 200; iw = iw + 1) write_cycle(1'b1); end
            begin : mr   for (ir = 0; ir < 100; ir = ir + 1) read_cycle(1'b1); end
        join
        settle;
        reset_dut;
        #1;
        if (rdempty !== 1'b1) fail("rdempty not set after mid-traffic reset");
        if (wrfull  !== 1'b0) fail("wrfull set after mid-traffic reset");
        fork
            begin : pw2   for (iw = 0; iw < 3000; iw = iw + 1) write_cycle(($unsigned($random(seed)) % 100) < 60); end
            begin : pr2   for (ir = 0; ir < 6000; ir = ir + 1) read_cycle(($unsigned($random(seed)) % 100) < 60); end
        join
        settle;                       // a finished thread leaves its request pin high
        for (i = 0; i < DEPTH + 40; i = i + 1) read_cycle(1'b1);
        settle;
        if (wcnt !== rcnt) fail("after reset: words lost or duplicated");

        $display("AW=%0d depth=%0d wper=%0d rper=%0d  peak occupancy=%0d  errors=%0d",
                 AW, DEPTH, WPER, RPER, peak, errors);
        if (errors == 0) $display("FIFO PASS"); else $display("FIFO FAIL");
        $finish;
    end

    // watchdog
    initial begin
        #(64'd20000000000);
        $display("FIFO FAIL: timeout");
        $finish;
    end

endmodule
