// System-level check of src/async_fifo.v between the real producer and consumer.
// See notes/fifo.md.
//
//   packet_formatter (audio clock)  ->  async_fifo  ->  udp_tx_core (RMII clock)
//
// packet_formatter and udp_tx_core are the FPGA VHDL through GHDL. rmii_tx is
// modelled as its handshake contract: one acknowledge every four clocks while
// the line is granted. Every payload byte udp_tx_core emits is compared with
// the byte packet_formatter wrote, in order. The peak FIFO occupancy is the
// number that sizes the FIFO.
//
// Plusargs: +period=<audio clocks per frame>  256 = 96 kHz, 1024 = 24 kHz
//           +stall=<ns>   delay before the line is granted after a packet is
//                         requested, e.g. an ARP reply in flight
//           +packets=<n>

`timescale 1ns/1ps

module tb_fifo_system;

    parameter AW = 10;
    localparam DEPTH = 1 << AW;

    integer PERIOD, STALL, NPKT;

    reg clk24 = 1'b0;
    reg clk50 = 1'b0;
    reg rst   = 1'b1;
    reg rst_n = 1'b0;

    always #20.345 clk24 = ~clk24;
    always #10     clk50 = ~clk50;

    // ---- producer ---------------------------------------------------------

    reg          tdm_valid = 1'b0;
    reg  [383:0] tdm_data  = 384'd0;
    wire         fifo_wr_en;
    wire [7:0]   fifo_wr_data;
    wire         packet_ready;
    wire         wrfull;

    packet_formatter u_fmt (
        .clk_18m(clk24), .rst(rst),
        .tdm16_valid(tdm_valid), .tdm16_data(tdm_data),
        .dbg_byte0(8'hD0), .dbg_byte1(8'hD1),
        .dbg_status(8'hE0), .dbg_status2(8'hE2), .dbg_status3(8'hE3),
        .dbg_status4(8'hE4), .dbg_status5(8'hE5), .dbg_status6(8'hE6),
        .dbg_status7(8'hE7), .dbg_status8(8'hE8),
        .fifo_wr_en(fifo_wr_en), .fifo_wr_data(fifo_wr_data),
        .packet_ready(packet_ready)
    );

    // ---- FIFO -------------------------------------------------------------

    wire         fifo_rd_en;
    wire [7:0]   fifo_rd_data;
    wire         rdempty;

    async_fifo #(.DATA_WIDTH(8), .ADDR_WIDTH(AW)) u_fifo (
        .rst_n(rst_n),
        .wrclk(clk24), .wrreq(fifo_wr_en), .data(fifo_wr_data), .wrfull(wrfull),
        .rdclk(clk50), .rdreq(fifo_rd_en), .q(fifo_rd_data), .rdempty(rdempty)
    );

    // ---- consumer ---------------------------------------------------------

    wire        tx_start;
    wire [7:0]  tx_data;
    reg         tx_ready = 1'b0;

    udp_tx_core u_udp (
        .clk_50m(clk50), .rst(rst),
        .fpga_mac(48'h02_00_00_00_00_01), .fpga_ip(32'hC0A80365),
        .pc_mac(48'h02_00_00_00_00_02),   .pc_ip(32'hC0A8030A),
        .udp_port(16'd5001),
        .packet_ready(packet_ready),
        .fifo_rd_en(fifo_rd_en), .fifo_rd_data(fifo_rd_data),
        .tx_start(tx_start), .tx_data(tx_data), .tx_ready(tx_ready)
    );

    // rmii_tx contract: grant after STALL ns, then one acknowledge per four clocks
    integer grant_ns  = 0;
    integer ack_cnt   = 0;
    reg     granted   = 1'b0;
    reg     tx_start_d = 1'b0;

    always @(posedge clk50) begin
        tx_start_d <= tx_start;
        tx_ready   <= 1'b0;
        if (tx_start && !tx_start_d) begin
            granted <= 1'b0;
            ack_cnt <= 0;
            grant_ns = 0;
        end else if (tx_start && !granted) begin
            grant_ns = grant_ns + 20;
            if (grant_ns >= STALL) granted <= 1'b1;
        end
        if (!tx_start) granted <= 1'b0;
        if (tx_start && granted) begin
            ack_cnt <= ack_cnt + 1;
            if (ack_cnt % 4 == 3) tx_ready <= 1'b1;
        end
    end

    // ---- scoreboard -------------------------------------------------------

    reg [7:0] sb [0:262143];
    integer w = 0, r = 0, peak = 0, occ, errors = 0;
    integer frame_idx = 0, byte_k = 0, pkts = 0, payload_bytes = 0;
    integer overflow_drops = 0;

    always @(posedge clk24) if (fifo_wr_en) begin
        if (wrfull) overflow_drops = overflow_drops + 1;
        else begin
            sb[w] = fifo_wr_data;
            w = w + 1;
        end
    end

    always @(posedge clk50) begin
        if (fifo_rd_en && !rdempty) r = r + 1;
        occ = w - r;
        if (occ > peak) peak = occ;
    end

    // each acknowledge takes tx_data; frame byte index restarts per frame
    always @(posedge clk50) begin
        if (!tx_start) byte_k = 0;
        else if (tx_ready) begin
            if (byte_k >= 42) begin
                if (pkts * 410 + (byte_k - 42) >= w) begin
                    errors = errors + 1;
                    if (errors < 6) $display("ERROR pkt %0d byte %0d: read before written", pkts, byte_k);
                end else if (tx_data !== sb[pkts * 410 + (byte_k - 42)]) begin
                    errors = errors + 1;
                    if (errors < 6) $display("ERROR pkt %0d byte %0d: got %h expected %h",
                                             pkts, byte_k, tx_data, sb[pkts * 410 + (byte_k - 42)]);
                end
                payload_bytes = payload_bytes + 1;
            end
            byte_k = byte_k + 1;
            if (byte_k == 452) begin
                pkts = pkts + 1;
                byte_k = 0;
            end
        end
    end

    // ---- stimulus: one frame per PERIOD audio clocks -----------------------

    integer f, i;
    initial begin
        if (!$value$plusargs("period=%d",  PERIOD)) PERIOD = 256;
        if (!$value$plusargs("stall=%d",   STALL))  STALL  = 0;
        if (!$value$plusargs("packets=%d", NPKT))   NPKT   = 40;

        rst = 1'b1; rst_n = 1'b0;
        #500 rst_n = 1'b1;
        repeat (4) @(posedge clk24);
        repeat (4) @(posedge clk50);
        rst = 1'b0;
        repeat (4) @(posedge clk24);

        for (f = 0; f < NPKT * 8; f = f + 1) begin
            // frame data: byte i of frame f is (f*48 + i), so any loss shows
            for (i = 0; i < 48; i = i + 1) tdm_data[383 - 8*i -: 8] = (f * 48 + i) & 8'hFF;
            @(posedge clk24); tdm_valid <= 1'b1;
            @(posedge clk24); tdm_valid <= 1'b0;
            repeat (PERIOD - 2) @(posedge clk24);
        end
        repeat (4000) @(posedge clk50);
        $display("period=%0d clks (%0d Hz)  stall=%0d ns  AW=%0d depth=%0d",
                 PERIOD, 24576000 / PERIOD, STALL, AW, DEPTH);
        $display("packets sent=%0d  payload bytes checked=%0d  written=%0d read=%0d  peak occupancy=%0d  dropped writes=%0d  errors=%0d",
                 pkts, payload_bytes, w, r, peak, overflow_drops, errors);
        if (errors == 0 && overflow_drops == 0 && pkts >= NPKT - 1) $display("SYSTEM PASS");
        else $display("SYSTEM FAIL");
        $finish;
    end

    initial begin
        #(64'd400000000);
        $display("SYSTEM FAIL: timeout");
        $finish;
    end

endmodule
